$ErrorActionPreference = "Stop"

$attachmentPath = "C:\Users\ritik\.codex\attachments\83287f12-ede4-4719-bd54-17a4640f1f0b\pasted-text.txt"
$raw = Get-Content -LiteralPath $attachmentPath -Raw

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
      "roi" { "ROI"; break }
      "otp" { "OTP"; break }
      "qr" { "QR"; break }
      "ghcr" { "GHCR"; break }
      "spa" { "SPA"; break }
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

function Extract-Items {
  $items = New-Object System.Collections.Generic.List[object]
  $matches = [regex]::Matches($raw, "(?m)^(?<num>\d+)\.\s+(?<name>[a-z0-9-]+)\s*$")
  for ($i = 0; $i -lt $matches.Count; $i++) {
    $match = $matches[$i]
    $start = $match.Index + $match.Length
    $end = if ($i + 1 -lt $matches.Count) { $matches[$i + 1].Index } else { $raw.Length }
    $before = $raw.Substring(0, $match.Index)
    $headingMatches = [regex]::Matches($before, "(?m)^(?:[A-Z]\.\s+(?<lettered>.+)|(?<extra>Extra Innovative Skills.*))$")
    if ($headingMatches.Count -gt 0) {
      $lastHeading = $headingMatches[$headingMatches.Count - 1]
      $category = if ($lastHeading.Groups["lettered"].Success) { $lastHeading.Groups["lettered"].Value.Trim() } else { $lastHeading.Groups["extra"].Value.Trim() }
    } else {
      $category = "General Skills"
    }
    $body = $raw.Substring($start, $end - $start).Trim()
    $body = [regex]::Replace($body, "(?s)\r?\nExample output:.*$", "").Trim()
    $body = [regex]::Replace($body, "(?s)\r?\nOutput:.*$", "").Trim()
    $desc = ($body -split "\r?\n" | Where-Object { $_.Trim().Length -gt 0 } | Select-Object -First 1).Trim()
    $desc = Clean-Text $desc
    $items.Add([pscustomobject]@{
      Number = [int]$match.Groups["num"].Value
      Name = $match.Groups["name"].Value.Trim()
      Display = To-Title $match.Groups["name"].Value.Trim()
      Category = $category
      Description = $desc
    })
  }
  return $items
}

function Category-Key([string]$category) {
  if ($category -like "*ADO*") { return "ado" }
  if ($category -like "*Codebase Context*") { return "context" }
  if ($category -like "*Playwright*") { return "playwright" }
  if ($category -like "*Component Mapping*") { return "mapping" }
  if ($category -like "*Code Generation*") { return "generation" }
  if ($category -like "*Testing*") { return "testing" }
  if ($category -like "*Extra Innovative*") { return "domain" }
  return "general"
}

