# formulate

Work a subject out with the user, split it into topics, and keep each one as a durable log of decisions, open questions, and next steps.

## When to use

- "help me think this through"
- "capture what we worked out"
- "what did we decide?" / "what's still open?"
- a discussion that has tangled several subjects and needs separating
- pausing a design discussion mid-argument
- resuming a topic that already has a log

## What it does

Runs the session and records it. The agent engages on the subject — states the forks, argues against proposals it doubts, proposes entry text as it goes — rather than transcribing after the fact. Subjects with their own decision to make get their own workspace, cross-linked to the ones they touch. Open questions that turn on facts are handed to `deep-research` and come back as recorded facts pointing at the sources; questions that turn on preference go to the user.

The result is a tracked topic workspace instead of reasoning left in scrollback. Every conclusion is sorted into one of five kinds — settled, learned, rejected, open, next — and each has a bar it must clear: a decision without the argument that produced it is not settled, and an open question without the consequence of a bad resolution is not a question.

The rejected section is the point. It records every proposal that was argued down, with the specific reason it failed, so the same ground is not re-derived later.

Entries carry stable ids and explicit relation fields (`rules-out`, `supersedes`, `blocks`, `load-bearing`, `research`, `topic`), so the log lifts into a graph or an index later without anyone re-reading prose to reconstruct the edges.

A log is a peer of a research topic, sharing the `.research/<topic>/` workspace convention with `deep-research`. It holds `topic.md`, `log.md`, and `changes.md` — and deliberately no `conclusion.md`, since what it records is what was rejected as much as what was concluded.

## Install

```sh
npx skills add cyberuni/research-workbench --skill formulate
```
