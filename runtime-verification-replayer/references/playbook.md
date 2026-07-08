# Playbook

## Purpose

After code generation, reruns the Playwright flow and verifies the actual UI behavior in browser.

Category mission:

Convert ticket expectations and changed behavior into targeted tests and verification evidence that match repository style.

## Procedure

1. Mine local test conventions. 2. Connect each acceptance criterion to proof. 3. Add failing reproduction first when useful. 4. Write minimal tests with existing helpers. 5. Diagnose CI failures into scoped repair instructions. 6. Produce PR evidence.

## Skill-Specific Moves

- Primary purpose: After code generation, reruns the Playwright flow and verifies the actual UI behavior in browser.
- Prefer browser-observed evidence over static guesses and record preconditions precisely.

## Decision Rules

Prefer meaningful behavior coverage over shallow snapshots. Do not weaken assertions to make tests pass. Separate app bugs from test flakiness.

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
