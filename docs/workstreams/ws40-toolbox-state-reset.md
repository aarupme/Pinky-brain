# WS40 Toolbox State Reset

Purpose: prove toolbox execution after the manual-command signal guards and fix the stale execution state after successful toolbox runs.

## Problem

After toolbox commands completed successfully, the cockpit could remain at state=executing. This made it look like Pinky was still busy even though command execution had finished and the loop had returned to normal scanning.

## Root cause

bin/pinky-command-run sets runtime state during command execution, but the command path in bin/pinky-loop returned after command-checked without normalizing the state back to watching.

## Change

Updated bin/pinky-loop so that after bin/pinky-command-run completes, the loop sets Pinky state back to watching before returning command-checked.

## Validation

Validated with:

- toolbox read-only command proof
- toolbox self-test command proof
- post-completion cockpit inspection
- bash -n bin/pinky-loop
- ./bin/pinky-self-test
- ./bin/pinky-cockpit

Observed result:

- toolbox execution works again
- no unwanted decision alert ding occurred during the proofs
- command run log showed exit_code=0
- immediate in-command report may still show state=executing because it runs before control returns to the loop
- post-completion cockpit report returns to state=watching
- loop and beacon remain running
- candidate remains none

## Result

PASS: successful toolbox command completion now returns Pinky to watching state after the loop regains control.

## Follow-up

For better operator visibility, future toolbox execution could print a post-run cockpit report after the loop-level state reset, so the final visible line always reflects the normalized post-command state.
