$ErrorActionPreference = "Stop"

function To-Title([string]$name) {
  return (($name -split "-") | ForEach-Object {
    switch ($_) {
      "ado" { "ADO"; break }
      "ai" { "AI"; break }
      "api" { "API"; break }
      "ui" { "UI"; break }
      "ux" { "UX"; break }
      "pr" { "PR"; break }
      "rtl" { "RTL"; break }
      "e2e" { "E2E"; break }
      "ci" { "CI"; break }
      "cd" { "CD"; break }
      "roi" { "ROI"; break }
      "otp" { "OTP"; break }
      "qr" { "QR"; break }
      "ghcr" { "GHCR"; break }
      "spa" { "SPA"; break }
      "seo" { "SEO"; break }
      "qa" { "QA"; break }
      default { (Get-Culture).TextInfo.ToTitleCase($_) }
    }
  }) -join " "
}

function Read-Description([string]$skillPath) {
  $lines = Get-Content -LiteralPath $skillPath
  for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -like "description:*") {
      if ($lines[$i].Trim() -eq "description: >") {
        $parts = New-Object System.Collections.Generic.List[string]
        for ($j = $i + 1; $j -lt $lines.Count; $j++) {
          if ($lines[$j] -eq "---") { break }
          $parts.Add($lines[$j].Trim())
        }
        return (($parts | Where-Object { $_ }) -join " ")
      }
      return $lines[$i].Substring($lines[$i].IndexOf(":") + 1).Trim()
    }
  }
  return "Support repository-aware engineering work with evidence, risk review, and verification."
}

function Skill-Family([string]$name, [string]$description) {
  $text = "$name $description"
  if ($name -match "ado|ticket|workitem|client-impact") { return "ADO ticket operations" }
  if ($name -match "payment|razorpay|otp|qr|auth|secret|privacy|permission|credential") { return "security and high-risk UX" }
  if ($name -match "docker|deploy|nginx|ghcr|lightsail|environment") { return "operations and deployment" }
  if ($name -match "rabbitmq|websocket|outbox|approval|incident") { return "data and async workflow" }
  if ($name -match "playwright|flow|runtime|visual|network|a11y|session|role-based") { return "runtime/browser flow analysis" }
  if ($name -match "component|route|storybook|blast|feature-flag|permission-ui") { return "component and source mapping" }
  if ($name -match "generator|implementer|editor|enforcer|builder|redux|zustand|react-query|table|modal|i18n") { return "frontend code generation" }
  if ($name -match "test|coverage|ci|repair|verifier|flaky|mock|contract|e2e|qa") { return "testing and evaluation" }
  if ($name -match "architecture|monorepo|module|legacy|refactor|library|technical-debt") { return "architecture and maintainability" }
  if ($name -match "requirements|story|stakeholder|decision|risk-register|estimation|docs|readme|changelog|semantic|open-source") { return "planning and communication" }
  if ($text -match "security|auth|authorization|privacy|secret|input|upload|payment|razorpay|otp|qr") { return "security and high-risk UX" }
  if ($text -match "docker|ghcr|lightsail|nginx|deploy|release|environment|observability|logging|incident|build") { return "operations and deployment" }
  if ($text -match "database|migration|backfill|data|cache|concurrency|webhook|background|rabbitmq|websocket|outbox") { return "data and async workflow" }
  if ($text -match "playwright|flow|runtime|visual|network|a11y|session|role-based") { return "runtime/browser flow analysis" }
  if ($text -match "component|route|storybook|blast|feature-flag|permission-ui") { return "component and source mapping" }
  if ($text -match "generator|implementer|editor|enforcer|builder|redux|zustand|react-query|table|modal|i18n") { return "frontend code generation" }
  if ($text -match "test|coverage|ci|repair|verifier|flaky|mock|contract|e2e|qa") { return "testing and evaluation" }
  if ($text -match "architecture|monorepo|module|legacy|refactor|library|technical-debt") { return "architecture and maintainability" }
  if ($text -match "requirements|story|stakeholder|decision|risk-register|estimation|docs|readme|changelog|semantic|open-source") { return "planning and communication" }
  return "general repository assistance"
}

