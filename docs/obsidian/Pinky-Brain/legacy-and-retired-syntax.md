# Legacy and Retired Syntax

This page exists so old syntax can be understood without teaching it as the current operator contract.

## Current operator contract

Use only the Pinky v2 envelope for normal operator work:

```text
PINKY-BASH-START
cd ~/Desktop/pinky-brain && <safe command>
PINKY-BASH-END
```

## Retired: suffix-only `# pinky`

The old suffix form is retired:

```bash
cd ~/Desktop/pinky-brain && ./bin/pinky-status # pinky
```

Do not use this as the operator contract.

If it appears in older docs, treat that text as stale unless it is explicitly marked as legacy.

## Legacy: `PINKY-RUN`

`PINKY-RUN` may appear in old notes, tests, or compatibility fixtures.

Do not teach it as normal operation.

## Legacy: `PINKY-CODE-RUN`

`PINKY-CODE-RUN` may appear in WS47 or older toolbox work.

Do not teach it as normal operation.

## Why old syntax still appears

Old syntax can remain in:

- historical workstream notes
- tests and fixtures
- compatibility paths
- stale protocol docs that still need cleanup

That does not make it the current Brain/Pinky contract.

## Documentation rule

When updating docs:

1. Teach only the v2 envelope in normal workflow pages.
2. Move old syntax references here.
3. Mark historical examples as legacy or retired.
4. Do not mix old syntax into Start Here, Daily Workflow, or Command Envelope.

## Operator rule

If Brain sees old syntax during normal operation, stop and ask whether the text is historical, stale, or a compatibility fixture.
