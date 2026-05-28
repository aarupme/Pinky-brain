# Operator Quick Guide

Use this page when you want to operate Pinky Brain without reading the full manual.

## Default mode

Use Single Terminal Mode.

- Keep the watcher stopped while planning, patching, reviewing, or recovering.
- Start the watcher only for a bounded Pinky execution or verification.
- Use `.run/pinky-code-editor-command.txt` as the command source.
- Disable visible-chat fallback during normal operation with `PINKY_READ_VISIBLE=/bin/false`.
- Send `Narf!` only as the final callback after the full outer terminal workflow has completed.

## Fast path: run one Pinky command

1. Reset stale runtime files.
2. Write exactly one v2 envelope to `.run/pinky-code-editor-command.txt`.
3. Run bounded watcher.
4. Let watcher stop.
5. Run status/proof checks.
6. Send final callback with `./bin/pinky-send --text 'Narf!'`.

## Standard wrapper

```bash
cd ~/Desktop/pinky-brain && rm -f .run/pinky-command.candidate .run/pinky-command.candidate.classification .run/pinky-command.candidate.reason .run/pinky-transport.input .run/pinky-command.last-hash && ./bin/pinky-set-state stopped && printf "%s\n" "PINKY-BASH-START" "cd ~/Desktop/pinky-brain && ./bin/pinky-status" "PINKY-BASH-END" > .run/pinky-code-editor-command.txt && PINKY_READ_VISIBLE=/bin/false ./bin/pinky-cockpit-watch --max-cycles 10 --sleep 0.2 && ./bin/pinky-status && ./bin/pinky-send --text 'Narf!'
```

## Stop signals

Stop and recover before continuing if:

- the watcher does not stop
- final `Narf!` does not arrive
- the prompt is trapped in quote or continuation mode
- `candidate=present` remains after the watcher stopped
- logs grow unexpectedly
- old syntax appears in a normal workflow page

## Recovery rule

Stop the watcher first. Then inspect with bounded commands from the same single Terminal.

## Stable source contract

The executable source is `.run/pinky-code-editor-command.txt`.

Normal chat is not executable. Visible chat history is not a command source. This prevents old envelopes, markdown, terminal echoes, and UI markup from being picked up as commands.

Normal workflow:

1. Write one bounded envelope into `.run/pinky-code-editor-command.txt`.
2. Start or keep the visible cockpit watcher running.
3. Pinky extracts the command from that file only.
4. Pinky executes visibly in Terminal.
5. Pinky clears candidate and command-source state.
6. Pinky sends `Narf!` after the terminal workflow completes.

Visible-chat fallback is test-only and must be enabled explicitly with `PINKY_ALLOW_VISIBLE_FALLBACK=1`.
