# Verification Matrix

Use this matrix to decide how to prove the skill did useful work.

| Concern | Verification | Evidence To Report |
|---|---|---|
| Mapping confidence | Confirm source paths with route/import/runtime/test evidence | File paths and confidence score |
| Repository convention | Compare against nearest existing pattern | Pattern file and reused helper/component |
| Regression risk | Run or propose narrow tests | Command and result or blocker |
| Abuse/deny path | Test invalid role, replay, duplicate submit, expired credential, or unauthorized action | Negative test evidence |

## Reporting Rules

- Report commands exactly when commands are run.
- If verification is manual, name the screen, role, route, data, and expected state.
- If verification is blocked, name the missing prerequisite and the next owner action.
- For confidence below 0.75, prefer a mapping/report artifact over code changes.
