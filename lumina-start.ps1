# ============================================================
# Lumina FX V1A — Self-Contained Windows Launcher
# ============================================================
# All project files are bundled alongside this script.
# On first run: installs Node.js if needed, runs npm install
# On every run: starts the server and opens the browser
# ============================================================

$PORT = 3457
$LOG_FILE = "$env:TEMP\lumina-fx-install.log"

# ---- Helper Functions ----

function Show-Error($msg) {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show($msg, "Lumina FX", "OK", "Error") | Out-Null
}

function Show-Progress($msg) {
    Add-Type -AssemblyName System.Windows.Forms
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Lumina FX Setup"
    $form.Size = New-Object System.Drawing.Size(400, 150)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false
    $form.TopMost = $true
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $msg
    $label.AutoSize = $false
    $label.Size = New-Object System.Drawing.Size(360, 60)
    $label.Location = New-Object System.Drawing.Point(15, 30)
    $label.Font = New-Object System.Drawing.Font("Segoe UI", 11)
    $form.Controls.Add($label)
    $form.Show()
    $form.Refresh()
    return $form
}

# ---- Step 1: Verify embedded project files ----

$PROJECT_DIR = Split-Path -Parent $PSCommandPath

if (-not (Test-Path (Join-Path $PROJECT_DIR "lighting-server-V1A.js"))) {
    Show-Error "Project files not found.`n`nMake sure all files are in the same folder as Lumina FX.vbs"
    exit 1
}

# ---- Step 2: Find Node.js ----

function Find-Node {
    # Check PATH first
    $nodePath = Get-Command node -ErrorAction SilentlyContinue
    if ($nodePath) { return $nodePath.Source }

    # Check common install locations
    $locations = @(
        "$env:ProgramFiles\nodejs\node.exe",
        "${env:ProgramFiles(x86)}\nodejs\node.exe",
        "$env:APPDATA\nvm\current\node.exe",
        "$env:LOCALAPPDATA\Programs\nodejs\node.exe",
        "$env:USERPROFILE\.volta\bin\node.exe"
    )

    foreach ($loc in $locations) {
        if (Test-Path $loc) { return $loc }
    }

    # Check NVM for Windows
    $nvmDir = "$env:APPDATA\nvm"
    if (Test-Path $nvmDir) {
        $versions = Get-ChildItem $nvmDir -Directory | Where-Object { $_.Name -match '^\d' } | Sort-Object Name -Descending
        foreach ($v in $versions) {
            $np = Join-Path $v.FullName "node.exe"
            if (Test-Path $np) { return $np }
        }
    }

    return $null
}

$NODE_BIN = Find-Node

# ---- Step 3: Install Node.js if needed ----

if (-not $NODE_BIN) {
    "$(Get-Date): Starting first-run setup" | Out-File $LOG_FILE

    $progressForm = Show-Progress "Installing Node.js... This may take a few minutes."

    try {
        # Download Node.js LTS installer
        $installerUrl = "https://nodejs.org/dist/v22.12.0/node-v22.12.0-x64.msi"
        $installerPath = "$env:TEMP\node-installer.msi"

        "Downloading Node.js from $installerUrl ..." | Out-File $LOG_FILE -Append
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -UseBasicParsing

        # Install silently
        "Installing Node.js..." | Out-File $LOG_FILE -Append
        Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /qn /norestart" -Wait -NoNewWindow

        # Refresh PATH
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

        $NODE_BIN = Find-Node

        if (-not $NODE_BIN) {
            $progressForm.Close()
            Show-Error "Failed to install Node.js.`n`nCheck log: $LOG_FILE"
            exit 1
        }

        "Node.js installed: $NODE_BIN" | Out-File $LOG_FILE -Append
        Remove-Item $installerPath -ErrorAction SilentlyContinue
    }
    catch {
        $progressForm.Close()
        "ERROR: $($_.Exception.Message)" | Out-File $LOG_FILE -Append
        Show-Error "Failed to install Node.js.`n`n$($_.Exception.Message)`n`nCheck log: $LOG_FILE"
        exit 1
    }

    $progressForm.Close()
}

# Find npm
$NPM_BIN = Join-Path (Split-Path $NODE_BIN) "npm.cmd"
if (-not (Test-Path $NPM_BIN)) {
    $NPM_BIN = Get-Command npm -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source
}

# ---- Step 4: npm install if needed ----

if (-not (Test-Path (Join-Path $PROJECT_DIR "node_modules"))) {
    if (-not (Test-Path $LOG_FILE)) { "$(Get-Date): Setup" | Out-File $LOG_FILE }

    $progressForm = Show-Progress "Installing dependencies..."

    "Running npm install in $PROJECT_DIR ..." | Out-File $LOG_FILE -Append
    Push-Location $PROJECT_DIR
    & $NPM_BIN install 2>&1 | Out-File $LOG_FILE -Append
    $exitCode = $LASTEXITCODE
    Pop-Location

    if ($exitCode -ne 0) {
        $progressForm.Close()
        Show-Error "Failed to install dependencies.`n`nLog: $LOG_FILE"
        exit 1
    }

    $progressForm.Close()
}

# ---- Step 5: Create media directories if missing ----

$mediaMovies = Join-Path $PROJECT_DIR "media\movies"
$mediaPics = Join-Path $PROJECT_DIR "media\pics"
if (-not (Test-Path $mediaMovies)) { New-Item -ItemType Directory -Path $mediaMovies -Force | Out-Null }
if (-not (Test-Path $mediaPics)) { New-Item -ItemType Directory -Path $mediaPics -Force | Out-Null }

# ---- Step 6: Kill zombie processes on port ----

$portInUse = netstat -ano 2>$null | Select-String ":$PORT\s" | ForEach-Object {
    ($_ -split '\s+')[-1]
} | Where-Object { $_ -match '^\d+$' } | Select-Object -Unique

foreach ($pid in $portInUse) {
    if ($pid -ne "0") {
        Stop-Process -Id $pid -Force -ErrorAction SilentlyContinue
    }
}
Start-Sleep -Seconds 1

# ---- Step 7: Start the server ----

Push-Location $PROJECT_DIR
$serverProcess = Start-Process -FilePath $NODE_BIN -ArgumentList "lighting-server-V1A.js" -WorkingDirectory $PROJECT_DIR -WindowStyle Hidden -PassThru
Pop-Location

# Wait for server to be ready (up to 15 seconds)
$ready = $false
for ($i = 0; $i -lt 50; $i++) {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:$PORT" -UseBasicParsing -TimeoutSec 1 -ErrorAction SilentlyContinue
        if ($response.StatusCode -eq 200) {
            $ready = $true
            break
        }
    } catch {}
    Start-Sleep -Milliseconds 300
}

if (-not $ready) {
    Show-Error "Server failed to start.`n`nCheck if port $PORT is already in use."
    Stop-Process -Id $serverProcess.Id -Force -ErrorAction SilentlyContinue
    exit 1
}

# Open in browser
Start-Process "http://localhost:$PORT"

# Keep running so the server stays alive
Wait-Process -Id $serverProcess.Id
