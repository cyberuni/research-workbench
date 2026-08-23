---
name: formulate
activation: per-situation
description: Use this skill when the user wants to work a topic out with you and keep it — thinking through an unformed idea, separating a tangled discussion into distinct topics, researching what a topic turns on, or tracking each topic's decisions, open questions, and next actions.
---

# Formulate

Work a subject from unformed to formulated, with the user, and leave behind one tracked workspace per topic.

Two halves, both required. **Run the session**: engage, separate the topics, resolve what research can resolve. **Record it**: sort the result into entries that outlive the conversation. Skipping the first makes this a transcript service; skipping the second loses the session.

## When to use

- The user wants to think a subject through rather than be answered
- A discussion has tangled several subjects and needs separating
- The user asks what is decided, what is still open, or what to do next on a topic
- A working session — designing, grilling, discovering, planning — has produced conclusions
- A topic already has a workspace and this session adds to it

Not for: ratified decisions with a stable rationale (write an ADR), mission or task state (use the project's plan or issue tracker), a sourced investigation with no decision attached (use `deep-research` directly), or a transcript.

## Part A — Run the session

### 1. Set the frame

Get the subject to one sentence before anything else: **what is being decided, and by when does it matter**. Offer a candidate sentence and let the user correct it; do not interview.

If the user cannot answer what a good outcome looks like, that is the first open question, not a reason to stall.

### 2. Survey what exists

```bash
ls <research-root>/ 2>/dev/null
```

Read the header and `## Open` of any workspace whose slug is close to the subject. Resume rather than restart: an existing settled entry is not up for re-argument unless this session produces a claim that overturns it.

The research root honors `RESEARCH_ROOT` and a `research_root:` value in `SKILL.local.md`; default `.research/`.

### 3. Segregate the topics

One workspace per topic. A topic is a subject with **its own decision to make** — not a section, not a phase, not a subtopic of convenience.

| Signal | Verdict |
| --- | --- |
| Two questions that can resolve independently | Two topics |
| One question whose answer forces the other | One topic |
| Same question, different timescale (now vs later) | One topic; the later part is an `N<n>` |
| Different subject that keeps intruding on this one | Split it out, link it, park it |

Name the split to the user as you make it — "that is a separate topic, I am opening one for it" — and keep going. Do not stop the session to negotiate taxonomy.

Cross-link split topics: each `topic.md` names the others under `## Related`, with the reason they touch.

Create a workspace with:

```bash
bash <skill-dir>/scripts/new-log.sh "<Topic Title>"
```

Emits one JSON object naming `topic_dir` and each file path. Read those paths rather than scraping other output. The slug is the subject argued about, never the date or the session. Never open a second workspace for a topic that has one, and never fork on wording alone.

### 4. Engage

The user is formulating; contribute, do not transcribe.

- State the fork when you see one, with what each branch costs.
- Argue against a proposal you think is wrong, once, with the specific claim you doubt — then record the outcome either way.
- Propose the entry text as the session runs: "that is settled, S3, because X ruled out Y." Confirming a written entry is cheaper than reconstructing one later.
- When the user wants sustained adversarial pressure rather than a partner, hand off to whatever grilling or challenge skill the project provides, then formulate the result.
- Stop engaging when the topic is formulated: every branch has a decision, an open question with a consequence, or an action with a done condition.

### 5. Send out what research can settle

An open question that turns on facts rather than on preference is a research question. Do not argue it — resolve it.

- Run `deep-research` on it, scoped to the question, not to the whole topic.
- Record the result as `L<n>` in the log, citing the research topic's `conclusion.md` path. The log holds the fact and what it changes; the research workspace holds the sources.
- Mark the question `research:` while it is out, and supersede it when the answer lands.

Questions that turn on preference, appetite, or authority go to the user, not to research. If a question is neither — nobody can settle it yet — it stays open with the consequence stated.

## Part B — Record the session

### 6. Sort into five kinds

Every conclusion is exactly one of these. Anything that fits none is conversation, not content — drop it.

| Kind | Id | Bar it must clear |
| --- | --- | --- |
| **Settled** | `S<n>` | A decision, plus the argument that produced it, plus what it rules out |
| **Learned** | `L<n>` | A fact established this session that was not known at the start |
| **Rejected** | `R<n>` | A proposal, and the specific reason it failed |
| **Open** | `Q<n>` | A question, plus what breaks if it resolves badly |
| **Next** | `N<n>` | An action with a stated done condition |

### 7. Assign ids and relations

Ids make the log liftable into a graph later without re-reading prose. Record relations as fields at write time; never reconstruct them afterwards.

- Ids are **stable and never reused**. Allocate the next free number per kind; a retired entry's id stays retired.
- `rules-out:` on a settled entry — what the decision eliminates.
- `load-bearing:` on a settled entry — `yes` if expensive to unwind, `no` if cheap, `unknown` where the session did not establish which.
- `supersedes:` on a rejected entry — the id it overturned.
- `blocks:` on an open question — the `N<n>` ids it gates.
- `research:` on an open question — the research topic slug that will answer it.
- `topic:` on any entry that depends on a decision in another workspace — `<slug>#<id>`.

Omit a field rather than writing an empty one.

### 8. Apply the bars

- A decision without its argument is not settled — it will be re-derived. Record the reasoning or move it to Open.
- A decision the user agreed to under challenge records **which specific claim failed**, not that agreement was reached.
- An open question states the consequence of a bad resolution. Without one it belongs in Next or nowhere.
- Rejections are the highest-value entries. Record every proposal that was argued down, including your own.
- Action items name the artifact they change. "Think about X" is an open question, not an action.
- Supersede rather than delete: when this session overturns an entry, move it to Rejected with the reason it fell and a `supersedes:` pointing at its old id.
- An entry belongs to the topic whose decision it serves. Duplicating one across two workspaces is a sign the split was wrong.

### 9. Write and record

Update `log.md`, then append one dated block to `changes.md` naming entries added and entries superseded.

Preserve entries the session did not touch. Rewrite an entry only when this session changed it, and bump `**Updated:**` in the log header.

### 10. Report

Emit to the user, not only to the file. Per topic touched:

1. What changed — new settled, new rejected, entries superseded
2. The Next list in priority order
3. The single most load-bearing open question, and who or what can settle it

When several topics were touched, lead with one roll-up of every open question and next action across them, then the per-topic detail. Derive the roll-up by reading the workspaces; never keep a second copy of it on disk.

Commit each workspace on its own, following the project's commit discipline.

## Anti-patterns

- Answering the subject instead of formulating it with the user
- Summarizing the conversation instead of extracting conclusions
- One workspace holding two independent decisions, or one decision split across two
- Halting the session to negotiate the topic split
- Arguing a question that sources could settle, or researching a question that is pure preference
- Recording a decision without the argument, or agreement without the failed claim
- Reusing an id, or renumbering entries to close gaps
- Relations written as prose instead of fields
- An Open section used as a dumping ground for anything unresolved
- Action items with no done condition
- A cross-topic index file that duplicates what the logs already hold
- Deleting an overturned entry instead of moving it to Rejected
