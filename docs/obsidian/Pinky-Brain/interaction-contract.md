# Brain / Pinky Interaction Contract

This page defines how Brain, Assistant, and Pinky communicate.

## Lanes

There are two working lanes: Brain lane and Pinky lane.

### Brain lane

Use Brain lane for:

- numbered decisions
- manual Terminal 2 instructions
- recovery
- documentation planning
- architecture and UX choices
- any moment where Pinky is sleeping or stopped

Brain questions use numbered options. Brain answers with a number only.

### Pinky lane

Use Pinky lane only when Pinky is awake and Terminal 1 is running the cockpit watcher.

A Pinky lane message contains exactly one runnable v2 command envelope.

## Runtime words

### `Narf!`

`Narf!` is Pinky’s continuation callback.

It appears when:

- the cockpit watcher starts watching
- a Pinky execution completes
- Pinky has returned control to Brain / Assistant

Every completed Pinky execution must send `Narf!`.

### `Bash remaining`

Progress is reported as:

```text
Bash remaining: N
Delta reason: <why count changed>
```

If the count goes up, the assistant explains what new finding expanded scope.

If the count goes down, it must be because a bash step completed.

### 🧠

Use 🧠 when human Brain input is required.

Common reasons:

- choosing a workflow
- confirming a documentation model
- choosing whether to start Pinky
- resolving unclear product behavior
- stopping automation after a failure

## Do not send Pinky envelopes when

- Pinky is sleeping
- Pinky is stopped
- Terminal 1 is not running cockpit watcher
- the task needs Brain judgment
- the command could trap Terminal in quote, heredoc, or continuation prompt
- the command could recursively read growing logs or status logs
- there is no clear single command to run

## Correct interaction pattern

1. Assistant asks Brain a numbered question.
2. Brain replies with one number.
3. Assistant reports bash remaining and delta reason.
4. If Pinky is stopped, Assistant gives Terminal 2 instructions.
5. If Pinky is running, Assistant may send one v2 envelope.
6. Pinky completes and sends `Narf!`.
7. Assistant continues or asks Brain for the next numbered decision.
