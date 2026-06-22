# Architecture Review Checklist

Use this checklist to evaluate proposed changes against an existing repository architecture.

## Discovery Commands

Prefer fast structural inspection:

```bash
rg --files
rg -n "controller|handler|service|repository|adapter|usecase|interactor|entity|model|schema|route|middleware|guard|policy"
rg -n "import .* from|require\\(|from .* import"
```

Inspect:

- Root workspace files
- Package manifests
- App entry points
- Routing files
- Controller/handler layers
- Service/use-case layers
- Repository/data-access layers
- Domain models/entities
- Dependency injection setup
- Middleware
- Auth/authorization code
- Build and deployment config
- Tests around the affected feature

## Architecture Summary Template

```markdown
## Architecture Summary

- Detected style:
- Application layers:
- Module boundaries:
- Dependency direction:
- Data flow:
- Communication patterns:
- Runtime/deployment shape:
- Evidence:
- Confidence:
```

## Pattern Inventory Template

```markdown
### Pattern Name

- Preferred usage:
- Alternative usage:
- Locations:
- Boundary rules:
- Exceptions:
- Confidence:
```

## Common Violation Signals

Architecture drift:

- New code uses a different layering model than nearby code.
- New feature creates a parallel service/repository/controller structure without need.
- New abstractions exist for only one caller.

Business logic inside controllers:

- Controller validates deep domain rules instead of delegating.
- Controller performs multi-step state transitions.
- Controller directly composes persistence operations.

Database access in UI:

- Frontend imports database clients or server-only modules.
- UI components know table names or persistence queries.

Cross-module coupling:

- Feature imports internal files from another feature module.
- Shared code depends back on app-specific code.
- Domain module imports presentation/UI layer.

Duplicate services:

- New service repeats behavior already available in an existing service.
- Similar naming exists with overlapping responsibilities.

Leaky abstractions:

- Higher layers know lower-layer implementation details.
- API response shapes expose persistence internals unintentionally.

God classes/components:

- One class/component gains unrelated responsibilities.
- Change combines rendering, validation, persistence, networking, and orchestration in one place.

## Risk Levels

Low:

- Follows existing pattern.
- Touches one module.
- No new dependencies.
- No public API or persistence changes.

Medium:

- Touches multiple modules.
- Adds a dependency within current architectural rules.
- Extends existing abstractions.
- Requires coordinated test updates.

High:

- Changes boundaries or layering.
- Adds a new framework or architectural pattern.
- Changes persistence model or public API.
- Creates cross-service or cross-module coupling.
- Affects auth, payments, data deletion, tenant isolation, or deployment architecture.

## Approval Triggers

Require explicit approval before:

- New framework
- New architectural layer
- New service boundary
- New module ownership model
- New shared abstraction
- New dependency that changes dependency direction
- Public API shape changes
- Persistence model changes
- Deployment topology changes
