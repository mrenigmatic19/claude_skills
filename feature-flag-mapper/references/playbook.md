# Playbook

## Purpose

Detects feature flags controlling the target UI and ensures Claude does not bypass or hardcode feature flag behavior.

Category mission:

Turn runtime and repository clues into confident component/source ownership before code generation starts.

## Procedure

1. Gather independent signals. 2. Score each signal. 3. Identify candidate files. 4. Reject duplicates and dead routes. 5. Estimate blast radius. 6. Proceed only when confidence clears the threshold.

## Skill-Specific Moves

- Primary purpose: Detects feature flags controlling the target UI and ensures Claude does not bypass or hardcode feature flag behavior.
- Produce durable maps with source paths, confidence, and update triggers.

## Decision Rules

Use weighted confidence, not a single filename match. Shared component edits require impact analysis across all consumers.

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
