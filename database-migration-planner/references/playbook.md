# Playbook

## Mission

Make data, schema, async, cache, and concurrency changes safe by exposing lifecycle, ownership, compatibility, and rollback concerns.

## Procedure

Find source of truth; trace readers/writers; check schema and API compatibility; evaluate migration/backfill/idempotency; verify observability and rollback.

## Skill-Specific Lens

- Purpose: Support database migrations with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is creating or reviewing schema changes, migrations, indexes, constraints, data backfills, seed changes, or rollback plans, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes.
- Produce an artifact another engineer can execute without rediscovering context.

## Minimum Done

- Evidence gathered from the closest relevant files or runtime signals.
- Risk and confidence stated.
- Recommendation or change scoped to the evidence.
- Verification path recorded.
