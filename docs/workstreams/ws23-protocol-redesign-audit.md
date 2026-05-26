# WS23 Protocol Redesign Audit

## Current confirmed contract

- Runtime prompt requires standalone control signals.
- Detector currently only accepts standalone signal lines after latest assistant text block.
- Loop suppresses repeated continuation using signal_hash from signal:block_start:latest_line_no.
- The recent failure came from a repeated coordinate hash and inconsistent assistant signal placement.

## Required design direction

- Keep control signals as standalone lines only.
- Update assistant operating discipline, not detector leniency, as the first rule.
- Add fixture-based detector tests before changing runtime detection.
- Replace coordinate-only continuation hash only after fixtures reproduce the repeated-response collision.
- Separate protocol markers from prose so Pinky never depends on natural-language formatting.

## Candidate WS23 implementation slices

1. Document protocol invariants and assistant output rules.
2. Add detector fixture harness using captured visible-text samples.
3. Add fixtures for standalone continuation, standalone brain, standalone stop, prefix-prose non-match, repeated-coordinate collision.
4. Patch signal hash to include latest assistant block content if and only if fixture proves collision.
5. Validate with stopped-runtime tests first, then one controlled runtime proof.
