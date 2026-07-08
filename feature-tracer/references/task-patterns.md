# Task Patterns

## Skill Identity

Feature Tracer belongs to the data and async workflow family.

Primary description:

Trace a feature end-to-end across a repository, mapping every component involved from UI to API, service, database, background jobs, external systems, tests, and side effects. Use when given a feature name, page, endpoint, component, service, database entity, bug area, or planned change and the full execution path must be understood before modifying code.

## Trigger Patterns

- A source map, ownership map, route map, import graph, or confidence score is needed before editing.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Schemas, migrations, jobs, queues, transactions, cache keys, idempotency signals

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for data and async workflow before recommending or editing.
3. Collect at least two independent signals before declaring ownership or source mapping.
4. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Skipping idempotency and backfill resume behavior
- Ignoring consumers of changed schemas or events

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
