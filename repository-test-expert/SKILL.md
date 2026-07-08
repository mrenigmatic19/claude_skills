---
name: repository-test-expert
description: Learn testing conventions from an existing codebase and generate new tests that match repository patterns. Use before adding, repairing, expanding, or reviewing tests when Codex must discover existing test frameworks, folder conventions, mocking strategy, fixture usage, assertion style, setup/teardown patterns, coverage gaps, and naming standards instead of inventing a new testing style.
---

# Repository Test Expert

## Goal

Learn how the repository writes tests before generating or modifying tests.

Never invent a testing style when repository patterns already exist.

## Core Rules

- Inspect existing tests before writing new tests.
- Match repository style exactly unless there is a documented reason not to.
- Reuse existing helpers, fixtures, factories, mocks, and setup utilities.
- Prefer the dominant local pattern nearest to the code under test.
- Do not introduce a new test framework, assertion library, mocking library, fixture format, or folder structure unless necessary.
- Explain any unavoidable deviation from existing patterns.
- Keep generated tests focused on meaningful behavior, edge cases, and regressions.

## Workflow

### Phase 1 - Discover Tests

Scan for existing tests:

- `*.test.*`
- `*.spec.*`
- `__tests__/`
- `test/`
- `tests/`
- `integration/`
- `e2e/`
- `cypress/`
- `playwright/`
- Framework-specific test directories

Classify discovered tests as:

- Unit Tests
- Integration Tests
- API Tests
- E2E Tests
- Performance Tests
- Snapshot Tests
- Contract Tests

Identify test frameworks and runners from:

- Package manifests
- Lockfiles
- Test config files
- CI config
- Existing test imports
- Test scripts

### Phase 2 - Learn Patterns

Read `references/pattern-extraction.md` before creating a testing blueprint.

Extract:

- Folder structure
- File naming conventions
- Test naming conventions
- Mocking strategy
- Fixture strategy
- Factory strategy
- Assertion style
- Async testing style
- Setup and teardown patterns
- Database or service isolation patterns
- API request helpers
- Snapshot usage
- Coverage tooling

Create a testing blueprint before writing tests.

### Phase 3 - Coverage Analysis

Find gaps in:

- Untested functions
- Untested services
- Untested endpoints
- Untested edge cases
- Error paths
- Authorization and permissions
- Boundary values
- State transitions
- Regression scenarios

Prefer high-risk behavior over shallow line coverage.

### Phase 4 - Generate Tests

When generating tests:

- Match repository style exactly.
- Place files in the same location pattern used by nearby tests.
- Reuse existing helpers.
- Reuse existing fixtures.
- Reuse existing mocks.
- Follow naming standards.
- Use the same assertion style.
- Use the same setup/teardown lifecycle.
- Keep test data realistic for the repository domain.
- Add only the tests needed for the requested behavior or identified gap.

## Output Format

```markdown
# Testing Pattern Report

## Testing Frameworks

## Test Classification

## Naming Convention

## Folder Structure

## Mocking Strategy

## Fixture Strategy

## Setup And Teardown

## Assertion Style

## Coverage Gaps

## Testing Blueprint

## Generated Tests

## Deviations Or New Patterns

## Verification
```

## Editing Standards

- Make focused test edits.
- Avoid unrelated refactors in production code.
- If production code must change to make testing possible, explain why.
- Prefer adding tests near existing related tests.
- Do not delete or rewrite existing tests unless explicitly requested or necessary to fix broken behavior.

## Verification

Run the narrowest relevant test command first.

If available, prefer commands already used by the repository, such as:

```bash
npm test
npm run test
npm run test -- <pattern>
pnpm test
yarn test
pytest
python -m pytest
go test ./...
cargo test
mvn test
gradle test
dotnet test
```

Report:

- Commands run
- Passing/failing result
- Failures related to the change
- Existing unrelated failures
- Tests not run and why

## Skill-Specific References

- references/task-patterns.md - concrete trigger patterns, inputs, procedure, and pitfalls for this exact skill.
- references/verification-matrix.md - proof matrix for deciding which tests, runtime checks, or review evidence are enough.

