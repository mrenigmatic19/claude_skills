# Task Patterns

## Skill Identity

Dependency License Auditor belongs to the runtime/browser flow analysis family.

Primary description:

Support dependency licensing with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is reviewing open source licenses, dependency policy, copyleft risk, attribution, package additions, or license inventories, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes. Use when an agent needs a deep, evidence-first workflow with repository-specific discovery, risk review, output contracts, and verification guidance.

## Trigger Patterns

- The task name or ticket intent directly matches this skill's purpose.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- App URL, role/session, test data, route, screenshots, network calls, accessibility labels

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for runtime/browser flow analysis before recommending or editing.
3. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Guessing source files from route names only
- Ignoring auth/session/test-data preconditions

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
