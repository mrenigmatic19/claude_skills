$ErrorActionPreference = "Stop"

$attachmentPath = "C:\Users\ritik\.codex\attachments\83287f12-ede4-4719-bd54-17a4640f1f0b\pasted-text.txt"
$raw = Get-Content -LiteralPath $attachmentPath -Raw

$items = New-Object System.Collections.Generic.List[object]
$currentCategory = ""
$matches = [regex]::Matches($raw, "(?m)^(?<num>\d+)\.\s+(?<name>[a-z0-9-]+)\s*$")

function Clean-Text([string]$text) {
  $leftDouble = [string][char]0x00E2 + [char]0x20AC + [char]0x0153
  $rightDouble = [string][char]0x00E2 + [char]0x20AC + [char]0x009D
  $rightSingle = [string][char]0x00E2 + [char]0x20AC + [char]0x2122
  $leftSingle = [string][char]0x00E2 + [char]0x20AC + [char]0x02DC
  $text = $text.Replace($leftDouble, '"')
  $text = $text.Replace($rightDouble, '"')
  $text = $text.Replace($rightSingle, "'")
  $text = $text.Replace($leftSingle, "'")
  return $text
}

for ($i = 0; $i -lt $matches.Count; $i++) {
  $match = $matches[$i]
  $start = $match.Index + $match.Length
  $end = if ($i + 1 -lt $matches.Count) { $matches[$i + 1].Index } else { $raw.Length }
  $before = $raw.Substring(0, $match.Index)
  $headingMatches = [regex]::Matches($before, "(?m)^[A-Z]\.\s+(.+)$")
  if ($headingMatches.Count -gt 0) {
    $currentCategory = $headingMatches[$headingMatches.Count - 1].Groups[1].Value.Trim()
  }

  $body = $raw.Substring($start, $end - $start).Trim()
  $body = [regex]::Replace($body, "(?s)\r?\nExample output:.*$", "").Trim()
  $body = [regex]::Replace($body, "(?s)\r?\nOutput:.*$", "").Trim()
  $descLine = ($body -split "\r?\n" | Where-Object { $_.Trim().Length -gt 0 } | Select-Object -First 1).Trim()
  $descLine = Clean-Text $descLine
  if ([string]::IsNullOrWhiteSpace($descLine)) {
    $descLine = "Supports repository-aware workflow guidance for this specialized automation task."
  }

  $items.Add([pscustomobject]@{
    Number = [int]$match.Groups["num"].Value
    Name = $match.Groups["name"].Value.Trim()
    Category = $currentCategory
    Description = $descLine
  })
}

