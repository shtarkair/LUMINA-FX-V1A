# ============================================================
# Lumina FX V1A — Windows Self-Installing Launcher
# ============================================================
# On first run: installs Node.js, clones repo, runs npm install
# On subsequent runs: starts the server and opens the browser
# ============================================================

$GITHUB_REPO = "https://github.com/shtarkair/LUMINA-FX-V1A.git"
$PORT = 3457
$LOG_FILE = "$env:TEMP\lumina-fx-install.log"

# ---- Helper Functions ----

function Show-Notification($msg) {
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    $balloon = New-Object System.Windows.Forms.NotifyIcon
    $balloon.Icon = [System.Drawing.SystemIcons]::Information
    $balloon.BalloonTipTitle = "Lumina FX"
    $balloon.BalloonTipText = $msg
    $balloon.Visible = $true
    $balloon.ShowBalloonTip(3000)
    Start-Sleep -Seconds 3
    $balloon.Dispose()
}

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

# ---- Step 1: Find Node.js ----

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

# ---- Step 2: Install Node.js if needed ----

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

# ---- Step 3: Check for Git ----

$GIT_BIN = Get-Command git -ErrorAction SilentlyContinue
if (-not $GIT_BIN) {
    Show-Error "Git is not installed.`n`nPlease install Git from https://git-scm.com/download/win`n`nAfter installation, double-click Lumina FX again."
    Start-Process "https://git-scm.com/download/win"
    exit 1
}

# ---- Step 4: Find or clone the project ----

function Find-Project {
    # Priority 1: Same directory as this script
    $scriptDir = Split-Path -Parent $PSCommandPath
    if (Test-Path (Join-Path $scriptDir "lighting-server-V1A.js")) {
        return $scriptDir
    }

    # Priority 2: ~/Lumina FX/
    $luminaDir = Join-Path $env:USERPROFILE "Lumina FX"
    if (Test-Path (Join-Path $luminaDir "lighting-server-V1A.js")) {
        return $luminaDir
    }

    # Priority 3: Search common locations
    $searchDirs = @(
        (Join-Path $env:USERPROFILE "Documents"),
        (Join-Path $env:USERPROFILE "Desktop"),
        $env:USERPROFILE
    )

    foreach ($dir in $searchDirs) {
        if (Test-Path $dir) {
            $found = Get-ChildItem -Path $dir -Filter "lighting-server-V1A.js" -Recurse -Depth 4 -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($found) { return $found.DirectoryName }
        }
    }

    return $null
}

$PROJECT_DIR = Find-Project

if (-not $PROJECT_DIR) {
    if (-not (Test-Path $LOG_FILE)) { "$(Get-Date): Setup" | Out-File $LOG_FILE }

    $progressForm = Show-Progress "Downloading Lumina FX from GitHub..."

    $LUMINA_DIR = Join-Path $env:USERPROFILE "Lumina FX"
    "Cloning $GITHUB_REPO to $LUMINA_DIR ..." | Out-File $LOG_FILE -Append

    & git clone $GITHUB_REPO $LUMINA_DIR 2>&1 | Out-File $LOG_FILE -Append

    if (-not (Test-Path (Join-Path $LUMINA_DIR "lighting-server-V1A.js"))) {
        $progressForm.Close()
        Show-Error "Failed to download Lumina FX.`n`nPlease check your internet connection and try again.`n`nLog: $LOG_FILE"
        exit 1
    }

    $PROJECT_DIR = $LUMINA_DIR
    "Project cloned to $PROJECT_DIR" | Out-File $LOG_FILE -Append
    $progressForm.Close()
}

# ---- Step 5: npm install if needed ----

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

# ---- Step 6: Create media directories if missing ----

$mediaMovies = Join-Path $PROJECT_DIR "media\movies"
$mediaPics = Join-Path $PROJECT_DIR "media\pics"
if (-not (Test-Path $mediaMovies)) { New-Item -ItemType Directory -Path $mediaMovies -Force | Out-Null }
if (-not (Test-Path $mediaPics)) { New-Item -ItemType Directory -Path $mediaPics -Force | Out-Null }

# ---- Step 7: Start the server ----

# Kill any existing Lumina server
Get-Process -Name "node" -ErrorAction SilentlyContinue | Where-Object {
    $_.CommandLine -like "*lighting-server*"
} | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

Push-Location $PROJECT_DIR
$serverProcess = Start-Process -FilePath $NODE_BIN -ArgumentList "lighting-server-V1A.js" -WorkingDirectory $PROJECT_DIR -WindowStyle Hidden -PassThru
Pop-Location

# Wait for server to be ready (up to 10 seconds)
$ready = $false
for ($i = 0; $i -lt 30; $i++) {
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
