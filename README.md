# research-workbench

Repo-backed research workflows and skills for grounded, durable investigation.

## What this is

`research-workbench` is a public skill repo for teams that want an Obsidian-like research workflow, but with the local repository as the source of truth.

It separates:

- durable source registries
- topic-specific research notes
- structured evidence logs
- synthesis documents that inform decisions

## Initial layout

```text
skills/
  research-workbench/
docs/
  research/
    README.md
    sources/
      README.md
      canonical-sources.md
    topics/
      README.md
    evidence/
      README.md
      evidence.csv
    syntheses/
      README.md
```

## Primary skill

The first skill is [`research-workbench`](skills/research-workbench/README.md). It defines how to:

- plan research before collecting material
- maintain a canonical source registry
- record claims and counterclaims in structured form
- write durable topic notes and synthesis summaries

## Design direction

- Skill-first, not plugin-first
- Repo as storage medium
- Markdown and simple tabular artifacts first
- Search/tool integrations are optional later
