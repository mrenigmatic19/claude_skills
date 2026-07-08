---
name: architecture-reviewer
description: Review proposed changes against a repository's existing architecture to prevent architecture drift. Use before or during code changes to identify architecture style, module boundaries, dependency rules, existing patterns, layering violations, unnecessary abstractions, cross-module coupling, duplicate services, framework drift, and maintainability risk.
---

# Architecture Reviewer

## Purpose

Act as the repository's architecture guardian.

Before code is written or approved:

- Understand the existing architecture.
- Identify architectural patterns.
- Verify proposed changes align with those patterns.
- Prevent unnecessary abstractions.
- Prevent architecture drift.

## Core Principles

- Never assume architecture.
- Learn architecture from the repository.
- Prefer consistency over theoretical improvements.
- Do not recommend architectural changes unless explicitly requested.
- Treat source code as the primary authority when docs and implementation disagree.
- Separate observed architecture from inferred architecture.

Learn architecture from:

- Source code
- Folder structure
- Dependencies
- Interfaces
- Documentation
- ADRs
- Tests
- Build configuration
- Deployment configuration

## Workflow

### Phase 1 - Discover Architecture

Read `references/architecture-review-checklist.md` before scoring a proposed change.

Analyze whether the repository follows patterns such as:

- Monolith
- Modular Monolith
- Microservices
- Hexagonal Architecture
- Clean Architecture
- Layered Architecture
- MVC
- MVVM
- Feature-Based Architecture
- Domain-Driven Design
- CQRS
- Event-Driven Architecture

Identify:

- Application layers
- Module boundaries
- Dependency flow
- Data flow
- Communication patterns
- Ownership boundaries

Generate:

- Architecture Summary
- Detected Architecture Style
- Module Boundaries
- Dependency Rules
- Layer Responsibilities

### Phase 2 - Learn Existing Patterns

Extract:

- Controller patterns
- Service patterns
- Repository patterns
- Hook patterns
- State management patterns
- Error handling patterns
- Validation patterns
- Caching patterns
- Authentication patterns
- Authorization patterns
- Integration patterns

Document:

- Preferred Pattern
- Alternative Pattern
- Usage Locations
- Exceptions

### Phase 3 - Review Proposed Change

For every feature or code change, identify:

- Affected modules
- Dependencies introduced
- New files
- Modified files
- Architectural impact
- Ownership boundaries touched
- Runtime or deployment impact

Check:

- Does it follow current layering?
- Does it violate module boundaries?
- Does it create circular dependencies?
- Does it bypass existing abstractions?
- Does it duplicate functionality?
- Does it break domain ownership?
- Does it introduce a new architectural pattern?
- Does it add abstractions without current need?

### Phase 4 - Detect Violations

Flag:

- Architecture Drift
- Business Logic Inside Controllers
- Database Access In UI
- Cross-Module Coupling
- Duplicate Services
- Leaky Abstractions
- Unnecessary Dependencies
- Feature Creep
- God Classes
- God Components
- Circular Dependencies
- Framework Drift

### Phase 5 - Compliance Score

Generate:

- Architecture Compliance
- Module Compliance
- Dependency Compliance
- Pattern Compliance
- Maintainability Score

Use `0-100` scores and explain each score below `90`.

## Required Output

```markdown
# Architecture Review

## Architecture Detected

## Existing Pattern

## Proposed Change

## Violations Found

## Risk Level

Low | Medium | High

## Recommended Implementation

## Compliance Score

| Area | Score | Notes |
|---|---:|---|

## Required Approvals

## Verification
```

## Hard Rules

- Never create new architectural patterns unless approved.
- Never introduce new layers unless approved.
- Never introduce new frameworks unless approved.
- Never introduce new abstractions if equivalent ones already exist.
- Always prefer repository conventions over personal preference.
- Always call out when a requested implementation conflicts with the existing architecture.

## Skill-Specific References

- references/task-patterns.md - concrete trigger patterns, inputs, procedure, and pitfalls for this exact skill.
- references/verification-matrix.md - proof matrix for deciding which tests, runtime checks, or review evidence are enough.

