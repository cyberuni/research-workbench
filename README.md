# research-workbench

Repo-backed research workflows and skills for grounded, durable investigation.

## What this is

This is a public skill repo that ships the `deep-research` skill — a structured, multi-source research workflow for agents.

By default the skill works in draft mode: results are shown inline and nothing is written to disk unless the user confirms. When saved, research artifacts land in `.research/` in the consuming repo.

The skill separates:

- durable source registries
- topic-specific research workspaces
- structured evidence per topic
- conclusion documents per topic that inform decisions and agent consumption

## Install

Run this in your own repository:

```bash
npx skills add cyberuni/research-workbench --skill deep-research
```

This installs the skill under `.agents/skills/deep-research/` in your repo.

## Usage

Open your repository in Claude Code, Cursor, Codex, or another agent and ask:

- `Do deep research on this topic`
- `Deep research: what are the tradeoffs of X vs Y?`
- `Thorough investigation of Z and save the results`

If the agent saves the research, commit the resulting files under `.research/`. The skill files under `.agents/` are committed once at install time and don't change per-research.

## Installed layout in a consuming project

When a team installs this skill project-scoped, the canonical install location is:

- `.agents/skills/deep-research/`

That installed skill directory can include sibling files and folders such as:

- `SKILL.md`
- `README.md`
- `scripts/`
- `assets/`
- `references/`
- `SKILL.project.md`
- `SKILL.local.md`

If the root `skills/deep-research` path exists in the consuming repo, it should be treated as a compatibility symlink back to `.agents/skills/deep-research/`, not as the source of truth.

Project installs may also write:

- `.agents/cyber-skills-lock.json`

## Primary skill

The first skill is [`deep-research`](skills/deep-research/README.md). It defines how to:

- plan research before collecting material
- maintain a canonical source registry
- record evidence and changes per topic
- write durable topic notes and conclusion documents per topic
- consume research by reading `conclusion.md` first, then falling back only when needed
- scaffold new topic workspaces with `.agents/skills/deep-research/scripts/new-topic.sh`
