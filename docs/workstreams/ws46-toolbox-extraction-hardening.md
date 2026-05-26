# WS46 Toolbox Extraction Hardening

Purpose: reduce silent Pinky toolbox failures by allowing status-style diagnostic commands through extraction instead of silently dropping them before classification.

## Problem

Valid-looking toolbox commands were injected but not executed because the extractor filtered some commands before classification or dry-run reporting.

## Root cause

bin/pinky-command-extract filtered toolbox candidates containing git status or sleep, so the operator got no useful visible failure report.

## Change

Removed the extractor-level git status and sleep filter.

Updated command extraction fixture expectations.

Isolated fixture state from live .run command state.

## Validation

Validated with command extraction fixtures, pinky-self-test, cockpit status, and a pushed implementation commit.

## Result

PASS: toolbox status probes are now extractable instead of silently ignored.

## Follow-up

WS47 must add explicit visible rejection reporting and replace long arbitrary toolbox commands with short task-registry execution.
