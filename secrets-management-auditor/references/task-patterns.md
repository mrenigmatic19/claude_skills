# Task Patterns

## Skill Identity

Secrets Management Auditor belongs to the security and high-risk UX family.

Primary description:

Support secrets management with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is reviewing API keys, tokens, credentials, secret storage, secret rotation, leaked secrets, .env files, or vault integrations, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes. Use when an agent needs a deep, evidence-first workflow with repository-specific discovery, risk review, output contracts, and verification guidance.

## Trigger Patterns

- The change touches high-risk user trust, identity, money, credentials, or personal data.

## Inputs To Ask For Or Discover

- User request or ticket text
- Relevant repository paths
- Existing tests or verification commands
- Roles, permissions, data classes, threat paths, audit logs, deny-case tests

## Exact Procedure

1. Restate the exact task in one sentence and name the expected artifact.
2. Collect the minimum evidence set for security and high-risk UX before recommending or editing.
3. Apply a conservative stop gate when evidence is incomplete or the blast radius is not bounded.
4. Write the result with evidence, confidence, risk, verification, and unresolved gaps.

## Common Pitfalls

- Using the skill name as a substitute for evidence
- Skipping local conventions and producing generic advice
- Omitting confidence or blockers
- Testing only allow paths and not deny paths
- Ignoring replay, duplicate-submit, or privilege escalation cases

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
