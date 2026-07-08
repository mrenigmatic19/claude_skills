# Task Patterns

## Skill Identity

AI Ticket Eligibility Gate belongs to the ADO ticket operations family.

Primary description:

Classifies whether the ticket is safe for AI automation: frontend-only, low-risk, clear AC, testable, no payment/auth/security complexity. Use for ado ticket understanding skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.

## Trigger Patterns

- An agent must decide whether to proceed, stop, or require human review.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- ADO ID, title, description, comments, state, linked PRs, role, acceptance criteria

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for ADO ticket operations before recommending or editing.
3. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Treating vague ADO wording as acceptance criteria
- Forgetting to preserve missing details as questions

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
