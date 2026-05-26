# WS41 Visible Toolbox Post-Run Report

Purpose: ensure toolbox-executed Terminal commands end with a normalized visible cockpit report without closing the Terminal session.

## Problem

After WS40, Pinky correctly reset state to watching after toolbox command execution, but the human-visible Terminal command could still end with state=executing because any cockpit report printed inside the toolbox command ran before control returned to the loop.

An early WS41 wrapper attempt also used exit with the captured command exit code. That caused the Terminal shell session to complete and left the Terminal window at Process completed, which is not acceptable for the Brain/operator workflow.

## Root cause

bin/pinky-command-run sent the raw extracted command to Terminal. The command was not wrapped with a final visible normalized report. When wrapping was first attempted with exit, the wrapper terminated the Terminal shell session.

## Change

Updated bin/pinky-command-run so the Terminal-injected command is wrapped with a no-exit visible post-command footer:

- run the requested command
- capture its exit code
- set Pinky state back to watching
- print a final report header
- print bin/pinky-cockpit
- print command_exit=<code>
- do not exit the Terminal shell session

## Validation

Validated with:

- bash -n bin/pinky-command-run
- ./bin/pinky-self-test
- fresh toolbox execution proof
- post-completion Terminal inspection
- git --no-pager diff

Observed result:

- toolbox command executed successfully
- Terminal stayed open and ready for input
- no unwanted decision alert occurred
- final visible report returned to state=watching
- command_exit=0 printed after the final report
- candidate returned to none
- loop and beacon remained running

## Result

PASS: toolbox-executed commands now end with a visible normalized cockpit report and keep Terminal ready for continued Brain/operator use.

## Follow-up

Future hardening should add fixture coverage for command wrapping and quote-sensitive command payloads. The runtime should also avoid leaving state=duplicate as the visible cockpit state after harmless duplicate suppression.
