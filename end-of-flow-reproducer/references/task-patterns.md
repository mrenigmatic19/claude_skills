# Task Patterns

## Skill Identity

End Of Flow Reproducer belongs to the runtime/browser flow analysis family.

Primary description:

Special skill for tickets like "issue on final confirmation page." It drives the app from start to the final page instead of guessing the component. Use for flow context + playwright mcp skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.

## Trigger Patterns

- Browser-observed evidence is needed to confirm the real UI path.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- App URL, role/session, test data, route, screenshots, network calls, accessibility labels

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for runtime/browser flow analysis before recommending or editing.
3. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Guessing source files from route names only
- Ignoring auth/session/test-data preconditions

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
