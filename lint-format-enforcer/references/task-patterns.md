# Task Patterns

## Skill Identity

Lint Format Enforcer belongs to the frontend code generation family.

Primary description:

Support lint and formatting with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is fixing or reviewing lint, format, import order, static analysis, precommit hooks, or style violations, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes. Use when an agent needs a deep, evidence-first workflow with repository-specific discovery, risk review, output contracts, and verification guidance.

## Trigger Patterns

- A code change is requested and must be constrained to approved files and local patterns.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Approved edit set, nearest pattern, design-system component, API/state contracts, i18n keys

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for frontend code generation before recommending or editing.
3. Freeze the approved edit set, then make the smallest change that satisfies the behavior.
4. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Creating one-off UI instead of reusing design-system components
- Refactoring unrelated files while solving a ticket

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
