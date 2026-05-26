# Pinky Brain Operator Command Reference

Compact operator reference for the local Pinky Brain runtime.

## Core rule

Pinky Brain is a supervised local runtime. It must preserve manual control and must not auto-execute high-impact commands. Use read-only inspection first, keep commands short, and avoid pagers or destructive side effects.

## Fast operator commands

| Command | Purpose | Notes |
| --- | --- | --- |
| `./bin/pinky-mode on` | Start the Pinky workspace mode | Opens/restores layout, starts beacon, sends the runtime prompt. |
| `./bin/pinky-mode off` | Stop Pinky mode | Runs the kill path, stops beacon, sends the stop prompt. |
| `./bin/pinky-mode status` | Show full runtime dashboard | Delegates to `./bin/pinky-status`. |
| `./bin/pinky-mode k` | Local kill switch | Same stop path as `kill`; use when automation must stop immediately. |
| `./bin/pinky-mode K` | Local kill switch | Uppercase alias for `k`. |
| `./bin/pinky-mode kill` | Local kill switch | Stops loop and beacon and sets stopped state. |
| `./bin/pinky-mode help` | Show mode commands | Read-only help output. |
| `./bin/pinky-status` | Read-only dashboard | Shows git cleanliness, loop/beacon state, command candidate/dry-run state, latest signal state, and compact log tails. |
| `./bin/pinky-protocol` | Read-only protocol contract | Prints the current Brain/user Terminal lane, Pinky toolbox lane, continuation lane, standalone signal rule, and command execution rule. |

## Conversation protocol

| Signal | Meaning | Operator action |
| --- | --- | --- |
| `Narf!` | Pinky-safe continue signal | Pinky may continue only through the supervised safe path. |
| `🐭` | Legacy Pinky continue signal | Kept for compatibility; prefer `Narf!` in operator language. |
| `🧠` | Brain decision required | Stop and let the human/model decide. |
| `🛑` | Hard stop | Stop automation. |
| `k` or `K` | User kill switch | Treat as immediate local stop. |

## Command candidate flow

Pinky command execution is deliberately gated.

1. The assistant may expose a candidate command only inside the command marker protocol.
2. `./bin/pinky-command-detect` checks whether a runnable marker is visible.
3. `./bin/pinky-command-extract` extracts a project-prefixed candidate into `.run/pinky-command.candidate`.
4. `./bin/pinky-command-dry-run` classifies the candidate without executing it.
5. `./bin/pinky-command-run` executes only candidates classified as safe.
6. `./bin/pinky-command-clear` removes the current candidate.

## Marker rules

Runnable candidates use this visible sequence:

```text
🧰 PINKY-RUN
cd ~/Desktop/pinky-brain && <allowed command>
🧰 PINKY-READY
```

Current extractor rules require the command to start with:

```text
cd ~/Desktop/pinky-brain &&
```

The extractor avoids self-extraction, git status probes, and sleep-only probes.

## Safety classification

| Classification | Meaning |
| --- | --- |
| `safe` | Allowed for local execution by the command runner. |
| `brain_required` | Human/model decision required before execution. |
| `blocked` | Must not be executed by Pinky. |
| `none` | No candidate exists. |

Current safe allowlist is intentionally narrow and limited to local read-only status/detection commands. High-impact commands such as commits, pushes, installs, deployments, migrations, and broad unrecognized project commands require brain review. Dangerous patterns such as `sudo`, destructive removes, ownership/mode changes, shell-piped network installs, disk utilities, and invalid prefixes are blocked.

## Safe workflow reminders

- `l` means: wait briefly, inspect visible terminal state, report success/failure/in-progress, then provide one next safe command only when appropriate.
- Use `git --no-pager` for git log/diff output.
- Do not use commands that open interactive pagers.
- Do not use heredocs or fragile long quoted shell writes.
- Inspect before patching.
- Patch in small reversible slices.
- Validate before commit.
- Commit and push only after validation.
