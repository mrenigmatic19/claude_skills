# Evidence Map

## Evidence To Gather

Route match, visible text, accessibility labels, network calls, API hook names, import paths, parent pages, tests, stories, feature flags, role guards, dead routes, and shared component usage counts.

## Evidence Quality

Strong evidence:

- Direct route, import, API, test, runtime, or log evidence.
- Multiple independent signals that agree.
- Recent code paths over stale docs.
- Existing tests or stories that encode expected behavior.

Weak evidence:

- Similar filenames without imports or runtime proof.
- Unverified ticket wording.
- Generated or vendored code.
- Comments that disagree with implementation.
- Screenshots without route, role, or environment.

## Confidence Scoring

Use 0.0 to 1.0.

- 0.90 to 1.00: direct evidence from source plus runtime or tests.
- 0.75 to 0.89: multiple source signals, minor gaps.
- 0.50 to 0.74: plausible but missing one critical signal.
- Below 0.50: do not implement; ask for more context.

## Evidence Ledger

Record important evidence as:

- Claim
- Evidence source
- Confidence
- Why it matters
- Gap or contradiction
