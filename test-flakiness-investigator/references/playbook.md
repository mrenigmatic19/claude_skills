# Playbook

## Mission

Create tests and verification plans that encode meaningful behavior, not shallow coverage.

## Procedure

Mine local test style; map behavior to assertions; choose unit/component/integration/E2E level; reuse fixtures; add regression proof; run the narrowest checks.

## Skill-Specific Lens

- Purpose: Support test flakiness with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is debugging intermittent tests, race conditions, timing issues, shared state, CI-only failures, or nondeterministic assertions, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes.
- Separate symptom, trigger, root cause, proof, and repair path.

## Minimum Done

- Evidence gathered from the closest relevant files or runtime signals.
- Risk and confidence stated.
- Recommendation or change scoped to the evidence.
- Verification path recorded.
