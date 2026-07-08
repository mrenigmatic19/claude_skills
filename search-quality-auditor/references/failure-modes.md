# Failure Modes

## Stop Conditions

Stop when a change can lose data, double-process events, break consumers, or cannot be rolled back.

## Common Mistakes

- Recommending a new pattern before reading local examples.
- Treating docs as current when source code disagrees.
- Ignoring tests, runtime behavior, or deployment/config impact.
- Hiding uncertainty.
- Making unrelated cleanup changes.

## Recovery

- Narrow scope.
- Gather one stronger evidence source.
- Ask one precise question.
- Produce a plan or map instead of code.
