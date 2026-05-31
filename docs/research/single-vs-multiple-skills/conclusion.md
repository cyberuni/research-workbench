# Single vs Multiple Skills Conclusion

## Question

When should a capability be one skill like `research-workbench` versus several skills such as `consume-research`, `review-research`, `update-research`, or `start-research`?

## Verdict

Use a single skill when the user intent, artifact model, and success criteria still form one coherent workflow. `research-workbench` is currently in that category. A user who wants to start research, update research, or consume a conclusion is still interacting with the same topic-centric workspace and the same underlying contracts.

Split into multiple skills only when the workflows become independently reusable and trigger from different situations. A dedicated `consume-research` skill becomes justified if agent sessions regularly need to read and apply research without performing authoring steps. A `start-research` or `update-research` skill becomes justified when those workflows become deterministic enough to benefit from tighter instructions, scripts, or different acceptance criteria.

## Confidence

Medium

## Strongest support

- `SMS-001` — one coherent repo-backed research workflow currently exists
- `SMS-002` — skill splitting should follow different triggers, inputs, or outputs rather than internal implementation steps
- `SMS-003` — shared governances make future splitting safer without forcing it now

## Strongest counterevidence

- `SMS-004` — multi-skill sets become valuable when coordination overhead, delegation, and promotion stages are part of the normal workflow

## Not supported

- The claim that authoring, updating, reviewing, and consuming should always be different skills from the beginning
- The claim that one large skill should absorb all future workflow divergence indefinitely

## Thin evidence

- We do not yet have repeated real usage data showing whether pure consumer sessions are common enough to justify a dedicated skill
- We do not yet know whether future scripts will naturally cluster around separate start/update/review flows

## Recheck triggers

- Repeated prompts that only consume or review research without authoring
- A growing number of deterministic scripts specific to one sub-workflow
- Diverging success criteria between authoring and consumption tasks
