# Pinky Brain

Pinky Brain is a lightweight inline Terminal transport.

Active product path:

- runtime/README.md
- runtime/bin/pinky-start
- runtime/bin/pinky-listen
- runtime/bin/pinky-parse-next
- runtime/bin/pinky-read-chatgpt
- runtime/bin/pinky-send-chatgpt
- runtime/bin/pinky-normalize-command
- runtime/bin/pinky-request-stop
- runtime/bin/pinky-stop

Runtime state:

- runtime/.run/ is local runtime state and is ignored by git.

Lifecycle:

- Start Pinky once per ChatGPT chat.
- Keep Pinky running until leaving the chat or workstream.
- If no execution is needed, ChatGPT sends no Pinky bash block.
- Do not use Pinky start/stop as a test harness.

Boot protocol:

- Pinky sends one startup message to ChatGPT.
- That single message contains the full boot contract and the startup state line.
- Startup state line: Pinky started expected=PINKY_BASH_0001
- Pinky bash blocks must start with the exact expected id and end with PINKY_BASH_END.
- Use exactly one approved command block per response.
- ChatGPT must match the expected id exactly and ignore old or future ids.

Safety:

- No heredocs in manual or Pinky bash blocks.
- No pagers.
- No raw git diff or raw git log.
- Use git --no-pager for git inspection.

Launch:

- Double-click ~/Desktop/Pinky Brain.command to start Pinky in Terminal.
- Developer launch: cd ~/Desktop/pinky-brain && runtime/bin/pinky-start.
- Reinstall launcher: runtime/install/install-desktop-launcher.

Launcher status:

- Current working launcher: ~/Desktop/Pinky Brain.command.
- Pinky.app wrapper is disabled for now because the minimal shell app bundle can trigger a Rosetta prompt on Apple Silicon.
- Next app wrapper must be native and must not require Rosetta.
