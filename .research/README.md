# Research

This directory stores durable research artifacts in the repository.

## Structure

| Path | Purpose |
| --- | --- |
| `_sources/` | Long-lived source registries and watchlists shared across topics |
| `<topic-slug>/` | One topic workspace with investigation, conclusion, evidence, and changes |

## Workflow

1. Start from `_sources/` and identify the source angles that matter.
2. Create a new topic directory with `bash skills/research/scripts/new-topic.sh "<Topic Title>"`.
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
