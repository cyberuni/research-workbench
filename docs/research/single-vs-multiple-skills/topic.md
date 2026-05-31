# Single vs Multiple Skills (May 2026)

## Question

When should a capability be one skill like `research-workbench` versus several skills such as `consume-research`, `review-research`, `update-research`, or `start-research`?

## Scope

In scope:

- Common Reuse Principle
- user-facing trigger clarity
- shared contracts across related skills
- when to split author and consumer workflows

Out of scope:

- detailed marketplace ranking strategy
- tool-specific monetization or branding decisions

## Source angles

- skill-package structure
- plugin/package boundaries
- multi-skill workflow examples
- consumer versus author workflow separation

## Findings

### A single skill is better when the user intent is still one coherent workflow

`research-workbench` currently covers one coherent domain situation: grounded research in a repository. Authoring and consuming are two modes of the same workflow, not yet two clearly different products.

### Multiple skills become justified when triggers, inputs, or outputs diverge

Separate skills become useful when they:

- activate from different user intents
- operate on different artifacts
- need different success criteria
- are reusable independently

### Shared contracts reduce the risk of over-splitting

If future skills do emerge, shared governances for layout, synthesis, evidence, and sources allow them to stay consistent without copying rules into each skill.

### Pipelines and skillsets are evidence for splitting only when coordination overhead is real

The trading repo shows that a skillset is worthwhile when multiple agents, queues, or promotion stages are present. That is not yet true for `research-workbench`.

## Contradictions

- Splitting consumption into its own skill can improve clarity, but it can also create unnecessary fragmentation if readers and authors still operate on the same topic workspace.

## Open questions

- At what point does `consume-research` become different enough from `research-workbench` to justify its own skill?
- Should `start-research` exist only if topic bootstrapping becomes deterministic enough to script?
- Should an eventual `review-research` focus on QA findings rather than authoring?

## Sources consulted

- `vercel-labs/skills` — public skill packaging norms
- `unisonventures/trading` `knowledge-pipeline` — example of multi-skill workflow coordination
- local `research-workbench` design decisions and governances
