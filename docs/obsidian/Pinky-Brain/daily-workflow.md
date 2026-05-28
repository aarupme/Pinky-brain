# Daily Workflow

This is the normal operating path for Pinky Brain.

## Start from stopped or sleeping

Do not assume Pinky is running.

When Pinky is stopped or sleeping, use Brain lane first.

The assistant should either:

- ask Brain a numbered decision question
- give a manual Terminal 2 instruction
- direct Brain to start the cockpit watcher in Terminal 1

## Start cockpit watcher

Terminal 1 is the cockpit watcher terminal.

Start Pinky only when Brain has chosen to start it.

Expected startup behavior:

1. Terminal 1 starts the cockpit watcher.
2. The watcher prints that it is watching.
3. Pinky sends `Narf!`.
4. Terminal 1 remains dedicated to the cockpit watcher.

## Send one envelope

When Pinky is awake, the assistant may send exactly one runnable v2 envelope.

```text
PINKY-BASH-START
cd ~/Desktop/pinky-brain && <safe command>
PINKY-BASH-END
```

Do not send a second command until the first one has completed and Pinky has returned control.

## Confirm completion

A completed Pinky execution must report `Narf!`.

The watcher should also show the last exit code.

After completion:

1. Assistant reduces `Bash remaining` by one.
2. Assistant explains the delta reason.
3. Assistant either continues with the next safe step or asks Brain for a numbered decision.

## Use Terminal 2 for admin and recovery

Terminal 2 is for Brain/admin/recovery work.

Use it when:

- Pinky is sleeping
- Pinky is stopped
- cockpit watcher is not visible
- a command failed before execution
- logs or state need inspection
- manual file writing is safer than Pinky execution

## Daily loop

1. Brain chooses the next mode.
2. Assistant prepares one safe step.
3. Terminal 1 runs Pinky only if watcher is active.
4. Terminal 2 handles admin/recovery when Pinky is stopped.
5. Pinky reports `Narf!` after execution.
6. Assistant updates `Bash remaining`.
7. Brain answers the next numbered question when needed.

## Stop conditions

Stop automation and return to Brain lane when:

- Pinky does not send `Narf!`
- Terminal enters quote, heredoc, or continuation mode
- output looks recursive
- logs grow unexpectedly
- the command path is unclear
- the next action requires product or UX judgment
