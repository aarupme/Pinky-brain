# WS6 — Auto Pinky Loop

Status: COMPLETE

Validated: 2026-05-24 22:45:52

## Files

- bin/pinky-loop
- bin/pinky-watch-once
- bin/pinky-detect-signal
- bin/pinky-kill
- bin/pinky-mode
- docs/ws6-auto-pinky-loop-test.md

## Behavior

WS6 adds controlled automatic continuation for the Pinky signal only.

Runtime signal handling:

- 🐭 -> sends "l" once when safe
- repeated same 🐭 -> skipped by signal hash
- 🧠 -> switches to Brain state, does not send anything
- 🛑 -> creates stop file, switches beacon to Stopped, halts automation

## Safety controls

- .run/pinky-loop.stop acts as manual stop/hard-stop file
- bin/pinky-kill activates the stop file and sets beacon to stopped
- pinky-mode off uses pinky-kill
- pinky-loop once performs one controlled pass only
- pinky-loop start runs the loop in managed background mode
- pinky-loop stop kills parent loop and helper processes
- signal_hash prevents duplicate l sends for the same detected signal
- cooldown prevents rapid repeated l sends
- no auto-send happens on brain or stop signals

## Manual validation

Validated Pinky auto-send:

- Fresh standalone 🐭 detected
- ./bin/pinky-loop once returned loop=pinky-autosent-l
- logs/pinky-loop.log recorded autosend=l
- .run/pinky-loop.last-hash was written

Validated same-message protection:

- Re-running without a new 🐭 returned loop=pinky-skipped-same-message
- logs/pinky-loop.log recorded autosend=skipped reason=same-hash
- no duplicate l was sent

Validated Brain safety:

- Fresh standalone 🧠 detected
- ./bin/pinky-loop once returned loop=brain-needed
- .run/pinky-signal.state contained brain
- .run/pinky-beacon.state contained brain
- no l was sent

Validated hard stop:

- Fresh standalone 🛑 detected
- ./bin/pinky-loop once returned loop=hard-stop
- .run/pinky-loop.stop became present
- .run/pinky-signal.state contained stop
- .run/pinky-beacon.state contained stopped
- no active loop processes remained

## Current operating model

Safe manual loop pass:

./bin/pinky-loop once

Managed background loop:

./bin/pinky-loop start

Stop loop:

./bin/pinky-loop stop

Hard kill:

./bin/pinky-kill

Runtime mode on/off:

./bin/pinky-mode on
./bin/pinky-mode off

## Known limitations

- Signal detection is based on currently visible ChatGPT Accessibility text.
- Signal hash uses recent standalone runtime signal counting.
- k/K kill switch is included in the runtime prompt, but not yet detected directly from user input outside ChatGPT.
- Background loop should be used carefully until more long-run testing is complete.
- No menu bar UI yet.
- No native SwiftUI/AppKit app yet.

## Next workstream

WS7 — Long-Run Supervised Loop Test

Goal:
Run the managed loop through a short real development cycle and confirm:
- loop start/stop stability
- no duplicate l sends
- Brain alert pauses correctly
- Stop signal halts correctly
- logs remain readable
- no orphan processes remain
