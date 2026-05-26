# WS37 Manual Command Signal Guard

Purpose: prevent manual Brain/user Terminal command blocks from triggering runtime decision alerts.

## Problem

While Pinky Brain mode was active, the beacon dinged even when the assistant had not intentionally emitted a fresh standalone decision signal. The visible chat contained a manual-lane control marker immediately followed by a fenced Terminal command. The signal detector treated that marker as a runtime alert.

## Root cause

bin/pinky-detect-signal accepted a standalone decision marker anywhere after the latest assistant block start, including the normal manual-command pattern:

- decision marker line
- blank line
- fenced bash command

That pattern is used to tell the human/operator to run a manual Terminal command. It should not wake Pinky as an unresolved runtime decision alert.

## Change

Updated bin/pinky-detect-signal so a standalone decision marker is ignored when the next meaningful line is a fenced code block.

## Regression coverage

Added tests/fixtures/brain-manual-command-nonmatch.txt and registered it in tests/run-detect-signal-fixtures.

The fixture verifies that this pattern returns signal=none:

- prose/context lines
- encoded decision marker
- blank line
- fenced bash command

## Validation

Commands validated:

- bash -n bin/pinky-detect-signal tests/run-detect-signal-fixtures
- ./tests/run-detect-signal-fixtures
- ./bin/pinky-self-test
- git --no-pager diff

Observed result:

- detect-signal fixtures pass
- command fixtures pass
- self-test=pass
- cockpit returned to watching during validation after stale brain state cleared

## Result

PASS: manual Terminal command prompts no longer produce runtime decision alerts when followed by a fenced command block.

## Follow-up

Pinky still needs a cleaner separation between Brain/manual-lane visibility and runtime signal visibility. Future work should consider structured assistant-output parsing rather than broad visible-text scanning.
