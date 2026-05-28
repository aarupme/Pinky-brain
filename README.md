# Pinky Brain

Pinky Brain is currently hard-isolated to the v2 inline Terminal transport.

Active product path:

- v2/README.md
- v2/bin/pinky-start
- v2/bin/pinky-listen
- v2/bin/pinky-parse-next
- v2/bin/pinky-read-chatgpt
- v2/bin/pinky-send-chatgpt
- v2/bin/pinky-normalize-command
- v2/bin/pinky-request-stop
- v2/bin/pinky-stop

Runtime state:

- v2/.run/ is local runtime state and is ignored by git.

Lifecycle:

- Start Pinky once per ChatGPT chat.
- Keep Pinky running until leaving the chat or workstream.
- If no execution is needed, ChatGPT sends no Pinky bash block.
- Do not use Pinky start/stop as a test harness.

Safety:

- No heredocs in manual or Pinky bash blocks.
- No pagers.
- No raw git diff or raw git log.
- Use git --no-pager for git inspection.
