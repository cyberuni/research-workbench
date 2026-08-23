# formulate

Capture a design or research session as a durable log of decisions, open questions, and next steps.

## When to use

- "capture what we worked out"
- "what did we decide?"
- "log this before we stop"
- pausing a design discussion mid-argument
- resuming a topic that already has a log

## What it does

Turns a working conversation into a tracked topic workspace instead of leaving the reasoning in scrollback. Every conclusion is sorted into one of five kinds — settled, learned, rejected, open, next — and each has a bar it must clear: a decision without the argument that produced it is not settled, and an open question without the consequence of a bad resolution is not a question.

The rejected section is the point. It records every proposal that was argued down, with the specific reason it failed, so the same ground is not re-derived later.

Entries carry stable ids and explicit relation fields (`rules-out`, `supersedes`, `blocks`, `load-bearing`), so the log lifts into a graph or an index later without anyone re-reading prose to reconstruct the edges.

A log is a peer of a research topic, sharing the `.research/<topic>/` workspace convention with `deep-research`. It holds `topic.md`, `log.md`, and `changes.md` — and deliberately no `conclusion.md`, since what it records is what was rejected as much as what was concluded.

## Install

```sh
npx skills add cyberuni/research-workbench --skill formulate
```
