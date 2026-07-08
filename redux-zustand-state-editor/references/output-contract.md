# Output Contract

## Required Sections

Produce Scope, Files Edited, Pattern Reused, Behavior Changed, Tests Added, Verification, Risks, and Follow-up Cleanup.

## Universal Fields

- Summary: one or two sentences.
- Inputs Understood: ticket, flow, route, role, files, logs, or PR context.
- Evidence Reviewed: concrete file paths, runtime observations, commands, or ADO/PR details.
- Risk Level: Low, Medium, or High with reason.
- Confidence: 0.0 to 1.0 with the main uncertainty.
- Decision: proceed, stop, ask, implement, verify, or escalate.
- Result: artifact produced, files changed, tests planned, or verification completed.
- Gaps: missing facts and exact question or owner needed.

## Reviewer-Ready Style

- Use short headings and precise bullets.
- Prefer specific nouns over general claims.
- Avoid saying 'should be fine' or 'looks good' without evidence.
- Include negative findings when they changed the decision.
- Make the output pasteable into ADO or a PR when relevant.

## For Code Changes

Include:

- Approved edit set.
- Pattern reused.
- Behavior changed.
- Tests added or skipped.
- Commands run.
- Residual risk.
