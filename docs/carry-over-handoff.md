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
- latest commit: a5d0d85 Allow Pinky status in safe command flow

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
- 🧰 PINKY-RUN = runnable command intent marker
- 🧰 PINKY-READY = command block complete marker

Validated capabilities:
- pinky-send sends messages to ChatGPT
- pinky-mode on/off controls runtime
- pinky-loop handles 🐭, 🧠, 🛑 with safety gates
- Pinky now sends Narf! instead of l
- command detect/extract/classify/dry-run/manual-run exists
- manual command runner has audit logging

Recommended next workstream:
WS14 — Runtime Loop End-to-End Proof

Completed WS10 slices:
- k/K kill switch now stops the beacon as well as the loop.
- pinky-status log tails are compacted from 8 lines to 4 lines.

Completed WS11 slice:
- pinky-mode status now delegates to the full read-only pinky-status dashboard.

Completed WS12 slice:
- Added docs/operator-command-reference.md as the compact operator command surface index.

Completed WS13 slice:
- Candidate flow QA found and fixed the safe allowlist gap: ./bin/pinky-status now classifies and runs through the safe command flow.

Goal:
Prove the working runtime loop end-to-end with the smallest safe test: start mode/loop only when controlled, verify signal detection, candidate detection/extraction, dry-run, safe execution, clear state, and kill switch. Patch only blockers found during the proof. Avoid docs/polish until the runtime flow is demonstrably working.
