# Lumina FX V1A — User Manual

**Copyright (c) 2026 Shai Shtarker. All rights reserved.**

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Interface Overview](#interface-overview)
3. [Fixture Management](#fixture-management)
4. [Timeline & Cues](#timeline--cues)
5. [Effects Generator](#effects-generator)
6. [Sequences (SEQ Tab)](#sequences-seq-tab)
7. [MIDI Control](#midi-control)
8. [DMX Output Settings](#dmx-output-settings)
9. [Connecting Lumina to a Lighting System](#connecting-lumina-to-a-lighting-system)
10. [Show File Management](#show-file-management)
11. [Keyboard Shortcuts](#keyboard-shortcuts)
12. [Settings & Preferences](#settings--preferences)

---

## 1. Getting Started

### Installation (Mac)
1. Download **Lumina-FX-V1A-Mac.zip** from the [Releases page](https://github.com/shtarkair/LUMINA-FX-V1A/releases)
2. Unzip the file
3. Double-click **Lumina FX.app**
4. On first launch, the app installs required components automatically

### Installation (Windows)
1. Download **Lumina-FX-V1A-Windows.zip** from the [Releases page](https://github.com/shtarkair/LUMINA-FX-V1A/releases)
2. Unzip the file
3. Double-click **Lumina FX.vbs**
4. On first launch, the app installs required components automatically

**Note:** Windows may show a security warning on first run. Click **More info** then **Run anyway** to proceed.

### Requirements
- **Mac**: macOS 12.0 or later
- **Windows**: Windows 10 or later
- Internet connection (first run only)

---

## 2. Interface Overview

The Lumina FX interface is divided into these main areas:

### Toolbar (Top)
- **Play / Pause** — Start or stop playback
- **Loop** — Toggle loop mode (set In/Out points with number pads)
- **Master Fader** — Controls overall output level (0–100%)
- **BPM** — Tempo control (20–300 BPM), displayed as whole numbers
- **UNDO / REDO** — Step backward or forward through your edit history

### Fixture Pad Bar (Left Side)
- One pad per fixture for quick access
- Tap a pad to select the fixture
- Use **SEL ALL** to select all fixtures at once
- **REC** — Record live automation from faders or MIDI
- **ERASE** — Click cues to delete them
- **QUANT** — Snap new cues to the beat grid

### Timeline (Center)
- Visual beat grid showing all fixture lanes
- Each fixture has a horizontal lane with its cues
- Drag the playhead to scrub through time
- Dark grid lines at every 4 beats, brighter lines at every 16

### Right Panel Tabs
- **CUE** — Edit selected cue parameters
- **FX** — Generate effects across fixtures
- **SEQ** — Store and recall sequences (25 slots per category)
- **SET** — Settings, DMX output, MIDI config, file management

---

## 3. Fixture Management

### Adding Fixtures
1. Open the **Fixture Manager** (click the fixture icon in the toolbar)
2. Click **Add Fixture**
3. Set the name, type, position, and color

### Built-in Fixture Profiles
SPOT, WASH, STROBE, LED, FX, DIM, ROBE MP, ROBE MP2, MAC VIPER, MAC VIPER2

### Custom Profiles
1. Open **Fixture Builder** from the Fixture Manager
2. Name your profile, set a color
3. Add parameters with channel offsets
4. Choose 8-bit or 16-bit per parameter
5. Click **SAVE**

### Renaming & Renumbering
- Tap the fixture name to rename (on-screen keyboard)
- Tap the fixture ID to set a custom number (numeric keypad)
- **RENUMBER ALL** re-IDs all fixtures sequentially

### DMX Patch
- Each fixture is auto-assigned a DMX address when added
- To change: click the address field in Fixture Manager and use the keypad (format: Universe.Address)
- Conflicting addresses show a red border warning

### Parameters
Each fixture can have these parameters depending on its profile:

| Group | Parameters |
|-------|-----------|
| **Intensity** | Dimmer (0–100%), Strobe (0–25 Hz) |
| **Position** | Pan (0–540°), Tilt (0–270°) |
| **Color** | Cyan, Magenta, Yellow, White, CTO (0–100%), Color Wheel (0–16) |
| **Beam** | Zoom (5–60°), Iris (0–100%), Focus (0–100%) |
| **Blades** | A/B/C/D (0–100%), A/B/C/D Rotation (0–360°) |
| **Gobo** | A/B (0–8), A/B Rotation (0–360°) |

---

## 4. Timeline & Cues

### Timeline Tools
- **SELECT** — Click to select cues, drag to move them
- **DRAW** — Click on a lane to create a new cue
- **ERASE** — Click a cue to delete it
- **COPY** — Click cue(s) then click a target lane to paste
- **SPLIT** — Click a cue to split it at that point

### Creating Cues
- Switch to **DRAW** mode and click on a fixture lane
- Or use **REC** mode to record live from faders or MIDI

### Editing Cues (CUE Tab)
Select a cue to edit its properties:
- **Value** — Target parameter value
- **Duration** — Length in beats
- **Fade In / Fade Out** — Proportional fade (0–1)
- **Start Value / End Value** — Fade start and end points
- **Easing** — STEP, LINEAR, EASE IN, EASE OUT, S-CURVE, BOUNCE

### Deleting Cues
- Use **ERASE** mode and click, or select cues and press **Delete** key

### Undo / Redo
- **Undo**: Ctrl+Z (Cmd+Z on Mac)
- **Redo**: Ctrl+Shift+Z or Ctrl+Y (Cmd+Shift+Z or Cmd+Y on Mac)
- Stores last 20 actions
- Shows action label on screen (e.g., "UNDO: delete cues")

---

## 5. Effects Generator

Open the **FX** tab to generate effects across multiple fixtures at once.

### How to Use
1. **FIX** — Select which fixtures to include
2. **PARAM** — Choose the parameter to affect (Dimmer, Pan, Tilt, etc.)
3. **EFFECT** — Choose the effect type
4. **SPEED** — Set cycle length (0.25–32 beats)
5. **SPREAD** — Phase offset between fixtures (0–100%)
6. **CROSSFADE** — Overlap between fixtures (0–100%)
7. **EASING** — Transition curve
8. **DIRECTION** — FWD or BWD (reverse fixture order)

### Effect Types

| Effect | Description |
|--------|------------|
| **Chase** | Sequential fade across fixtures |
| **Sine** | Smooth sine wave oscillation |
| **Ramp Up** | Fade from min to max |
| **Ramp Down** | Fade from max to min |
| **Pulse** | Short burst on/off |
| **Strobe** | Rapid flashing |
| **Random** | Random values per beat |
| **Fan** | Spread values linearly across fixtures |
| **Ballyhoo** | Circular pan+tilt motion (figure-8) |
| **Fly Tilt** | Dim+tilt fly in/out |
| **Fly Pan** | Dim+pan fly in/out |

### Fixture Selection
- Toggle individual fixtures on/off
- Select by type, position, or color group
- Use ALL / NONE / INVERT buttons
- Nth fixture patterns: ODD, every 3rd, every 4th, custom

---

## 6. Sequences (SEQ Tab)

Store and recall cue snapshots for live performance.

### Storing a Sequence
1. Select the cues you want to store
2. Click **STORE**
3. Click a slot (5x5 grid, 25 slots per category)
4. Double-click a slot to rename it

### Categories
- **DIM** — Dimmer sequences
- **POS** — Position sequences
- **COL** — Color sequences
- **BEAM** — Beam sequences
- **ALL** — Full scene sequences

### Recalling a Sequence
- Click a filled slot to recall it
- **MERGE** — Adds to existing cues
- **REPLACE** — Clears and replaces current cues
- **FADE** slider — Crossfade duration (0–16 beats)

### Save / Load Sequences
- **SAVE** — Export sequences to a file
- **LOAD** — Import sequences from a file

---

## 7. MIDI Control

### Connecting MIDI
1. Go to **SET** tab
2. Click **MIDI ON**
3. Or enable **Auto-connect** to connect at startup

### MIDI Learn
1. Click **MIDI LEARN** to enter learn mode
2. Click any slider or button in Lumina
3. Move the knob/fader/button on your MIDI controller
4. The control is now mapped
5. Double-click a slider to unassign it

### Encoder Modes
- **Absolute** — Fader sends exact value (0–127)
- **Pickup** — Incremental control, no jumps when touching the knob (recommended for M-Audio encoders)
- Encoder sensitivity is adjustable in MIDI settings

### MIDI Profiles
- Save different MIDI mappings as named profiles
- Switch between profiles for different controllers
- Profiles are saved using the on-screen keyboard

### Mappable Actions
REC, ERASE, QUANT, COPY, SPLIT, EFFECT, UNDO, REDO — all assignable to MIDI buttons

---

## 8. DMX Output Settings

Found in the **SET** tab under Output:

### Output Options
- **Enable / Disable Output** — Master toggle
- **ArtNet** — Enable ArtNet output with host IP (default: 127.0.0.1)
- **sACN / E1.31** — Enable sACN output
- **DMX Rate** — 25, 30, or 40 Hz refresh rate

### ArtNet Host IP — Broadcast vs Unicast

The **Host** field controls where Lumina sends ArtNet packets:

- **Broadcast** — use `x.255.255.255` matching your subnet (e.g. `2.255.255.255` on a `2.x.x.x` network). All ArtNet devices on the network receive the data. Use this for Setups 1, 3, and 4.
- **Unicast** — use the specific IP of the target device (e.g. `2.0.0.5` for a single ArtNet node, or the MA2's IP for Setup 4 direct injection). Only that device receives the data.

> **Tip:** If you're unsure, start with broadcast. Switch to unicast only when you need to target one specific device or avoid sending to others on the network.

### Network Interface (IN / OUT)

- **IN** — the interface Lumina listens on for incoming ArtNet. `Any (all interfaces)` is a safe default.
- **OUT** — the interface Lumina sends ArtNet from. `Default` works fine on a dedicated show computer with a single network connection.

> **Note for general-purpose laptops only:** If your computer is connected to both WiFi (internet) and Ethernet (stage network) at the same time, set OUT to the specific Ethernet NIC connected to the stage. Leaving it on `Default` may cause ArtNet packets to go out the wrong interface and never reach your fixtures or console.

### DMX Input
- **Input Enable** — Monitor external DMX input
- **Input Source IP** — IP address to listen on

### Universe Routing
- Map Lumina universes to ArtNet or sACN universe numbers
- Use the numeric keypad to set custom universe IDs

---

## 9. Connecting Lumina to a Lighting System

Lumina can integrate with any ArtNet-compatible lighting system. Below are four connection setups, from simple standalone use to full integration with a GrandMA2 + NPU rig.

**Merge Mode Summary:**
- Setup 1 — Parallel / Broadcast → **HTP** merge on ArtNet nodes
- Setup 2 — Series / Unicast → **HTP** merge inside Lumina
- Setup 3 — Standalone → **no merge** (Lumina is the only source)
- Setup 4 — ArtNet Injection → **HTP** merge inside GrandMA2

---

### Setup 1 — Parallel / Broadcast (HTP)

**What it is:** Lumina and the lighting console both broadcast ArtNet to the same network. Each ArtNet node receives both streams and merges them using HTP (Highest Takes Precedence).

**When to use:** When you have ArtNet nodes (e.g. Luminex, Artistic Licence, MA 2-Port Node) that support dual-input HTP merge. Works alongside any existing ArtNet console without changing the console's configuration.

**Network setup:**
- Join the stage ArtNet network (subnet `2.x.x.x`, mask `255.0.0.0`)
- Set Lumina's IP to a unique address in that subnet (e.g. `2.0.0.10`)
- In Lumina → **SETTINGS** → ArtNet output: `OUTPUT ON`, broadcast address `2.255.255.255`
- In Lumina → **SETTINGS** → ArtNet input: `INPUT ON` (so the DMX Monitor can show what the console is sending)

**On each ArtNet node:**
- Enable **dual-input HTP merge**
- Set Source A = console IP, Source B = Lumina IP (or leave as broadcast-receive)

**How it works:** Both sources send DMX values. The node outputs whichever value is higher per channel — Lumina effects only "win" when their value is above the console's current value.

**Risk:** Cheap nodes may not support dual-input merge. Test before using in a show.

---

### Setup 2 — Series / Unicast (HTP)

**What it is:** The console sends ArtNet **unicast** directly to the Mac running Lumina. Lumina receives the console's DMX, merges it with its own output using HTP, and then sends the merged result to the ArtNet nodes.

**When to use:** When your nodes do not support dual-input merge, or when you want Lumina to be the single DMX source for the nodes.

**Network setup:**
- Set the console to send ArtNet **unicast** to the Mac's IP address (e.g. `2.0.0.10`)
- In Lumina → **SETTINGS** → ArtNet input: `INPUT ON`
- In Lumina → **SETTINGS** → ArtNet output: `OUTPUT ON`
- Lumina's `mergeUniverse()` function automatically performs HTP merge between `inputBuffer` (console) and `outputBuffer` (Lumina) on every frame

**How it works:** Lumina sits in the middle of the data path. It receives the console's data, merges it, and forwards the result. The console sees no ArtNet nodes directly — only Lumina does.

**Risk:** If Lumina crashes or the Mac goes offline, the fixtures go dark. Keep a backup route available.

---

### Setup 3 — Standalone (No Merge)

**What it is:** Lumina is the only lighting controller. There is no console. Lumina sends ArtNet directly to fixtures or ArtNet nodes.

**When to use:** Small shows, rehearsals, installations, or when a full console is not available.

**Network setup:**
- In Lumina → **SETTINGS** → ArtNet output: `OUTPUT ON`, broadcast or unicast to node IPs
- ArtNet input: not required
- Patch your fixtures in Lumina and build your cues, sequences, and effects

**How it works:** No merge is needed. Lumina is the single source of truth for all DMX channels.

---

### Setup 4 — ArtNet Injection into GrandMA2 (HTP)

**What it is:** Lumina injects ArtNet directly into a GrandMA2 console. The MA2 receives Lumina's data as an ArtNet input, merges it with its own output using HTP, and forwards the merged result to the stage via MA-Net to the NPU/MPU stage processor, which outputs the final DMX to the fixtures.

**When to use:** The console is already controlling the show through a full MA-Net + NPU rig. You want Lumina to act as a real-time effects engine on top of the existing system — like a pedal board added to an existing signal chain — without touching the existing network wiring or fixture patching.

**Network setup:**
1. Connect the Mac running Lumina to the **FOH network switch** (the same switch the MA2 is plugged into)
2. Set Lumina's IP to a unique address in the MA ArtNet subnet (e.g. `2.0.0.10`, mask `255.0.0.0`)
3. In Lumina → **SETTINGS** → ArtNet output: `OUTPUT ON`, broadcast address `2.255.255.255`
4. In Lumina → **SETTINGS** → ArtNet input: `INPUT ON` (optional — for DMX Monitor only)

**On the GrandMA2 console:**
1. Go to **Setup → Network Protocols → Art-Net**
2. Enable **"Art-Net Input Active"**
3. Enable **"Network DMX If Alone"**
4. Add an **Input** line: set `LocalStart`, `Amount`, and `Universe` to match the universes Lumina is sending
5. Press **Please** to confirm

**Make HTP work:**
Run this command on the MA2 to zero out all fixture values so Lumina's values can win the HTP merge:
```
Attribute Thru At 0
```
After running this command, Lumina's values will be the highest on every channel and will take over. When the lighting operator brings up a cue, the MA2's values will rise and take precedence on those channels instead.

**How it works:** MA2 receives Lumina's ArtNet and merges it internally using HTP. The merged result travels via MA-Net (MA's proprietary protocol) to the NPU/MPU stage processor, which outputs final DMX to the fixtures. No changes are needed to the existing stage wiring or node configuration.

**Note:** This is the same method used by tracking systems like BlackTrax — they also inject positional data via ArtNet into the MA2 input for real-time fixture control on top of the show's running cues.

---

## 10. Show File Management

### Saving a Show
1. Open the **Lumina Menu** (click the Lumina logo or menu button)
2. Go to the **SAVE** tab
3. Enter a filename
4. Click **SAVE**

Show files are saved as `.lumina` format containing all fixtures, cues, sequences, DMX patch, MIDI map, and settings.

### Loading a Show
1. Open the **Lumina Menu**
2. Go to the **LOAD** tab
3. Browse your local shows, GitHub community shows, or USB drives
4. Click a show to load it

### Auto-Save
- Lumina auto-saves your work periodically
- Keeps rotating backups (backup-1, backup-2, backup-3)
- Older backups are automatically rotated out

### USB Drive Support
- Save shows directly to a USB drive
- Load shows from USB drives
- Shows are stored in a "Lumina Shows" folder on the drive

### Software Updates
- Go to the **UPDATE** tab in the Lumina Menu
- Click **Check for Updates** to see if a new version is available
- Click **Apply Update** to install

---

## 11. Keyboard Shortcuts

| Action | Windows | Mac |
|--------|---------|-----|
| Play / Pause | **Space** | **Space** |
| Delete selected cues | **Delete** | **Delete / Backspace** |
| Clear selection / cancel | **Escape** | **Escape** |
| Undo | **Ctrl+Z** | **Cmd+Z** |
| Redo | **Ctrl+Shift+Z** | **Cmd+Shift+Z** |
| Redo (alternate) | **Ctrl+Y** | **Cmd+Y** |
| Confirm input dialogs | **Enter** | **Enter** |
| Multi-select cues | **Shift + Click** | **Shift + Click** |

---

## 12. Settings & Preferences

Found in the **SET** tab:

### Display
- **Screen Flash** — Flash the screen on cue triggers (green for select all, red for delete, white for loop). Toggle on/off in Setup
- **Auto Dissolve** — Smooth transitions between sequential cues. Toggle on/off
- **Click Sound** — Audible feedback on interactions. Toggle on/off
- **OSD (On-Screen Display)** — Shows parameter changes briefly on screen

### Startup
- **Startup Show** — Choose which show loads when the app opens
- **MIDI at Startup** — Auto-connect MIDI controller on launch

### Master Level Warning
- When master fader is below 100%, the LUMINA FX logo flashes red as a reminder

---

## Need Help?

Visit the GitHub repository for updates and community show files:
https://github.com/shtarkair/LUMINA-FX-V1A