function Category-Block([string]$key, [string]$section) {
  $blocks = @{
    "ado:mission" = "Convert uncertain ADO work items into explicit engineering instructions: normalized intent, missing facts, automation eligibility, risk class, branch/PR metadata, and reviewer-ready comments."
    "ado:evidence" = "ADO title, description, acceptance criteria, comments, screenshots, linked PRs, linked bugs, affected route names, user role, environment, current status, story type, and business impact."
    "ado:workflow" = "1. Preserve the raw ticket in notes before rewriting it. 2. Extract nouns into feature, route, role, data object, and UI surface. 3. Convert verbs into expected behavior. 4. Mark vague phrases as unresolved. 5. Assign risk and confidence. 6. Produce an ADO-ready artifact with blockers and next action."
    "ado:decisions" = "AI-safe only when the ticket is narrow, testable, frontend-contained, has clear acceptance criteria, and avoids auth, payment, security, customer data, infra, and destructive workflow changes."
    "ado:stop" = "Stop when the ticket has no reproducible behavior, no target surface, conflicting comments, missing role/environment, or high-risk areas without owner approval."
    "ado:outputs" = "Use compact ADO-friendly sections: Understanding, Assumptions, Missing Details, Risk, Plan, Files To Inspect, Tests, Confidence, Next Status."
    "ado:examples" = "Ticket says 'make export work like old app'. Extract: export action, old-app comparison missing, target route unknown, CSV schema unknown. Ask for old app screenshot/sample CSV before coding."

    "context:mission" = "Build high-signal repository maps that help future agents change code safely: routes, components, imports, feature slices, API contracts, state patterns, tests, design-system inventory, and package boundaries."
    "context:evidence" = "Router definitions, page modules, feature folders, shared components, hooks, stores, API clients, generated types, test files, Storybook stories, package manifests, tsconfig paths, workspace boundaries, and design tokens."
    "context:workflow" = "1. Start with entry points and manifests. 2. Walk from route to page to feature module. 3. Trace imports outward one layer at a time. 4. Record evidence with file paths. 5. Distinguish primary owner files from incidental dependencies. 6. Write indexes that are specific enough to drive later edits."
    "context:decisions" = "Prefer observed relationships over name similarity. Treat generated files, vendored code, barrel exports, and shared utilities as supporting evidence, not ownership proof."
    "context:stop" = "Stop before recommending edits when route ownership is ambiguous, package boundaries conflict, or multiple components share names without runtime or import evidence."
    "context:outputs" = "Produce machine-usable maps when requested: route maps, feature slices, import graphs, API consumer maps, state pattern summaries, test pattern inventories, and design-system indexes."
    "context:examples" = "For /reports/:id/summary, map route definition, ReportSummaryPage, feature hooks, API clients, query keys, child components, tests, and shared table components."

    "playwright:mission" = "Use real browser evidence to discover, reproduce, document, and verify frontend flows instead of guessing from filenames or component names."
    "playwright:evidence" = "Current URL, route params, visible headings, buttons, form labels, dialogs, accessibility snapshot, network requests, console errors, screenshots, storage/session state, role used, test data, timing waits, and source matches from text search."
    "playwright:workflow" = "1. Establish preconditions and role. 2. Open the app and navigate like a user. 3. Capture route, visible UI, accessibility labels, and network calls at every major step. 4. Map runtime evidence to source files. 5. Save flow context. 6. Re-run after changes and compare."
    "playwright:decisions" = "Prefer role/name selectors and accessibility labels over brittle CSS selectors. Treat a browser failure as inconclusive until environment, auth, test data, network, and timing are checked."
    "playwright:stop" = "Stop when auth cannot be established, test data is missing, the local app is not running, the route requires external systems, or the flow has destructive side effects."
    "playwright:outputs" = "Produce flow documents with Preconditions, Steps, Route, UI Observed, Network Observed, Source Mapping, Failure Classification, Screenshots, and Verification Result."
    "playwright:examples" = "For a final confirmation page bug, drive the whole flow from login through submit. Do not edit a guessed ConfirmationPage until runtime evidence maps the page to source."

    "mapping:mission" = "Turn runtime and repository clues into confident component/source ownership before code generation starts."
    "mapping:evidence" = "Route match, visible text, accessibility labels, network calls, API hook names, import paths, parent pages, tests, stories, feature flags, role guards, dead routes, and shared component usage counts."
    "mapping:workflow" = "1. Gather independent signals. 2. Score each signal. 3. Identify candidate files. 4. Reject duplicates and dead routes. 5. Estimate blast radius. 6. Proceed only when confidence clears the threshold."
    "mapping:decisions" = "Use weighted confidence, not a single filename match. Shared component edits require impact analysis across all consumers."
    "mapping:stop" = "Stop when confidence is below threshold, a component is shared widely, a feature flag controls the surface, or role/permission logic is unresolved."
    "mapping:outputs" = "Produce Candidate Files, Evidence Weights, Confidence Score, Blast Radius, Stop/Proceed Decision, and Files Approved For Edit."
    "mapping:examples" = "Route match 0.40 plus visible text 0.25 plus API hook 0.20 plus nearby test 0.15 equals 1.00 confidence. Filename-only match is never enough."

    "generation:mission" = "Generate frontend changes only after the target route, component, API, state, design-system pattern, and tests are known."
    "generation:evidence" = "Planner-approved files, existing component variants, design-system imports, API client conventions, React Query keys, Redux/Zustand selectors/actions, validation schemas, table/modal patterns, i18n files, and nearby tests."
    "generation:workflow" = "1. Confirm approved edit set. 2. Read nearest implementation pattern. 3. Make the smallest behavior-preserving diff. 4. Add missing UI states. 5. Update tests in local style. 6. Run narrow verification. 7. Report exact evidence."
    "generation:decisions" = "Do not create raw HTML controls when design-system components exist. Do not invent state management, query keys, schema libraries, or CSS patterns."
    "generation:stop" = "Stop when requested files are not approved, the component mapping is low-confidence, the design-system equivalent is unknown, or the change touches high-risk flows without explicit plan."
    "generation:outputs" = "Produce Scope, Files Edited, Pattern Reused, Behavior Changed, Tests Added, Verification, Risks, and Follow-up Cleanup."
    "generation:examples" = "For table CSV export, inspect existing table column definitions, export helpers, loading/empty/error states, permissions, and tests before adding a button."

    "testing:mission" = "Convert ticket expectations and changed behavior into targeted tests and verification evidence that match repository style."
    "testing:evidence" = "Nearby unit/component/E2E tests, render helpers, mock APIs, fixtures, selectors, user-event style, Playwright config, CI logs, coverage reports, acceptance criteria, screenshots, and manual verification notes."
    "testing:workflow" = "1. Mine local test conventions. 2. Connect each acceptance criterion to proof. 3. Add failing reproduction first when useful. 4. Write minimal tests with existing helpers. 5. Diagnose CI failures into scoped repair instructions. 6. Produce PR evidence."
    "testing:decisions" = "Prefer meaningful behavior coverage over shallow snapshots. Do not weaken assertions to make tests pass. Separate app bugs from test flakiness."
    "testing:stop" = "Stop when the behavior cannot be reproduced, mocks would hide the bug, test data is unavailable, or CI failure logs are incomplete."
    "testing:outputs" = "Produce Test Pattern Summary, AC Coverage Matrix, Tests Added/Changed, Commands Run, Failures, Screenshots/Traces, and Known Gaps."
    "testing:examples" = "If AC says 'Submit disabled until required fields are valid', test initial disabled state, invalid input message, valid input enabling, and submit payload."

    "domain:mission" = "Apply specialized product and operations knowledge for AI contribution tracking, PR learning, payment/OTP/QR flows, async events, real-time state, Docker, GHCR, Lightsail, Nginx, and incident workflows."
    "domain:evidence" = "PR history, review comments, AI branch vs final branch diff, payment/OTP/QR UI, async event docs, WebSocket handlers, Docker Compose, GHCR tags, Lightsail/Nginx config, health checks, incident state screens, approval workflows, and operational logs."
    "domain:workflow" = "1. Identify domain risk first. 2. Gather source, runtime, and operational evidence. 3. Map UI state to backend or deployment state. 4. Enforce high-risk review gates. 5. Produce audit-ready evidence. 6. Feed lessons back into future skill guidance."
    "domain:decisions" = "Treat payment, OTP, QR credential, deployment, and incident-remediation changes as high-risk unless proven otherwise. Prefer observability and rollback evidence over optimistic claims."
    "domain:stop" = "Stop when secrets, payment behavior, production deploys, real customer data, destructive remediation, or credential security is involved without explicit approval and verification path."
    "domain:outputs" = "Produce Domain Risk Review, Evidence, State Mapping, Required Human Review, Verification Plan, Rollback/Recovery Notes, and Learning Feedback."
    "domain:examples" = "For Razorpay checkout UI, verify duplicate-submit prevention, idempotency messaging, webhook reconciliation states, failure retries, and human review before merge."
  }
  $keyed = "$key`:$section"
  if ($blocks.ContainsKey($keyed)) { return $blocks[$keyed] }
  return "Use repository evidence, risk controls, scoped implementation, and concrete verification for this skill."
}

