# WS2 — Floating Beacon Prototype

Status: PARTIAL COMPLETE

Validated: 2026-05-24 13:26:23

## Files

- bin/pinky-beacon
- bin/pinky-beacon-start
- bin/pinky-beacon-stop
- bin/pinky-beacon-status
- logs/pinky-beacon.log
- .run/pinky-beacon.pid

## Current behavior

- Creates a top-center floating Pinky Brain beacon.
- Uses a frameless halfmoon-style prototype surface.
- Stays above normal macOS windows using topmost/lift loop.
- Click cycles states.
- Keyboard shortcuts:
  - 1 = Idle
  - 2 = Pinky Active
  - 3 = Brain Needed
  - 4 = Paused
  - 5 = Stopped
  - Esc = close window

## Terminal/process discipline

Long-running UI processes must not be launched directly in the foreground by default.

Use:

./bin/pinky-beacon-start

This command:
- stops any existing tracked Pinky beacon
- starts one clean background instance
- writes .run/pinky-beacon.pid
- writes logs/pinky-beacon.log
- keeps Terminal usable

Use:

./bin/pinky-beacon-stop

This command:
- stops the tracked beacon process
- removes .run/pinky-beacon.pid

Use:

./bin/pinky-beacon-status

This command:
- shows the tracked PID
- shows active Pinky beacon processes

## Known limitations

- Tkinter can prototype shape and topmost behavior, but real native polish should move to SwiftUI/AppKit.
- Tk transparent/shaped window behavior may differ across macOS versions.
- Current halfmoon surface is functional but not final visual design.
- No sound yet.
- No ChatGPT signal watcher yet.
- No ON/OFF runtime integration yet.

## Next recommended step

WS2.1 — Refine Beacon Visual Design

Goal:
Make the halfmoon feel like a native macOS menu-bar-adjacent overlay:
- smaller height
- cleaner translucent glass feel
- stronger icon hierarchy
- less “window” feeling
- no visible controls
- state change only through code/manual shortcuts for now

After that:
WS3 — Brain Sound Alert
