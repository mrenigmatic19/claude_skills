$ErrorActionPreference = "Stop"

$originalSkills = @(
  ".agents", ".git",
  "ai-contribution-tracker", "architecture-reviewer", "codebase-knowledge-extractor",
  "feature-tracer", "repository-coding-standards", "repository-test-expert"
)

$recommendedRaw = Get-Content -LiteralPath "C:\Users\ritik\.codex\attachments\83287f12-ede4-4719-bd54-17a4640f1f0b\pasted-text.txt" -Raw
$recommended = [regex]::Matches($recommendedRaw, "(?m)^\d+\.\s+([a-z0-9-]+)\s*$") | ForEach-Object { $_.Groups[1].Value }
$recommendedSet = @{}
foreach ($name in $recommended) { $recommendedSet[$name] = $true }

function To-Title([string]$name) {
  return (($name -split "-") | ForEach-Object {
    switch ($_) {
      "api" { "API"; break }
      "ui" { "UI"; break }
      "ci" { "CI"; break }
      "cd" { "CD"; break }
      "seo" { "SEO"; break }
      "qa" { "QA"; break }
      "e2e" { "E2E"; break }
      "i18n" { "I18N"; break }
      default { (Get-Culture).TextInfo.ToTitleCase($_) }
    }
  }) -join " "
}

function Short-Description([string]$description) {
  $clean = $description.Trim().TrimEnd(".")
  if ($clean.Length -le 64) { return $clean }
  $words = $clean -split "\s+"
  $out = ""
  foreach ($word in $words) {
    $candidate = if ($out.Length -eq 0) { $word } else { "$out $word" }
    if ($candidate.Length -gt 61) { break }
    $out = $candidate
  }
  if ($out.Length -lt 25) { return $clean.Substring(0, [Math]::Min(61, $clean.Length)).Trim() + "..." }
  return $out.TrimEnd(",;:") + "..."
}

function Read-Description([string]$skillPath) {
  $lines = Get-Content -LiteralPath $skillPath
  for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -like "description:*") {
      $line = $lines[$i]
      if ($line.Trim() -eq "description: >") {
        return $lines[$i + 1].Trim()
      }
      return $line.Substring($line.IndexOf(":") + 1).Trim()
    }
  }
  return "Support repository-aware engineering work with evidence, risk review, and verification."
}

function Domain-Key([string]$name, [string]$description) {
  $text = "$name $description"
  if ($text -match "security|auth|authorization|privacy|secret|input|upload|payment|license") { return "risk" }
  if ($text -match "test|e2e|mock|contract|coverage|acceptance|flaky|qa") { return "testing" }
  if ($text -match "frontend|responsive|design|accessibility|form|api-client|browser|seo|analytics|experiment|international|timezone|mobile") { return "frontend" }
  if ($text -match "database|migration|backfill|data-model|retention|cache|concurrency|background|webhook|search") { return "dataflow" }
  if ($text -match "docker|environment|release|ci|cd|deploy|build|logging|observability|incident") { return "operations" }
  if ($text -match "requirements|story|stakeholder|decision|risk-register|estimation|changelog|readme|docs|open-source|semantic") { return "planning" }
  if ($text -match "architecture|module|monorepo|legacy|refactor|technical-debt|library") { return "architecture" }
  return "general"
}

