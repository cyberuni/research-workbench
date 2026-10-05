# Research Method

How an investigation proceeds from question to conclusion. Applies to Draft, Update, and Durable modes.

## Source angles

An angle is an independent route to the answer: a different source type, community, or vantage point (for example: the spec and its decision record, maintainer issue threads, production postmortems, benchmarks). Two searches against the same kind of source are one angle.

List the planned angles in `topic.md` under `## Source angles` before collecting evidence.

## Stopping rule

- **Start** with 2–3 independent angles.
- **Stop** once 3–4 angles agree. More passes over agreeing sources add cost, not confidence.
- **Continue** when angles conflict: add passes aimed at the conflict until it is explained or clearly irreducible. Record what remains in `topic.md` `## Contradictions` and in the conclusion's strongest-counterevidence section.
- **When findings stay thin**, say so. Do not fill gaps with inference. Record the gap in the conclusion's thin-evidence section and list the follow-ups in `topic.md` `## Open questions` and the conclusion's recheck triggers.

## Per-angle delegation

When the runtime can spawn subagents and the question is broad enough to need several angles, delegate one subagent per angle. Give each its angle, the question and scope from `topic.md`, and ask it to return evidence entries in the `evidence.md` format (see `research-evidence.md`) plus any contradictions it found. For a narrow question or a runtime without subagents, work the angles in turn yourself.

Never delegate synthesis. Merging the angles, weighing contradictions, and writing `conclusion.md` stay with the agent that owns the topic, because the verdict depends on comparing angles no single subagent saw.
