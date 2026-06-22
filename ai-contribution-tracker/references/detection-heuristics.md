# Detection Heuristics

Use these heuristics as evidence, not proof. Combine multiple signals before making a classification.

## Stronger AI Indicators

- Large cohesive code additions with very few iterative commits.
- Generic, highly structured comments that explain obvious code.
- Broad boilerplate with consistent naming and formatting across unrelated files.
- Test files that cover many surface paths but miss project-specific edge cases.
- Documentation written in polished generic phrasing without matching implementation nuance.
- Commit messages such as `Add comprehensive tests`, `Implement robust error handling`, `Refactor for better maintainability`, or similarly broad AI-like summaries.
- Sudden introduction of repetitive helper abstractions not used elsewhere in the repository.
- Code that is syntactically clean but semantically disconnected from existing project conventions.
- Multiple files with identical section ordering, comment style, and defensive checks.

## Weaker AI Indicators

- Polished variable names.
- Good formatting.
- Long functions.
- Use of modern language features.
- Boilerplate from a framework generator.
- Similarity to public examples.

These weak indicators should not drive attribution by themselves.

## Human-Written Indicators

- Small incremental commits that match surrounding project style.
- Changes linked to bug-specific context, issue references, or production incidents.
- Hand-edited edge cases that reflect domain knowledge.
- Imperfect but locally consistent naming, comments, or structure.
- Commit history showing exploration, reverts, and targeted follow-up fixes.
- Tests that focus on specific regressions or known business rules.

## Mixed Contribution Indicators

- A human-authored feature commit followed by broad AI-like tests or documentation.
- AI-like scaffolding adapted with project-specific logic.
- Large generated sections interleaved with manual integration code.
- Commit messages or PR notes mentioning Copilot, Claude, ChatGPT, Cursor, pair programming with AI, generated tests, or assisted refactors.

## Unknown Indicators

Classify as `Unknown` when:

- The file is too small to evaluate.
- The commit only changes formatting, dependencies, lockfiles, or generated artifacts.
- There is not enough history.
- Signals conflict strongly.
- The contribution is standard framework output.

## File Role Guidance

- Treat tests separately from source code.
- Treat documentation separately from source code.
- Treat generated directories as excluded unless the user explicitly asks to include them.
- Treat vendored code, minified assets, compiled artifacts, lockfiles, screenshots, and binary files as excluded from LOC attribution.

## Suggested Exclusions

Exclude or separately report:

- `node_modules/`
- `vendor/`
- `dist/`
- `build/`
- `.next/`
- `.nuxt/`
- `coverage/`
- `.turbo/`
- `.cache/`
- Lockfiles unless dependency-change attribution is explicitly requested
- Minified files
- Binary files
- Generated API clients
- Generated migrations when clearly tool-created

## Confidence Examples

`Likely AI Generated`, confidence `0.85`:

- One large commit adds many files with uniform comments, generic tests, and no iterative history.

`Mixed Contribution`, confidence `0.70`:

- Core implementation matches project style, but tests and docs are broad, generic, and added in the same sweep.

`Likely Human Written`, confidence `0.75`:

- Small targeted bug fix references an issue, changes one branch, and adds a regression test for a specific edge case.

`Unknown`, confidence `0.25`:

- A generated lockfile or tiny formatting change has no meaningful authorship signal.
