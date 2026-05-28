# Single Terminal Code-Editor Workflow

This is the default Pinky Brain operating workflow.

Use one Terminal. Keep the watcher stopped while preparing or patching code. Start the watcher only for a bounded Pinky execution or verification run.

## Core contract

- ChatGPT writes runnable commands into `.run/pinky-code-editor-command.txt`.
- Pinky reads that file before any visible-chat fallback.
- Run bounded watcher tests with `PINKY_READ_VISIBLE=/bin/false`.
- Watcher startup prints `PINKY cockpit state=watching`.
- Startup does not send `Narf!`.
- Inner transport completion does not send `Narf!`.
- The outermost terminal workflow sends `Narf!` to ChatGPT only after every command in the shell chain has finished.

## Step-by-step: run one Pinky command

1. Start from a clean stopped runtime.
2. Remove stale candidate and transport files.
3. Write exactly one v2 envelope into `.run/pinky-code-editor-command.txt`.
4. Run `PINKY_READ_VISIBLE=/bin/false ./bin/pinky-cockpit-watch --max-cycles 10 --sleep 0.2`.
5. Let the watcher stop with `PINKY cockpit state=stopped reason=max_cycles`.
6. Run any status, diff, test, commit, or push commands that belong to the workflow.
7. Send the callback with `./bin/pinky-send --text 'Narf!'` as the final command only.

## Wrapper pattern

```bash
cd ~/Desktop/pinky-brain && rm -f .run/pinky-command.candidate .run/pinky-command.candidate.classification .run/pinky-command.candidate.reason .run/pinky-transport.input .run/pinky-command.last-hash && ./bin/pinky-set-state stopped && printf "%s\n" "PINKY-BASH-START" "cd ~/Desktop/pinky-brain && ./bin/pinky-status" "PINKY-BASH-END" > .run/pinky-code-editor-command.txt && PINKY_READ_VISIBLE=/bin/false ./bin/pinky-cockpit-watch --max-cycles 10 --sleep 0.2 && ./bin/pinky-status && ./bin/pinky-send --text 'Narf!'
```

## Do not do this

- Do not rely on visible ChatGPT text as the primary command source.
- Do not send `Narf!` from inside the Pinky envelope.
- Do not send `Narf!` at watcher startup.
- Do not patch files while the watcher is running.
- Do not use heredocs for operational commands.
- Do not continue after `Narf!` unless it was sent by the outermost workflow.
