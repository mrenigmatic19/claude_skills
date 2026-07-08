# Task Patterns

## Skill Identity

Monorepo Boundary Guardian belongs to the architecture and maintainability family.

Primary description:

Prevents Claude from editing wrong packages or crossing frontend/backend/shared package boundaries without approval. Use for codebase context skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.

## Trigger Patterns

- An agent must decide whether to proceed, stop, or require human review.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Module boundaries, dependency graph, public APIs, ADRs, package manifests

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for architecture and maintainability before recommending or editing.
3. Apply a conservative stop gate when evidence is incomplete or the blast radius is not bounded.
4. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
