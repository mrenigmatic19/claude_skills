# Task Patterns

## Skill Identity

Repository Test Expert belongs to the testing and evaluation family.

Primary description:

Learn testing conventions from an existing codebase and generate new tests that match repository patterns. Use before adding, repairing, expanding, or reviewing tests when Codex must discover existing test frameworks, folder conventions, mocking strategy, fixture usage, assertion style, setup/teardown patterns, coverage gaps, and naming standards instead of inventing a new testing style.

## Trigger Patterns

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