function Domain-Text([string]$key, [string]$section) {
  $map = @{
    "risk:mission" = "Protect security, privacy, payment, permission, and compliance boundaries by turning vague risk into concrete attack paths, controls, tests, and review gates."
    "risk:workflow" = "Identify trust boundaries; map sensitive data and privileged actions; find enforcement points; test deny and abuse cases; require human review for high-impact paths."
    "risk:evidence" = "Auth guards, policy checks, server handlers, schemas, logs, secrets, payment state, upload handling, privacy docs, audit trails, tests, and threat notes."
    "risk:output" = "Risk Summary, Assets, Trust Boundaries, Abuse Cases, Existing Controls, Gaps, Required Tests, Human Review, Residual Risk."
    "risk:stop" = "Stop when secrets, customer data, payment, auth, destructive actions, or legal/compliance claims are involved without clear owner approval."

    "testing:mission" = "Create tests and verification plans that encode meaningful behavior, not shallow coverage."
    "testing:workflow" = "Mine local test style; map behavior to assertions; choose unit/component/integration/E2E level; reuse fixtures; add regression proof; run the narrowest checks."
    "testing:evidence" = "Nearby tests, helpers, fixtures, mocks, CI config, failing logs, selectors, acceptance criteria, coverage output, and runtime reproduction."
    "testing:output" = "Test Pattern, Behaviors Covered, Tests Added, Commands Run, Failures, Flake Risk, Coverage Gap, Remaining Manual Checks."
    "testing:stop" = "Stop when the behavior cannot be reproduced, mocks would hide the real risk, or test data/environment is unavailable."

    "frontend:mission" = "Keep UI changes grounded in actual routes, components, state, APIs, design-system usage, accessibility, and responsive behavior."
    "frontend:workflow" = "Map route to source; inspect nearest component pattern; trace state and API calls; reuse design-system components; verify states, roles, accessibility, and viewport behavior."
    "frontend:evidence" = "Routes, pages, components, hooks, stores, API clients, query keys, design tokens, stories, RTL/Playwright tests, screenshots, and browser observations."
    "frontend:output" = "UI Surface, Source Mapping, State/API Flow, Design-System Pattern, Edge States, Accessibility/Responsive Notes, Tests, Verification."
    "frontend:stop" = "Stop when component ownership, role visibility, feature flags, or design-system equivalents are unknown."

    "dataflow:mission" = "Make data, schema, async, cache, and concurrency changes safe by exposing lifecycle, ownership, compatibility, and rollback concerns."
    "dataflow:workflow" = "Find source of truth; trace readers/writers; check schema and API compatibility; evaluate migration/backfill/idempotency; verify observability and rollback."
    "dataflow:evidence" = "Models, schemas, migrations, queues, jobs, webhooks, cache keys, transactions, API consumers, logs, metrics, and data repair scripts."
    "dataflow:output" = "Data Flow, Ownership, Compatibility, Migration/Backfill Plan, Idempotency, Failure Handling, Verification Queries, Rollback."
    "dataflow:stop" = "Stop when a change can lose data, double-process events, break consumers, or cannot be rolled back."

    "operations:mission" = "Improve build, release, observability, local environment, and incident workflows with reproducible commands and rollback evidence."
    "operations:workflow" = "Map environment and pipeline; inspect config and secrets boundaries; reproduce failure; isolate service/build/deploy stage; add health/alert evidence; define rollback."
    "operations:evidence" = "Package scripts, CI workflows, Docker files, compose files, env examples, logs, metrics, traces, release notes, build output, and deployment config."
    "operations:output" = "Current State, Failing Stage, Evidence, Fix/Plan, Verification Commands, Rollback, Monitoring, Owner Handoff."
    "operations:stop" = "Stop before production-affecting deploy, secret changes, or destructive environment actions without explicit approval."

    "planning:mission" = "Turn ambiguous product, documentation, release, and stakeholder work into precise decisions, criteria, risks, and next actions."
    "planning:workflow" = "Clarify audience and outcome; extract facts and assumptions; define success criteria; rank risk and dependencies; produce concise artifact."
    "planning:evidence" = "Tickets, docs, README, PRs, changelogs, ADRs, requirements, stakeholder notes, release scope, and user-facing behavior."
    "planning:output" = "Context, Decision/Criteria, Options, Risks, Owner Questions, Recommended Next Step, Verification/Acceptance."
    "planning:stop" = "Stop when business intent, audience, success measure, or approval owner is missing."

    "architecture:mission" = "Preserve repository architecture while enabling safe refactors, module boundaries, modernization, and library decisions."
    "architecture:workflow" = "Discover current patterns; map dependencies and ownership; evaluate options; choose incremental slices; protect compatibility; verify with tests/build."
    "architecture:evidence" = "Folder structure, imports, manifests, boundaries, public APIs, shared libraries, ADRs, tests, build graph, and dependency history."
    "architecture:output" = "Current Architecture, Boundary Impact, Options, Recommendation, Migration Slices, Risk, Verification, Approval Needed."
    "architecture:stop" = "Stop before new frameworks, broad rewrites, public API breaks, or boundary changes without explicit approval."
  }
  $lookup = "$key`:$section"
  if ($map.ContainsKey($lookup)) { return $map[$lookup] }
  return "Use evidence-first engineering judgment, narrow changes, and concrete verification."
}

function Specific-Lens([string]$name, [string]$description) {
  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add("- Purpose: $description")
  if ($name -match "auditor|reviewer|guard|checker") { $lines.Add("- Bias toward finding regressions, missing tests, hidden coupling, and review gates.") }
  if ($name -match "planner|builder|writer|advisor") { $lines.Add("- Produce an artifact another engineer can execute without rediscovering context.") }
  if ($name -match "mapper|tracer|indexer|documenter|finder") { $lines.Add("- Create maps with source paths, owners, dependency direction, and confidence.") }
  if ($name -match "diagnoser|investigator|doctor|explainer") { $lines.Add("- Separate symptom, trigger, root cause, proof, and repair path.") }
  if ($name -match "implementer|editor|enforcer|generator") { $lines.Add("- Make the smallest repository-consistent change and verify behavior, not just compilation.") }
  return ($lines -join "`n")
}

