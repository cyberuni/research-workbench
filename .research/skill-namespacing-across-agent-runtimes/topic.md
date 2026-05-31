# Skill Namespacing Across Agent Runtimes (May 2026)

## Question

How do major agent runtimes handle skill/tool naming conflicts when plugins or multiple sources contribute skills with the same name — specifically from the human invocation perspective?

## Scope

In scope:
- End-user agent tools (Claude Code, Codex CLI, Cursor, GitHub Copilot, Windsurf, Antigravity, Gemini CLI)
- Human-facing invocation syntax: what the user types to explicitly invoke a skill
- How plugin packaging changes the invocation format visible to the user
- Underlying SDK/framework namespacing as secondary context only

Out of scope:
- Implicit/natural-language invocation (agent auto-detects skill from description match)
- Programmatic tool registration in developer SDKs (OpenAI Agents SDK, LangChain, MAF, Google ADK)
- MCP server-level naming (covered in evidence as context)

## Source angles

- Official docs per tool (primary)
- Plugin/skill authoring guides
- Community reports of naming conflicts and workarounds
- MCP spec for underlying character constraints

## Findings

### Human invocation syntax varies by tool

Each runtime chose its own trigger character:

| Tool | Explicit invocation |
|------|-------------------|
| Claude Code | `/skill-name` (standalone and plugin — namespace shown parenthetically in description) |
| Codex CLI | `$skill-name` |
| Cursor | `/skill-name` |
| GitHub Copilot | `/skill-name` |
| Windsurf | `@skill-name` |
| Antigravity | `@skill-name` or natural language |
| Gemini CLI | natural language; `/skills` is management only |

### Plugin namespacing: Claude Code moved to short-form invocation with parenthetical attribution

As of 2026-05-31, Claude Code changed behavior. Plugin skills are now invoked with the short form `/skill-name`, matching all other runtimes. The plugin namespace is shown parenthetically in the skill list description: `/deep-research    (research-workbench) <description>`. This is the "short form as convenience alias" pattern.

Previously, Claude Code required `/research-workbench:deep-research` for plugin skills. That form may still work as the canonical unambiguous form, but the default display and invocation is now the short form.

All tools (Claude Code, Codex, Cursor, Copilot, Windsurf, Antigravity, Gemini) now keep the invocation flat. Claude Code distinguishes itself by showing the source plugin parenthetically for discoverability, while others provide no such attribution.

### GitHub Copilot explicitly forbids manual namespace prefixes in skill names

The Copilot docs state: "Do not manually add namespace prefixes to the skill name field. Using prefixes like `myorg/skillname` or `myorg:skillname` causes the skill to silently fail to load." Plugin-level namespacing exists internally but is not exposed in the invocation.

### Codex CLI has internal namespacing but does not expose it to the user

Plugin skills use a `plugin-name:skill-name` namespace internally for conflict avoidance, but the user invokes with `$skill-name` regardless. A marketplace disambiguation format (`$PLUGIN_NAME@$MARKETPLACE_NAME`) exists for browsing, not invocation.

### MCP spec constrains underlying tool names

MCP tool names must match `^[a-zA-Z0-9_-]{1,64}$` — colons and dots are forbidden. Hosts layer their own prefixing on top. This creates a split within Claude Code itself:
- Agent SDK: `mcp__server__tool`
- Agent Skills / Direct API: `Server:tool` (colon — technically violates MCP spec)

## Contradictions

- Codex CLI docs describe an internal `plugin-name:skill-name` namespace but the official invocation docs show only `$skill-name` with no plugin prefix. It is unclear whether the colon form is ever user-visible.
- GitHub Copilot plugin docs say the plugin name is used as a "command prefix" automatically, but the user-facing invocation docs show only `/skill-name`. The two may refer to different layers.

## Open questions

- Will Cursor, Windsurf, and Antigravity add explicit plugin namespacing as their plugin ecosystems grow?
- Will the agent runtime ecosystem converge on a shared namespacing convention, following the precedent of package ecosystems (JS, PHP, Python)?
- Does Codex expose the `plugin-name:skill-name` form to users in any context (e.g., when two plugins conflict on the same skill name)?

## Sources consulted

- [Create plugins — Claude Code Docs](https://code.claude.com/docs/en/plugins)
- [Agent Skills — Codex | OpenAI Developers](https://developers.openai.com/codex/skills)
- [Codex CLI Plugin System](https://codex.danielvaughan.com/2026/03/30/codex-cli-plugin-system/)
- [Cascade Skills — Windsurf Docs](https://docs.windsurf.com/windsurf/cascade/skills)
- [Use Agent Skills in VS Code — GitHub Copilot](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [Agent plugins in VS Code (Preview)](https://code.visualstudio.com/docs/copilot/customization/agent-plugins)
- [Authoring Google Antigravity Skills | Google Codelabs](https://codelabs.developers.google.com/getting-started-with-antigravity-skills)
- [Configuring MCP Servers and Skills for Antigravity CLI and IDE](https://medium.com/google-cloud/configuring-mcp-servers-and-skills-for-antigravity-cli-and-ide-a938c7eebb78)
- [Agent Skills | Gemini CLI](https://geminicli.com/docs/cli/skills/)
- [SEP-986: Specify Format for Tool Names · MCP](https://github.com/modelcontextprotocol/modelcontextprotocol/issues/986)
- [MCP tool naming discrepancy (colons vs double underscores) · claude-code #18763](https://github.com/anthropics/claude-code/issues/18763)
