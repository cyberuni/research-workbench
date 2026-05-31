# Draft: open-plugin-spec proposal

**Venue:** New issue in `vercel-labs/open-plugin-spec`

**Title:** Proposal: normative skill invocation format — `{plugin-name}:{skill-name}` as primary, with fuzzy completion note

---

Thanks for the work on this spec — the colon-separated `{plugin-name}:{component-name}` format in §X is the right structural call. I want to propose going one step further: making the prefixed form normative as the *primary* display in skill lists.

## The gap

The current spec says `{plugin-name}:{component-name}` is RECOMMENDED. In practice, most agent runtimes surface skills in the *flat* form — Windsurf uses `@skill-name`, GitHub Copilot uses `/skill-name`, Gemini CLI uses natural language, Claude Code uses `/skill-name` with the plugin name shown parenthetically. None require the user to type a namespace prefix. The plugin namespace exists internally but is invisible at invocation time.

This leaves two problems unresolved across the ecosystem:

1. **Silent conflict.** When two installed plugins define a skill with the same name, flat-name resolution is undefined — typically first-loaded-wins with no user signal.
2. **Asymmetry within hosts.** In Claude Code, commands from a plugin are already prefixed (`/plugin-name:command`) while skills from the same plugin are not (`/skill-name`). Users browsing `research-workbench` skills can't type `/<plugin>:<tab>` to narrow autocomplete to that plugin's surface.

## The proposal

> **Skill lists SHOULD display plugin skills in prefixed form as primary** (`{plugin-name}:{skill-name}`), consistent with how commands are typically displayed.
>
> **The unprefixed form MAY continue to work as an alias** for backwards compatibility, but SHOULD NOT be the primary display entry.

**Note on fuzzy completion:** The main objection to prefixed-as-primary is typing friction. This is a host-layer concern rather than a spec concern, but hosts adopting this format are strongly encouraged to support fuzzy completion so users can find skills by typing part of the skill name without the prefix. For example, typing `community-post` or `comm` should surface `/research-workbench:community-post` as a match. The spec can't mandate autocomplete quality, but naming this pattern explicitly helps host implementors understand the intent.

## Why this pair solves it

| Concern | Addressed by |
|---|---|
| Silent conflict (two plugins, same skill name) | Prefixed form — ambiguity eliminated by construction |
| Consistency with commands | Prefixed form — same `plugin:component` pattern |
| `/<plugin>:<tab>` narrows to that plugin's full surface | Prefixed form as primary in autocomplete |
| Typing friction | Fuzzy completion at the host layer |

## Prior art and community

- anthropics/claude-code#50486 — open issue requesting uniform prefix for skills, matching how commands already work. Contributors @kriscoleman and @francisco-perez-sorrosal independently confirmed the asymmetry and prefer prefixed-as-primary with bare aliases retained for backwards compat.

The broader pattern follows every major package ecosystem: npm scoped packages, Python namespaced packages, PHP vendor prefixes. Flat names win early; conflicts force namespacing as the ecosystem grows. Specifying prefixed-as-primary now avoids repeating that history.

## What I'd love to see clarified

1. Is there appetite to strengthen RECOMMENDED → SHOULD for prefixed-as-primary in skill lists?
2. Should the fuzzy completion note be included in the spec as non-normative guidance, or left out entirely?
3. Does this interact with the `commands/` vs `skills/` asymmetry in any hosts, or is that purely a host-layer concern?

Happy to contribute spec language or a PR if the direction looks right.
