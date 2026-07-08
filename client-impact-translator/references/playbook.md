# Playbook

## Purpose

Translates a technical ticket into a client-friendly impact summary: "What changed, why it matters, how it was validated."

Category mission:

Convert uncertain ADO work items into explicit engineering instructions: normalized intent, missing facts, automation eligibility, risk class, branch/PR metadata, and reviewer-ready comments.

## Procedure

1. Preserve the raw ticket in notes before rewriting it. 2. Extract nouns into feature, route, role, data object, and UI surface. 3. Convert verbs into expected behavior. 4. Mark vague phrases as unresolved. 5. Assign risk and confidence. 6. Produce an ADO-ready artifact with blockers and next action.

## Skill-Specific Moves

- Primary purpose: Translates a technical ticket into a client-friendly impact summary: "What changed, why it matters, how it was validated."
- Optimize for clean artifact shape, exact wording, and copy/paste readiness.

## Decision Rules

AI-safe only when the ticket is narrow, testable, frontend-contained, has clear acceptance criteria, and avoids auth, payment, security, customer data, infra, and destructive workflow changes.

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
