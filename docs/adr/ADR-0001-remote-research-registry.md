# ADR-0001: Remote Research Registry via `_sources/remote-topics.md`

**Status:** Accepted  
**Date:** 2026-06-01

## Context

Research conclusions produced by the deep-research workbench are valuable beyond the project that commissioned them. A survey of the agent runtime landscape, for example, is relevant to any project making infrastructure decisions — not just the one where it was first written.

Several distribution models were considered for sharing research across projects:

**npm package distribution.** Research artifacts bundled as an npm package, distributed via the package registry. Requires a publish step, changeset, and version bump for every update. Adds `package.json` overhead to what is otherwise a plain markdown repo. Semver semantics are meaningful for code; less so for research conclusions that update by date.

**Marketplace installer.** Listing research in a plugin marketplace and having the agent runtime install it alongside skills. The marketplace installer is designed for executable artifacts (skills, hooks, settings). It does not have a protocol for copying declarative knowledge files. Extending it would require changes to each agent runtime's installer — outside the control of this project.

**Standalone GitHub URL.** Pointing directly at a `conclusion.md` file via a raw GitHub URL. Zero infrastructure: no publish step, no package manager. The agent fetches the URL at runtime. Pinning is available via commit SHA or git tag in the URL. Discoverability is the weakness — there is no built-in way to know the URL exists.

**Separate research registry.** A dedicated JSON/YAML manifest in a separate repo listing all published research topics. Adds a new surface to maintain and a new URL for agents to know about. Solves discoverability but at the cost of a second registry system.

## Decision

Extend the deep-research skill with a **project-local remote topic registry**: `<research-root>/_sources/remote-topics.md`.

Each project that wants access to a remotely published research conclusion adds one row to this file — the topic slug, a direct URL to the remote `conclusion.md`, a `valid_until` date, and a short description. Consumer mode checks this file when a topic is not found locally, fetches the URL, and presents the result as if it were local research.

```markdown
| topic | url | valid_until | description |
|-------|-----|-------------|-------------|
| agent-runtime-landscape | https://raw.githubusercontent.com/org/repo/main/.research/agent-runtime-landscape/conclusion.md | 2026-01-01 | Survey of agent execution runtimes. |
```

## Rationale

This design resolves the tension between the four options by separating two concerns that were previously conflated:

- **Delivery** — how the research content reaches the agent at runtime. Answer: URL fetch, done by the skill, not an installer.
- **Discoverability** — how a project learns that a research topic exists. Answer: a curated entry in `_sources/remote-topics.md`, added by a human once.

The marketplace and npm are not needed for delivery. The skill already has the ability to fetch a URL (consumer mode). The only new behavior is: check the local registry file before concluding a topic is absent.

Discoverability is intentionally kept as a human curation step. A marketplace or awesome-list can surface research URLs for humans to find; once found, they add one row to the registry file. This keeps the skill simple and avoids coupling it to any external registry infrastructure.

The `_sources/` directory is the natural home for this file — it already holds durable source registries and watchlists used across topics.

## Consequences

**Positive:**
- No publish step, no package manager, no installer changes required.
- Research repos stay lightweight — plain markdown, no `package.json`.
- Local research always wins; remote is a fallback, never an override.
- Pinning to a specific git ref in the URL gives the same stability guarantees as semver without the overhead.
- The `valid_until` field surfaces staleness explicitly rather than letting old research be consumed silently.

**Negative / accepted tradeoffs:**
- Discoverability is not automatic. A human must find the research URL and add it to `remote-topics.md`. This is intentional — fully automatic discovery would require external registry infrastructure.
- Each project maintains its own `remote-topics.md`. There is no single authoritative list of all published research. A community awesome-list or marketplace index can fill this role externally.
- Consumer mode now has a network dependency (URL fetch) when a local topic is absent. Agents without network access or working in restricted environments will not be able to resolve remote topics.

## Alternatives considered and rejected

**npm distribution** — operational overhead (publish, changeset, version bump) for no delivery benefit over a raw URL. Rejected.

**Marketplace installer extension** — requires changes to each agent runtime's installer. Outside the control of this project. Rejected.

**Separate research registry repo** — adds a second surface to maintain and a second URL for agents to know about. Adds complexity without solving the core problem better than `remote-topics.md`. Rejected.
