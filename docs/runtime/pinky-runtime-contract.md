# Pinky Runtime Contract

## Current accepted model

Pinky Brain uses Terminal as the source of truth.

Required loop:

1. Brain writes a visible command into `.run/pinky-visible.txt`.
2. Pinky cockpit detects the command.
3. Pinky prints the picked command in Terminal.
4. Pinky executes the command in Terminal.
5. Pinky prints command output in Terminal.
6. Pinky records transport completion.
7. Pinky writes `.run/pinky-transport-complete`.
8. Pinky waits for `pinky-completion-barrier`.
9. Only after the barrier passes, live runtime may send `Narf!` back to ChatGPT.

## Hard rule: no early Narf

`Narf!` must never be sent while a Brain-issued bash block is still doing patch, proof, status, commit, push, or inspection work.

Live auto-continuation is allowed only when the runtime is started standalone:

```bash
cd ~/Desktop/pinky-brain && ./bin/pinky-start-real-runtime
```

Do not append status checks, sleeps, proofs, commits, or pushes after this command.

## Runtime modes

### Live runtime

Use only when Pinky should auto-continue:

```bash
cd ~/Desktop/pinky-brain && ./bin/pinky-start-real-runtime
```

This starts `pinky-cockpit-watch` with `PINKY_ALLOW_NARF=1`.

### Test runtime

Use during diagnostics, patching, and acceptance tests:

```bash
cd ~/Desktop/pinky-brain && ./bin/pinky-start-test-runtime
```

This starts with `PINKY_ALLOW_NARF=0`.

### Bounded one-shot tests

Use bounded cockpit tests for patch verification:

```bash
PINKY_MAX_CYCLES=3 PINKY_SLEEP_SECONDS=1 ./bin/pinky-cockpit-watch
```

Bounded tests must not send `Narf!`.

## Safe command submission

Submit a command to the live bridge with:

```bash
cd ~/Desktop/pinky-brain && printf 'cd ~/Desktop/pinky-brain && printf PINKY_OK # pinky\n' > .run/pinky-visible.txt
```

Commands must include `# pinky` so the extractor can classify them as intended Pinky commands.

## Acceptance proof from 2026-05-28

Final accepted evidence:

- Runtime PID was alive.
- `.run/pinky-real-runtime.log` showed command output, transport completion, completion settled, barrier ok, and narf gate allowed.
- `logs/pinky-send.log` showed `send=success target=ChatGPT`.
- `pinky-status` showed `last_transport` and `last_completion` with `exit_code=0`.
- Git was synced: `main...origin/main`.

## Key files

- `bin/pinky-command-extract`: reads deterministic bridge source `.run/pinky-visible.txt`.
- `bin/pinky-cockpit-watch`: main loop, completion sentinel, completion barrier, gated Narf.
- `bin/pinky-completion-barrier`: confirms completion sentinel before continuation.
- `bin/pinky-status`: reports transport and completion status.
- `bin/pinky-send`: sends callback to ChatGPT. Must target ChatGPT, not Terminal.
- `bin/pinky-start-real-runtime`: only valid live runtime launcher.
- `bin/pinky-start-test-runtime`: safe diagnostics launcher with Narf disabled.

## Regression risks

Do not reintroduce:

1. Printing `Narf!` to stdout from `pinky-send`.
2. Starting live runtime inside a multi-step proof script.
3. Sending `Narf!` without checking `pinky-completion-barrier`.
4. Reading only old `command-runs` status.
5. Running live Narf mode during patching.

## Current good commits

- `fb9dd09 Stabilize Pinky bridge execution and completion barrier`
- `7f74aab Gate Pinky Narf send to explicit runtime mode`
- `8b9d1cf Report Pinky transport completion in status`
- `39746eb Separate live Narf runtime from test and patch workflows`
- `40a198a Restore ChatGPT-targeted Pinky send path`
