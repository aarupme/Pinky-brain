# Troubleshooting

Use this page when the system behavior does not match the expected Pinky Brain loop.

## No `Narf!` after startup

Likely causes:

- cockpit watcher did not start
- Terminal 1 is not actually watching
- watcher lock or state is stale
- Pinky is stopped or sleeping

Action:

1. Stop sending Pinky envelopes.
2. Use Terminal 2.
3. Inspect status with bounded commands.
4. Restart only after state is clear.

## No `Narf!` after execution

Likely causes:

- command is still running
- command failed before callback
- transport did not complete
- output/log guard stopped the path

Action:

1. Do not resend the same envelope.
2. Inspect the last exit/status from Terminal 2.
3. Check bounded recent logs only.
4. Return to Brain decision if unclear.

## Repeated `Narf!`

Likely causes:

- duplicate watcher
- stale loop
- repeated callback from old state
- Terminal roles are mixed

Action:

1. Stop automation.
2. Check for multiple watcher processes.
3. Check watcher lock.
4. Keep Terminal 1 dedicated to cockpit watcher only.

## Command rejected before execution

Likely causes:

- incomplete envelope
- empty envelope
- nested envelope
- duplicate command hash
- placeholder command
- syntax check failure
- command classified as blocked or Brain-required

Action:

1. Read the rejection reason.
2. Simplify the command.
3. Ask Brain if the command requires judgment.
4. Do not bypass the rejection with unsafe syntax.

## Terminal is trapped in quote or continuation prompt

Symptoms:

- prompt changes to continuation mode
- pasted command does not run
- shell waits for closing quote or heredoc terminator

Action:

1. Press Control-C.
2. Confirm the normal prompt is back.
3. Do not paste more command text into the trapped prompt.
4. Replace the command with a simpler safe shape.

## Old syntax appears in docs

Likely causes:

- stale protocol page
- old workstream notes
- compatibility tests
- legacy examples not marked as retired

Action:

1. Do not treat old syntax as the current operator contract.
2. Current operator contract is v2 envelope only.
3. Move legacy syntax explanations to `legacy-and-retired-syntax.md`.

## Wrong terminal used

Terminal roles:

- Terminal 1 = Pinky cockpit watcher only
- Terminal 2 = Brain/admin/recovery only

Action:

1. Stop and identify which terminal is doing what.
2. Restore Terminal 1 to watcher-only.
3. Use Terminal 2 for inspection, recovery, or manual writes.

## Logs are too large

Large logs indicate safety risk.

Action:

1. Stop automation.
2. Do not tail or watch growing logs.
3. Use bounded reads only.
4. Fix recursive status/log behavior before restart.
