# WS35 Kill-Switch Proof

Purpose: execute the WS28 F05 kill-switch stress test in a controlled, non-destructive way.

## Scope

- Inspect the existing kill-switch implementation before testing.
- Verify the actual command path instead of assuming file names.
- Run the safest first proof: kill while runtime is already stopped.
- Confirm the runtime remains stopped, beacon remains stopped, and repo remains clean.

## Source inspected

- bin/pinky-mode
- bin/pinky-loop
- bin/pinky-kill
- bin directory listing
- docs/workstreams/ws28-future-feature-stress-backlog.md

## Finding

The actual kill command is bin/pinky-kill. There is no bin/pinky-stop file. The mode wrapper routes k/kill to bin/pinky-kill.

bin/pinky-kill performs these actions:

- creates the run directory if needed
- touches the loop stop file
- sets state to stopped
- stops the loop
- stops the beacon
- prints a concise stopped confirmation

## Proof executed

Command:

cd ~/Desktop/pinky-brain && ./bin/pinky-mode k && printf "\n--- after kill proof ---\n" && ./bin/pinky-status

Observed result:

- Pinky kill switch activated
- automation=stopped
- git=clean
- loop=stopped pid=none
- beacon=stopped pid=none
- loop-stop=present
- candidate=none
- dry-run=none

## Result

PASS: kill-switch is idempotent when runtime is already stopped.

## Remaining F05 work

A later runtime-active proof should verify k/K stops an active loop and beacon cleanly. That test should start from a clean repo, intentionally start runtime, confirm loop/beacon running, trigger the kill path, then confirm stopped recovery.
