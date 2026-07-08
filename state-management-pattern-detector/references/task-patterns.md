# Task Patterns

## Skill Identity

State Management Pattern Detector belongs to the frontend code generation family.

Primary description:

Detects whether a feature uses Redux, Zustand, Context, React Query, local state, signals, or custom hooks. Use for codebase context skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.

## Trigger Patterns

- The task name or ticket intent directly matches this skill's purpose.

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
