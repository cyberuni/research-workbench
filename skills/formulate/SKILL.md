---
name: formulate
activation: per-situation
description: Use this skill when capturing a design or research session into a log of decisions, open questions, and next steps.
---

# Formulate

Apply when a working session — designing, grilling, discovering, planning — has produced conclusions that must outlive the conversation.

## When to use

- The user asks to capture, record, log, or write up what was worked out
- A design discussion reaches a conclusion, or is being paused mid-argument
- The user asks what was decided, what is still open, or what to do next
- A prior log exists for the topic and the session has added to it

Not for: ratified decisions with a stable rationale (write an ADR), mission or task state (use the project's plan or issue tracker), sourced investigation (use `deep-research`), or a transcript.

## Workflow

### 1. Locate the log

A log is a topic workspace under the research root holding `topic.md`, `log.md`, and `changes.md`. It is a peer of a research topic, not a kind of one: it carries no `conclusion.md`, because what it records is what was **rejected** as much as what was concluded.

Check for an existing workspace before creating one:

```bash
ls .research/ 2>/dev/null
```

| Found | Action |
| --- | --- |
| A workspace for this topic | Merge into its `log.md`. Never open a second workspace for one topic |
| A near-miss slug for the same subject | Merge into the existing one; do not fork on wording |
| Nothing | Create it with the script below |

```bash
bash <skill-dir>/scripts/new-log.sh "<Topic Title>"
```

Emits one JSON object naming `topic_dir` and each file path. Read those paths rather than scraping other output. The research root honors `RESEARCH_ROOT` and a `research_root:` value in `SKILL.local.md`.

Topic slug is the subject argued about, never the date or the session.

### 2. Sort the session into five kinds

Every conclusion is exactly one of these. Anything that fits none is conversation, not content — drop it.

| Kind | Id | Bar it must clear |
| --- | --- | --- |
| **Settled** | `S<n>` | A decision, plus the argument that produced it, plus what it rules out |
| **Learned** | `L<n>` | A fact established this session that was not known at the start |
| **Rejected** | `R<n>` | A proposal, and the specific reason it failed |
| **Open** | `Q<n>` | A question, plus what breaks if it resolves badly |
| **Next** | `N<n>` | An action with a stated done condition |

### 3. Assign ids and relations

Ids make the log liftable into a graph later without re-reading prose. Record relations as fields at write time; never reconstruct them afterwards.

- Ids are **stable and never reused**. Allocate the next free number per kind; a retired entry's id stays retired.
- `rules-out:` on a settled entry — what the decision eliminates.
- `load-bearing:` on a settled entry — `yes` if expensive to unwind, `no` if cheap, `unknown` where the session did not establish which.
- `supersedes:` on a rejected entry — the id it overturned.
- `blocks:` on an open question — the `N<n>` ids it gates.

Omit a field rather than writing an empty one.

### 4. Apply the bars

- A decision without its argument is not settled — it will be re-derived. Record the reasoning or move it to Open.
- A decision the user agreed to under challenge records **which specific claim failed**, not that agreement was reached.
- An open question states the consequence of a bad resolution. Without one it belongs in Next or nowhere.
- Rejections are the highest-value entries. Record every proposal that was argued down, including the assistant's own.
- Action items name the artifact they change. "Think about X" is an open question, not an action.
- Supersede rather than delete: when this session overturns an entry, move it to Rejected with the reason it fell and a `supersedes:` pointing at its old id.

### 5. Write and record

Update `log.md`, then append one dated block to `changes.md` naming entries added and entries superseded.

Preserve entries the session did not touch. Rewrite an entry only when this session changed it, and bump `**Updated:**` in the log header.

### 6. Report

Emit to the user, not only to the file:

1. What changed this session — new settled, new rejected, entries superseded
2. The Next list in priority order
3. The single most load-bearing open question

Commit the workspace on its own, following the project's commit discipline.

## Anti-patterns

- Summarizing the conversation instead of extracting conclusions
- Recording a decision without the argument, or agreement without the failed claim
- Reusing an id, or renumbering entries to close gaps
- Relations written as prose instead of fields
- An Open section used as a dumping ground for anything unresolved
- Action items with no done condition
- A second workspace for a topic that already has one
- Deleting an overturned entry instead of moving it to Rejected
