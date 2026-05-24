# WS1 — Pinky Brain Sender Script

Status: COMPLETE

Validated: 2026-05-24 13:13:36

## Files

- bin/pinky-send
- prompts/runtime-start.txt
- prompts/runtime-stop.txt
- docs/ws1-sender-test.md

## Commands validated

- ./bin/pinky-send --help: passed
- ./bin/pinky-send: passed, exits non-zero with usage
- ./bin/pinky-send --file missing.txt: passed, exits non-zero with clear error
- ./bin/pinky-send --text "pinkytest": passed
- ./bin/pinky-send --start: passed
- ./bin/pinky-send --stop: passed

## Known limitation

The sender uses clipboard paste through AppleScript/System Events.
Clipboard preservation is included, but future WS1.1 may harden reliability if needed.

## Next workstream

WS2 — Floating Beacon Prototype
