# WS44 Sound Smoke Report

Purpose: make brain-alert sound behavior auditable in Terminal instead of relying only on user perception.

## Problem

Brain dings were hard to reason about because the audible sound path did not produce a clear Terminal report or durable log entry. This made it difficult to distinguish between:

- sound path failure
- detector suppression
- beacon/latch behavior
- user not hearing a sound event

## Change

Updated bin/pinky-sound-brain so it now:

- checks that the macOS Glass sound file exists
- plays the sound through afplay
- writes an auditable event to logs/pinky-sound.log
- prints brain_ding=played or brain_ding=failed in Terminal

Updated bin/pinky-smoke with an explicit --sound mode.

Normal smoke remains silent. Sound proof is deliberate:

./bin/pinky-smoke --sound

## Validation

Validated with:

- bash -n bin/pinky-sound-brain bin/pinky-smoke
- ./bin/pinky-sound-brain
- ./bin/pinky-smoke --sound
- logs/pinky-sound.log inspection
- final cockpit report

Observed result:

- Terminal printed brain_ding=played
- logs/pinky-sound.log recorded the sound event
- pinky-smoke --sound included a sound section
- self-test and fixtures passed inside smoke
- final cockpit returned to state=watching
- loop and beacon remained running
- candidate remained none

## Result

PASS: brain ding behavior is now auditable through both Terminal output and logs/pinky-sound.log.

## Follow-up

Future smoke modes can add active kill-switch proof and toolbox execution proof, but normal ./bin/pinky-smoke should remain non-intrusive and silent.
