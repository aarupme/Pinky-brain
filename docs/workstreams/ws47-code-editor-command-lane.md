# WS47 Code Editor Command Lane

Purpose: replace brittle prose/toolbox command extraction with a cleaner code-editor command lane.

## Problem

The previous toolbox lane depended on parsing normal ChatGPT prose and marker text. It was fragile with longer commands, quote-heavy payloads, redirects, and markdown-like content. Commands could be injected but not sent, silently ignored, or rejected before useful feedback reached the operator.

## Decision

Use a plain marker outside the code block and execute only the next code block payload.

Marker:

PINKY-CODE-RUN

Payload:

The next fenced code block after the marker.

## Contract

Assistant prose is ignored.

Pinky scans visible ChatGPT text from the bottom upward.

Pinky finds the latest PINKY-CODE-RUN marker.

Pinky extracts only the content of the next fenced code block after that marker.

Pinky normalizes, hashes, classifies, dry-runs, and executes that extracted payload.

The marker is not executed.

The code fence is not executed.

Text outside the block is ignored.

## Implementation

Updated bin/pinky-command-extract to support code-block extraction.

Kept legacy toolbox extraction as fallback.

Added source reporting so extracted commands can report source=code-block or source=toolbox.

Added fixtures:

- tests/fixtures/toolbox-code-run-status.txt
- tests/fixtures/toolbox-code-run-long.txt
- tests/fixtures/toolbox-code-run-no-block.txt

Updated tests/run-command-extract-fixtures.

## Validation

Validated with:

- bash -n bin/pinky-command-extract
- bash -n tests/run-command-extract-fixtures
- ./tests/run-command-extract-fixtures
- ./bin/pinky-self-test
- ./bin/pinky-cockpit
- live small code-lane probe
- live longer code-lane probe

Observed result:

- fixture tests pass
- self-test passes
- repo committed and pushed cleanly
- small code-lane command executed
- longer code-lane command executed
- runtime remained watching
- loop and beacon remained running
- candidate returned to none

## Result

PASS: Pinky can now execute commands from the assistant code-editor lane instead of relying only on brittle prose/toolbox extraction.

## Follow-up

Add visible rejection reporting when a PINKY-CODE-RUN marker is present but no executable code block is extracted.
