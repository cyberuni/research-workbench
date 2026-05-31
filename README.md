# research-workbench

Repo-backed research workflows and skills for grounded, durable investigation.

## What this is

`research-workbench` is a public skill repo for teams that want an Obsidian-like research workflow, but with the local repository as the source of truth.

It separates:

- durable source registries
- topic-specific research workspaces
- structured evidence per topic
- synthesis documents per topic that inform decisions and agent consumption

## Initial layout

```text
skills/
  research-workbench/
governances/
  research-layout.md
  research-synthesis.md
  research-evidence.md
  research-sources.md
assets/
  templates/
    topic.md
    synthesis.md
    evidence.md
    changes.md
scripts/
  new-topic.sh
.plugin/
  plugin.json
docs/
  research/
    README.md
    _sources/
      README.md
      canonical-sources.md
    <topic-slug>/
      topic.md
      synthesis.md
      evidence.md
      changes.md
```

## Primary skill

The first skill is [`research-workbench`](skills/research-workbench/README.md). It defines how to:

- plan research before collecting material
- maintain a canonical source registry
- record evidence and changes per topic
- write durable topic notes and synthesis summaries per topic
- consume research by reading `synthesis.md` first, then falling back only when needed
- scaffold new topic workspaces with `scripts/new-topic.sh`

## Design direction

- Skill-first, not plugin-first
- Repo as storage medium
- Markdown and simple tabular artifacts first
- Search/tool integrations are optional later
