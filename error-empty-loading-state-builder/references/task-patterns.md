# Task Patterns

## Skill Identity

Error Empty Loading State Builder belongs to the frontend code generation family.

Primary description:

Adds correct loading, error, empty, unauthorized, and retry states for new UI behavior. Use for code generation skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.

## Trigger Patterns

- A code change is requested and must be constrained to approved files and local patterns.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Approved edit set, nearest pattern, design-system component, API/state contracts, i18n keys

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for frontend code generation before recommending or editing.
3. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Creating one-off UI instead of reusing design-system components
- Refactoring unrelated files while solving a ticket

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
