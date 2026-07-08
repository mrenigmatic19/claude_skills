# Playbook

## Purpose

Traces imports and dependencies from a target component to understand what changing one file may break.

Category mission:

Build high-signal repository maps that help future agents change code safely: routes, components, imports, feature slices, API contracts, state patterns, tests, design-system inventory, and package boundaries.

## Procedure

1. Start with entry points and manifests. 2. Walk from route to page to feature module. 3. Trace imports outward one layer at a time. 4. Record evidence with file paths. 5. Distinguish primary owner files from incidental dependencies. 6. Write indexes that are specific enough to drive later edits.

## Skill-Specific Moves

- Primary purpose: Traces imports and dependencies from a target component to understand what changing one file may break.
- Produce durable maps with source paths, confidence, and update triggers.

## Decision Rules

Prefer observed relationships over name similarity. Treat generated files, vendored code, barrel exports, and shared utilities as supporting evidence, not ownership proof.

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
