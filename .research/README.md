# Research

This directory stores durable research artifacts in the repository.

## Structure

| Path | Purpose |
| --- | --- |
| `_sources/` | Long-lived source registries and watchlists shared across topics |
| `<topic-slug>/` | One topic workspace. A research topic holds investigation, conclusion, evidence, and changes; a design log holds the question, the log, and changes |

## Workflow

1. Start from `_sources/` and identify the source angles that matter.
2. Create a new topic directory with `bash skills/deep-research/scripts/new-topic.sh "<Topic Title>"`.
3. Investigate in `topic.md`, collect evidence in `evidence.md`, and keep the current answer in `conclusion.md`.
4. Append meaningful updates to `changes.md`.

## Example

```text
.research/
  _sources/
    canonical-sources.md
  model-context-protocol/
    topic.md
    conclusion.md
    evidence.md
    changes.md
```

## Index

| Topic | Question |
| --- | --- |
| [great-research-agent-extensions](great-research-agent-extensions/conclusion.md) | What makes a strong research-oriented agent extension or skill package for Claude, Cursor, Codex, or similar agent runtimes? |
| [single-vs-multiple-skills](single-vs-multiple-skills/conclusion.md) | When should a capability be one skill versus several (consume, review, update, start)? |
| [skill-namespacing-across-agent-runtimes](skill-namespacing-across-agent-runtimes/conclusion.md) | When a human explicitly invokes a skill, what syntax do they type, and does it change for plugin vs. standalone skills? |
