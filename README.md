# research-workbench

Repo-backed research workflows and skills for grounded, durable investigation.

## What this is

`research-workbench` is a public skill repo for teams that want an Obsidian-like research workflow, but with the local repository as the source of truth.

It separates:

- durable source registries
- topic-specific research workspaces
- structured evidence per topic
- synthesis documents per topic that inform decisions and agent consumption

## How users use this repo

Most users do not work in this repository directly.

The normal workflow is:

1. Install the skill with `npx skills add cyberuni/research-workbench --skill research-workbench`
2. Open your own repository in Claude Code, Cursor, Codex, or another agent
3. Ask the agent to use the `research-workbench` skill
4. Commit the resulting files in your repo, including any installed skill files under `.agents/`

Example prompts:

- `Use the research-workbench skill to set up research for this topic`
- `Create a new research topic workspace for this repo`
- `Use the research-workbench workflow and save the evidence locally`

## Installed layout in a consuming project

When a team installs this skill project-scoped, the canonical install location is:

- `.agents/skills/research-workbench/`

That installed skill directory can include sibling files and folders such as:

- `SKILL.md`
- `README.md`
- `scripts/`
- `assets/`
- `references/`
- `SKILL.project.md`
- `SKILL.local.md`

If the root `skills/research-workbench` path exists in the consuming repo, it should be treated as a compatibility symlink back to `.agents/skills/research-workbench/`, not as the source of truth.

Project installs may also write:

- `.agents/cyber-skills-lock.json`

## Source repo layout

This repository itself is the source repo that users install from. Its authored layout looks like this:

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

Important distinction:

- In the source repo, public skills are authored under `skills/`
- In a consuming repo, installed skills live under `.agents/skills/`
- `governances/`, `assets/`, and `scripts/` here describe source-repo content, not a shared `.agents/governances/` or `.agents/assets/` install tree
- If assets or scripts are needed at runtime for an installed skill, they should live inside that installed skill directory under `.agents/skills/<name>/...`

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
