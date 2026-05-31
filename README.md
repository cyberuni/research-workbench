# research

Repo-backed research workflows and skills for grounded, durable investigation.

## What this is

`research` is a public skill repo for teams that want an Obsidian-like research workflow, but with the local repository as the source of truth.

It separates:

- durable source registries
- topic-specific research workspaces
- structured evidence per topic
- conclusion documents per topic that inform decisions and agent consumption

## How users use this repo

Most users do not work in this repository directly.

The normal workflow is:

1. Install the skill with `npx skills add cyberuni/research --skill research`
2. Open your own repository in Claude Code, Cursor, Codex, or another agent
3. Ask the agent to do deep research on a topic
4. Commit the resulting files in your repo, including any installed skill files under `.agents/`

Example prompts:

- `Do deep research on this topic`
- `Deep research: what are the tradeoffs of X vs Y?`
- `Thorough investigation of Z and save the results`

## Installed layout in a consuming project

When a team installs this skill project-scoped, the canonical install location is:

- `.agents/skills/research/`

That installed skill directory can include sibling files and folders such as:

- `SKILL.md`
- `README.md`
- `scripts/`
- `assets/`
- `references/`
- `SKILL.project.md`
- `SKILL.local.md`

If the root `skills/research` path exists in the consuming repo, it should be treated as a compatibility symlink back to `.agents/skills/research/`, not as the source of truth.

Project installs may also write:

- `.agents/cyber-skills-lock.json`

## Source repo layout

This repository itself is the source repo that users install from. Its authored layout looks like this:

```text
skills/
  research/
    SKILL.md
    README.md
    governances/
      research-layout.md
      research-conclusion.md
      research-evidence.md
      research-sources.md
    assets/
      templates/
        topic.md
        conclusion.md
        evidence.md
        changes.md
    scripts/
      new-topic.sh
.plugin/
  plugin.json
.research/
  README.md
  _sources/
    README.md
    canonical-sources.md
  <topic-slug>/
    topic.md
    conclusion.md
    evidence.md
    changes.md
```

Important distinction:

- In the source repo, public skills are authored under `skills/`
- In a consuming repo, installed skills live under `.agents/skills/`
- Research artifacts default to `.research/` in the consuming repo and can be overridden per repo
- `governances/`, `assets/`, and `scripts/` live inside the skill directory so they are distributed together with the skill
- When installed in a consuming repo, these files land at `.agents/skills/research/governances/`, `assets/`, and `scripts/`

## Primary skill

The first skill is [`deep-research`](skills/research/README.md). It defines how to:

- plan research before collecting material
- maintain a canonical source registry
- record evidence and changes per topic
- write durable topic notes and conclusion documents per topic
- consume research by reading `conclusion.md` first, then falling back only when needed
- scaffold new topic workspaces with `skills/research/scripts/new-topic.sh`

## Design direction

- Skill-first, not plugin-first
- Repo as storage medium
- Markdown and simple tabular artifacts first
- Search/tool integrations are optional later
