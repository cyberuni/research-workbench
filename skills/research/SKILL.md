---
name: deep-research
description: "Use this skill when the user explicitly asks for deep research, thorough investigation, or structured multi-source analysis on a topic — not for quick lookups or casual research requests."
triggers:
  - "deep research"
  - "thorough research"
  - "structured research"
---

# Deep Research Workbench

Use the local repository as the durable research workspace.

Default research root: `.research/`

Override it per repository by adding a line like `research_root: research` to `SKILL.local.md`.

## When to use

Use this skill when the user asks for **deep research**, **thorough investigation**, or a **structured multi-source analysis**. Do not trigger for casual "research this" or quick lookup requests — those don't need the full workbench.

Signs the full workbench is warranted:

- durable source tracking rather than ephemeral browsing
- cross-checking across multiple source types
- structured notes that can be reviewed in git
- a conclusion that can later support design, policy, or implementation decisions

## Modes

- **Draft mode** (default): research in a temp folder, present results inline, iterate with user, offer to save when satisfied.
- **Update mode**: load existing research from `<research-root>/`, re-investigate for new info or contradictions, present what changed inline, offer to write changes back.
- **Durable mode**: write directly to `<research-root>/`. Use when the user says to save from the start, or when the research is large enough that it will take multiple sessions to complete.
- **Consumer mode**: read `conclusion.md` first. Read `topic.md`, `evidence.md`, or `changes.md` only when the conclusion is insufficient, contested, or stale.

### Choosing the mode

Use **Consumer mode** when the user is asking about or referencing existing research (e.g., "what did we find about X?", "summarize the conclusion on Y", "is there prior research on Z?").

Use **Update mode** when the user wants to revisit, refresh, or re-run existing research (e.g., "check for new info on X", "any contradictions since we last looked?", "update the research on Y").

Otherwise, start in **Draft mode** unless any of these are true:
- The user explicitly asks to save or store the research.
- The research scope is broad enough that it will clearly span multiple sessions.

In **Draft mode**:
1. Use a system temp directory (e.g., `/tmp/research-<topic-slug>/`) for all artifacts.
2. Present the conclusion and open questions inline in the response.
3. Iterate: ask the user if they have feedback, corrections, or want open questions explored further.
4. When the result is good, ask: "Want me to save this research to `.research/<topic-slug>/`?"
5. On confirmation, copy artifacts from temp to `<research-root>/` and commit.

In **Update mode**:
1. Read existing artifacts from `<research-root>/<topic-slug>/`.
2. Re-investigate: look for new sources, changed information, or claims that now contradict the prior conclusion.
3. Present what is new or changed inline. Highlight contradictions or confidence shifts.
4. Iterate with the user on any open questions.
5. When the result is good, ask: "Want me to write these updates back to `.research/<topic-slug>/`?"
6. On confirmation, update the artifacts in place and append to `changes.md`, then commit.

## Storage Model

Use these locations:

- `<research-root>/_sources/` for durable source registries and watchlists
- `<skill-dir>/assets/templates/` for reusable topic file templates
- `<research-root>/<topic-slug>/topic.md` for the working investigation record
- `<research-root>/<topic-slug>/conclusion.md` for the current best consumable answer
- `<research-root>/<topic-slug>/evidence.md` for structured claims, contradictions, and confidence
- `<research-root>/<topic-slug>/changes.md` for topic-specific update history

Do not collapse all research into one file.

## Workflow

### Draft mode workflow

1. Define the question and scope.
2. Check `<research-root>/_sources/` for relevant canonical sources.
3. Write artifacts to `/tmp/research-<topic-slug>/`.
4. Present the conclusion inline. List any open questions and contradictions.
5. Ask the user for feedback or whether to dig into open questions.
6. Repeat until the user is satisfied.
7. Ask: "Want me to save this research to `.research/<topic-slug>/`?"
8. On yes: copy artifacts to `<research-root>/` and commit.

### Update mode workflow

1. Read existing artifacts from `<research-root>/<topic-slug>/`.
2. Identify the prior conclusion, open questions, and evidence gaps.
3. Re-investigate: search for new sources, changed positions, or claims that now contradict the record.
4. Present a diff-style summary inline: what is confirmed, what is new, what now contradicts prior findings.
5. Ask the user for feedback or whether to explore any new open questions.
6. Repeat until the user is satisfied.
7. Ask: "Want me to write these updates back to `.research/<topic-slug>/`?"
8. On yes: update artifacts in place, append a dated entry to `changes.md`, and commit.

### Durable mode workflow

1. Define the question and scope before collecting sources.
2. Check `<research-root>/_sources/` for relevant canonical sources and note which source angles must be covered.
3. Create a new topic directory with `bash <skill-dir>/scripts/new-topic.sh "<Topic Title>"` or update an existing one.
4. Record evidence in `<research-root>/<topic-slug>/evidence.md` as claims are gathered.
5. Capture contradictions, weak evidence, and open questions explicitly.
6. Write or refresh `<research-root>/<topic-slug>/conclusion.md` when the findings are stable enough to summarize.
7. Append material changes to `<research-root>/<topic-slug>/changes.md`.

Load shared contracts from the skill directory:

- `governances/research-layout.md`
- `governances/research-conclusion.md`
- `governances/research-evidence.md`
- `governances/research-sources.md`

## Source Rules

- Prefer primary sources when available.
- Use multiple independent source angles for important claims.
- Distinguish source type: official docs, maintainers, research groups, foundations, code, issue threads, discussions, benchmarks, postmortems.
- Mark uncertain or conflicting claims instead of smoothing them over.

## Topic Workspace Structure

Each topic should live in its own directory under `<research-root>/`:

```text
<research-root>/<topic-slug>/
  topic.md
  conclusion.md
  evidence.md
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

Use `evidence.md` with one section per claim or evidence item.

Each evidence entry should capture:

- claim ID
- date
- status
- confidence
- source label
- source URL
- source type
- notes

If a claim is later overturned or weakened, update the row rather than silently replacing the conclusion elsewhere.

## Conclusion Rules

Each `conclusion.md` should state:

- the question being answered
- the current verdict
- confidence
- the strongest supporting evidence
- the strongest weakening or contradictory evidence
- what is not supported
- where evidence is thin
- what should be checked again later

Treat `conclusion.md` as the main consumption surface. It should be a complete, condensed verdict of the research rather than a teaser that forces the reader into other files.

## Change Log Rules

Each `changes.md` entry should capture:

- date
- what changed
- why it changed
- whether the conclusion changed materially
- which evidence or source triggered the update
