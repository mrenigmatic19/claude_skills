# Playbook

## Mission

Protect security, privacy, payment, permission, and compliance boundaries by turning vague risk into concrete attack paths, controls, tests, and review gates.

## Procedure

Identify trust boundaries; map sensitive data and privileged actions; find enforcement points; test deny and abuse cases; require human review for high-impact paths.

## Skill-Specific Lens

- Purpose: Support secrets management with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is reviewing API keys, tokens, credentials, secret storage, secret rotation, leaked secrets, .env files, or vault integrations, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes.
- Bias toward finding regressions, missing tests, hidden coupling, and review gates.

## Minimum Done

- Evidence gathered from the closest relevant files or runtime signals.
- Risk and confidence stated.
- Recommendation or change scoped to the evidence.
- Verification path recorded.
