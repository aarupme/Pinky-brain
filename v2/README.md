# Pinky Brain v2

Pinky v2 is a tiny local macOS transport tool.

## Runtime model

One ChatGPT chat equals one Pinky session.
Pinky runs inside one stable Terminal window.

Start with:

cd ~/Desktop/pinky-brain
v2/bin/pinky-start

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

## Forbidden in v2

No Terminal do script.
No new Terminal windows or tabs.
No background listener for normal operation.
No VS Code inbox.
No file bridge as product.
No logs or ledger architecture.
