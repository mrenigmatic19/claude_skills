# Examples

## Canonical Example

If AC says 'Submit disabled until required fields are valid', test initial disabled state, invalid input message, valid input enabling, and submit payload.

## Prompt Patterns That Should Trigger This Skill

- Use this skill for the attached ADO ticket.
- Map this route/component before changing it.
- Decide if this task is safe for AI automation.
- Build the PR or ADO comment from this evidence.
- Re-run or verify this frontend flow.
- Explain why this CI, Playwright, or review failure happened.

## Good Output Pattern

Summary:
State the decision in one sentence.

Evidence:
List the source files, runtime observations, ticket fields, or logs.

Risk and confidence:
Give a number and name the uncertainty.

Action:
Give the scoped plan, generated artifact, tests, or stop decision.

Verification:
List commands, browser proof, screenshots, or why verification is blocked.

## Bad Output Pattern

- Generic advice with no file paths.
- A plan that edits files not mapped by evidence.
- Confidence without a reason.
- No mention of risk.
- No stop condition when required facts are absent.
