# Great Research Agent Extensions Conclusion

## Question

What makes a strong research-oriented agent extension or skill package for Claude, Cursor, Codex, or similar agent runtimes?

## Verdict

A strong research agent extension should optimize first for durable, topic-centric research artifacts and a conclusion-first consumption model, then package that workflow as a skill or plugin. The critical design feature is not a complex pipeline but a reliable contract: each topic should expose a complete `conclusion.md` as the default read surface, with `topic.md`, `evidence.csv`, and `changes.md` available for traceability and updates.

The extension should keep reusable rules out of ad hoc skill prose. Shared layout, conclusion, evidence, and source-registry contracts belong in governances, while templates belong in assets. A neutral plugin manifest is useful early because it makes the package shape explicit without forcing tool-specific behavior.

## Confidence

Medium

## Strongest support

- `GRE-001` — topic-centric workspaces align better with screaming architecture than shared artifact buckets
- `GRE-002` — conclusion-first consumption reduces agent reading cost and ambiguity
- `GRE-003` — shared research contracts are likely to be reused across multiple future skills

## Strongest counterevidence

- `GRE-004` — multi-agent pipelines provide stronger coordination and contradiction handling when the research process becomes queue-driven or delegated

## Not supported

- The claim that every research workflow needs an inbox or explicit multi-stage state machine
- The claim that vendor-specific plugin manifests should be added before any concrete runtime need is validated

## Thin evidence

- Current support for neutral versus vendor-specific manifests outside Codex remains thin
- Real-world examples of research-consumer skills are limited compared to authoring workflows

## Recheck triggers

- A concrete Claude or Cursor plugin runtime requirement that neutral manifests cannot satisfy
- Repeated use cases where agents only consume research and would benefit from a dedicated consumer skill
- Evidence that topic-local `evidence.csv` is too granular or not granular enough in practice