function Skill-Specific([object]$item) {
  $name = $item.Name
  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add("- Primary purpose: $($item.Description)")
  if ($name -match "normalizer|extractor|translator|writer|namer|linker") { $lines.Add("- Optimize for clean artifact shape, exact wording, and copy/paste readiness.") }
  if ($name -match "risk|eligibility|guard|stop|classifier") { $lines.Add("- Bias toward conservative gating when evidence is incomplete or high-risk surfaces appear.") }
  if ($name -match "mapper|indexer|tracer|builder|documenter") { $lines.Add("- Produce durable maps with source paths, confidence, and update triggers.") }
  if ($name -match "playwright|flow|runtime|visual|network|a11y|session|role") { $lines.Add("- Prefer browser-observed evidence over static guesses and record preconditions precisely.") }
  if ($name -match "generator|implementer|editor|enforcer|builder") { $lines.Add("- Only edit files approved by evidence and reuse the closest local implementation pattern.") }
  if ($name -match "test|verifier|coverage|ci|repair") { $lines.Add("- Connect each test or repair to an acceptance criterion, regression, or CI failure line.") }
  if ($name -match "razorpay|otp|qr|payment|credential") { $lines.Add("- Treat the flow as security/payment-sensitive and require explicit negative-state verification.") }
  if ($name -match "docker|ghcr|lightsail|nginx|deploy") { $lines.Add("- Check local/prod parity, ports, health checks, image tags, reverse proxy rules, and rollback path.") }
  if ($name -match "rabbitmq|websocket|outbox|incident|approval") { $lines.Add("- Map every UI state to an async backend event, retry path, or workflow transition.") }
  return ($lines -join "`n")
}

