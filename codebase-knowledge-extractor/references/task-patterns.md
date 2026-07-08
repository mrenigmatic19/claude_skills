# Task Patterns

## Skill Identity

Codebase Knowledge Extractor belongs to the operations and deployment family.

Primary description:

Build a complete understanding of a repository by extracting architecture, patterns, concepts, workflows, dependencies, and business logic. Use for senior-engineer onboarding, repository knowledge bases, code comprehension before large changes, architecture maps, concept inventories, feature-flow tracing, dependency mapping, and recommended reading orders for large or unfamiliar codebases.

## Trigger Patterns

- Acceptance criteria are implied, scattered, or mixed with implementation notes.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Docker/CI/deploy config, env files, logs, health checks, rollback path

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for operations and deployment before recommending or editing.
3. Transform messy input into a strict artifact shape; preserve missing fields instead of inventing values.
4. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Changing deploy config without rollback
- Ignoring env parity and health checks

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
