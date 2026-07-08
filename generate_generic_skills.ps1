$ErrorActionPreference = "Stop"

$skills = @(
  @{name="dependency-upgrade-planner"; display="Dependency Upgrade Planner"; short="Plan safe dependency upgrades"; domain="dependency upgrades"; trigger="upgrading packages, frameworks, SDKs, runtimes, lockfiles, or transitive dependencies"; focus=@("Version constraints and peer dependencies","Breaking changes and migration notes","Lockfile integrity and reproducibility","Security fixes versus behavior risk","Rollback and staged rollout plan")},
  @{name="security-threat-modeler"; display="Security Threat Modeler"; short="Model application security threats"; domain="security threat modeling"; trigger="reviewing features for abuse paths, trust boundaries, sensitive data, STRIDE risks, auth risks, or threat models"; focus=@("Trust boundaries and attacker entry points","Authentication and authorization assumptions","Data sensitivity and retention","Abuse cases and rate limits","Mitigations ranked by risk")},
  @{name="api-contract-auditor"; display="API Contract Auditor"; short="Audit API request and response contracts"; domain="API contracts"; trigger="designing, changing, reviewing, or debugging REST, GraphQL, RPC, webhook, or internal service contracts"; focus=@("Request and response schema compatibility","Status codes and error formats","Pagination, filtering, and sorting semantics","Authentication and authorization behavior","Backward compatibility and versioning")},
  @{name="database-migration-planner"; display="Database Migration Planner"; short="Plan safe database migrations"; domain="database migrations"; trigger="creating or reviewing schema changes, migrations, indexes, constraints, data backfills, seed changes, or rollback plans"; focus=@("Expand-contract sequencing","Backfill cost and locking behavior","Index and constraint safety","Rollback and restore plan","Application compatibility during rollout")},
  @{name="performance-profiler"; display="Performance Profiler"; short="Find and verify performance bottlenecks"; domain="performance profiling"; trigger="diagnosing slow pages, APIs, queries, builds, jobs, memory pressure, latency, throughput, or resource usage"; focus=@("Measured baseline before changes","Hot path and bottleneck isolation","CPU, memory, IO, network, and database cost","Cache and batching opportunities","Regression verification")},
  @{name="observability-instrumentation-planner"; display="Observability Instrumentation Planner"; short="Plan logs metrics and traces"; domain="observability instrumentation"; trigger="adding or reviewing logging, metrics, tracing, dashboards, alerts, SLOs, incident signals, or telemetry coverage"; focus=@("Golden signals and user-visible outcomes","Trace/span boundaries and correlation IDs","Metric cardinality and cost","Structured log fields without secrets","Actionable alert thresholds")},
  @{name="error-handling-auditor"; display="Error Handling Auditor"; short="Audit error flows and recovery"; domain="error handling"; trigger="reviewing exceptions, retries, failure modes, user-facing errors, fallback logic, or recovery paths"; focus=@("Expected versus unexpected errors","Retry, timeout, and idempotency behavior","User-facing message quality","Logging and alerting for failures","Resource cleanup and partial success handling")},
  @{name="logging-standards-auditor"; display="Logging Standards Auditor"; short="Audit structured logging quality"; domain="logging standards"; trigger="adding, reviewing, normalizing, or reducing application logs, audit logs, request logs, or debugging output"; focus=@("Structured fields and correlation IDs","Noise level and log severity","Sensitive data redaction","Operational usefulness during incidents","Consistency with repository logging helpers")},
  @{name="release-readiness-reviewer"; display="Release Readiness Reviewer"; short="Check if a release is ready"; domain="release readiness"; trigger="preparing releases, cutovers, production deploys, changelogs, release candidates, go/no-go checks, or rollback plans"; focus=@("Scope and risk summary","Tests, migrations, and feature flags","Operational runbook and rollback","Monitoring and support readiness","Known issues and owner signoff")},
  @{name="ci-cd-pipeline-auditor"; display="CI CD Pipeline Auditor"; short="Audit build and deploy pipelines"; domain="CI/CD pipelines"; trigger="reviewing or fixing CI workflows, deployment pipelines, build scripts, release automation, or flaky pipeline behavior"; focus=@("Pipeline stages and required checks","Secrets and permissions","Caching and artifact correctness","Environment parity and promotion rules","Failure visibility and retry safety")},
  @{name="docker-compose-diagnoser"; display="Docker Compose Diagnoser"; short="Diagnose local Docker Compose stacks"; domain="Docker Compose diagnostics"; trigger="debugging docker compose services, containers, networks, volumes, health checks, ports, images, or local environment startup"; focus=@("Service dependency graph","Ports, networks, and volumes","Environment variables and secrets","Health checks and startup order","Rebuild versus runtime failure isolation")},
  @{name="environment-config-auditor"; display="Environment Config Auditor"; short="Audit env config and parity"; domain="environment configuration"; trigger="working with env vars, config files, runtime settings, feature flags, deployment configuration, or environment parity"; focus=@("Required, optional, and deprecated settings","Dev/staging/prod parity","Default values and fail-fast behavior","Secret versus non-secret classification","Documentation and example files")},
  @{name="secrets-management-auditor"; display="Secrets Management Auditor"; short="Audit secret handling"; domain="secrets management"; trigger="reviewing API keys, tokens, credentials, secret storage, secret rotation, leaked secrets, .env files, or vault integrations"; focus=@("Secret sources and storage locations","Exposure in code, logs, builds, and artifacts","Rotation and revocation process","Least privilege and scope","Local development handling")},
  @{name="accessibility-reviewer"; display="Accessibility Reviewer"; short="Review UI accessibility"; domain="accessibility"; trigger="reviewing interfaces for WCAG issues, keyboard navigation, screen readers, color contrast, forms, modals, or semantic markup"; focus=@("Keyboard-only workflow","Semantic structure and ARIA use","Labeling and error announcements","Contrast and focus visibility","Motion and responsive accessibility")},
  @{name="frontend-state-flow-mapper"; display="Frontend State Flow Mapper"; short="Map UI state and data flow"; domain="frontend state flow"; trigger="understanding or changing React, Vue, Angular, Svelte, mobile, or client-side state, props, stores, caches, or effects"; focus=@("State owners and derived state","Effects and async loading paths","Cache invalidation and stale data","Component boundaries and prop flow","Race conditions and cleanup")},
  @{name="design-system-consistency-reviewer"; display="Design System Consistency Reviewer"; short="Keep UI aligned to design systems"; domain="design system consistency"; trigger="building or reviewing UI components, tokens, spacing, typography, colors, icons, variants, or component library usage"; focus=@("Existing component reuse","Token and variant consistency","Interaction states and disabled states","Responsive density and layout rhythm","Avoiding one-off styles")},
  @{name="responsive-ui-auditor"; display="Responsive UI Auditor"; short="Audit responsive layouts"; domain="responsive UI"; trigger="checking mobile, tablet, desktop, overflow, viewport resizing, layout shifts, or text fitting issues"; focus=@("Viewport coverage and breakpoints","Overflow, wrapping, and truncation","Touch targets and spacing","Stable dimensions for fixed controls","Content priority on small screens")},
  @{name="form-validation-auditor"; display="Form Validation Auditor"; short="Audit form validation and UX"; domain="form validation"; trigger="creating or reviewing forms, validators, input masks, schema validation, error messages, submission flows, or multi-step forms"; focus=@("Client and server validation parity","Field-level and form-level errors","Accessibility of labels and messages","Submission idempotency and disabled states","Invalid, empty, edge, and malicious input")},
  @{name="api-client-consistency-reviewer"; display="API Client Consistency Reviewer"; short="Review API client usage"; domain="API clients"; trigger="adding or reviewing frontend API clients, SDK wrappers, fetch utilities, retry logic, request auth, or response normalization"; focus=@("Existing client abstraction reuse","Headers, auth, and base URL handling","Error normalization and retries","Cancellation and loading state","Type/schema validation boundaries")},
  @{name="data-model-consistency-auditor"; display="Data Model Consistency Auditor"; short="Audit domain data models"; domain="data model consistency"; trigger="changing models, DTOs, schemas, types, entities, serializers, validators, or shared domain objects"; focus=@("Canonical model ownership","Naming and type consistency","Serializer and DTO boundaries","Database/API/frontend shape drift","Migration and compatibility risk")},
  @{name="background-job-auditor"; display="Background Job Auditor"; short="Audit queues jobs and workers"; domain="background jobs"; trigger="reviewing queues, workers, cron jobs, schedulers, retries, job payloads, idempotency, or delayed processing"; focus=@("Producer and consumer flow","Retry, timeout, and dead-letter behavior","Idempotency and duplicate handling","Payload schema compatibility","Operational visibility")},
  @{name="webhook-integration-auditor"; display="Webhook Integration Auditor"; short="Audit webhook integrations"; domain="webhook integrations"; trigger="implementing or reviewing inbound or outbound webhooks, signatures, event payloads, retries, ordering, or provider callbacks"; focus=@("Signature verification and replay protection","Event schema and versioning","Idempotency and ordering","Retry behavior and provider limits","Audit trail and failure recovery")},
  @{name="auth-flow-reviewer"; display="Auth Flow Reviewer"; short="Review authentication flows"; domain="authentication flows"; trigger="reviewing login, signup, OAuth, SSO, sessions, refresh tokens, password reset, MFA, or identity provider integration"; focus=@("Credential and token lifecycle","Session fixation and CSRF risks","OAuth/SSO redirect and state handling","MFA and recovery flows","User enumeration and rate limits")},
  @{name="authorization-boundary-auditor"; display="Authorization Boundary Auditor"; short="Audit permission boundaries"; domain="authorization boundaries"; trigger="reviewing RBAC, ABAC, tenant isolation, object permissions, admin actions, or access control checks"; focus=@("Subject, action, resource, and scope model","Server-side enforcement points","Tenant and ownership isolation","Privilege escalation paths","Tests for deny cases")},
  @{name="input-sanitization-auditor"; display="Input Sanitization Auditor"; short="Audit unsafe input handling"; domain="input sanitization"; trigger="reviewing parsers, user input, uploads, HTML, Markdown, SQL, shell commands, path handling, or injection risks"; focus=@("Input trust boundaries","Encoding versus validation versus sanitization","Injection vectors and unsafe sinks","File/path traversal handling","Negative tests and fuzz cases")},
  @{name="privacy-impact-reviewer"; display="Privacy Impact Reviewer"; short="Review privacy and data minimization"; domain="privacy impact"; trigger="reviewing personal data collection, analytics, tracking, retention, consent, exports, deletion, or privacy-sensitive features"; focus=@("Personal data inventory","Purpose limitation and minimization","Consent and user controls","Retention, deletion, and export paths","Third-party sharing and analytics")},
  @{name="data-retention-auditor"; display="Data Retention Auditor"; short="Audit retention and deletion flows"; domain="data retention"; trigger="reviewing retention policies, archival, deletion jobs, soft deletes, legal hold, backups, or lifecycle workflows"; focus=@("Retention rules by data class","Deletion propagation and auditability","Backup and restore implications","Legal hold and exception handling","User-visible deletion promises")},
  @{name="payment-flow-auditor"; display="Payment Flow Auditor"; short="Audit payments and billing flows"; domain="payment flows"; trigger="reviewing checkout, invoices, subscriptions, refunds, tax, webhooks, payment processors, or billing state"; focus=@("Payment state machine","Idempotency and duplicate charge prevention","Processor webhook reconciliation","PCI and secret handling","Refunds, disputes, and failure states")},
  @{name="feature-flag-planner"; display="Feature Flag Planner"; short="Plan safe feature flags"; domain="feature flags"; trigger="adding or reviewing feature flags, experiments, staged rollouts, kill switches, or config-gated behavior"; focus=@("Flag ownership and lifecycle","Default values and fail-closed behavior","Targeting rules and rollout plan","Removal plan and stale flag risk","Test coverage across flag states")},
  @{name="migration-backfill-planner"; display="Migration Backfill Planner"; short="Plan data backfills safely"; domain="data backfills"; trigger="planning or reviewing data backfills, one-off scripts, bulk updates, reprocessing jobs, or historical data repair"; focus=@("Source of truth and target rows","Batching, locking, and rate limits","Idempotency and resume behavior","Verification queries and sampling","Rollback and audit trail")},
  @{name="code-review-finding-writer"; display="Code Review Finding Writer"; short="Write precise review findings"; domain="code review findings"; trigger="turning review observations into concise actionable findings with severity, evidence, and suggested fixes"; focus=@("Behavioral impact over style preference","File and line evidence","Minimal reproduction or scenario","Severity and confidence","Actionable fix direction")},
  @{name="bug-reproduction-planner"; display="Bug Reproduction Planner"; short="Plan reliable bug reproduction"; domain="bug reproduction"; trigger="triaging bugs, intermittent failures, unclear reports, reproduction steps, environment differences, or suspected regressions"; focus=@("Observed versus expected behavior","Environment and version matrix","Minimal reproduction path","Logs, traces, and screenshots needed","Regression range and suspected owner")},
  @{name="root-cause-analysis-writer"; display="Root Cause Analysis Writer"; short="Write clear incident RCAs"; domain="root cause analysis"; trigger="writing incident reports, postmortems, RCAs, timelines, contributing factors, corrective actions, or lessons learned"; focus=@("Impact and detection timeline","Trigger versus root cause","Contributing technical and process factors","Corrective and preventive actions","Blameless language with accountable owners")},
  @{name="incident-response-runbooker"; display="Incident Response Runbooker"; short="Create actionable incident runbooks"; domain="incident response runbooks"; trigger="creating or reviewing runbooks for outages, alerts, on-call diagnosis, mitigation steps, escalation, or recovery"; focus=@("Symptoms and alert entry points","Triage commands and dashboards","Mitigation and rollback steps","Escalation and communication paths","Post-incident cleanup")},
  @{name="docs-maintenance-auditor"; display="Docs Maintenance Auditor"; short="Audit docs against code"; domain="documentation maintenance"; trigger="checking README, guides, API docs, setup docs, architecture docs, or comments against implementation"; focus=@("Code/doc mismatches","Missing setup or operational steps","Outdated screenshots or commands","Audience and task fit","Low-churn source of truth")},
  @{name="readme-onboarding-builder"; display="README Onboarding Builder"; short="Improve repo onboarding docs"; domain="README onboarding"; trigger="creating or improving repository README onboarding, local setup, architecture overview, commands, or first-change guidance"; focus=@("Fast path to first successful run","Prerequisites and environment variables","Common commands and expected output","Project map and reading order","Troubleshooting common setup failures")},
  @{name="api-documentation-builder"; display="API Documentation Builder"; short="Create useful API docs"; domain="API documentation"; trigger="documenting endpoints, schemas, examples, auth, errors, SDK usage, webhooks, or API changelogs"; focus=@("Audience and use cases","Auth and environment setup","Request/response examples","Error and pagination semantics","Compatibility and version notes")},
  @{name="changelog-writer"; display="Changelog Writer"; short="Write concise changelogs"; domain="changelog writing"; trigger="creating release notes, changelogs, user-facing change summaries, migration notes, or upgrade summaries"; focus=@("User-visible changes","Breaking changes and migrations","Fixes grouped by impact","Known issues and deprecations","Links to commits, PRs, or tickets")},
  @{name="semantic-versioning-advisor"; display="Semantic Versioning Advisor"; short="Advise version bumps"; domain="semantic versioning"; trigger="deciding major, minor, patch versions, pre-releases, compatibility impact, API breaks, or package release strategy"; focus=@("Public API surface","Breaking behavior versus internal change","Deprecation policy","Migration burden","Pre-release and rollback options")},
  @{name="dependency-license-auditor"; display="Dependency License Auditor"; short="Audit dependency licenses"; domain="dependency licensing"; trigger="reviewing open source licenses, dependency policy, copyleft risk, attribution, package additions, or license inventories"; focus=@("Direct and transitive licenses","Policy compatibility","Copyleft and distribution implications","Attribution and notice requirements","Unknown or missing license metadata")},
  @{name="open-source-readiness-reviewer"; display="Open Source Readiness Reviewer"; short="Prepare repos for open source"; domain="open source readiness"; trigger="preparing code for public release, checking repository hygiene, secrets, licenses, docs, governance, or contribution setup"; focus=@("Secret and internal reference sweep","License, notice, and attribution","README, contributing, and code of conduct","Issue and PR templates","Build reproducibility for outsiders")},
  @{name="monorepo-boundary-auditor"; display="Monorepo Boundary Auditor"; short="Audit monorepo package boundaries"; domain="monorepo boundaries"; trigger="working in monorepos with packages, workspaces, shared libraries, dependency graphs, ownership boundaries, or build orchestration"; focus=@("Package dependency direction","Shared code ownership","Build and test target selection","Circular dependency risk","Versioning and publishing boundaries")},
  @{name="module-extraction-planner"; display="Module Extraction Planner"; short="Plan module extraction"; domain="module extraction"; trigger="splitting modules, extracting packages/services, decoupling code, moving boundaries, or reducing large modules"; focus=@("Current responsibility map","Dependency and data ownership","Incremental extraction sequence","Compatibility adapters","Test and rollout strategy")},
  @{name="technical-debt-prioritizer"; display="Technical Debt Prioritizer"; short="Prioritize technical debt work"; domain="technical debt prioritization"; trigger="cataloging or prioritizing tech debt, refactors, cleanup, maintainability risks, or engineering investment"; focus=@("User and operational impact","Change frequency and defect history","Complexity and ownership","Effort and risk estimate","Sequenced remediation plan")},
  @{name="refactor-safety-planner"; display="Refactor Safety Planner"; short="Plan safe refactors"; domain="refactor safety"; trigger="planning refactors, reorganizations, rewrites, cleanup, behavior-preserving changes, or incremental modernization"; focus=@("Behavioral contract to preserve","Characterization tests and golden paths","Small reversible steps","Public API and data compatibility","Verification after each step")},
  @{name="legacy-code-modernizer"; display="Legacy Code Modernizer"; short="Modernize legacy code safely"; domain="legacy modernization"; trigger="modernizing old frameworks, language versions, patterns, build systems, or brittle legacy modules"; focus=@("Current behavior and implicit contracts","Compatibility constraints","Modernization slices","Risk around generated or vendored code","Fallback and rollback strategy")},
  @{name="test-flakiness-investigator"; display="Test Flakiness Investigator"; short="Investigate flaky tests"; domain="test flakiness"; trigger="debugging intermittent tests, race conditions, timing issues, shared state, CI-only failures, or nondeterministic assertions"; focus=@("Failure frequency and environments","Randomness, time, network, and concurrency","Shared state and cleanup","Ordering assumptions","Stabilization without weakening assertions")},
  @{name="test-data-factory-designer"; display="Test Data Factory Designer"; short="Design maintainable test data"; domain="test data factories"; trigger="creating or improving factories, fixtures, seed data, builders, mocks, or reusable test setup"; focus=@("Factory ownership and naming","Minimal valid defaults","Override ergonomics","Database isolation and cleanup","Avoiding brittle global fixtures")},
  @{name="mocking-strategy-reviewer"; display="Mocking Strategy Reviewer"; short="Review mocks and test doubles"; domain="mocking strategy"; trigger="choosing or reviewing mocks, stubs, fakes, spies, contract tests, service virtualization, or dependency boundaries"; focus=@("Boundary being isolated","Mock fidelity and drift risk","Existing helper reuse","Assertions on behavior not implementation","Contract coverage for external services")},
  @{name="contract-test-planner"; display="Contract Test Planner"; short="Plan provider and consumer contracts"; domain="contract testing"; trigger="adding contract tests for APIs, events, services, SDKs, schemas, consumers, or provider compatibility"; focus=@("Consumer expectations","Provider guarantees","Schema versioning and examples","CI verification placement","Failure ownership and update workflow")},
  @{name="e2e-test-planner"; display="E2E Test Planner"; short="Plan useful end-to-end tests"; domain="end-to-end testing"; trigger="planning browser, mobile, full-stack, or workflow tests across services and UI"; focus=@("Critical user journeys","Stable selectors and data setup","Environment and dependency control","Failure screenshots/traces/videos","Avoiding redundant slow coverage")},
  @{name="qa-acceptance-criteria-writer"; display="QA Acceptance Criteria Writer"; short="Write testable acceptance criteria"; domain="acceptance criteria"; trigger="turning requirements, stories, bugs, or vague feature requests into testable acceptance criteria"; focus=@("Observable user outcomes","Positive and negative scenarios","Roles, permissions, and edge cases","Data setup and state transitions","Definition of done and exclusions")},
  @{name="user-story-slicer"; display="User Story Slicer"; short="Slice large work into deliverable stories"; domain="story slicing"; trigger="breaking epics, features, migrations, or large tasks into thin vertical slices with acceptance criteria"; focus=@("Small user-visible increments","Dependency ordering","Risk-first sequencing","Non-functional requirements","Explicit out-of-scope work")},
  @{name="product-requirements-clarifier"; display="Product Requirements Clarifier"; short="Clarify product requirements"; domain="product requirements"; trigger="refining ambiguous feature requests, PRDs, specs, workflows, edge cases, or stakeholder requirements"; focus=@("Problem, users, and desired outcome","Functional and non-functional requirements","Open questions and assumptions","Edge cases and constraints","Measurable success criteria")},
  @{name="stakeholder-update-writer"; display="Stakeholder Update Writer"; short="Write concise project updates"; domain="stakeholder updates"; trigger="writing project status, executive summaries, delivery updates, blockers, risks, or progress notes"; focus=@("Current state and delta since last update","Decisions made and needed","Risks, blockers, and mitigations","Next milestones and owners","Audience-appropriate detail")},
  @{name="decision-record-writer"; display="Decision Record Writer"; short="Write architecture decision records"; domain="decision records"; trigger="creating ADRs, design decisions, tradeoff records, option analysis, or durable technical rationale"; focus=@("Context and forces","Options considered","Decision and consequences","Rejected alternatives","Review date and reversal signals")},
  @{name="risk-register-builder"; display="Risk Register Builder"; short="Build actionable risk registers"; domain="risk registers"; trigger="identifying, ranking, tracking, or communicating project, technical, security, operational, or delivery risks"; focus=@("Risk statement and cause","Impact and likelihood","Mitigation and contingency","Owner and review cadence","Trigger indicators")},
  @{name="estimation-breakdown-builder"; display="Estimation Breakdown Builder"; short="Break work into estimates"; domain="engineering estimation"; trigger="estimating implementation work, project timelines, task breakdowns, uncertainty, or delivery sequencing"; focus=@("Work breakdown by outcome","Unknowns and discovery tasks","Dependencies and critical path","Confidence ranges","Validation and buffer strategy")},
  @{name="architecture-decision-matrix"; display="Architecture Decision Matrix"; short="Compare technical options"; domain="architecture option comparison"; trigger="comparing libraries, frameworks, providers, architectures, build approaches, or implementation strategies"; focus=@("Decision criteria and weights","Current constraints","Option pros, cons, and risks","Migration and operational cost","Recommendation with confidence")},
  @{name="library-selection-advisor"; display="Library Selection Advisor"; short="Choose libraries conservatively"; domain="library selection"; trigger="selecting packages, frameworks, SDKs, UI libraries, utilities, or third-party services"; focus=@("Repository fit and existing dependencies","Maintenance health and ecosystem","Bundle/runtime/security cost","API stability and migration path","Build versus buy decision")},
  @{name="build-system-diagnoser"; display="Build System Diagnoser"; short="Diagnose build failures"; domain="build systems"; trigger="debugging builds, bundlers, compilers, transpilers, package scripts, cache issues, or artifact generation"; focus=@("Build graph and entry points","Environment and version mismatches","Cache and generated artifacts","Compiler/bundler configuration","Minimal failing command")},
  @{name="lint-format-enforcer"; display="Lint Format Enforcer"; short="Align lint and formatting"; domain="lint and formatting"; trigger="fixing or reviewing lint, format, import order, static analysis, precommit hooks, or style violations"; focus=@("Configured tools and versions","Scope of mechanical formatting","Rule intent versus false positive","Autofix safety","Avoiding unrelated churn")},
  @{name="type-safety-auditor"; display="Type Safety Auditor"; short="Audit type safety gaps"; domain="type safety"; trigger="reviewing TypeScript, Flow, Python typing, generics, nullability, casts, schema types, or compile-time safety"; focus=@("Unsafe casts and any-like escapes","Null/undefined and optional handling","Runtime validation boundaries","Public types and inferred contracts","Type tests or compile checks")},
  @{name="schema-validation-planner"; display="Schema Validation Planner"; short="Plan runtime schema validation"; domain="schema validation"; trigger="adding or reviewing Zod, JSON Schema, Pydantic, Joi, Yup, OpenAPI schemas, or runtime validators"; focus=@("Validation boundary placement","Schema/source-of-truth ownership","Error reporting and localization","Backward compatibility","Generated types and drift prevention")},
  @{name="cache-strategy-reviewer"; display="Cache Strategy Reviewer"; short="Review cache correctness"; domain="cache strategy"; trigger="designing or debugging caching, memoization, CDN behavior, Redis, browser cache, stale data, or invalidation"; focus=@("Cache key and scope","TTL and invalidation triggers","Consistency and stale-read tolerance","Stampede and eviction behavior","Observability and manual purge")},
  @{name="concurrency-race-auditor"; display="Concurrency Race Auditor"; short="Audit race conditions"; domain="concurrency and races"; trigger="reviewing async code, locks, transactions, concurrent requests, workers, race bugs, or ordering problems"; focus=@("Shared mutable state","Transaction boundaries and isolation","Locking and idempotency","Ordering assumptions","Stress and interleaving tests")},
  @{name="file-upload-security-reviewer"; display="File Upload Security Reviewer"; short="Review file upload safety"; domain="file upload security"; trigger="implementing or auditing uploads, file parsing, storage, downloads, MIME checks, antivirus scanning, or user-generated files"; focus=@("File type and size validation","Storage paths and access control","Malware and content scanning","Metadata stripping and privacy","Download headers and signed URLs")},
  @{name="search-quality-auditor"; display="Search Quality Auditor"; short="Audit search relevance"; domain="search quality"; trigger="reviewing search, filtering, ranking, autocomplete, faceting, synonyms, indexing, or relevance issues"; focus=@("Query parsing and normalization","Ranking signals and tie breakers","Index freshness and backfill","No-result and typo handling","Evaluation set and relevance metrics")},
  @{name="analytics-event-auditor"; display="Analytics Event Auditor"; short="Audit analytics instrumentation"; domain="analytics events"; trigger="adding or reviewing product analytics, event names, funnels, attribution, tracking plans, or telemetry schemas"; focus=@("Event purpose and owner","Naming and property consistency","Privacy and consent","Deduplication and identity handling","Validation against tracking plan")},
  @{name="experimentation-planner"; display="Experimentation Planner"; short="Plan product experiments"; domain="experimentation"; trigger="planning A/B tests, experiments, metrics, cohorts, guardrails, exposure logging, or rollout analysis"; focus=@("Hypothesis and success metrics","Randomization and exposure rules","Sample size and duration assumptions","Guardrails and stopping rules","Instrumentation and analysis plan")},
  @{name="internationalization-reviewer"; display="Internationalization Reviewer"; short="Review localization readiness"; domain="internationalization"; trigger="reviewing i18n, l10n, translation keys, locale formatting, RTL layouts, pluralization, or language expansion"; focus=@("Hardcoded user-facing strings","Date, number, currency, and timezone formatting","Pluralization and gender rules","RTL and layout expansion","Translation key organization")},
  @{name="timezone-date-auditor"; display="Timezone Date Auditor"; short="Audit dates times and timezones"; domain="date and timezone handling"; trigger="reviewing scheduling, timestamps, date math, timezones, calendars, daylight saving, or relative dates"; focus=@("Storage timezone and precision","User locale display","DST and boundary cases","Server/client clock assumptions","Tests for exact dates")},
  @{name="mobile-release-checker"; display="Mobile Release Checker"; short="Check mobile release readiness"; domain="mobile release readiness"; trigger="preparing iOS or Android releases, app store submissions, mobile builds, permissions, versioning, or rollout checks"; focus=@("Version codes and build numbers","Permissions and privacy disclosures","Store metadata and screenshots","Crash/analytics and rollback strategy","Device and OS coverage")},
  @{name="browser-compatibility-auditor"; display="Browser Compatibility Auditor"; short="Audit browser compatibility"; domain="browser compatibility"; trigger="checking cross-browser support, polyfills, CSS features, Safari/Firefox/Chrome differences, or progressive enhancement"; focus=@("Supported browser matrix","Feature detection and fallbacks","CSS/layout compatibility","Input and media API support","Cross-browser test plan")},
  @{name="seo-technical-auditor"; display="SEO Technical Auditor"; short="Audit technical SEO"; domain="technical SEO"; trigger="reviewing public web pages for metadata, crawlability, sitemaps, structured data, canonical URLs, performance, or indexing"; focus=@("Indexability and robots rules","Canonical and metadata correctness","Structured data validity","Core Web Vitals risks","Redirects and URL consistency")}
)

