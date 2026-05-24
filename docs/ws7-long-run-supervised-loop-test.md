# WS7 — Long-Run Supervised Loop Test

Status: COMPLETE

Validated: 2026-05-24 22:51:18

## Purpose

Validate Pinky Brain as a supervised runtime loop, not just one-shot commands.

## Test setup

Started Pinky Brain mode with:

./bin/pinky-mode on

Cleared previous loop state:

- .run/pinky-loop.stop
- .run/pinky-loop.last-hash
- .run/pinky-loop.last-send

Started managed background loop with:

./bin/pinky-loop start

## Results

### Pinky auto-continue

Fresh standalone 🐭 was detected.

Observed result:

- signal=pinky
- autosend=l
- loop=pinky-autosent-l
- .run/pinky-loop.last-hash written

Result: PASS

### Duplicate-send protection

The same visible 🐭 continued to be detected repeatedly.

Observed result:

- signal=pinky
- autosend=skipped reason=same-hash
- loop=pinky-skipped-same-message

Result: PASS

No duplicate l sends occurred.

### Brain interruption

Fresh standalone 🧠 was detected while the background loop was running.

Observed result:

- signal=brain
- loop=brain-needed
- .run/pinky-signal.state contained brain
- .run/pinky-beacon.state contained brain
- Brain alert sound played after detection
- no autosend=l occurred after Brain appeared

Result: PASS

### Hard stop

Fresh standalone 🛑 was detected while the background loop was running.

Observed result:

- signal=stop
- loop=hard-stop
- .run/pinky-loop.stop became present
- .run/pinky-signal.state contained stop
- .run/pinky-beacon.state contained stopped
- active loop processes became none

Result: PASS

### Cleanup

Ran:

./bin/pinky-loop stop

Observed result:

- loop pid: none
- stop file: present
- active loop processes: none

Result: PASS

## Current validated operating model

Start runtime:

./bin/pinky-mode on

Start supervised loop:

./bin/pinky-loop start

Inspect status:

./bin/pinky-loop status
./bin/pinky-beacon-status

Stop loop:

./bin/pinky-loop stop

Hard kill:

./bin/pinky-kill

Stop full Pinky mode:

./bin/pinky-mode off

## Known issues / follow-up

- pinky-loop status can show a stale PID while the process is already gone until pinky-loop stop clears it.
- Signal detection is still based on visible ChatGPT Accessibility text.
- Background loop is validated for short supervised runs, not all-day unattended operation.
- k/K kill switch is implemented in the runtime prompt, but not yet independently detected as a local user input signal.
- Beacon remains running after loop stop unless explicitly stopped or pinky-mode off is used.

## Next recommended workstream

WS8 — Runtime Hardening

Scope:

- make status auto-clear stale PID files
- make pinky-mode off non-blocking/reliable
- add local k/K kill-switch capture strategy
- add log compaction/readability
- add safer loop health reporting
- optionally add menu/control surface later