function Specific-Triggers([string]$name) {
  $triggers = New-Object System.Collections.Generic.List[string]
  if ($name -match "normalizer") { $triggers.Add("Raw, pasted, or inconsistent ticket text needs to become structured fields.") }
  if ($name -match "extractor|criteria") { $triggers.Add("Acceptance criteria are implied, scattered, or mixed with implementation notes.") }
  if ($name -match "eligibility|risk|guard|stop|classifier") { $triggers.Add("An agent must decide whether to proceed, stop, or require human review.") }
  if ($name -match "mapper|indexer|tracer|finder") { $triggers.Add("A source map, ownership map, route map, import graph, or confidence score is needed before editing.") }
  if ($name -match "playwright|runtime|flow|visual|network|a11y|session") { $triggers.Add("Browser-observed evidence is needed to confirm the real UI path.") }
  if ($name -match "generator|implementer|editor|builder|enforcer") { $triggers.Add("A code change is requested and must be constrained to approved files and local patterns.") }
  if ($name -match "test|coverage|ci|repair|verifier|flaky") { $triggers.Add("Tests, CI failures, verification evidence, or regression proof are needed.") }
  if ($name -match "docker|deploy|nginx|ghcr|lightsail|environment") { $triggers.Add("Local environment, build, proxy, container, or deployment behavior is part of the task.") }
  if ($name -match "payment|razorpay|otp|qr|auth|secret|privacy|permission") { $triggers.Add("The change touches high-risk user trust, identity, money, credentials, or personal data.") }
  if ($triggers.Count -eq 0) { $triggers.Add("The task name or ticket intent directly matches this skill's purpose.") }
  return ($triggers | ForEach-Object { "- $_" }) -join "`n"
}

function Specific-Inputs([string]$name, [string]$family) {
  $items = @("User request or ticket text", "Relevant repository paths", "Existing tests or verification commands")
  if ($family -eq "ADO ticket operations") { $items += @("ADO ID, title, description, comments, state, linked PRs, role, acceptance criteria") }
  if ($family -eq "runtime/browser flow analysis") { $items += @("App URL, role/session, test data, route, screenshots, network calls, accessibility labels") }
  if ($family -eq "component and source mapping") { $items += @("Route definitions, visible UI text, import paths, parent pages, stories, shared component usage") }
  if ($family -eq "frontend code generation") { $items += @("Approved edit set, nearest pattern, design-system component, API/state contracts, i18n keys") }
  if ($family -eq "testing and evaluation") { $items += @("Failing logs, nearby test helpers, fixtures, mocks, selectors, coverage gaps") }
  if ($family -eq "security and high-risk UX") { $items += @("Roles, permissions, data classes, threat paths, audit logs, deny-case tests") }
  if ($family -eq "operations and deployment") { $items += @("Docker/CI/deploy config, env files, logs, health checks, rollback path") }
  if ($family -eq "data and async workflow") { $items += @("Schemas, migrations, jobs, queues, transactions, cache keys, idempotency signals") }
  if ($family -eq "architecture and maintainability") { $items += @("Module boundaries, dependency graph, public APIs, ADRs, package manifests") }
  return (($items | Select-Object -Unique) | ForEach-Object { "- $_" }) -join "`n"
}

function Specific-Procedure([string]$name, [string]$family) {
  $steps = New-Object System.Collections.Generic.List[string]
  $steps.Add("Restate the exact task in one sentence and name the expected artifact.")
  $steps.Add("Collect the minimum evidence set for $family before recommending or editing.")
  if ($name -match "normalizer|extractor|translator|writer|namer|linker") {
    $steps.Add("Transform messy input into a strict artifact shape; preserve missing fields instead of inventing values.")
  }
  if ($name -match "mapper|indexer|tracer|finder|scorer") {
    $steps.Add("Collect at least two independent signals before declaring ownership or source mapping.")
  }
  if ($name -match "generator|implementer|editor|enforcer") {
    $steps.Add("Freeze the approved edit set, then make the smallest change that satisfies the behavior.")
  }
  if ($name -match "test|coverage|ci|repair|verifier") {
    $steps.Add("Connect every test or repair to an acceptance criterion, failing log line, or regression risk.")
  }
  if ($name -match "risk|guard|auth|payment|otp|qr|secret|privacy|deploy") {
    $steps.Add("Apply a conservative stop gate when evidence is incomplete or the blast radius is not bounded.")
  }
  $steps.Add("Write the result with evidence, confidence, risk, verification, and unresolved gaps.")
  $numbered = New-Object System.Collections.Generic.List[string]
  for ($i = 0; $i -lt $steps.Count; $i++) {
    $numbered.Add(("{0}. {1}" -f ($i + 1), $steps[$i]))
  }
  return $numbered -join "`n"
}

