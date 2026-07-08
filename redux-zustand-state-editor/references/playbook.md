# Playbook

## Purpose

Guides changes in Redux/Zustand stores without breaking selectors, actions, reducers, or persisted state.

Category mission:

Generate frontend changes only after the target route, component, API, state, design-system pattern, and tests are known.

## Procedure

1. Confirm approved edit set. 2. Read nearest implementation pattern. 3. Make the smallest behavior-preserving diff. 4. Add missing UI states. 5. Update tests in local style. 6. Run narrow verification. 7. Report exact evidence.

## Skill-Specific Moves

- Primary purpose: Guides changes in Redux/Zustand stores without breaking selectors, actions, reducers, or persisted state.
- Only edit files approved by evidence and reuse the closest local implementation pattern.

## Decision Rules

Do not create raw HTML controls when design-system components exist. Do not invent state management, query keys, schema libraries, or CSS patterns.

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
