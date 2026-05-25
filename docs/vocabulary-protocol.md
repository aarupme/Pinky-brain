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

## Runnable command markers

- 🧰 PINKY-RUN = command block is intended for Pinky
- 🧰 PINKY-READY = command block is complete and ready to extract

## Rule

Pinky must not extract or run a command unless both command markers are visible and the classifier returns safe.
