# Pinky Brain

Pinky Brain is a tiny local macOS transport tool.

## Runtime model

One ChatGPT chat equals one Pinky session.
Pinky runs inside one stable Terminal window.

Start with:

cd ~/Desktop/pinky-brain
runtime/bin/pinky-start

Stop with Ctrl-C in the Pinky Terminal window.

## Notifications

On start, Pinky sends ChatGPT:
Pinky started expected=PINKY_BASH_0001

On stop, Pinky sends ChatGPT:
Pinky stopped expected=PINKY_BASH_<current>

## Counter model

Pinky resets expected-id to 0001 on start.
Pinky owns the counter.
ChatGPT follows the counter Pinky reports.
Pinky executes only the exact expected PINKY_BASH_id block.
Pinky ignores old, future, incomplete, or mismatched blocks.

## Command block format

PINKY_BASH_0001
cd ~/Desktop/pinky-brain
echo OK
PINKY_BASH_END

## Terminal proof

Pinky prints PINKY_RUNNING_id before execution.
Pinky prints PINKY_DONE_id_exit after execution.
Pinky then sends Narf with the next expected id.

## Forbidden in runtime

No Terminal do script.
No new Terminal windows or tabs.
No background listener for normal operation.
No VS Code inbox.
No file bridge as product.
No logs or ledger architecture.

## Runtime isolation contract

Pinky Brain is the active inline Terminal transport.

Runtime runtime is intentionally isolated from legacy Pinky mechanisms:

- No root `bin/` runtime dependency.
- No `.run/` root runtime dependency.
- No cockpit watcher.
- No code-editor command lane.
- No file bridge as product transport.
- No Terminal `do script`.
- No new Terminal windows or tabs.
- No background listener for normal operation.

Active runtime runtime surface:

- `runtime/bin/pinky-start`
- `runtime/bin/pinky-listen`
- `runtime/bin/pinky-read-chatgpt`
- `runtime/bin/pinky-parse-next`
- `runtime/bin/pinky-send-chatgpt`
- `runtime/bin/pinky-normalize-command`
- `runtime/bin/pinky-request-stop`
- `runtime/bin/pinky-stop`
- `runtime/.run/`

Legacy files outside `runtime/` may remain for archive/reference only. They are not part of the runtime product path.
## Runtime lifecycle contract

Pinky Brain is one live transport session per ChatGPT chat.

- Brain starts Pinky once at the beginning of a ChatGPT chat.
- Pinky remains running until the chat or workstream is ending.
- ChatGPT must not start and stop Pinky as a test harness.
- If no execution is needed, ChatGPT sends no Pinky bash block.
- Manual inspection mode means normal Brain-run Terminal commands, not Pinky stop/start cycling.
- `runtime/bin/pinky-request-stop` is only for intentionally leaving the chat/workstream.
- Boot tests must not stop Pinky unless the test is explicitly a shutdown test.

## Command body safety contract

ChatGPT-authored Pinky bash bodies must be safe shell, even though Pinky normalizes dangerous Unicode punctuation before execution.

- Use ASCII-only command bodies.
- Do not use heredocs in manual bash or Pinky bash blocks.
- Do not use raw multiline quoted strings.
- Do not place raw smart-quote characters inside shell-quoted strings.
- Do not use raw `git diff` or raw `git log`.
- Disable pagers before git inspection commands: `export GIT_PAGER=cat` and `export PAGER=cat`.
- Use `git --no-pager status -sb`, `git --no-pager log --oneline -N`, and `git --no-pager diff --stat`.
- For Unicode normalization tests, generate fixtures with Python `chr(...)` into temp files, then run `runtime/bin/pinky-normalize-command` against those files.
- Do not start and stop Pinky for tests. If Pinky is live and no execution is needed, send no Pinky bash block.
