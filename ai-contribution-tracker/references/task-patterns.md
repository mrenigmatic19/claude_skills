# Task Patterns

## Skill Identity

AI Contribution Tracker belongs to the testing and evaluation family.

Primary description:

Analyze repository history to estimate which code was likely AI-generated, human-written, mixed, or unknown. Use when producing AI adoption reports, commit-level AI attribution, developer-level AI usage metrics, generated test/documentation/boilerplate estimates, or repository development statistics from git history, pull requests, commits, changed files, and code patterns. Always report uncertainty with confidence scores and never claim certainty.

## Trigger Patterns

- The task name or ticket intent directly matches this skill's purpose.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Failing logs, nearby test helpers, fixtures, mocks, selectors, coverage gaps

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for testing and evaluation before recommending or editing.
3. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Adding snapshots without behavior assertions
- Weakening assertions to pass CI

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
