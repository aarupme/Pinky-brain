# Command Envelope

The command envelope is the current Pinky v2 execution contract.

Use it only when Pinky is awake, Terminal 1 is running the cockpit watcher, and the assistant needs Pinky to run exactly one shell payload.

```text
PINKY-BASH-START
cd ~/Desktop/pinky-brain && <safe command>
PINKY-BASH-END
```

## Rules

- A Pinky lane message must contain exactly one runnable v2 envelope.
- The envelope body must be a complete bash command.
- The command must start from the repo:
  ```bash
  cd ~/Desktop/pinky-brain && ...
  ```
- Do not use retired suffix-only `# pinky` syntax.
- Do not use `PINKY-RUN` or `PINKY-CODE-RUN` as the operator contract.
- Do not send envelopes when Pinky is sleeping or stopped.
- Do not send empty status-only Pinky messages.

## Extraction behavior

The current extractor reads visible ChatGPT text and selects the latest valid envelope.

It rejects unsafe or ambiguous input:

- incomplete envelope
- empty envelope
- nested envelope
- duplicate command hash
- placeholder commands
- syntax errors detected by bash syntax check

## Valid example

```text
PINKY-BASH-START
cd ~/Desktop/pinky-brain && ./bin/pinky-status
PINKY-BASH-END
```

## Invalid examples

Missing repo prefix:

```text
PINKY-BASH-START
./bin/pinky-status
PINKY-BASH-END
```

Retired suffix syntax:

```bash
cd ~/Desktop/pinky-brain && ./bin/pinky-status # pinky
```

Nested envelope:

```text
PINKY-BASH-START
printf "PINKY-BASH-START"
PINKY-BASH-END
```

## Operator meaning

The envelope does not mean "run anything."

It means:

1. Pinky is awake.
2. The cockpit watcher is visible in Terminal 1.
3. The payload is safe enough to send through the supervised runtime.
4. Preflight and syntax checks still happen before execution.
