# WS3 — Brain Sound Alert

Status: COMPLETE

Validated: 2026-05-24 22:14:01

## Files

- bin/pinky-sound-brain
- bin/pinky-beacon

## Behavior

- Brain alert sound uses macOS built-in Glass.aiff.
- Sound helper command:
  - ./bin/pinky-sound-brain
- Pinky Brain beacon plays the sound once when state changes into Brain Needed.
- Re-entering Brain Needed from a different state triggers the sound again.
- Staying in Brain Needed does not repeatedly loop sound.

## Manual validation

- Clicked Pinky Brain panel from Idle to Pinky Active to Brain Needed.
- Glass alert played once on Brain Needed.
- Confirmed by user.

## Known limitations

- Sound is local macOS only.
- No mute setting yet.
- No repeat-after-timeout behavior yet.
- Sound is not connected to ChatGPT signal watcher yet.

## Next workstream

WS4 — Runtime Toggle

Goal:
Add one local command that turns Pinky Brain session mode ON/OFF:
- ON applies workspace layout
- ON starts beacon
- ON sends runtime-start prompt to ChatGPT
- OFF sends runtime-stop prompt to ChatGPT
- OFF stops beacon
