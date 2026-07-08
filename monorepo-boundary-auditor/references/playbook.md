# Playbook

## Mission

Improve build, release, observability, local environment, and incident workflows with reproducible commands and rollback evidence.

## Procedure

Map environment and pipeline; inspect config and secrets boundaries; reproduce failure; isolate service/build/deploy stage; add health/alert evidence; define rollback.

## Skill-Specific Lens

- Purpose: Support monorepo boundaries with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is working in monorepos with packages, workspaces, shared libraries, dependency graphs, ownership boundaries, or build orchestration, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes.
- Bias toward finding regressions, missing tests, hidden coupling, and review gates.

## Minimum Done

- Evidence gathered from the closest relevant files or runtime signals.
- Risk and confidence stated.
- Recommendation or change scoped to the evidence.
- Verification path recorded.
