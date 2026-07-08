# Playbook

## Mission

Make data, schema, async, cache, and concurrency changes safe by exposing lifecycle, ownership, compatibility, and rollback concerns.

## Procedure

Find source of truth; trace readers/writers; check schema and API compatibility; evaluate migration/backfill/idempotency; verify observability and rollback.

## Skill-Specific Lens

- Purpose: Support build systems with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is debugging builds, bundlers, compilers, transpilers, package scripts, cache issues, or artifact generation, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes.
- Separate symptom, trigger, root cause, proof, and repair path.

## Minimum Done

- Evidence gathered from the closest relevant files or runtime signals.
- Risk and confidence stated.
- Recommendation or change scoped to the evidence.
- Verification path recorded.
