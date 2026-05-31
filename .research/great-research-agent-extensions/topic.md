# Great Research Agent Extensions (May 2026)

## Question

What makes a strong research-oriented agent extension or skill package for Claude, Cursor, Codex, or similar agent runtimes?

## Scope

In scope:

- repo-backed research workflows
- plugin versus skill packaging
- research storage structure for durable local consumption and updates
- agent consumption patterns for research outputs

Out of scope:

- domain-specific academic methodology
- hosted research SaaS products
- full multi-agent orchestration systems unless they inform packaging or workflow boundaries

## Source angles

- neutral plugin/package structure
- current agent-skill packaging norms
- existing research workflow examples
- local multi-agent pipeline examples

## Findings

### Package shape matters less than consumption contract

The strongest reusable requirement so far is not the plugin bundle itself, but a strict contract for how research outputs are stored and read. `conclusion.md` needs to be the main consumption surface. Topic-local evidence and change history exist to support verification and updates, not to force every reader into process detail.

### Topic-centric workspaces fit screaming architecture

Shared artifact buckets like `topics/`, `evidence/`, and `conclusions/` hide the main domain. A topic directory with `topic.md`, `conclusion.md`, `evidence.csv`, and `changes.md` keeps each research question visible and coherent.

### Shared contracts should be extracted from skill prose

Rules for layout, conclusion, evidence, and source registries are likely to be reused across future skills. They belong in shared normative files rather than only in one `SKILL.md`.

### Multi-agent pipelines are a useful contrast, not the default

The `knowledge-pipeline` design in the trading repo is useful for contradiction handling, state transitions, and deterministic scripts. It is still heavier than needed for the baseline research-workbench use case.

## Contradictions

- A richer state machine improves coordination, but it can also overfit the workflow and make simple research too bureaucratic.
- Plugin-local vendor manifests improve compatibility, but neutral plugin packaging may be the better default until tool-specific needs appear.

## Open questions

- Should consumer behavior remain inside `research-workbench`, or split into a separate `consume-research` skill later?
- Should vendor-specific manifests beyond Codex be added now or only when validated against real runtimes?
- Should there be a `watchlist.md` in `_sources/` for update-driven research?

## Sources consulted

- `vercel-labs/open-plugin-spec` — neutral packaging direction
- `openai/plugins` — Codex plugin examples
- `vercel-labs/skills` — skill packaging norms
- `unisonventures/trading` `knowledge-pipeline` protocol — multi-agent research pipeline reference
