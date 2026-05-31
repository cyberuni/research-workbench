# Research

This directory stores durable research artifacts in the repository.

## Structure

| Path | Purpose |
| --- | --- |
| `_sources/` | Long-lived source registries and watchlists shared across topics |
| `_templates/` | Reusable file templates for new topic workspaces |
| `<topic-slug>/` | One topic workspace with investigation, synthesis, evidence, and changes |

## Workflow

1. Start from `_sources/` and identify the source angles that matter.
2. Create a new topic directory from `_templates/`.
3. Investigate in `topic.md`, collect evidence in `evidence.csv`, and keep the current answer in `synthesis.md`.
4. Append meaningful updates to `changes.md`.

## Example

```text
docs/research/
  _sources/
    canonical-sources.md
  _templates/
    topic.md
    synthesis.md
    evidence.csv
    changes.md
  model-context-protocol/
    topic.md
    synthesis.md
    evidence.csv
    changes.md
```
