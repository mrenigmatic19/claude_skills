# Playbook

## Purpose

Captures frontend network calls during a Playwright flow and maps API calls to frontend hooks/services.

Category mission:

Use real browser evidence to discover, reproduce, document, and verify frontend flows instead of guessing from filenames or component names.

## Procedure

1. Establish preconditions and role. 2. Open the app and navigate like a user. 3. Capture route, visible UI, accessibility labels, and network calls at every major step. 4. Map runtime evidence to source files. 5. Save flow context. 6. Re-run after changes and compare.

## Skill-Specific Moves

- Primary purpose: Captures frontend network calls during a Playwright flow and maps API calls to frontend hooks/services.
- Prefer browser-observed evidence over static guesses and record preconditions precisely.

## Decision Rules

Prefer role/name selectors and accessibility labels over brittle CSS selectors. Treat a browser failure as inconclusive until environment, auth, test data, network, and timing are checked.

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
