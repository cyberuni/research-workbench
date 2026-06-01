# research-workbench

An agent plugin that ships durable research workflows and community post authoring for AI coding agents.

## What this is

`research-workbench` is a public agent plugin. It ships two skills — `deep-research` and `community-post` — that work across Claude Code, Codex, Cursor, and other agent runtimes that support the plugin format.

Skills work in draft mode by default: results are shown inline and nothing is written to disk unless you confirm. When saved, research artifacts land in `.research/` in the consuming repo.

## Skills

### `deep-research`

A structured, multi-source research workflow. Separates:

- durable source registries
- topic-specific research workspaces
- structured evidence per topic
- conclusion documents per topic that inform decisions and agent consumption

Invoke it with:

- `Do deep research on this topic`
- `Deep research: what are the tradeoffs of X vs Y?`
- `Thorough investigation of Z and save the results`

See [`skills/deep-research/README.md`](skills/deep-research/README.md) for full details.

### `community-post`

Research a topic and produce a post as a durable artifact — GitHub issue, GitHub discussion, Discord message, Reddit/X post, or Asana task. Runs `deep-research` first (or reads existing research), then drafts and files the post.

## Install

```bash
npx skills add cyberuni/research-workbench
```

This installs the plugin under `.agents/plugins/research-workbench/` in your repo.

Skills are invoked by name in each runtime:

| Runtime | Invocation |
|---|---|
| Claude Code | `/deep-research` · `/community-post` (plugin shown parenthetically) |
| Codex CLI | `$deep-research` · `$community-post` |
| Cursor | `/deep-research` · `/community-post` |
| GitHub Copilot | `/deep-research` · `/community-post` |
| Windsurf | `@deep-research` · `@community-post` |

## Research artifact layout

When research is saved, artifacts land under `.research/` in the consuming repo:

```text
.research/
  _sources/          # durable source registries
  <topic-slug>/
    topic.md         # working investigation record
    conclusion.md    # current best consumable answer
    evidence.md      # structured claims and confidence
    changes.md       # update history
```

`conclusion.md` is the primary consumption surface — read it first before falling back to other files.

## Plugin manifests

Skills live in `skills/`. Each runtime reads from its own manifest directory:

| Runtime | Manifest location |
|---|---|
| Claude Code / GitHub Copilot | `.claude-plugin/plugin.json` |
| Codex CLI | `.codex-plugin/plugin.json` |
| Cursor | `.cursor-plugin/plugin.json` |

All manifests declare `"skills": "skills/"` to point at the shared skill definitions.