function Write-GenericDeepSkill([string]$name) {
  $dir = Join-Path $PSScriptRoot $name
  $skillPath = Join-Path $dir "SKILL.md"
  $agentsDir = Join-Path $dir "agents"
  $refsDir = Join-Path $dir "references"
  New-Item -ItemType Directory -Force -Path $agentsDir, $refsDir | Out-Null

  $description = Read-Description $skillPath
  $display = To-Title $name
  $short = Short-Description $description
  $key = Domain-Key $name $description
  $mission = Domain-Text $key "mission"
  $workflow = Domain-Text $key "workflow"
  $evidence = Domain-Text $key "evidence"
  $output = Domain-Text $key "output"
  $stop = Domain-Text $key "stop"
  $specific = Specific-Lens $name $description

  $skillMd = @"
---
name: $name
description: >
  $description Use when an agent needs a deep, evidence-first workflow with repository-specific discovery, risk review, output contracts, and verification guidance.
---

# $display

## Operating Role

$mission

## Load Order

Read references/playbook.md and references/evidence-map.md before final recommendations or edits. Read references/output-contract.md before producing the final artifact. Read references/failure-modes.md when risk, ambiguity, or high-impact behavior is present. Read references/examples.md when shaping the final response.

## Core Commitments

- Ground every important claim in source, tests, config, runtime behavior, logs, or user-provided artifacts.
- Keep facts, assumptions, risks, and confidence separate.
- Prefer established repository patterns over generic best practices.
- Make the narrowest useful recommendation or change.
- Include verification commands, manual proof, or the reason verification is blocked.

## Skill-Specific Lens

$specific
"@
  Set-Content -LiteralPath $skillPath -Value $skillMd -Encoding UTF8

  $openai = @"
interface:
  display_name: "$display"
  short_description: "$short"
  default_prompt: "Use `$$name to handle this task with evidence, risk review, and concrete verification."

policy:
  allow_implicit_invocation: true
"@
  Set-Content -LiteralPath (Join-Path $agentsDir "openai.yaml") -Value $openai -Encoding UTF8

  $playbook = @"
# Playbook

## Mission

$mission

## Procedure

$workflow

## Skill-Specific Lens

$specific

## Minimum Done

- Evidence gathered from the closest relevant files or runtime signals.
- Risk and confidence stated.
- Recommendation or change scoped to the evidence.
- Verification path recorded.
"@
  Set-Content -LiteralPath (Join-Path $refsDir "playbook.md") -Value $playbook -Encoding UTF8

  $evidenceMap = @"
# Evidence Map

## Gather

$evidence

## Evidence Standards

- Strong: direct source, tests, runtime observation, logs, config, or command output.
- Medium: multiple naming/import/config signals that agree.
- Weak: filename similarity, stale docs, unverified ticket text, or comments without implementation.

## Confidence

- 0.90 to 1.00: direct evidence and verification.
- 0.75 to 0.89: strong evidence with minor gaps.
- 0.50 to 0.74: plausible, but missing a critical proof point.
- Below 0.50: ask or stop instead of guessing.
"@
  Set-Content -LiteralPath (Join-Path $refsDir "evidence-map.md") -Value $evidenceMap -Encoding UTF8

  $outputContract = @"
# Output Contract

## Required Shape

$output

## Always Include

- Summary
- Evidence Reviewed
- Risk Level
- Confidence
- Recommendation or Change
- Verification
- Open Questions or Blockers

## Quality Bar

- Specific file paths or runtime signals beat generic advice.
- Explain why a risk matters, not just that it exists.
- Make the next step executable.
"@
  Set-Content -LiteralPath (Join-Path $refsDir "output-contract.md") -Value $outputContract -Encoding UTF8

  $failureModes = @"
# Failure Modes

## Stop Conditions

$stop

## Common Mistakes

- Recommending a new pattern before reading local examples.
- Treating docs as current when source code disagrees.
- Ignoring tests, runtime behavior, or deployment/config impact.
- Hiding uncertainty.
- Making unrelated cleanup changes.

## Recovery

- Narrow scope.
- Gather one stronger evidence source.
- Ask one precise question.
- Produce a plan or map instead of code.
"@
  Set-Content -LiteralPath (Join-Path $refsDir "failure-modes.md") -Value $failureModes -Encoding UTF8

  $examples = @"
# Examples

## Good Prompt Fit

- Review this change for risk and missing verification.
- Plan this implementation using existing repository patterns.
- Diagnose this failure and produce a scoped repair path.
- Map the affected files before changing behavior.

## Good Response Pattern

Summary:
One sentence decision or result.

Evidence:
Files, tests, logs, configs, commands, or runtime observations.

Risk and confidence:
Low, Medium, or High plus 0.0 to 1.0 confidence.

Action:
Plan, patch summary, report, or stop decision.

Verification:
Commands run, proof observed, or blocker.
"@
  Set-Content -LiteralPath (Join-Path $refsDir "examples.md") -Value $examples -Encoding UTF8

  Get-ChildItem -LiteralPath $refsDir -Filter "$name-checklist.md" | Remove-Item
}

$generic = Get-ChildItem -Directory | Where-Object {
  ($originalSkills -notcontains $_.Name) -and (-not $recommendedSet.ContainsKey($_.Name))
} | Select-Object -ExpandProperty Name

foreach ($name in $generic) {
  Write-GenericDeepSkill $name
}

Write-Host "Enhanced $($generic.Count) generic skills with deep multi-reference packs."