function Write-DeepSkill([object]$item) {
  $dir = Join-Path $PSScriptRoot $item.Name
  $agentsDir = Join-Path $dir "agents"
  $refsDir = Join-Path $dir "references"
  New-Item -ItemType Directory -Force -Path $agentsDir, $refsDir | Out-Null

  $key = Category-Key $item.Category
  $mission = Category-Block $key "mission"
  $evidence = Category-Block $key "evidence"
  $workflow = Category-Block $key "workflow"
  $decisions = Category-Block $key "decisions"
  $stop = Category-Block $key "stop"
  $outputs = Category-Block $key "outputs"
  $examples = Category-Block $key "examples"
  $specific = Skill-Specific $item
  $short = Short-Description $item.Description

  $skillMd = @"
---
name: $($item.Name)
description: >
  $($item.Description) Use for $($item.Category.ToLowerInvariant()) work when an agent needs deep, repository-aware procedures, evidence standards, stop conditions, output contracts, and verification guidance instead of generic advice.
---

# $($item.Display)

## Operating Role

Act as the specialist for this exact capability, not as a generic frontend assistant.

$mission

## Load Order

Read these references as needed, in this order:

1. references/playbook.md - task workflow and decision sequence.
2. references/evidence-map.md - what evidence to gather and how to judge it.
3. references/output-contract.md - required artifact shape and quality bar.
4. references/failure-modes.md - stop conditions, review gates, and common mistakes.
5. references/examples.md - realistic examples and response patterns.

Always read playbook.md and evidence-map.md before implementation, classification, or final recommendations. Read output-contract.md before producing a ticket, PR, map, test, report, or generated-code summary.

## Non-Negotiables

- Start from actual ticket text, runtime evidence, repository files, tests, configs, or logs.
- Cite file paths, routes, selectors, API names, work items, screenshots, or command output when they support a claim.
- Separate facts, assumptions, confidence, and blockers.
- Use the repository's existing architecture, design system, state patterns, test helpers, and workflow language.
- Stop before code generation when confidence is low, high-risk surfaces are involved, or required context is missing.
- Prefer a narrow artifact or minimal diff over broad cleanup.
- Preserve evidence that a reviewer or future agent can audit.

## Skill-Specific Lens

$specific

## Final Response Shape

Use the output contract unless the user asks for a different format. Keep the response practical:

- What was understood.
- Evidence used.
- Risk and confidence.
- Action taken or recommended.
- Verification and gaps.
"@
  Set-Content -LiteralPath (Join-Path $dir "SKILL.md") -Value $skillMd -Encoding UTF8

  $openaiYaml = @"
interface:
  display_name: "$($item.Display)"
  short_description: "$short"
  default_prompt: "Use `$$($item.Name) to handle this task with repository evidence, risk gates, and a reviewer-ready output."

policy:
  allow_implicit_invocation: true
"@
  Set-Content -LiteralPath (Join-Path $agentsDir "openai.yaml") -Value $openaiYaml -Encoding UTF8

  $playbook = @"
# Playbook

## Purpose

$($item.Description)

Category mission:

$mission

## Procedure

$workflow

## Skill-Specific Moves

$specific

## Decision Rules

$decisions

## Minimum Done

- The target artifact or code path is grounded in evidence.
- Ambiguity is named instead of silently resolved.
- Risk and confidence are explicit.
- Verification is either completed or precisely described.
- The next human/agent action is obvious.
"@
  Set-Content -LiteralPath (Join-Path $refsDir "playbook.md") -Value $playbook -Encoding UTF8

  $evidenceMap = @"
# Evidence Map

## Evidence To Gather

$evidence

## Evidence Quality

Strong evidence:

- Direct route, import, API, test, runtime, or log evidence.
- Multiple independent signals that agree.
- Recent code paths over stale docs.
- Existing tests or stories that encode expected behavior.

Weak evidence:

- Similar filenames without imports or runtime proof.
- Unverified ticket wording.
- Generated or vendored code.
- Comments that disagree with implementation.
- Screenshots without route, role, or environment.

## Confidence Scoring

Use 0.0 to 1.0.

- 0.90 to 1.00: direct evidence from source plus runtime or tests.
- 0.75 to 0.89: multiple source signals, minor gaps.
- 0.50 to 0.74: plausible but missing one critical signal.
- Below 0.50: do not implement; ask for more context.

## Evidence Ledger

Record important evidence as:

- Claim
- Evidence source
- Confidence
- Why it matters
- Gap or contradiction
"@
  Set-Content -LiteralPath (Join-Path $refsDir "evidence-map.md") -Value $evidenceMap -Encoding UTF8

  $outputContract = @"
# Output Contract

## Required Sections

$outputs

## Universal Fields

- Summary: one or two sentences.
- Inputs Understood: ticket, flow, route, role, files, logs, or PR context.
- Evidence Reviewed: concrete file paths, runtime observations, commands, or ADO/PR details.
- Risk Level: Low, Medium, or High with reason.
- Confidence: 0.0 to 1.0 with the main uncertainty.
- Decision: proceed, stop, ask, implement, verify, or escalate.
- Result: artifact produced, files changed, tests planned, or verification completed.
- Gaps: missing facts and exact question or owner needed.

## Reviewer-Ready Style

- Use short headings and precise bullets.
- Prefer specific nouns over general claims.
- Avoid saying 'should be fine' or 'looks good' without evidence.
- Include negative findings when they changed the decision.
- Make the output pasteable into ADO or a PR when relevant.

## For Code Changes

Include:

- Approved edit set.
- Pattern reused.
- Behavior changed.
- Tests added or skipped.
- Commands run.
- Residual risk.
"@
  Set-Content -LiteralPath (Join-Path $refsDir "output-contract.md") -Value $outputContract -Encoding UTF8

  $failureModes = @"
# Failure Modes

## Stop Conditions

$stop

## Common Mistakes

- Treating the skill name as enough context.
- Writing code from ticket wording without mapping route, component, API, state, and tests.
- Creating a new component, state pattern, selector strategy, or test style when the repo already has one.
- Ignoring role, permission, feature flag, environment, or test-data preconditions.
- Reporting confidence without explaining evidence.
- Replacing human review for high-risk payment, auth, credential, deployment, or customer-data paths.

## Recovery Actions

- Ask one precise clarification question.
- Produce a mapping report instead of code.
- Limit the change to verified files.
- Add a failing reproduction before a fix.
- Request human review for risk acceptance.
- Save the missing evidence as a blocker rather than guessing.
"@
  Set-Content -LiteralPath (Join-Path $refsDir "failure-modes.md") -Value $failureModes -Encoding UTF8

  $examplesMd = @"
# Examples

## Canonical Example

$examples

## Prompt Patterns That Should Trigger This Skill

- Use this skill for the attached ADO ticket.
- Map this route/component before changing it.
- Decide if this task is safe for AI automation.
- Build the PR or ADO comment from this evidence.
- Re-run or verify this frontend flow.
- Explain why this CI, Playwright, or review failure happened.

## Good Output Pattern

Summary:
State the decision in one sentence.

Evidence:
List the source files, runtime observations, ticket fields, or logs.

Risk and confidence:
Give a number and name the uncertainty.

Action:
Give the scoped plan, generated artifact, tests, or stop decision.

Verification:
List commands, browser proof, screenshots, or why verification is blocked.

## Bad Output Pattern

- Generic advice with no file paths.
- A plan that edits files not mapped by evidence.
- Confidence without a reason.
- No mention of risk.
- No stop condition when required facts are absent.
"@
  Set-Content -LiteralPath (Join-Path $refsDir "examples.md") -Value $examplesMd -Encoding UTF8

  $oldChecklist = Join-Path $refsDir "$($item.Name)-checklist.md"
  if (Test-Path -LiteralPath $oldChecklist) {
    Remove-Item -LiteralPath $oldChecklist
  }
}

$items = Extract-Items
foreach ($item in $items) {
  Write-DeepSkill $item
}

$readmeLines = New-Object System.Collections.Generic.List[string]
$readmeLines.Add("# claude_skills")
$readmeLines.Add("")
$readmeLines.Add("## Recommended Claude Code Skill Ideas")
$readmeLines.Add("")
$readmeLines.Add("Each recommended skill now uses a deeper pack: SKILL.md plus references/playbook.md, evidence-map.md, output-contract.md, failure-modes.md, and examples.md.")
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

Write-Host "Enhanced $($items.Count) recommended skills with deep multi-reference packs."
