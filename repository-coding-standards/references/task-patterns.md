# Task Patterns

## Skill Identity

Repository Coding Standards belongs to the security and high-risk UX family.

Primary description:

Enforce repository-specific coding standards before generating or modifying code. Use when Codex must learn existing source conventions, linters, formatters, tsconfig, editorconfig, style guides, architecture rules, naming, folder structure, imports, error handling, logging, security conventions, testing style, and dependency rules before writing or reviewing code.

## Trigger Patterns

- The task name or ticket intent directly matches this skill's purpose.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Roles, permissions, data classes, threat paths, audit logs, deny-case tests

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for security and high-risk UX before recommending or editing.
3. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Testing only allow paths and not deny paths
- Ignoring replay, duplicate-submit, or privilege escalation cases

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
