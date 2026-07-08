# Playbook

## Mission

Keep UI changes grounded in actual routes, components, state, APIs, design-system usage, accessibility, and responsive behavior.

## Procedure

Map route to source; inspect nearest component pattern; trace state and API calls; reuse design-system components; verify states, roles, accessibility, and viewport behavior.

## Skill-Specific Lens

- Purpose: Support lint and formatting with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is fixing or reviewing lint, format, import order, static analysis, precommit hooks, or style violations, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes.
- Make the smallest repository-consistent change and verify behavior, not just compilation.

## Minimum Done

- Evidence gathered from the closest relevant files or runtime signals.
- Risk and confidence stated.
- Recommendation or change scoped to the evidence.
- Verification path recorded.
