# Task Patterns

## Skill Identity

Codebase Architecture Indexer belongs to the architecture and maintainability family.

Primary description:

Scans the frontend repo and produces architecture.md: tech stack, folder structure, routing, state management, styling, API layer, and test framework. Use for codebase context skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.

## Trigger Patterns

- A source map, ownership map, route map, import graph, or confidence score is needed before editing.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Module boundaries, dependency graph, public APIs, ADRs, package manifests

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for architecture and maintainability before recommending or editing.
3. Collect at least two independent signals before declaring ownership or source mapping.
4. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
