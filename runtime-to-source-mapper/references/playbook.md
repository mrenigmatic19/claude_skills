# Playbook

## Purpose

Combines Playwright route, visible text, network calls, and repo search to identify the exact component/file.

Category mission:

Turn runtime and repository clues into confident component/source ownership before code generation starts.

## Procedure

1. Gather independent signals. 2. Score each signal. 3. Identify candidate files. 4. Reject duplicates and dead routes. 5. Estimate blast radius. 6. Proceed only when confidence clears the threshold.

## Skill-Specific Moves

- Primary purpose: Combines Playwright route, visible text, network calls, and repo search to identify the exact component/file.
- Produce durable maps with source paths, confidence, and update triggers.
- Prefer browser-observed evidence over static guesses and record preconditions precisely.

## Decision Rules

Use weighted confidence, not a single filename match. Shared component edits require impact analysis across all consumers.

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
