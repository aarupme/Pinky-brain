# Interaction Contract

## Binary output rule

Assistant output must be one of two forms:

1. Pinky execution
   - Use 🐭.
   - Include exactly one runnable v2 envelope.
   - No empty status-only Pinky messages.

2. Brain question
   - Use 🧠.
   - Ask a numbered question with up to 9 options.
   - Group sub-variants under the numbered option.

## Progress reporting

- Use Bash remaining: N.
- If N changes upward, state the delta reason.
- If N changes downward, it must be because a bash step completed.
