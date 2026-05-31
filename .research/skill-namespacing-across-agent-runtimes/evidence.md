# Evidence

## Claim E01

Date: 2026-05-31
Status: supports
Confidence: high

Source:
- Label: Claude Code plugin docs
- URL: https://code.claude.com/docs/en/plugins
- Type: official documentation

Notes:
- Confirms `/plugin-name:skill-name` format for plugin skills in Claude Code
- Plugin `name` field in `plugin.json` sets the namespace prefix
- Standalone skills in `.claude/skills/` use `/skill-name` with no prefix
- Explicitly states: "namespacing prevents conflicts between plugins"

## Claim E02

Date: 2026-05-31
Status: supports
Confidence: high

Source:
- Label: Codex CLI skills docs
- URL: https://developers.openai.com/codex/skills
- Type: official documentation

Notes:
- Confirms `$skill-name` as explicit invocation syntax
- Plugin-bundled skills surface under same `$name` — no visible prefix in invocation
- `/skills` or `$` can be typed to browse available skills

## Claim E03

Date: 2026-05-31
Status: supports
Confidence: medium

Source:
- Label: Codex CLI Plugin System blog post
- URL: https://codex.danielvaughan.com/2026/03/30/codex-cli-plugin-system/
- Type: community/unofficial

Notes:
- Claims plugin skills use `plugin-name:skill-name` namespace internally
- Claims marketplace disambiguation uses `$PLUGIN_NAME@$MARKETPLACE_NAME`
- Neither form appears in official invocation docs — may be internal only
- Confidence medium due to unofficial source

## Claim E04

Date: 2026-05-31
Status: supports
Confidence: high

Source:
- Label: GitHub Copilot — Use Agent Skills in VS Code
- URL: https://code.visualstudio.com/docs/copilot/customization/agent-skills
- Type: official documentation

Notes:
- Confirms `/skill-name` as invocation format
- "Do not manually add namespace prefixes to the skill name field. Using prefixes like `myorg/skillname` or `myorg:skillname` causes the skill to silently fail to load."
- Plugin name is used internally for conflict avoidance but not surfaced in invocation

## Claim E05

Date: 2026-05-31
Status: supports
Confidence: high

Source:
- Label: Windsurf Cascade Skills docs
- URL: https://docs.windsurf.com/windsurf/cascade/skills
- Type: official documentation

Notes:
- `@skill-name` is the explicit invocation syntax
- Skill scope (workspace > global > enterprise) determines priority, not a namespace prefix
- No plugin prefix exposed to user

## Claim E06

Date: 2026-05-31
Status: supports
Confidence: medium

Source:
- Label: Antigravity Skills — Google Codelabs
- URL: https://codelabs.developers.google.com/getting-started-with-antigravity-skills
- Type: official tutorial

Notes:
- Primary invocation is natural language (semantic matching against description fields)
- `@skill-name` also accepted as explicit hint
- No distinction between plugin-sourced and standalone in invocation
- Docs do not show a plugin namespacing format

## Claim E07

Date: 2026-05-31
Status: supports
Confidence: medium

Source:
- Label: Gemini CLI Skills docs
- URL: https://geminicli.com/docs/cli/skills/
- Type: official documentation

Notes:
- `/skills` is a management command (list, enable, disable, install, uninstall)
- Invocation is natural language — no explicit `$` or `/` prefix for skill calls
- Skills bundled in extensions use the same invocation as standalone

## Claim E08

Date: 2026-05-31
Status: supports
Confidence: high

Source:
- Label: SEP-986 — Specify Format for Tool Names (MCP)
- URL: https://github.com/modelcontextprotocol/modelcontextprotocol/issues/986
- Type: spec proposal / issue tracker

Notes:
- MCP spec restricts tool names to `^[a-zA-Z0-9_-]{1,64}$`
- Colons and dots are forbidden at the protocol level
- Hosts (Claude Code, Codex, etc.) layer their own prefixing on top of this

## Claim E09

Date: 2026-05-31
Status: mixed
Confidence: high

Source:
- Label: MCP tool naming discrepancy — claude-code #18763
- URL: https://github.com/anthropics/claude-code/issues/18763
- Type: issue tracker

Notes:
- Documents inconsistency within Claude Code itself:
  - Agent SDK uses `mcp__server__tool` (double underscore)
  - Agent Skills / Direct Messages API uses `Server:tool` (colon)
- Colon format violates MCP spec character rules
- Issue closed as "not planned" — no fix committed
