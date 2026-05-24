# WS5 — Signal Watcher

Status: COMPLETE

Validated: 2026-05-24 22:32:27

## Files

- bin/pinky-read-visible
- bin/pinky-detect-signal
- bin/pinky-watch-once
- bin/pinky-set-state
- bin/pinky-beacon

## Behavior

The watcher path is currently non-looping and safe.

Signal read path:

1. ./bin/pinky-read-visible
   - reads visible ChatGPT text through macOS Accessibility
   - uses AXDescription from AXStaticText nodes

2. ./bin/pinky-detect-signal
   - scans recent visible text
   - detects only standalone recent runtime signal lines
   - supports:
     - 🐭 -> signal=pinky
     - 🧠 or <0001f9e0> -> signal=brain
     - 🛑 -> signal=stop
   - avoids false positives from old runtime prompt/code blocks

3. ./bin/pinky-watch-once
   - runs one detection pass only
   - writes .run/pinky-signal.state
   - appends logs/pinky-signal.log
   - updates beacon state through ./bin/pinky-set-state

4. ./bin/pinky-set-state
   - writes .run/pinky-beacon.state
   - beacon polls this file and updates visually without restart

## Manual validation

Validated Brain signal path:

- Fresh standalone 🧠 appeared in ChatGPT visible output.
- ./bin/pinky-watch-once returned signal=brain.
- .run/pinky-signal.state contained brain.
- .run/pinky-beacon.state contained brain.
- Beacon entered Brain state.

## Safety boundary

WS5 does not auto-send messages.
WS5 does not loop.
WS5 does not continue automatically.
WS5 only detects and reflects signal state.

## Known limitations

- Reads only currently visible ChatGPT text.
- Conservative signal detection requires standalone recent signal lines.
- Does not yet hash latest message.
- Does not yet debounce repeated signals.
- Does not yet auto-send l for 🐭.
- Does not yet implement k/K kill switch outside the runtime prompt.

## Next workstream

WS6 — Auto Pinky Loop

Goal:
Add controlled auto-send for 🐭 only.

Required safety:
- latest-message hash
- trigger once per message
- cooldown
- no auto-send on 🧠
- no auto-send on 🛑
- k/K user kill switch
- manual stop file
- clear logs
