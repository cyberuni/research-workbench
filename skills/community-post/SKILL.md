---
name: community-post
description: "Use this skill when contributing a design proposal to an open-source community — research, draft with evidence, file."
---

# Community Post

## When to use

When you have a design decision or architectural insight and want to contribute it upstream — as a GitHub issue, RFC, or discussion post — with evidence, community context, and counterarguments addressed.

## Modes

This skill operates in three modes depending on what research exists:

- **New** — no prior research exists. Run the `deep-research` skill first (durable mode), then draft the post from the resulting artifacts.
- **Existing** — research already lives in `.research/<topic-slug>/`. Read `conclusion.md` and `evidence.md` directly; skip to step 4.
- **Follow-up** — a post has already been filed and new research updates exist. Run the `deep-research` skill in update mode, then draft a follow-up post referencing the original issue URL.

Choose the mode by checking whether `.research/<topic-slug>/` exists and whether a prior issue URL is recorded in `conclusion.md`.

## Steps

### 1. Identify the primary venue

Pick the repo where the standard is actively being *defined*, not where it is discussed in aggregate. Filing in a spec repo is more impactful than filing in a community forum or issue tracker that explicitly defers decisions elsewhere.

Signal for the right venue: maintainers there are empowered to merge normative spec changes based on the issue.

### 2. Research existing discussions

Search the target repo and related community repos for prior issues, PRs, and threads on the same topic. For each find, record:

- Issue/PR number and URL
- Author handle (for `@mention` later)
- The core claim or proposal
- Current status (open, closed, merged, stalled)
- Whether it agrees with, partially overlaps with, or contradicts your proposal

Aim for 3–5 direct prior-art references. Stop when additional searches return nothing new.

### 3. Categorize positions

Separate what you found into two groups:

**Agreements** — issues/comments that independently converge on the same conclusion or identify the same problem. These are your supporting evidence; cite them directly.

**Counterarguments** — objections, alternative proposals, or explicit disagreements. Do not ignore them. For each, determine whether it is:
- Fully addressed by your proposal (state how)
- Partially addressed (acknowledge the gap)
- Out of scope (say so without dismissing it)

### 4. Save research with the deep-research workbench

Do not create a `docs/research/YYYY-MM-<topic>.md` file. Instead:

1. Use the `deep-research` skill to produce or update the topic workspace at `.research/<topic-slug>/`.
2. The research must capture, at minimum:
   - Author handles (`@username`) for every prior-art reference found in steps 2–3
   - Community position table (agreements vs. counterarguments)
   - Open questions and confidence level
3. `conclusion.md` becomes the primary input for drafting the post (step 5). Read it in full before writing anything.
4. After the post is filed, append the live issue URL to `conclusion.md` under a `## Filed` section.

### 5. Draft the post

Structure:

1. **Opening** (2–3 sentences) — acknowledge what the project already got right before stating the problem. Establishes credibility and good faith.
2. **Ideas** (not "Positions" or "Demands") — one section per idea, each with a concrete example (code, table, or quote).
3. **What I'd love to see clarified** — a numbered list of specific, actionable asks. Use "Clarify" or "Recommend", not "Must" or "Require".
4. **Prior art and community support** — bullet list, one per reference, with `@handle` for authors.
5. **Anticipated pushback — and my take** — address each known objection directly. Acknowledge before countering.
6. **Closing** (2 sentences) — offer to contribute spec language; end with an open question to invite dialogue.

### 6. Calibrate the tone

Apply throughout the post:

| Area | Do | Avoid |
| --- | --- | --- |
| **General register** | Casual, collegial — "feels like", "I think", "Sharing in case it's useful" | Formal position papers, "I propose that the spec shall" |
| **Technical positions** | Firm and specific — blockquotes, tables, concrete JSON examples | Hedging technical claims with "maybe" or "possibly" |
| **Objection responses** | Open with acknowledgment — "Fair concern." / "Agreed —" before the counter | Terse or dismissive rebuttals |
| **Voice** | First-person singular — "I", "I'm already shipping…" | "We" unless writing on behalf of a named team |
| **Author handles** | `@username` on all referenced authors so GitHub notifies them | Bare usernames that don't trigger notifications |
| **Closing** | End with a question that opens dialogue | Ending on a demand or deadline |

### 7. Final review before filing

Check:
- [ ] Title is firm and specific (the proposal is clear, even if the body is humble)
- [ ] Every referenced issue has a link and `@handle`
- [ ] No "we" when writing as an individual
- [ ] Counterarguments section addresses every objection found in step 3
- [ ] Closing includes an offer to contribute and an open question
- [ ] Own repo or implementation is mentioned to show skin in the game

### 8. File

```bash
gh issue create \
  --repo <org>/<repo> \
  --title "<title>" \
  --body "$(cat <<'BODY'
<post body>
BODY
)"
```

Capture the URL from stdout and update `conclusion.md` with a link to the live issue under a `## Filed` section.

## Anti-patterns

- **Filing in the discussion forum instead of the spec repo** — gets acknowledged but never acted on.
- **Listing objections without addressing them** — makes the proposal look incomplete; maintainers will raise them in comments anyway.
- **"Position 1 / Position 2" headings** — sounds like a formal debate brief; use "Idea 1 / Idea 2" instead.
- **Ending with demands** — "the spec MUST add this" closes the conversation; "I'd love to see this clarified" opens it.
- **Skipping the prior art section** — wastes maintainer time and signals you haven't read the existing discussions.
- **Cross-posting to multiple venues simultaneously** — pick the primary venue; cross-reference from secondary venues after the primary issue is live.