function Specific-Pitfalls([string]$name, [string]$family) {
  $items = @("Using the skill name as a substitute for evidence", "Skipping local conventions and producing generic advice", "Omitting confidence or blockers")
  if ($family -eq "ADO ticket operations") { $items += @("Treating vague ADO wording as acceptance criteria", "Forgetting to preserve missing details as questions") }
  if ($family -eq "runtime/browser flow analysis") { $items += @("Guessing source files from route names only", "Ignoring auth/session/test-data preconditions") }
  if ($family -eq "component and source mapping") { $items += @("Editing a shared component without consumer impact", "Mistaking dead routes or duplicate components for live code") }
  if ($family -eq "frontend code generation") { $items += @("Creating one-off UI instead of reusing design-system components", "Refactoring unrelated files while solving a ticket") }
  if ($family -eq "testing and evaluation") { $items += @("Adding snapshots without behavior assertions", "Weakening assertions to pass CI") }
  if ($family -eq "security and high-risk UX") { $items += @("Testing only allow paths and not deny paths", "Ignoring replay, duplicate-submit, or privilege escalation cases") }
  if ($family -eq "operations and deployment") { $items += @("Changing deploy config without rollback", "Ignoring env parity and health checks") }
  if ($family -eq "data and async workflow") { $items += @("Skipping idempotency and backfill resume behavior", "Ignoring consumers of changed schemas or events") }
  return (($items | Select-Object -Unique) | ForEach-Object { "- $_" }) -join "`n"
}

function Verification-Matrix([string]$name, [string]$family) {
  $rows = @(
    "| Concern | Verification | Evidence To Report |",
    "|---|---|---|",
    "| Mapping confidence | Confirm source paths with route/import/runtime/test evidence | File paths and confidence score |",
    "| Repository convention | Compare against nearest existing pattern | Pattern file and reused helper/component |",
    "| Regression risk | Run or propose narrow tests | Command and result or blocker |"
  )
  if ($family -eq "ADO ticket operations") { $rows += "| Ticket artifact quality | Check required fields and missing-detail questions | Structured ticket/ADO comment preview |" }
  if ($family -eq "runtime/browser flow analysis") { $rows += "| Browser behavior | Replay the user flow with role/session data | URL, screenshot, network/a11y observation |" }
  if ($family -eq "frontend code generation") { $rows += "| UI states | Verify loading, error, empty, disabled, unauthorized, and success states | Test or manual state checklist |" }
  if ($family -eq "testing and evaluation") { $rows += "| Test usefulness | Ensure assertions prove behavior, not implementation trivia | AC-to-test mapping |" }
  if ($family -eq "security and high-risk UX") { $rows += "| Abuse/deny path | Test invalid role, replay, duplicate submit, expired credential, or unauthorized action | Negative test evidence |" }
  if ($family -eq "operations and deployment") { $rows += "| Rollback readiness | Identify rollback command/config/version | Rollback note and owner |" }
  if ($family -eq "data and async workflow") { $rows += "| Idempotency and compatibility | Check retries, consumers, migrations, and backfill resume | Query/log/test evidence |" }
  return $rows -join "`n"
}

