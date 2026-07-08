---
name: responsive-ui-auditor
description: >
  Support responsive UI with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is checking mobile, tablet, desktop, overflow, viewport resizing, layout shifts, or text fitting issues, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes. Use when an agent needs a deep, evidence-first workflow with repository-specific discovery, risk review, output contracts, and verification guidance.
---

# Responsive UI Auditor

## Operating Role

Keep UI changes grounded in actual routes, components, state, APIs, design-system usage, accessibility, and responsive behavior.

## Load Order

## Skill-Specific References

- references/task-patterns.md - concrete trigger patterns, inputs, procedure, and pitfalls for this exact skill.
- references/verification-matrix.md - proof matrix for deciding which tests, runtime checks, or review evidence are enough.

Read references/playbook.md and references/evidence-map.md before final recommendations or edits. Read references/output-contract.md before producing the final artifact. Read references/failure-modes.md when risk, ambiguity, or high-impact behavior is present. Read references/examples.md when shaping the final response.

## Core Commitments

- Ground every important claim in source, tests, config, runtime behavior, logs, or user-provided artifacts.
- Keep facts, assumptions, risks, and confidence separate.
- Prefer established repository patterns over generic best practices.
- Make the narrowest useful recommendation or change.
- Include verification commands, manual proof, or the reason verification is blocked.

## Skill-Specific Lens

- Purpose: Support responsive UI with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is checking mobile, tablet, desktop, overflow, viewport resizing, layout shifts, or text fitting issues, especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes.
- Bias toward finding regressions, missing tests, hidden coupling, and review gates.

