---
name: codebase-knowledge-extractor
description: Build a complete understanding of a repository by extracting architecture, patterns, concepts, workflows, dependencies, and business logic. Use for senior-engineer onboarding, repository knowledge bases, code comprehension before large changes, architecture maps, concept inventories, feature-flow tracing, dependency mapping, and recommended reading orders for large or unfamiliar codebases.
---

# Codebase Knowledge Extractor

## Goal

Act as a senior engineer onboarding to the project.

Build a repository knowledge graph before recommending or making broad changes.

## Core Rules

- Comprehend before changing code.
- Separate observed repository facts from inferred architecture.
- Provide file references for important claims.
- Prefer concrete feature flows over vague architecture summaries.
- Identify uncertainty and missing context.
- Do not invent business concepts that are not supported by code, docs, schemas, or tests.

## Workflow

### Phase 1 - Architecture Discovery

Analyze:

- Root structure
- Services
- Modules
- Packages
- Apps
- Shared libraries
- Configuration
- Build and deployment files
- Database files and migrations
- API definitions

Document:

- Frontend architecture
- Backend architecture
- Database architecture
- Deployment architecture
- Test architecture
- Integration architecture

### Phase 2 - Concept Mining

Read `references/concept-mining.md` before building the knowledge base.

Extract:

- Design patterns
- Architecture patterns
- Domain concepts
- Business entities
- Services
- Events
- Workflows
- External integrations
- Authorization concepts
- Data lifecycle concepts

Examples:

- Repository Pattern
- CQRS
- Event Driven
- MVC
- Dependency Injection
- Factory Pattern
- Service Layer
- Controller Layer
- Adapter Pattern
- Scheduler or Worker Pattern

### Phase 3 - Cross Reference

For each concept, find:

- Definition
- Usage
- Implementations
- References
- Dependencies
- Tests
- Configuration
- Ownership boundaries when visible

Provide file references for the evidence.

### Phase 4 - Knowledge Graph

Build feature-flow chains such as:

```text
Feature
-> UI or API Entry Point
-> Controller or Handler
-> Service
-> Repository or Data Access
-> Database
-> Events or Jobs
-> External APIs
```

Adapt the chain to the repository's actual architecture.

## Output Format

```markdown
# Repository Knowledge Base

## Architecture

## Business Concepts

## Technical Concepts

## Feature Flows

## Dependencies

## Important Files

## Recommended Reading Order

## Knowledge Gaps

## Change-Risk Notes
```

## Recommended Reading Order Rules

Prioritize files that explain the system fastest:

1. Root manifests and workspace configuration
2. Application entry points
3. Routing or API definitions
4. Core domain models
5. Services and workflows
6. Data access and migrations
7. External integration adapters
8. Tests that encode business behavior
9. Deployment and runtime configuration

## Evidence Standards

- Cite file paths and line numbers when possible.
- Use short quotes only when exact terminology matters.
- Mark inferred relationships as inferred.
- Highlight contradictions between docs, tests, and implementation.
- Call out generated, vendored, or build-output files as excluded when relevant.

## Skill-Specific References

- references/task-patterns.md - concrete trigger patterns, inputs, procedure, and pitfalls for this exact skill.
- references/verification-matrix.md - proof matrix for deciding which tests, runtime checks, or review evidence are enough.

