# Standards Profile Guide

Use this guide to infer repository-specific coding standards.

## Discovery Targets

Inspect:

- `.editorconfig`
- `.eslintrc*`
- `eslint.config.*`
- `.prettierrc*`
- `prettier.config.*`
- `biome.json`
- `tsconfig*.json`
- `jsconfig.json`
- `package.json`
- `pyproject.toml`
- `ruff.toml`
- `setup.cfg`
- `go.mod`
- `Cargo.toml`
- `pom.xml`
- `build.gradle`
- CI workflows
- Existing source files near the target change
- Existing tests near the target change

## Standards Profile Template

```markdown
## Standards Profile

- Language/framework:
- Formatter:
- Linter:
- Type system:
- File naming:
- Folder structure:
- Imports:
- Exports:
- Variables:
- Functions:
- Classes/types:
- Components:
- Error handling:
- Logging:
- Async/concurrency:
- API conventions:
- Security conventions:
- Testing conventions:
- Dependency policy:
```

## Naming Signals

Look for:

- camelCase, PascalCase, snake_case, kebab-case
- Prefix/suffix patterns
- Hook naming
- Service naming
- DTO/schema naming
- Test naming
- Route naming
- File/folder naming

Prefer conventions from nearby files over global guesses.

## Error Handling Signals

Look for:

- Exceptions
- Result/Either types
- Error response helpers
- HTTP error classes
- Validation errors
- Domain-specific errors
- Logging before rethrow
- User-facing versus internal error messages

Do not invent a new error abstraction if existing code already has one.

## Import And Dependency Signals

Look for:

- Absolute versus relative imports
- Path aliases
- Barrel files
- Import grouping
- Type-only imports
- Dynamic imports
- Existing utility libraries
- Prohibited dependencies

Avoid adding dependencies for small tasks unless explicitly approved.

## Security Signals

Check how the repository handles:

- Authentication
- Authorization
- Tenant or organization scoping
- Input validation
- Output escaping
- Secret handling
- PII logging
- File uploads
- External requests
- Rate limits
- Payment or billing boundaries

Security-sensitive changes should get stricter compliance review.

## Compliance Scoring

Use this interpretation:

- `95-100`: Matches local standards with no meaningful concern.
- `90-94`: Minor deviation or uncertainty.
- `75-89`: Noticeable deviation that should be fixed or justified.
- `50-74`: Significant mismatch with repository standards.
- `<50`: Likely incompatible with project conventions.

Explain all scores below `90` with concrete evidence.

## Approval Triggers

Ask for explicit approval before:

- Adding a new runtime dependency
- Introducing a new framework
- Creating a new architectural layer
- Changing public API shape
- Changing persistence models
- Adding global config
- Replacing established test tools
- Changing lint/format rules
- Changing security behavior
