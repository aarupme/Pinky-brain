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
| `./bin/pinky-self-test` | Read-only diagnostic test | Runs Pinky status and detector fixtures, then reports a pass/fail diagnostic checkpoint. |

## Conversation protocol

| Signal | Meaning | Operator action |
| --- | --- | --- |
| `Narf!` | Pinky-safe continue signal | Pinky may continue only through the supervised safe path. |
| `🐭` | Legacy Pinky continue signal | Kept for compatibility; prefer `Narf!` in operator language. |
| `🧠` | Brain decision required | Stop and let the human/model decide. |
| `🛑` | Hard stop | Stop automation. |
| `k` or `K` | User kill switch | Treat as immediate local stop. |

## Command candidate flow

Pinky cockpit execution is the primary user-facing path.

1. The assistant exposes exactly one visible direct command ending in `# pinky`.
2. `./bin/pinky-cockpit-watch` watches the code-editor command file from a foreground Terminal cockpit.
3. `./bin/pinky-command-extract` extracts the newest real project-prefixed command into `.run/pinky-command.candidate`.
4. Duplicate filtering prevents stale command replay.
5. `./bin/pinky-transport-once` visibly prints the picked command, executes it in Terminal, then prints `Narf!`.
6. Hidden/background transport remains secondary until the cockpit watcher is stable.

## Marker rules

Primary automatic candidates use this visible direct syntax:

```text
cd ~/Desktop/pinky-brain && <safe command> # pinky
```

Current extractor rules require the command to start with:

```text
cd ~/Desktop/pinky-brain &&
```

The extractor rejects placeholder/meta examples, self-extraction, cockpit/service control commands, docs probes, git status probes, and command bodies such as `<command>`.

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

## Cockpit status workflow

- Single Terminal Mode is the default: patch and recover with the watcher stopped.
- Start the foreground cockpit watcher only for live Pinky execution or bounded verification.
- Use ./bin/pinky-cockpit-status for read-only cockpit health checks.
- Do not send inspection, git, sed, or docs commands through the Pinky automatic lane.
- Pinky automatic lane is for simple visible execution payloads ending in # pinky.

## Safety checkpoint

- Pinky remains stopped after emergency log containment.
- Active executable surface is limited to guarded cockpit/status/extract/read/send/transport/preflight helpers.
- Legacy/background/clipboard/direct/beacon/control wrappers are non-executable.
- Transport execution requires preflight and syntax check before bash execution.
- Cockpit watcher requires preflight at startup and before each execution.
- Logs must remain below preflight threshold before Pinky can run.

## Pinky v2 command envelope

Pinky v2 must not execute suffix-only commands.

Required visible command envelope:

PINKY-BASH-START
cd ~/Desktop/pinky-brain && <safe command>
PINKY-BASH-END

Rules:
- Start marker and end marker are both required.
- Extract only the newest complete envelope.
- Ignore incomplete envelopes.
- Ignore quoted examples inside docs or shell strings.
- Retire suffix-only `# pinky` as active execution syntax.
- Keep Brain/Pinky binary lane separation.
- No hidden or background loops as the primary UX.
- Every completed Pinky execution must send `Narf!` back to ChatGPT.
- Every transport execution must pass preflight and syntax checks first.
- Output and logs must be bounded before Pinky can run again.
