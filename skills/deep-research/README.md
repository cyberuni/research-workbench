# deep-research

Run thorough, structured research in a repository with one durable workspace per topic and a conclusion-first consumption model.

## When to use

Use this skill when you want a rigorous, multi-source research workflow where the repository is the system of record. Not for quick lookups — for deep investigation.

Good triggers include:

- "Do deep research on this topic"
- "Deep research: what are the tradeoffs of X vs Y?"
- "Thorough investigation of Z and save the results"
- "Set up a reusable source registry"
- "Cross-check sources before writing a conclusion"

## What it does

The skill standardizes:

- canonical source registries
- one topic directory per research question
- structured evidence notes per topic
- conclusion and change history per topic
- `conclusion.md` as the default file consuming agents should read
- a small scaffold script for new topic workspaces

## Default storage

By default, the skill stores durable research artifacts under:

```text
.research/
```

Override the root per repository by adding a line like this to `SKILL.local.md`:

```text
research_root: research
```

## Install

```bash
npx skills add cyberuni/research-workbench --skill deep-research
```
