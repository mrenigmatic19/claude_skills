# Pattern Extraction Guide

Use this guide to learn the repository's testing style before generating tests.

## Discovery Commands

Prefer fast search commands:

```bash
rg --files -g "*.test.*" -g "*.spec.*" -g "**/__tests__/**" -g "test/**" -g "tests/**"
rg -n "describe\\(|it\\(|test\\(|expect\\(|beforeEach\\(|afterEach\\("
rg -n "pytest|unittest|describe|it\\(|test\\(|expect|assert"
```

Inspect package or project config:

- `package.json`
- `vitest.config.*`
- `jest.config.*`
- `playwright.config.*`
- `cypress.config.*`
- `pytest.ini`
- `pyproject.toml`
- `tox.ini`
- `go.mod`
- `Cargo.toml`
- `pom.xml`
- `build.gradle`
- `.github/workflows/*`

## Blueprint Fields

Build a short blueprint before editing:

```markdown
## Testing Blueprint

- Framework:
- Runner command:
- Test file location:
- File naming:
- Test naming:
- Mocking:
- Fixtures:
- Setup/teardown:
- Assertions:
- Async handling:
- Helpers to reuse:
- Edge cases to cover:
```

## Mocking Strategy Signals

Look for:

- Manual mocks
- Factory functions
- Dependency injection
- HTTP interceptors
- Service fakes
- Database transaction rollbacks
- Test containers
- In-memory databases
- Monkeypatching
- Module-level mocks
- Browser/network route mocks

Do not introduce a heavier mocking approach if existing tests use simple seams or helpers.

## Fixture Strategy Signals

Look for:

- Static fixture files
- Inline builders
- Factories
- Seed scripts
- Shared `fixtures` directories
- Test data generators
- Snapshot fixtures
- API response payloads

Prefer the fixture style used by nearby tests over the global style if they differ.

## Assertion Style Signals

Notice whether tests use:

- Exact equality
- Partial object matching
- Snapshot assertions
- Semantic assertions
- Status-code assertions
- Error-message assertions
- DOM role/text assertions
- Custom matchers

Use the same level of specificity as existing tests. Do not add brittle exact assertions if the repository generally checks behavior semantically.

## Naming Signals

Preserve conventions such as:

- `should ...`
- `returns ... when ...`
- `handles ...`
- `it("...")`
- `test("...")`
- `ClassName.methodName`
- Route or endpoint names
- Given/when/then phrasing

## Coverage Gap Prioritization

Prioritize:

- Recent or changed code
- Public APIs
- Business-critical paths
- Authorization checks
- Error handling
- Data validation
- Edge cases caused by null, empty, malformed, duplicate, expired, or unauthorized inputs
- Regression tests for observed bugs

Deprioritize:

- Trivial getters/setters
- Framework boilerplate
- Generated code
- Pure reformatting
- Covered behavior that only lacks redundant line coverage

## Deviation Rules

Introduce a new pattern only when:

- No existing pattern applies.
- Existing tests are clearly obsolete or broken.
- The requested test type is absent from the repository.
- The existing helper cannot express the behavior being tested.

When deviating, document:

- What existing pattern was considered.
- Why it was insufficient.
- What new pattern was added.
- How future tests should reuse it.
