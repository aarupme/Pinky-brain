# WS45 Sound Replay / Alert Isolation Hardening

Purpose: prevent brain-alert sound replay caused by visible/history replay or repeated state transitions.

## Problem

After WS44 made the brain ding auditable, live runtime testing exposed a replay problem. Brain-alert sounds could play repeatedly while the same alert remained visible or after runtime/beacon transitions. This made it difficult to distinguish a real unresolved decision alert from a stale replay.

## Root cause

The beacon originally relied on in-memory latch behavior. That was not stable enough because:

- the same visible brain state could reappear after watching transitions
- alert identity was not persisted as a durable event token
- beacon restart could forget the last played alert and replay a stale token
- state and alert handling needed stricter token-gated playback

## Change

Implemented alert-token based brain sound isolation.

Updated bin/pinky-set-state so brain state can write a durable alert token to:

- .run/pinky-beacon.alert

Updated bin/pinky-loop so real brain decision transitions pass the signal hash as the alert token.

Updated bin/pinky-beacon so tokenized brain alerts are sound-gated by alert identity instead of only state transitions.

Added persistent seen-token storage:

- .run/pinky-beacon.alert.seen

The beacon now remembers the last played brain alert token across restarts and only plays the sound for a new unique alert token.

Added tests/run-alert-token-fixtures and wired it into:

- bin/pinky-self-test
- bin/pinky-smoke

## Validation

Validated with:

- bash -n bin/pinky-set-state
- bash -n bin/pinky-loop
- python3 -m py_compile bin/pinky-beacon
- ./bin/pinky-self-test
- ./bin/pinky-smoke
- manual live beacon proof with repeated token and new token
- git status --short --branch
- post-commit runtime start/status check

Observed result:

- self-test passes
- normal smoke remains silent
- explicit sound smoke logs exactly one deliberate sound event
- repeated same alert token does not replay as a new event
- new alert token plays once
- runtime starts cleanly
- cockpit reports state=watching
- loop and beacon remain running
- repo is clean and synced after commit/push

## Result

PASS: brain-alert sound playback is now isolated to unique alert tokens instead of repeated visible/history state transitions.

## Follow-up

Future runtime health work can add a dedicated non-invasive live alert proof command that reports expected token deltas without relying on subjective audio perception.
