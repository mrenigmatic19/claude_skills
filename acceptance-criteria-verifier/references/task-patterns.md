# Task Patterns

## Skill Identity

Acceptance Criteria Verifier belongs to the testing and evaluation family.

Primary description:

Checks whether every acceptance criterion has proof: code change, unit test, E2E test, or manual verification note. Use for testing + evaluation skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.

## Trigger Patterns

- Acceptance criteria are implied, scattered, or mixed with implementation notes.
- Tests, CI failures, verification evidence, or regression proof are needed.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Failing logs, nearby test helpers, fixtures, mocks, selectors, coverage gaps

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for testing and evaluation before recommending or editing.
3. Connect every test or repair to an acceptance criterion, failing log line, or regression risk.
4. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Adding snapshots without behavior assertions
- Weakening assertions to pass CI

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
