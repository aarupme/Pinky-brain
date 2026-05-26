# WS28 Future Feature Stress Backlog

Purpose: use real future Pinky Brain feature work as controlled runtime stress tests, so bugs are discovered through normal development instead of artificial patch loops.

## Stress-test rules

- Start each feature slice from a clean synced repo.
- Keep runtime stopped before code edits unless the slice is explicitly a runtime proof.
- Use one Terminal command at a time.
- Inspect source before patching.
- Prefer docs/tests/harnesses before runtime behavior changes.
- Treat unexpected Pinky behavior as a test finding, not as an excuse for hot patching.
- Do not broaden signal detection without fixture coverage.

## Candidate future features

### F01 Startup and protocol clarity
Status: partly completed by WS25-WS27.
Stress target: compact startup, terminal protocol visibility, status clarity, fresh-chat handoff reliability.

### F02 Runtime self-test command
Goal: add a read-only command that checks repo cleanliness, runtime stopped/running state, detector fixtures, protocol source, and recent error logs.
Stress target: command composition, status accuracy, non-destructive diagnostics.

### F03 Controlled conversation continuation proof
Goal: repeat the WS24 two-signal proof as a reusable manual test checklist or command-assisted guide.
Stress target: continuation callback, signal hash uniqueness, duplicate suppression safety.

### F04 Toolbox lane proof
Goal: verify Pinky executes only commands exposed in the toolbox lane and rejects ordinary chat code blocks.
Stress target: command extraction, lane separation, safety boundaries.

### F05 Kill-switch proof
Goal: verify k/K stops automation cleanly from active runtime state.
Stress target: loop stop, beacon stop, candidate clearing, safe recovery.

### F06 Fresh-chat carry-over generator
Goal: generate a compact carry-over prompt from current repo status, recent commits, active protocol, and next recommended workstream.
Stress target: long-context recovery, handoff consistency, no giant startup bubble.

## Recommended next slice

WS29 should implement F02 as a read-only `pinky-self-test` command. It should not change runtime behavior.
