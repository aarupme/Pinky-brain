# Runtime Safety

## Required guards

- Preflight before cockpit startup.
- Preflight before every transport execution.
- Syntax check before bash execution.
- Transport output capped at write time.
- Logs capped by preflight threshold.
- No recursive status-log reading.
- Singleton cockpit watcher lock.

## Disabled paths

- Legacy direct execution.
- Clipboard execution.
- Background beacon/service wrappers.
- Legacy toolbox markers.
