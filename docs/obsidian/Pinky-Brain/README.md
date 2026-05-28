# Pinky Brain Operating Manual

This vault is the operating manual for Pinky Brain.

Pinky Brain is a local macOS runtime supervision layer controlled by Brain, the human operator. It uses a visible terminal workflow so the operator can see what is happening.

## Current operating model

- Brain makes product, UX, architecture, and recovery decisions.
- Assistant researches, plans, writes, and prepares safe commands.
- Pinky executes supervised shell payloads only when awake and watched.
- Terminal 1 is the Pinky cockpit watcher only.
- Terminal 2 is Brain/admin/recovery only.

## Fastest safe start

1. Assume Pinky is sleeping or stopped until proven otherwise.
2. Use Brain lane first.
3. Start cockpit watcher in Terminal 1 only when Brain chooses to start Pinky.
4. Wait for `Narf!`.
5. Send exactly one v2 command envelope.
6. Wait for completion and `Narf!`.
7. Continue only after bash remaining and delta reason are updated.

## Current command contract

Normal operator work uses only the Pinky v2 envelope:

```text
PINKY-BASH-START
cd ~/Desktop/pinky-brain && <safe command>
PINKY-BASH-END
```

Retired `# pinky`, legacy `PINKY-RUN`, and legacy `PINKY-CODE-RUN` are not the current operator contract.

## Manual pages

- [[interaction-contract]] — how Brain, Assistant, and Pinky communicate
- [[operator-roles]] — responsibilities and terminal separation
- [[daily-workflow]] — normal day-to-day operation
- [[command-envelope]] — v2 envelope rules and examples
- [[runtime-safety]] — mandatory safety rules
- [[recovery]] — what to do when Pinky is unclear or stuck
- [[troubleshooting]] — symptoms, likely causes, and actions
- [[legacy-and-retired-syntax]] — old syntax and how to treat it
- [[setup-obsidian]] — vault setup and maintenance

## Safety summary

- preflight before cockpit startup
- preflight before every transport execution
- syntax check before bash execution
- transport output capped at write time
- log threshold guard
- singleton cockpit watcher lock
- no hidden/background loops
- no recursive status-log reading

## Documentation rule

Do not invent behavior from memory.

When docs are unclear:

1. Research the codebase and existing docs.
2. Ask Brain numbered clarifying questions.
3. Update the vault with the current operator contract.
4. Move retired syntax to the legacy page instead of teaching it in normal workflow pages.
