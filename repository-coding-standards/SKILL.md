---
name: repository-coding-standards
description: Enforce repository-specific coding standards before generating or modifying code. Use when Codex must learn existing source conventions, linters, formatters, tsconfig, editorconfig, style guides, architecture rules, naming, folder structure, imports, error handling, logging, security conventions, testing style, and dependency rules before writing or reviewing code.
---

# Repository Coding Standards

## Goal

Never write code until repository standards are understood.

Use observed repository conventions as the default authority for code generation and review.

## Core Rules

- Learn local standards before generating or modifying code.
- Prefer established repository patterns over generic best practices.
- Do not introduce new patterns, libraries, architectures, or test styles without explicit approval.
- Match architecture, naming, imports, folder structure, error handling, logging, and testing style.
- Report uncertainty when standards conflict or are not visible.
- Keep code changes narrowly scoped to the requested behavior.

## Workflow

### Phase 1 - Learn Standards

Analyze:

- Existing source code
- Linters
- ESLint
- Prettier
- Biome
- TypeScript config
- EditorConfig
- Style guides
- Documentation
- Tests
- CI commands
- Framework config

Extract:

- Naming conventions
- Folder structure
- Error handling
- Logging
- Dependency injection
- API conventions
- Security conventions
- Import/export style
- Comment style
- Testing style

### Phase 2 - Create Standards Profile

Read `references/standards-profile.md` before producing or applying a standards profile.

Generate:

- File Naming
- Variable Naming
- Function Naming
- Class Naming
- Folder Structure
- Import Order
- Export Style
- Comment Style
- Error Handling Style
- Logging Style
- API Style
- Testing Style
- Security Style

### Phase 3 - Code Generation Rules

Before generating code, verify it:

- Matches architecture
- Matches naming
- Matches imports
- Matches folder structure
- Matches error handling
- Matches logging conventions
- Matches testing style
- Reuses existing utilities
- Avoids unnecessary dependencies
- Preserves security boundaries

Never introduce:

- New patterns
- New libraries
- New architectures
- New folder structures
- New testing frameworks
- New error abstractions

without explicit approval.

### Phase 4 - Compliance Check

Score:

- Architecture Compliance
- Naming Compliance
- Testing Compliance
- Security Compliance
- Performance Compliance
- Dependency Compliance

Use `0-100` scores and explain any score below `90`.

## Output Format

```markdown
# Coding Standards Report

## Detected Standards

## Standards Profile

## Compliance Score

| Area | Score | Notes |
|---|---:|---|

## Violations

## Suggested Fixes

## Approved Code

## Deviations Requiring Approval

## Verification
```

## Editing Standards

- Make the smallest code change that satisfies the request.
- Use existing abstractions unless they are demonstrably inadequate.
- Keep public APIs backward compatible unless the user requested a breaking change.
- Update tests using the repository's existing test style.
- Do not reformat unrelated files.
- Do not churn imports, comments, or formatting outside the touched code.

## Verification

Run available format, lint, typecheck, and test commands when relevant.

Report:

- Commands run
- Passing/failing result
- Relevant failures
- Existing unrelated failures
- Checks skipped and why

## Skill-Specific References

- references/task-patterns.md - concrete trigger patterns, inputs, procedure, and pitfalls for this exact skill.
- references/verification-matrix.md - proof matrix for deciding which tests, runtime checks, or review evidence are enough.

