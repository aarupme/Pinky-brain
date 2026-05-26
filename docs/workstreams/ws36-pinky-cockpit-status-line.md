# WS36 Pinky Cockpit Status Line

Purpose: prevent runtime-state guessing by adding a stable, visually scannable Terminal cockpit line.

## Problem

During Pinky Brain operation, the assistant previously relied too much on remembered runtime state. This caused workflow hiccups, including attempting toolbox execution while Pinky was stopped/sleeping.

## Change

Added bin/pinky-cockpit as a compact status dashboard and integrated it as the first visible line in bin/pinky-status.

## Cockpit fields

- state
- loop
- beacon
- candidate
- stop
- git

The output uses colored dots and a final check/warning marker when the terminal supports color. It gracefully falls back to plain text when color is unavailable.

## Validation

Commands validated:

- bash -n bin/pinky-cockpit bin/pinky-status
- ./bin/pinky-self-test
- ./bin/pinky-status

Observed result:

- self-test=pass
- cockpit appears at top of pinky-status
- dirty git state is clearly visible while files are modified/untracked
- runtime remains stopped
- beacon remains stopped
- candidate remains none

## Result

PASS: Pinky now has a stable cockpit status line that should be visible at the top of every status read.

## Follow-up

Use ./bin/pinky-status as the default first diagnostic command in future manual reads. Later, consider printing the cockpit line before and after toolbox command execution logs.
