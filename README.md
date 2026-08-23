# research-workbench

An agent plugin that ships durable research workflows and community post authoring for AI coding agents.

## What this is

`research-workbench` is a public agent plugin. It ships three skills — `deep-research`, `community-post`, and `formulate` — that work across Claude Code, Codex, Cursor, and other agent runtimes that support the plugin format.

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

### `formulate`

Work a subject out with the user and keep it: engage on the topic, split tangled discussions into one workspace per decision, send fact-shaped questions to `deep-research`, and track each topic's decisions, open questions, and next actions. Where `deep-research` turns sources into a conclusion, `formulate` turns an argument into a record — including every proposal that was argued down and the specific reason it failed, so the same ground is not re-derived.

See [`skills/formulate/README.md`](skills/formulate/README.md) for full details.

## Install

### Claude Code

```bash
claude plugin marketplace add cyberuni/marketplace
claude plugin install research-workbench@cyberuni
```

### Other runtimes

```bash
npx skills add cyberuni/research-workbench
```

This installs the plugin under `.agents/plugins/research-workbench/` in your repo.

Skills are invoked by name in each runtime:

| Runtime | Invocation |
|---|---|
| Claude Code | `/deep-research` · `/community-post` · `/formulate` (plugin shown parenthetically) |
| Codex CLI | `$deep-research` · `$community-post` · `$formulate` |
| Cursor | `/deep-research` · `/community-post` · `/formulate` |
| GitHub Copilot | `/deep-research` · `/community-post` · `/formulate` |
| Windsurf | `@deep-research` · `@community-post` · `@formulate` |

## Research artifact layout

When research is saved, artifacts land under `.research/` in the consuming repo:

```text
.research/
  _sources/          # durable source registries
  <topic-slug>/            # a research topic
    topic.md         # working investigation record
    conclusion.md    # current best consumable answer
    evidence.md      # structured claims and confidence
    changes.md       # update history
  <topic-slug>/            # a design log (peer, not a kind)
    topic.md         # the question being decided
    log.md           # settled, learned, rejected, open, next
    changes.md       # update history
```

`conclusion.md` is the primary consumption surface for a research topic — read it first before falling back to other files. A design log has no `conclusion.md`: what it records is what was rejected as much as what was concluded, so `log.md` is its consumption surface.

## Plugin manifests

Skills live in `skills/`. Each runtime reads from its own manifest directory:

| Runtime | Manifest location |
|---|---|
| Claude Code / GitHub Copilot | `.claude-plugin/plugin.json` |
| Codex CLI | `.codex-plugin/plugin.json` |
| Cursor | `.cursor-plugin/plugin.json` |

All manifests declare `"skills": "skills/"` to point at the shared skill definitions.
