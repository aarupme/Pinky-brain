# Obsidian Setup

This page explains how to use the Pinky Brain Obsidian vault.

## Vault path

The vault lives at:

```text
/Users/bennyaarup/Desktop/pinky-brain/docs/obsidian/Pinky-Brain
```

## Purpose

The vault is the operator-facing manual for Pinky Brain.

It should explain how to operate Pinky safely, how Brain should make decisions, and how to recover when the runtime is unclear.

## Recommended navigation

Start with:

1. [[README]]
2. [[daily-workflow]]
3. [[command-envelope]]
4. [[single-terminal-code-editor-workflow]]
4. [[runtime-safety]]
5. [[recovery]]

Use supporting pages when needed:

- [[interaction-contract]]
- [[operator-roles]]
- [[troubleshooting]]
- [[legacy-and-retired-syntax]]

## Maintenance rules

- Keep current operator behavior in the main workflow pages.
- Keep retired and legacy syntax in [[legacy-and-retired-syntax]].
- Do not mix historical syntax into the quick-start path.
- Research the codebase before documenting behavior.
- Ask Brain numbered questions when behavior or product intent is unclear.
- Prefer practical examples over abstract prose.

## Linking style

Use Obsidian wiki links for local manual pages.

Good:

```text
See [[command-envelope]] before sending Pinky commands.
```

Avoid duplicate page titles that make links ambiguous.

## Review checklist

Before considering the vault current, check:

- README has the current operating model.
- Command envelope page teaches v2 envelope only.
- Safety page includes preflight, syntax check, output cap, log guard, watcher lock, and no hidden loops.
- Recovery page explains what to do when the final workflow callback is missing.
- Legacy page contains old syntax instead of normal workflow pages.

## When the manual falls behind

If code and docs disagree:

1. Treat executable behavior as the thing to research.
2. Treat old docs as possible history, not truth.
3. Ask Brain to resolve product intent if code behavior and desired UX differ.
4. Update the manual after the decision.
