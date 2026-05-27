# Pinky Brain Vocabulary Protocol

Status: ACTIVE

## Runtime signals

- 🐭 = safe continuation is available
- 🧠 = Brain / human decision required
- 🛑 = hard stop

## Continuation token

- Narf! = Pinky continuation message sent by automation
- l = user shorthand in this ChatGPT workflow for let's go and look

## Kill switch

- k or K = manual kill switch inside Pinky mode
- pinky-mode k = local kill alias
- pinky-mode kill = local kill alias

## Primary automatic lane

- The active Pinky automatic lane is visible direct syntax only:
  `cd ~/Desktop/pinky-brain && <safe command> # pinky`
- Pinky must show the picked command in Terminal before execution.
- Pinky must show execution output in Terminal.
- Pinky must print `Narf!` after execution.

## Secondary / legacy command markers

- 🧰 PINKY-RUN = legacy command block marker.
- 🧰 PINKY-READY = legacy command-ready marker.

## Rule

The cockpit watcher is the primary user-facing path. Hidden/background service and toolbox marker paths are secondary until explicitly reactivated.