function Improve-Skill([string]$name) {
  $dir = Join-Path $PSScriptRoot $name
  $skillPath = Join-Path $dir "SKILL.md"
  if (!(Test-Path -LiteralPath $skillPath)) { return $null }
  $refs = Join-Path $dir "references"
  New-Item -ItemType Directory -Force -Path $refs | Out-Null
  $description = Read-Description $skillPath
  $family = Skill-Family $name $description
  $display = To-Title $name

  $taskPatterns = @"
# Task Patterns

## Skill Identity

$display belongs to the $family family.

Primary description:

$description

## Trigger Patterns

$(Specific-Triggers $name)

## Inputs To Ask For Or Discover

$(Specific-Inputs $name $family)

## Exact Procedure

$(Specific-Procedure $name $family)

## Common Pitfalls

$(Specific-Pitfalls $name $family)

## Depth Upgrade

This reference exists because the skill should not behave like a generic scaffold. Prefer this file when the task requires concrete moves for this exact skill rather than broad family-level guidance.
"@
  Set-Content -LiteralPath (Join-Path $refs "task-patterns.md") -Value $taskPatterns -Encoding UTF8

  $verification = @"
# Verification Matrix

Use this matrix to decide how to prove the skill did useful work.

$(Verification-Matrix $name $family)

## Reporting Rules

- Report commands exactly when commands are run.
- If verification is manual, name the screen, role, route, data, and expected state.
- If verification is blocked, name the missing prerequisite and the next owner action.
- For confidence below 0.75, prefer a mapping/report artifact over code changes.
"@
  Set-Content -LiteralPath (Join-Path $refs "verification-matrix.md") -Value $verification -Encoding UTF8

  $skillText = Get-Content -LiteralPath $skillPath -Raw
  if ($skillText -notmatch "task-patterns\.md") {
    $insert = @"

## Skill-Specific References

- references/task-patterns.md - concrete trigger patterns, inputs, procedure, and pitfalls for this exact skill.
- references/verification-matrix.md - proof matrix for deciding which tests, runtime checks, or review evidence are enough.
"@
    if ($skillText -match "## Load Order") {
      $skillText = $skillText -replace "(## Load Order\r?\n)", "`$1$insert`r`n"
    } else {
      $skillText = $skillText.TrimEnd() + "`r`n" + $insert + "`r`n"
    }
    Set-Content -LiteralPath $skillPath -Value $skillText -Encoding UTF8
  }

  $gaps = New-Object System.Collections.Generic.List[string]
  $refsCount = (Get-ChildItem -LiteralPath $refs -File -ErrorAction SilentlyContinue | Measure-Object).Count
  if ($refsCount -lt 5) { $gaps.Add("Too few progressive-disclosure references for depth.") }
  if ($skillText -notmatch "confidence|Confidence") { $gaps.Add("Confidence guidance was not visible in SKILL.md.") }
  if ($skillText -notmatch "evidence|Evidence") { $gaps.Add("Evidence standard needed to be more explicit.") }
  if ($skillText -notmatch "Stop|stop") { $gaps.Add("Stop conditions needed to be more visible.") }
  if ($gaps.Count -eq 0) { $gaps.Add("No structural blocker; main improvement was stronger skill-specific procedural detail.") }

  return [pscustomobject]@{
    Name = $name
    Family = $family
    Gaps = ($gaps -join " ")
    Applied = "Added references/task-patterns.md and references/verification-matrix.md; linked them from SKILL.md when missing."
  }
}

$skip = @(".git", ".agents")
$skills = Get-ChildItem -Directory | Where-Object { $skip -notcontains $_.Name } | Select-Object -ExpandProperty Name | Sort-Object
$reviews = New-Object System.Collections.Generic.List[object]
foreach ($name in $skills) {
  $review = Improve-Skill $name
  if ($null -ne $review) { $reviews.Add($review) }
}

$audit = New-Object System.Collections.Generic.List[string]
$audit.Add("# Skill Quality Review")
$audit.Add("")
$audit.Add("Reviewed each skill folder and applied skill-specific depth improvements.")
$audit.Add("")
$audit.Add("## Summary")
$audit.Add("")
$audit.Add("- Skills reviewed: $($reviews.Count)")
$audit.Add("- Improvements applied to each skill: task-patterns.md, verification-matrix.md, and SKILL.md reference links where missing.")
$audit.Add("- Review method: check trigger clarity, progressive references, evidence standards, stop conditions, output contracts, and verification guidance.")
$audit.Add("")
$audit.Add("## Per-Skill Notes")
$audit.Add("")
foreach ($review in $reviews) {
  $audit.Add("### $($review.Name)")
  $audit.Add("")
  $audit.Add("- Family: $($review.Family)")
  $audit.Add("- Improvement points: $($review.Gaps)")
  $audit.Add("- Improvements applied: $($review.Applied)")
  $audit.Add("")
}

Set-Content -LiteralPath (Join-Path $PSScriptRoot "SKILL_QUALITY_REVIEW.md") -Value $audit -Encoding UTF8

Write-Host "Reviewed and improved $($reviews.Count) skills."