function To-Title([string]$name) {
  return (($name -split "-") | ForEach-Object {
    if ($_ -eq "ado") { "ADO" }
    elseif ($_ -eq "ai") { "AI" }
    elseif ($_ -eq "api") { "API" }
    elseif ($_ -eq "ui") { "UI" }
    elseif ($_ -eq "ux") { "UX" }
    elseif ($_ -eq "pr") { "PR" }
    elseif ($_ -eq "rtl") { "RTL" }
    elseif ($_ -eq "e2e") { "E2E" }
    elseif ($_ -eq "ci") { "CI" }
    elseif ($_ -eq "roi") { "ROI" }
    elseif ($_ -eq "otp") { "OTP" }
    elseif ($_ -eq "qr") { "QR" }
    elseif ($_ -eq "ghcr") { "GHCR" }
    elseif ($_ -eq "spa") { "SPA" }
    else { (Get-Culture).TextInfo.ToTitleCase($_) }
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

function Focus-Items([string]$name, [string]$category, [string]$description) {
  $base = @(
    "Repository evidence before recommendations",
    "Existing patterns, helpers, and ownership boundaries",
    "Risk level, confidence, blockers, and missing details",
    "Minimum safe implementation or documentation path",
    "Concrete verification evidence and follow-up actions"
  )

  if ($category -like "*ADO*") {
    return @("Raw ticket intent and acceptance criteria", "ADO status, comments, branch, PR, and work item metadata", "Ambiguity, missing details, and clarification questions", "AI eligibility, risk class, and confidence", "Client-facing impact and validation summary")
  }
  if ($category -like "*Codebase Context*") {
    return @("Routes, components, state, API clients, tests, and owners", "Import and dependency graph evidence", "Feature slices and blast-radius boundaries", "Repository-specific architecture and design system patterns", "Generated indexes with source file references")
  }
  if ($category -like "*Playwright*") {
    return @("Browser-observed route, UI, accessibility, and network evidence", "Authenticated role/session preconditions", "Flow steps, screenshots, and visible state", "Timing, selector, environment, and test-data stability", "Source mapping from runtime evidence")
  }
  if ($category -like "*Component Mapping*") {
    return @("Runtime-to-source confidence scoring", "Route, visible text, API hook, and test evidence", "Duplicate and orphan component checks", "Feature flag, role, and permission mappings", "Shared component blast-radius estimate")
  }
  if ($category -like "*Code Generation*") {
    return @("Planner-approved files and minimal safe diff", "Existing frontend state, API, and design-system patterns", "Form, table, modal, i18n, and status-state expectations", "No unrelated refactors or raw custom UI when shared components exist", "Targeted tests and runtime verification")
  }
  if ($category -like "*Testing*") {
    return @("Nearby test style, helpers, fixtures, and assertions", "Acceptance criteria coverage and proof", "Failing-test-first reproduction when useful", "CI failure diagnosis and scoped repair feedback", "PR test evidence, screenshots, and known limitations")
  }
  if ($category -like "*Extra Innovative*") {
    return @("Domain-specific risk from AI PRs, payments, OTP, QR, async events, or deployment", "Human review deltas and reviewer feedback loops", "Operational state, deployment, and local environment evidence", "Frontend consistency for real-time and workflow state", "Metrics, ROI, and continuous improvement reporting")
  }

  return $base
}

function Write-Skill([object]$item) {
  $dir = Join-Path $PSScriptRoot $item.Name
  $agentsDir = Join-Path $dir "agents"
  $refsDir = Join-Path $dir "references"
  New-Item -ItemType Directory -Force -Path $agentsDir, $refsDir | Out-Null

  $display = To-Title $item.Name
  $short = Short-Description $item.Description
  $focus = Focus-Items $item.Name $item.Category $item.Description
  $focusBullets = ($focus | ForEach-Object { "- $_" }) -join "`n"
  $refName = "$($item.Name)-checklist.md"

  $skillMd = @"
---
name: $($item.Name)
description: >
  $($item.Description) Use when Codex needs $($item.Category.ToLowerInvariant()) support for ADO tickets, frontend code generation, Playwright/browser evidence, component mapping, tests, PR evidence, deployment review, or project-specific automation while preserving repository conventions and risk controls.
---

# $display

## Goal

Act as a senior frontend automation engineer for $($item.Category.ToLowerInvariant()).

Use this skill to turn the requested work into a grounded plan, implementation, review, or evidence artifact that follows the repository's existing structure.

## Core Rules

- Start from the user request, ADO ticket, PR, runtime flow, or changed files provided.
- Inspect nearby repository evidence before deciding what to edit or recommend.
- Separate confirmed facts from assumptions, missing details, and inferred links.
- Stop or ask for clarification when confidence is too low for safe code generation.
- Prefer minimal, planner-approved edits over broad refactors.
- Reuse existing components, hooks, services, selectors, fixtures, and test helpers.
- Record verification evidence in a form that can be pasted into an ADO comment or PR.

## Workflow

### Phase 1 - Normalize Inputs

Read references/$refName before producing the final answer.

Capture:

- Ticket, PR, bug, or feature summary
- Acceptance criteria or expected behavior
- Target route, component, API, state store, or flow when known
- Role, permission, feature flag, and environment context
- Missing details, blockers, and confidence level

### Phase 2 - Gather Evidence

Search the repository for:

- Routes, pages, components, hooks, services, API clients, stores, and tests
- Design-system components and existing UI patterns
- Playwright, RTL, unit, integration, or E2E test conventions
- Feature flags, role guards, permissions, and workflow state machines
- CI, deployment, Docker, Nginx, or environment files when relevant

For runtime-oriented tasks, use browser or Playwright evidence when available and map visible UI back to source files.

### Phase 3 - Produce The Artifact

Depending on the request, produce one of:

- Structured ticket understanding
- Clarification questions
- Implementation plan
- Scoped code change
- Test plan or generated tests
- Runtime verification report
- PR or ADO comment
- Architecture, route, component, or flow index
- Risk review or deployment review

Keep output focused and cite files or observed runtime evidence for important claims.

### Phase 4 - Verify

Run or recommend the narrowest meaningful verification:

- Unit, component, or E2E tests nearest to the affected behavior
- Typecheck, lint, and build commands from repository scripts
- Browser flow replay for UI and Playwright-related tasks
- Screenshots, network traces, or accessibility snapshots when visual/runtime proof matters
- Manual verification notes when automation is unavailable

## Domain Focus

$focusBullets

## Required Output

# $display Report

## Summary

## Inputs Understood

## Evidence Reviewed

## Risk And Confidence

## Recommendation Or Changes

## Verification Evidence

## Open Questions

## Quality Bar

- Name exact files, routes, selectors, APIs, or work items when known.
- Include a confidence score when mapping tickets, runtime flows, components, or risk.
- Do not invent source ownership, test commands, or runtime behavior.
- Prefer repository-specific evidence over generic frontend advice.
"@

  Set-Content -LiteralPath (Join-Path $dir "SKILL.md") -Value $skillMd -Encoding UTF8

  $openaiYaml = @"
interface:
  display_name: "$display"
  short_description: "$short"
  default_prompt: "Use `$$($item.Name) to handle this ticket or frontend workflow with repository evidence."

policy:
  allow_implicit_invocation: true
"@
  Set-Content -LiteralPath (Join-Path $agentsDir "openai.yaml") -Value $openaiYaml -Encoding UTF8

  $referenceMd = @"
# $display Checklist

Original catalog description:

$($item.Description)

## Input Checklist

- Identify the ticket, PR, flow, route, component, or deployment surface being discussed.
- Extract acceptance criteria, expected behavior, role, environment, and affected feature.
- Note ambiguity, missing details, and whether AI automation is safe.
- Capture known constraints such as auth, payments, security, customer data, feature flags, or infra.

## Evidence Checklist

- Search source files before making recommendations.
- Prefer the closest existing implementation over global assumptions.
- Include tests, fixtures, mocks, stories, route definitions, API clients, state stores, and config when relevant.
- For browser-flow tasks, capture route, visible UI, network calls, accessibility labels, screenshots, and source mappings.
- For ADO/PR tasks, include confidence, blockers, validation evidence, linked work item context, and reviewer-ready notes.

## Domain Checks

$focusBullets

## Stop Conditions

Stop before code generation and ask for clarification or human review when:

- Mapping confidence is below the requested or implied threshold.
- The work touches auth, authorization, payment, secrets, customer data, deployment, or destructive data changes without clear acceptance criteria.
- Required route, role, environment, test data, or API contract is missing.
- The requested change conflicts with repository architecture or design-system conventions.

## Output Guidance

- Keep plans scoped to files that evidence supports.
- Use concise ADO/PR-friendly language.
- Include risk level: Low, Medium, or High.
- Include confidence score from 0.0 to 1.0 for classification and mapping tasks.
- Include exact verification commands or runtime proof when available.
"@

  Set-Content -LiteralPath (Join-Path $refsDir $refName) -Value $referenceMd -Encoding UTF8
}

foreach ($item in $items) {
  Write-Skill $item
}

$readmeLines = New-Object System.Collections.Generic.List[string]
$readmeLines.Add("# claude_skills")
$readmeLines.Add("")
$readmeLines.Add("## Recommended Claude Code Skill Ideas")
$readmeLines.Add("")
$lastCategory = ""
foreach ($item in ($items | Sort-Object Number)) {
  if ($item.Category -ne $lastCategory) {
    $readmeLines.Add("")
    $readmeLines.Add("### $($item.Category)")
    $lastCategory = $item.Category
  }
  $readmeLines.Add(("{0}. `{1}` - {2}" -f $item.Number, $item.Name, $item.Description))
}

Set-Content -LiteralPath (Join-Path $PSScriptRoot "README.md") -Value $readmeLines -Encoding UTF8

Write-Host "Generated $($items.Count) recommended Claude Code skills."
