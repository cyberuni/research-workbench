---
name: research-workbench
description: "Use this skill when doing grounded research in a repository and you want durable local artifacts for sources, evidence, topic notes, and synthesis."
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

- `docs/research/sources/` for durable source registries and watchlists
- `docs/research/topics/` for topic-specific research notes
- `docs/research/evidence/evidence.csv` for structured claims, contradictions, and confidence
- `docs/research/syntheses/` for concise outputs that summarize what the evidence currently supports

Do not collapse all research into one file.

## Workflow

1. Define the question and scope before collecting sources.
2. Check `docs/research/sources/` for relevant canonical sources and note which source angles must be covered.
3. Create or update a topic note in `docs/research/topics/YYYY-MM-topic.md`.
4. Record evidence in `docs/research/evidence/evidence.csv` as claims are gathered.
5. Capture contradictions, weak evidence, and open questions explicitly.
6. Write a synthesis in `docs/research/syntheses/YYYY-MM-topic-summary.md` when the findings are stable enough to summarize.

## Source Rules

- Prefer primary sources when available.
- Use multiple independent source angles for important claims.
- Distinguish source type: official docs, maintainers, research groups, foundations, code, issue threads, discussions, benchmarks, postmortems.
- Mark uncertain or conflicting claims instead of smoothing them over.

## Topic Note Structure

Use this structure for `docs/research/topics/YYYY-MM-topic.md`:

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

Each evidence row should capture:

- date
- topic
- claim
- source label
- source URL
- source type
- confidence
- contradiction status
- notes

If a claim is later overturned or weakened, update the row rather than silently replacing the conclusion elsewhere.

## Synthesis Rules

Each synthesis should state:

- what the evidence supports
- what it does not support
- where evidence is thin
- what should be checked again later
