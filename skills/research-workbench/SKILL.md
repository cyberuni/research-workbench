---
name: research-workbench
description: "Use this skill when doing grounded research in a repository and you want each topic to have a durable local workspace for investigation, evidence, synthesis, and change history."
---

# Research Workbench

Use the local repository as the durable research workspace.

## When to use

Use this skill when the work needs:

- durable source tracking rather than ephemeral browsing
- cross-checking across multiple source types
- structured notes that can be reviewed in git
- a synthesis that can later support design, policy, or implementation decisions

## Storage Model

Use these locations:

- `docs/research/_sources/` for durable source registries and watchlists
- `docs/research/_templates/` for reusable topic file templates
- `docs/research/<topic-slug>/topic.md` for the working investigation record
- `docs/research/<topic-slug>/synthesis.md` for the current best consumable answer
- `docs/research/<topic-slug>/evidence.csv` for structured claims, contradictions, and confidence
- `docs/research/<topic-slug>/changes.md` for topic-specific update history

Do not collapse all research into one file.

## Workflow

1. Define the question and scope before collecting sources.
2. Check `docs/research/_sources/` for relevant canonical sources and note which source angles must be covered.
3. Create or update `docs/research/<topic-slug>/topic.md`.
4. Record evidence in `docs/research/<topic-slug>/evidence.csv` as claims are gathered.
5. Capture contradictions, weak evidence, and open questions explicitly.
6. Write or refresh `docs/research/<topic-slug>/synthesis.md` when the findings are stable enough to summarize.
7. Append material changes to `docs/research/<topic-slug>/changes.md`.

## Source Rules

- Prefer primary sources when available.
- Use multiple independent source angles for important claims.
- Distinguish source type: official docs, maintainers, research groups, foundations, code, issue threads, discussions, benchmarks, postmortems.
- Mark uncertain or conflicting claims instead of smoothing them over.

## Topic Workspace Structure

Each topic should live in its own directory:

```text
docs/research/<topic-slug>/
  topic.md
  synthesis.md
  evidence.csv
  changes.md
```

Use this structure for `topic.md`:

```markdown
# <Topic> (Month YYYY)

## Question

<What is being investigated?>

## Scope

<What is in scope and out of scope?>

## Source angles

- <Angle 1>
- <Angle 2>
- <Angle 3>

## Findings

### <Theme>

<Grounded findings with links back to evidence rows and source files.>

## Contradictions

- <Claim conflict or unresolved disagreement>

## Open questions

- <What still needs follow-up?>

## Sources consulted

- <Source label and URL>
```

## Evidence Log Rules

Each `evidence.csv` row should capture:

- date
- claim_id
- claim
- source label
- source URL
- source type
- confidence
- contradiction status
- notes

If a claim is later overturned or weakened, update the row rather than silently replacing the conclusion elsewhere.

## Synthesis Rules

Each `synthesis.md` should state:

- what the evidence supports
- what it does not support
- where evidence is thin
- what should be checked again later

## Change Log Rules

Each `changes.md` entry should capture:

- date
- what changed
- why it changed
- whether the synthesis changed materially
- which evidence or source triggered the update
