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
9. [Show File Management](#show-file-management)
10. [Keyboard Shortcuts](#keyboard-shortcuts)
11. [Settings & Preferences](#settings--preferences)

---

## 1. Getting Started

### Installation
1. Download **Lumina-FX-V1A-Mac.zip** from the [Releases page](https://github.com/shtarkair/LUMINA-FX-V1A/releases)
2. Unzip the file
3. Double-click **Lumina FX.app**
4. On first launch, the app installs required components automatically

### Requirements
- macOS 12.0 or later
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

### DMX Input
- **Input Enable** — Monitor external DMX input
- **Input Source IP** — IP address to listen on

### Universe Routing
- Map Lumina universes to ArtNet or sACN universe numbers
- Use the numeric keypad to set custom universe IDs

---

## 9. Show File Management

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

## 10. Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| **Space** | Play / Pause |
| **Delete / Backspace** | Delete selected cues |
| **Escape** | Clear selection / cancel tool |
| **Ctrl+Z / Cmd+Z** | Undo |
| **Ctrl+Shift+Z / Cmd+Shift+Z** | Redo |
| **Ctrl+Y / Cmd+Y** | Redo (alternate) |
| **Enter** | Confirm input dialogs |
| **Shift + Click** | Multi-select cues |

---

## 11. Settings & Preferences

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
