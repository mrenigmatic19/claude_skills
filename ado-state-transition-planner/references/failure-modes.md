# Failure Modes

## Stop Conditions

Stop when the ticket has no reproducible behavior, no target surface, conflicting comments, missing role/environment, or high-risk areas without owner approval.

## Common Mistakes

- Treating the skill name as enough context.
- Writing code from ticket wording without mapping route, component, API, state, and tests.
- Creating a new component, state pattern, selector strategy, or test style when the repo already has one.
- Ignoring role, permission, feature flag, environment, or test-data preconditions.
- Reporting confidence without explaining evidence.
- Replacing human review for high-risk payment, auth, credential, deployment, or customer-data paths.

## Recovery Actions

- Ask one precise clarification question.
- Produce a mapping report instead of code.
- Limit the change to verified files.
- Add a failing reproduction before a fix.
- Request human review for risk acceptance.
- Save the missing evidence as a blocker rather than guessing.
