# Concept Mining Guide

Use this guide to extract a useful repository knowledge graph.

## First-Pass Discovery

Prefer fast structural commands:

```bash
rg --files
rg -n "class |function |interface |type |enum |router|controller|service|repository|handler|usecase|workflow|event|queue|worker"
rg -n "TODO|FIXME|deprecated|migration|feature flag|permission|role|policy"
```

Inspect common system files:

- Package/workspace manifests
- Build config
- Docker and compose files
- CI workflows
- Environment examples
- App entry points
- Route definitions
- Schema files
- Migration files
- ORM models
- API clients
- Tests
- Documentation

## Architecture Signals

Look for:

- Apps versus packages
- Frontend/backend boundaries
- Controllers, routes, or handlers
- Services or use cases
- Repositories or data access objects
- Domain models or entities
- Event publishers/subscribers
- Queues and workers
- Schedulers
- Adapters for external systems
- Dependency injection containers
- Middleware
- Feature flags
- Auth and authorization layers

## Business Concept Signals

Extract concepts from:

- Model/entity names
- Database table names
- API route names
- Event names
- Test names
- User-facing copy
- Validation schemas
- Permissions and roles
- Payment, order, account, tenant, workflow, or lifecycle terminology

Do not treat every helper class as a business concept. Prefer concepts that appear across multiple layers.

## Technical Concept Signals

Extract patterns such as:

- MVC
- Service Layer
- Repository Pattern
- CQRS
- Event Driven Architecture
- Dependency Injection
- Factory Pattern
- Adapter Pattern
- Strategy Pattern
- Middleware Pipeline
- Worker Queue
- Request/Response DTOs
- Schema Validation

Name a pattern only when evidence exists in code structure or naming.

## Cross-Reference Template

```markdown
### Concept Name

- Type:
- Definition:
- Primary files:
- Used by:
- Depends on:
- Tests:
- Notes:
- Confidence:
```

## Feature Flow Template

```markdown
### Feature Name

1. Entry point:
2. Request or UI state:
3. Controller or handler:
4. Service or workflow:
5. Data access:
6. Database or storage:
7. Events/jobs:
8. External APIs:
9. Tests:
10. Risks:
```

## Confidence Levels

- High: Multiple code paths, tests, and names agree.
- Medium: Code structure is clear but docs/tests are sparse.
- Low: Relationship is inferred from naming or partial usage only.

Always include knowledge gaps when confidence is low.
