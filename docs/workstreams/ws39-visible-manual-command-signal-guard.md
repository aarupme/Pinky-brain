# WS39 Visible Manual Command Signal Guard

Purpose: prevent visible manual Terminal commands from being misread as unresolved runtime decision alerts.

## Problem

After WS37, the detector still sometimes returned signal=brain while the visible chat contained a manual Brain/user Terminal command pattern.

The first guard handled fenced code blocks, but ChatGPT visible text may strip the fence markers. In that rendered/readable form, the detector saw:

- decision marker
- prose/context
- plain repo-local command beginning with cd ~/Desktop/pinky-brain &&

That still triggered state=brain and could cause unnecessary alert behavior.

## Root cause

bin/pinky-detect-signal only ignored the decision marker when the next meaningful line looked like a fenced code block. It did not account for the visible-reader representation where the command appears as plain text without backticks.

## Change

Updated bin/pinky-detect-signal so a decision marker is ignored when a repo-local manual command appears within the next eight visible lines.

Added tests/fixtures/brain-manual-visible-command-nonmatch.txt and registered it in tests/run-detect-signal-fixtures.

## Validation

Validated with:

- bash -n bin/pinky-detect-signal tests/run-detect-signal-fixtures
- ./tests/run-detect-signal-fixtures
- ./bin/pinky-self-test
- ./bin/pinky-watch-once
- ./bin/pinky-cockpit
- git --no-pager diff

Observed result:

- signal fixtures pass
- command fixtures pass
- self-test=pass
- detector returns signal=none for the visible manual-command pattern
- cockpit returns to state=watching
- loop and beacon remain running

## Result

PASS: visible manual command prompts no longer trigger runtime decision-alert state.

## Follow-up

Future detector work should move toward structured lane parsing rather than broad visible-text scanning. Until then, manual-lane command patterns must be explicitly guarded with fixtures.
