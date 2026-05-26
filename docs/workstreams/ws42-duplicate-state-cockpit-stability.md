# WS42 Duplicate State Cockpit Stability

Purpose: prevent harmless duplicate suppression from showing a stale or confusing duplicate cockpit state.

## Problem

After WS41, Pinky was generally healthy, but duplicate suppression could temporarily show state=duplicate in the cockpit. This made the runtime look like it was in a special state even though no action was needed and the correct operator-facing state was simply watching.

## Root cause

bin/pinky-loop deliberately set state=duplicate in two duplicate-suppression paths:

- duplicate toolbox command candidate
- duplicate Pinky auto-send signal hash

Both paths are harmless suppression cases and should not change the visible cockpit state away from watching.

## Change

Updated bin/pinky-loop so duplicate suppression logs the duplicate event while keeping runtime state at watching.

## Validation

Validated with:

- bash -n bin/pinky-loop
- ./bin/pinky-self-test
- git --no-pager diff -- bin/pinky-loop
- ./bin/pinky-cockpit

Observed result:

- self-test=pass
- duplicate paths now set/keep state=watching
- cockpit reports state=watching
- loop and beacon remain running
- candidate remains none

## Result

PASS: duplicate suppression no longer creates a confusing visible duplicate cockpit state.

## Follow-up

Duplicate events are still logged for auditability. Future cockpit design can expose duplicate counts separately without making duplicate a primary runtime state.
