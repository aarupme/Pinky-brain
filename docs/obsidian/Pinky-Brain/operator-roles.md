# Operator Roles

Pinky Brain has clear role separation. The system becomes fragile when roles blur.

## Brain

Brain is the human operator.

Brain decides:

- product direction
- UX behavior
- architecture tradeoffs
- whether Pinky should start
- whether recovery is needed
- which numbered option to choose

Brain should answer numbered questions with a number only.

## Assistant

Assistant researches, plans, writes, and prepares safe commands.

Assistant must:

- use Brain lane first when Pinky is sleeping or stopped
- ask numbered questions when Brain judgment is required
- report `Bash remaining` and `Delta reason`
- explain scope increases when bash remaining goes up
- only reduce bash remaining after a completed bash step
- avoid commands that can trap Terminal in quotes, heredocs, or continuation prompts
- avoid hidden or background loops
- avoid recursive status-log reading

Assistant must not:

- assume Pinky is running
- send Pinky envelopes when Pinky is sleeping or stopped
- send empty status-only Pinky messages
- teach retired syntax as the current contract

## Pinky

Pinky is the local runtime supervision layer.

Pinky runs supervised shell payloads only when awake and watched from Terminal 1.

Pinky must:

- accept only the current runnable envelope contract for normal operator work
- run preflight before execution
- syntax-check before execution
- cap output at write time
- report completion with `Narf!`
- avoid duplicate execution by command hash

## Terminal 1

Terminal 1 is the Pinky cockpit watcher only.

Use Terminal 1 for:

- visible cockpit watcher
- Pinky startup confirmation
- `Narf!` callbacks
- observed Pinky execution results

Do not use Terminal 1 for Brain/admin/recovery work while it is acting as cockpit watcher.

## Terminal 2

Terminal 2 is Brain/admin/recovery only.

Use Terminal 2 for:

- repo inspection
- manual recovery
- safe file writes when Pinky is stopped
- git status and diff review
- starting or stopping Pinky when directed

## Role boundary examples

Correct:

- Pinky is stopped, so Assistant gives a Terminal 2 command.
- Brain chooses an option by number.
- Terminal 1 stays dedicated to cockpit watcher.

Incorrect:

- Assistant sends a Pinky envelope while Pinky is sleeping.
- Terminal 1 is used for manual repo editing while cockpit watcher is expected to run.
- Brain is asked to paste a command into a trapped quote prompt.
