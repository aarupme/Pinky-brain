# Pinky Brain Carry-Over Handoff

Status: READY FOR NEW CHAT

Repo path: ~/Desktop/pinky-brain
Remote: https://github.com/aarupme/Pinky-brain.git

Current clean checkpoint:
- main equals origin/main
- working tree is clean
- loop is stopped
- beacon is stopped
- command candidate is cleared
- dry-run returns no-candidate
- latest commit: 823c00b Show full Pinky status from mode command

Hard workflow rules:
- l means: lets go and look; wait briefly, inspect terminal state, report success/failure/in-progress, then give next single safe command only if needed
- no heredocs
- no long fragile inline quoted commands
- no commands that open interactive pagers
- use git --no-pager for git log/diff
- one command at a time
- inspect before patching
- preserve safe terminal/process discipline

Pinky vocabulary:
- Narf! = Pinky automated continuation token
- k/K = manual kill switch
- 🐭 = safe continuation available
- 🧠 = Brain/human decision required
- 🛑 = hard stop
- # 🐭 pinky-run = runnable command intent marker
- # 👀 pinky-ready = command block complete marker

Validated capabilities:
- pinky-send sends messages to ChatGPT
- pinky-mode on/off controls runtime
- pinky-loop handles 🐭, 🧠, 🛑 with safety gates
- Pinky now sends Narf! instead of l
- command detect/extract/classify/dry-run/manual-run exists
- manual command runner has audit logging

Recommended next workstream:
WS12 — Operator Docs + Command Surface Index

Completed WS10 slices:
- k/K kill switch now stops the beacon as well as the loop.
- pinky-status log tails are compacted from 8 lines to 4 lines.

Completed WS11 slice:
- pinky-mode status now delegates to the full read-only pinky-status dashboard.

Goal:
Create or update a compact operator-facing command surface reference so Pinky Brain commands are easy to remember: mode on/off/status, k/K kill switch, Narf protocol, status dashboard, dry-run/command candidate flow, and safe workflow rules. Preserve manual control, no auto-execution, no pager, and one-command-at-a-time workflow.
