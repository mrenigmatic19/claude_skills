# Playbook

## Purpose

Decides ADO status updates: AI In Progress, Needs Clarification, Ready for Review, AI Failed, or Human Required.

Category mission:

Convert uncertain ADO work items into explicit engineering instructions: normalized intent, missing facts, automation eligibility, risk class, branch/PR metadata, and reviewer-ready comments.

## Procedure

1. Preserve the raw ticket in notes before rewriting it. 2. Extract nouns into feature, route, role, data object, and UI surface. 3. Convert verbs into expected behavior. 4. Mark vague phrases as unresolved. 5. Assign risk and confidence. 6. Produce an ADO-ready artifact with blockers and next action.

## Skill-Specific Moves

- Primary purpose: Decides ADO status updates: AI In Progress, Needs Clarification, Ready for Review, AI Failed, or Human Required.

## Decision Rules

AI-safe only when the ticket is narrow, testable, frontend-contained, has clear acceptance criteria, and avoids auth, payment, security, customer data, infra, and destructive workflow changes.

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
