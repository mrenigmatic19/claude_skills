---
name: playwright-e2e-writer
description: >
  Creates or updates Playwright tests for the affected user flow, especially for end-of-flow tickets. Use for testing + evaluation skills work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.
---

# Playwright E2E Writer

## Operating Role

Act as the specialist for this exact capability, not as a generic frontend assistant.

Convert ticket expectations and changed behavior into targeted tests and verification evidence that match repository style.

## Load Order

## Skill-Specific References

- references/task-patterns.md - concrete trigger patterns, inputs, procedure, and pitfalls for this exact skill.
- references/verification-matrix.md - proof matrix for deciding which tests, runtime checks, or review evidence are enough.

Read these references as needed, in this order:

1. references/playbook.md - task workflow and decision sequence.
2. references/evidence-map.md - what evidence to gather and how to judge it.
3. references/output-contract.md - required artifact shape and quality bar.
4. references/failure-modes.md - stop conditions, review gates, and common mistakes.
5. references/examples.md - realistic examples and response patterns.

Always read playbook.md and evidence-map.md before implementation, classification, or final recommendations. Read output-contract.md before producing a ticket, PR, map, test, report, or generated-code summary.

## Non-Negotiables

- Start from actual ticket text, runtime evidence, repository files, tests, configs, or logs.
- Cite file paths, routes, selectors, API names, work items, screenshots, or command output when they support a claim.
- Separate facts, assumptions, confidence, and blockers.
- Use the repository's existing architecture, design system, state patterns, test helpers, and workflow language.
- Stop before code generation when confidence is low, high-risk surfaces are involved, or required context is missing.
- Prefer a narrow artifact or minimal diff over broad cleanup.
- Preserve evidence that a reviewer or future agent can audit.

## Skill-Specific Lens

- Primary purpose: Creates or updates Playwright tests for the affected user flow, especially for end-of-flow tickets.
- Optimize for clean artifact shape, exact wording, and copy/paste readiness.
- Prefer browser-observed evidence over static guesses and record preconditions precisely.

## Final Response Shape

Use the output contract unless the user asks for a different format. Keep the response practical:

- What was understood.
- Evidence used.
- Risk and confidence.
- Action taken or recommended.
- Verification and gaps.