function Escape-Yaml([string]$s) {
  return $s.Replace('"', '""')
}

foreach ($skill in $skills) {
  $dir = Join-Path $PSScriptRoot $skill.name
  $agentsDir = Join-Path $dir "agents"
  $refsDir = Join-Path $dir "references"
  New-Item -ItemType Directory -Force -Path $agentsDir, $refsDir | Out-Null

  $focusBullets = ($skill.focus | ForEach-Object { "- $_" }) -join "`n"
  $checklistName = "$($skill.name)-checklist.md"

  $skillMd = @"
---
name: $($skill.name)
description: Support $($skill.domain) with repository-aware analysis, implementation guidance, risk review, and verification. Use when Codex is $($skill.trigger), especially when the work must follow existing project conventions, avoid regressions, produce an audit or plan, or explain tradeoffs before making changes.
---

# $($skill.display)

## Goal

Act as a senior engineer for $($skill.domain).

Use this skill to understand the repository context, make conservative recommendations, and produce changes or plans that fit the existing system.

## Core Rules

- Inspect the closest existing implementation before proposing a new pattern.
- Treat source code, tests, configuration, and runtime behavior as primary evidence.
- Separate confirmed facts from assumptions and inference.
- Prefer small reversible steps over broad rewrites.
- Identify user-visible, security, data, operational, and compatibility risks.
- Reuse existing helpers, abstractions, commands, naming, and folder structure.
- Report verification performed and any checks that could not be run.

## Workflow

### Phase 1 - Discover Context

Read references/$checklistName before producing the final plan or review.

Find the nearest relevant:

- Source files and owners
- Tests and fixtures
- Configuration files
- Documentation
- Build, deploy, or runtime commands
- Logs, metrics, schemas, or migrations when applicable

Create a short evidence map with file paths for key claims.

### Phase 2 - Analyze Current Behavior

Describe how the current system handles $($skill.domain).

Identify:

- Existing conventions
- Current guarantees
- Known gaps
- Hidden coupling
- Edge cases
- Backward compatibility constraints

### Phase 3 - Plan Or Implement

When planning:

- Propose the smallest viable sequence.
- Include verification and rollback steps.
- Call out decisions that need user or owner approval.

When implementing:

- Keep edits scoped to the requested behavior.
- Preserve public contracts unless the user requested a breaking change.
- Add or update tests in the repository's existing style.
- Avoid unrelated formatting or cleanup.

### Phase 4 - Verify

Run the narrowest meaningful checks first.

Prefer repository-defined commands from package manifests, task files, CI config, or docs. Report exact commands and results.

## Domain Focus

$focusBullets

## Required Output

# $($skill.display) Report

## Summary

## Evidence Reviewed

## Current Behavior

## Risks And Gaps

## Recommendation Or Changes

## Verification

## Open Questions

## Quality Bar

- Every important recommendation must map to observed repository evidence or an explicit assumption.
- Every risk must include impact and a practical mitigation.
- Every implementation path must include tests or another concrete verification method.
"@

  Set-Content -LiteralPath (Join-Path $dir "SKILL.md") -Value $skillMd -Encoding UTF8

  $openaiYaml = @"
interface:
  display_name: "$($skill.display)"
  short_description: "$($skill.short)"
  default_prompt: "Use `$$($skill.name) to review this repository task and produce a practical report."

policy:
  allow_implicit_invocation: true
"@
  Set-Content -LiteralPath (Join-Path $agentsDir "openai.yaml") -Value $openaiYaml -Encoding UTF8

  $referenceMd = @"
# $($skill.display) Checklist

Use this checklist only after the skill is triggered. Keep the final response concise, but do enough discovery to avoid generic advice.

## Evidence To Gather

- Nearby code that already solves a similar problem.
- Tests that describe expected behavior or historical regressions.
- Configuration that controls runtime, build, deploy, lint, typecheck, or test behavior.
- Documentation or comments that explain intended contracts.
- Recent git history when the requested task mentions regressions, releases, ownership, or risk.

## Domain Checks

$focusBullets

## Risk Review

Classify each meaningful risk as `Low`, `Medium`, or `High`.

- `Low`: Local behavior, covered by tests, easy rollback, no data or security exposure.
- `Medium`: Multiple modules, partial test coverage, operational visibility needed, compatibility concerns possible.
- `High`: Security, privacy, payments, data loss, migrations, auth, tenant isolation, public API breaks, or difficult rollback.

For each `Medium` or `High` risk, include:

- Impact
- Evidence
- Mitigation
- Verification

## Implementation Guidance

- Prefer existing repository patterns over new abstractions.
- Make changes in thin slices that can be reviewed independently.
- Preserve backward compatibility unless the user explicitly asks for a breaking change.
- Add tests for bug fixes, edge cases, permission boundaries, and regression-prone logic.
- Update docs only when behavior, setup, or public contracts change.

## Verification Guidance

Use the narrowest relevant verification available:

- Unit or integration tests near the changed code.
- Typecheck, lint, or format checks when the stack supports them.
- Build checks for packaging, bundling, or deployment-sensitive changes.
- Manual reproduction steps when automated coverage is unavailable.
- Targeted queries, logs, or dashboards for operational changes.

Report skipped checks with the reason.
"@

  Set-Content -LiteralPath (Join-Path $refsDir $checklistName) -Value $referenceMd -Encoding UTF8
}

Write-Host "Generated $($skills.Count) skills."
