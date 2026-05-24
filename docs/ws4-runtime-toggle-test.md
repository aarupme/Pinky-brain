# WS4 — Runtime Toggle

Status: COMPLETE

Validated: 2026-05-24 22:16:44

## Files

- bin/pinky-mode
- bin/pinky-beacon-status

## Behavior

The command:

./bin/pinky-mode on

Performs:
- applies Pinky workspace layout
- starts Pinky beacon through the safe process wrapper
- sends prompts/runtime-start.txt to ChatGPT

The command:

./bin/pinky-mode off

Performs:
- sends prompts/runtime-stop.txt to ChatGPT
- stops Pinky beacon through the safe process wrapper

The command:

./bin/pinky-mode status

Performs:
- shows tracked beacon PID
- shows active Pinky beacon process
- excludes helper/status wrapper processes from the process list

## Manual validation

Validated ON:
- workspace layout applied
- beacon started
- runtime-start prompt sent to ChatGPT
- status showed one tracked beacon process

Validated OFF:
- runtime-stop prompt sent to ChatGPT
- beacon stopped
- status showed no active beacon process

## Known limitations

- Runtime ON/OFF is still command-line based.
- No menu bar control yet.
- No signal watcher yet.
- No automatic beacon state update from ChatGPT messages yet.

## Next workstream

WS5 — Signal Watcher

Goal:
Read latest ChatGPT assistant output through the Accessibility tree and detect:
- 🐭
- 🧠
- 🛑

MVP behavior:
- detect latest assistant message
- identify latest runtime signal
- log signal
- no auto-send yet
- no destructive automation
