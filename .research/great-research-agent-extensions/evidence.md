# Evidence

## Claim GRE-001

Date: 2026-05-30
Status: supports
Confidence: medium

Source:
- Label: local repo working session
- URL: https://github.com/cyberuni/research-workbench
- Type: local-design

Notes:
- Topic-centric workspaces fit screaming architecture better than shared artifact buckets.
- This claim is based on the refactor from shared folders to per-topic directories in this repo.

## Claim GRE-002

Date: 2026-05-30
Status: supports
Confidence: medium

Source:
- Label: working design decision
- URL: https://github.com/cyberuni/research-workbench/blob/main/governances/research-conclusion.md
- Type: governance

Notes:
- Consuming agents should read `conclusion.md` first and only drill into other files when needed.
- This establishes a stronger consumption contract than treating the conclusion as a summary teaser.

## Claim GRE-003

Date: 2026-05-30
Status: supports
Confidence: medium

Source:
- Label: open-plugin-spec and skills packaging direction
- URL: https://github.com/vercel-labs/open-plugin-spec
- Type: plugin-spec

Notes:
- Shared layout and evidence rules should be extracted from `SKILL.md` prose into shared contracts.
- This supports placing normative structure in governances and reusable files in assets.

## Claim GRE-004

Date: 2026-05-30
Status: contradicts
Confidence: medium

Source:
- Label: knowledge-pipeline protocol
- URL: /home/unional/code/unisonventures/trading/.agents/skillsets/knowledge-pipeline/PROTOCOL.md
- Type: local-reference

Notes:
- Multi-agent pipelines are useful when research becomes delegated and queue-driven rather than single-topic and local.
- This is a useful counterexample showing when extra workflow structure is justified.
