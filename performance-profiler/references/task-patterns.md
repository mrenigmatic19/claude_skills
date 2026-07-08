# Task Patterns

## Skill Identity

Performance Profiler belongs to the operations and deployment family.

Primary description:

Support performance profiling with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is diagnosing slow pages, APIs, queries, builds, jobs, memory pressure, latency, throughput, or resource usage, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes. Use when an agent needs a deep, evidence-first workflow with repository-specific discovery, risk review, output contracts, and verification guidance.

## Trigger Patterns

- The task name or ticket intent directly matches this skill's purpose.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Docker/CI/deploy config, env files, logs, health checks, rollback path

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for operations and deployment before recommending or editing.
3. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Changing deploy config without rollback
- Ignoring env parity and health checks

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
