# Task Patterns

## Skill Identity

Workitem PR Linker belongs to the ADO ticket operations family.

Primary description:

Creates the correct PR metadata: linked work item, reviewers, labels, description, risk notes, and test evidence. Use for ado ticket understanding skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.

## Trigger Patterns

- The task name or ticket intent directly matches this skill's purpose.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- ADO ID, title, description, comments, state, linked PRs, role, acceptance criteria

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for ADO ticket operations before recommending or editing.
3. Transform messy input into a strict artifact shape; preserve missing fields instead of inventing values.
4. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Treating vague ADO wording as acceptance criteria
- Forgetting to preserve missing details as questions

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
