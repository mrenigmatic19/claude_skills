# Task Patterns

## Skill Identity

Architecture Reviewer belongs to the architecture and maintainability family.

Primary description:

Review proposed changes against a repository's existing architecture to prevent architecture drift. Use before or during code changes to identify architecture style, module boundaries, dependency rules, existing patterns, layering violations, unnecessary abstractions, cross-module coupling, duplicate services, framework drift, and maintainability risk.

## Trigger Patterns

- The task name or ticket intent directly matches this skill's purpose.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Module boundaries, dependency graph, public APIs, ADRs, package manifests

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for architecture and maintainability before recommending or editing.
3. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
