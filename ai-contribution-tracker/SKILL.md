---
name: ai-contribution-tracker
description: Analyze repository history to estimate which code was likely AI-generated, human-written, mixed, or unknown. Use when producing AI adoption reports, commit-level AI attribution, developer-level AI usage metrics, generated test/documentation/boilerplate estimates, or repository development statistics from git history, pull requests, commits, changed files, and code patterns. Always report uncertainty with confidence scores and never claim certainty.
---

# AI Contribution Tracker

## Purpose

Track AI adoption within a repository and estimate AI-assisted contribution patterns without overstating certainty.

Estimate:

- AI-generated LOC
- Human-written LOC
- AI-assisted commits
- AI-generated tests
- AI-generated documentation
- AI-generated boilerplate
- Mixed contributions
- Unknown contributions

## Core Rules

- Never claim certainty about authorship.
- Always label findings as `Likely AI Generated`, `Likely Human Written`, `Mixed Contribution`, or `Unknown`.
- Always include a confidence score from `0.0` to `1.0`.
- Treat AI attribution as probabilistic evidence, not proof.
- Prefer conservative classification when signals conflict.
- Separate measured facts from inferred attribution.
- Do not shame, rank, or evaluate developers by moral judgment; report adoption and risk patterns.

## Workflow

### Phase 1 - Repository Analysis

Inspect repository history and current files:

- Git history
- Commit messages
- Pull request metadata when available
- Generated files
- Test files
- Documentation files
- Boilerplate/configuration files

Collect:

- Author
- Timestamp
- Commit hash
- Files changed
- Insertions
- Deletions
- File type
- File role: source, test, documentation, config, generated, migration, asset, vendor

Use git commands such as:

```bash
git log --numstat --date=iso --pretty=format:"commit %H%nAuthor: %an <%ae>%nDate: %ad%nSubject: %s"
git log --stat --date=iso
git blame --line-porcelain <file>
git diff --numstat <range>
```

### Phase 2 - AI Detection

Read `references/detection-heuristics.md` before making classification judgments.

Look for indicators:

- Copilot-style completion patterns
- Claude-generated style patterns
- Cursor-generated style patterns
- ChatGPT-generated style patterns
- AI-like commit messages
- Large boilerplate drops
- Repeated consistent generated style
- Sudden test/doc expansion with generic coverage
- Broad mechanical refactors with uniform phrasing

Classify each commit or file contribution as one of:

- `Likely AI Generated`
- `Likely Human Written`
- `Mixed Contribution`
- `Unknown`

### Phase 3 - Metrics

Generate repository-level metrics:

- Total LOC analyzed
- Human LOC estimate
- AI LOC estimate
- Mixed LOC estimate
- Unknown LOC estimate
- AI percentage
- Human percentage
- AI-assisted commits
- AI-generated tests
- AI-generated documentation
- AI-generated boilerplate

Generate developer-level metrics:

- Developer
- Commits
- Human LOC estimate
- AI LOC estimate
- Mixed LOC estimate
- Unknown LOC estimate
- AI percentage
- Average confidence

## Confidence Scoring

Use this scale:

- `0.80-1.00`: Strong repeated evidence across commit metadata, file patterns, and code style.
- `0.60-0.79`: Multiple useful signals, but some ambiguity remains.
- `0.40-0.59`: Weak or mixed signals.
- `0.00-0.39`: Insufficient evidence; usually classify as `Unknown`.

Lower confidence when:

- The commit combines many unrelated changes.
- The author has a consistent personal style that resembles generated code.
- The file is standard framework boilerplate.
- The change is mostly formatting or dependency lockfile churn.
- The repository has insufficient history.

## Output Format

```markdown
# AI Contribution Report

## Repository Summary

- Total LOC Analyzed:
- AI Generated LOC Estimate:
- Human Written LOC Estimate:
- Mixed LOC Estimate:
- Unknown LOC Estimate:
- Estimated AI %:
- Estimated Human %:
- Overall Confidence:

## Developer Breakdown

| Developer | Commits | Human LOC | AI LOC | Mixed LOC | Unknown LOC | AI % | Confidence |
|---|---:|---:|---:|---:|---:|---:|---:|

## Commit-Level Attribution

| Commit | Author | Date | Classification | Confidence | Evidence |
|---|---|---|---|---:|---|

## AI-Generated Test Estimate

## AI-Generated Documentation Estimate

## AI-Generated Boilerplate Estimate

## Risk Areas

## Evidence Limits

## Recommended Follow-Ups
```

## Risk Areas To Flag

Flag areas where AI-generated or AI-assisted code may need extra review:

- Authentication or authorization changes
- Payment or billing logic
- Database migrations
- Data deletion or destructive operations
- Security-sensitive parsing
- Generated tests with shallow assertions
- Documentation that may overpromise behavior
- Boilerplate copied without project-specific adaptation

## Reporting Standards

- Use concise evidence bullets.
- Distinguish exact git facts from inferred AI attribution.
- Include command ranges or commit hashes used for analysis.
- Call out excluded directories such as `node_modules`, `dist`, `build`, `.next`, `coverage`, `vendor`, lockfiles, binaries, and generated artifacts.
- State limitations clearly when pull request data or platform metadata is unavailable.

## Skill-Specific References

- references/task-patterns.md - concrete trigger patterns, inputs, procedure, and pitfalls for this exact skill.
- references/verification-matrix.md - proof matrix for deciding which tests, runtime checks, or review evidence are enough.

