# Runtime Safety

Runtime safety is mandatory. These rules exist because Pinky Brain previously created recursive log/status behavior that produced huge logs.

## Non-negotiable rules

- Run preflight before cockpit startup.
- Run preflight before every transport execution.
- Syntax-check bash before execution.
- Cap transport output at write time.
- Guard against oversized logs.
- Use a singleton cockpit watcher lock.
- Do not create hidden or background loops.
- Do not recursively read status logs or growing logs.

## Preflight

Preflight protects the runtime before work starts.

Use it before:

- starting cockpit watcher
- sending transport execution
- recovery after abnormal behavior
- inspecting suspicious state

## Syntax check

Every bash payload must pass syntax checking before execution.

This prevents commands from trapping Terminal in:

- open quotes
- heredoc prompts
- continuation prompts
- malformed command chains

## Output cap

Transport output must be capped while it is written.

Do not rely only on reading less output later. The write path itself must prevent runaway logs.

## Log threshold guard

Large logs are a safety signal.

When logs grow unexpectedly:

1. Stop automation.
2. Use Brain lane.
3. Inspect with small bounded commands.
4. Do not run recursive status-log readers.

## Singleton cockpit watcher

Only one cockpit watcher should run.

The watcher lock prevents multiple visible loops from competing.

If watcher behavior looks duplicated, switch to recovery and inspect the lock/state before starting another watcher.

## Forbidden patterns

- no heredocs in operational commands
- no fragile inline patching with complex quote interpolation
- no background loops
- no recursive status-log reading
- no empty status-only Pinky messages
- no envelope execution while Pinky is stopped
- no commands likely to enter quote, heredoc, or continuation mode

## Safe command shape

Prefer short, bounded, inspectable commands.

Good:

```bash
cd ~/Desktop/pinky-brain && ./bin/pinky-status
```

Good:

```bash
cd ~/Desktop/pinky-brain && git --no-pager diff -- docs/obsidian/Pinky-Brain
```

Risky:

```bash
cd ~/Desktop/pinky-brain && cat <<EOF > file.md
```

Risky:

```bash
cd ~/Desktop/pinky-brain && tail -f logs/pinky-loop.log
```

## Recovery principle

When uncertain, stop automation and return to Brain lane.

A safe pause is better than a fast loop.
