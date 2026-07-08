# Task Patterns

## Skill Identity

Frontend Blast Radius Estimator belongs to the component and source mapping family.

Primary description:

Predicts how many routes, tests, and components may be affected by a change before generation starts. Use for component mapping skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.

## Trigger Patterns

- The task name or ticket intent directly matches this skill's purpose.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Route definitions, visible UI text, import paths, parent pages, stories, shared component usage

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for component and source mapping before recommending or editing.
3. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Editing a shared component without consumer impact
- Mistaking dead routes or duplicate components for live code

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
