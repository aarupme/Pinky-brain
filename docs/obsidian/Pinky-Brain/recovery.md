# Recovery

Use recovery whenever Pinky behavior is unclear, stuck, duplicated, or unsafe.

## First rule

Do not keep pushing commands into a failing path.

Stop automation, return to Brain lane, and use Terminal 2 for bounded inspection.

## If Pinky is sleeping or stopped

Do not send a Pinky envelope.

Use Brain lane first:

1. Confirm Pinky is stopped or sleeping.
2. Decide whether to restart cockpit watcher.
3. Use Terminal 2 for admin checks.
4. Only return to Pinky lane after Terminal 1 is visibly watching.

## If `Narf!` does not appear

Expected behavior is `Narf!` on cockpit startup and after each completed execution.

If it does not appear:

1. Stop sending Pinky envelopes.
2. Inspect from Terminal 2.
3. Check cockpit watcher state.
4. Check recent logs with bounded commands only.
5. Decide whether to restart Pinky.

## If cockpit watcher is stuck

Use Terminal 2.

Check for:

- stale watcher lock
- multiple watcher processes
- state stuck outside `watching`
- command still executing
- oversized logs

Do not start another watcher until the lock/state situation is understood.

## If duplicate suppression blocks execution

Pinky may suppress a command that has the same hash as a previous command.

This is a safety feature.

Recovery options:

- confirm whether the previous execution already completed
- change the command only when a real new action is needed
- avoid resending the same envelope repeatedly

## If syntax check fails

Do not patch blindly.

Use a simpler command shape.

Avoid:

- open quotes
- heredocs
- nested command strings
- complex inline scripting
- shell interpolation inside generated code

## If logs grow too large

Large logs are a stop signal.

1. Stop automation.
2. Use bounded inspection commands.
3. Do not recursively read status logs.
4. Do not run watch/tail loops.
5. Fix the source of growth before restarting Pinky.

## Recovery terminal rule

Terminal 1 is for cockpit watcher.

Terminal 2 is for recovery.

When recovering, do not blur the two terminals.
