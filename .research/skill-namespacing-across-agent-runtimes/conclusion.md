# Skill Namespacing Across Agent Runtimes — Conclusion

## Question

When a human explicitly invokes a skill, what syntax do they type — and does that change when the skill comes from a plugin vs. standalone?

## Verdict

Most agent runtimes keep plugin namespacing invisible to the user. Windsurf and Antigravity use `@skill-name`; Cursor and GitHub Copilot use `/skill-name`; Codex CLI uses `$skill-name`. The invocation is the same whether the skill comes from a plugin or a standalone file.

**Claude Code currently uses short-form invocation for skills.** A plugin skill appears as `/deep-research` with the plugin name shown parenthetically — `/deep-research    (research-workbench) <description>`. Tab-completing the short form expands to the full `/research-workbench:deep-research`, confirming the qualified form is the canonical underlying invocation. Commands, by contrast, are already prefixed by default (`/plugin-name:command`), creating an asymmetry between the two component types (E10, E11).

**The better model: prefixed form as primary, fuzzy completion as the UX bridge.** Showing skills as `/plugin-name:skill-name` in the list — consistent with commands — is correct for three reasons:

1. **Conflict correctness.** Flat names silently resolve to whichever plugin loaded first. Prefixed names eliminate ambiguity by construction.
2. **Consistency.** Users already see `/plugin:command` for commands; expecting `/plugin:skill` for skills is the natural extension, not a new concept.
3. **Discoverability.** Typing `/<plugin>:<tab>` should narrow autocomplete to that plugin's full surface — commands and skills together. Today it only narrows to commands.

The friction objection — "users don't want to type the full prefix" — dissolves with good fuzzy completion. If typing `community-post` (or even `comm`) surfaces `/research-workbench:community-post` in the autocomplete list, users get the best of both worlds: short to type, unambiguous to select.

**The namespacing problem is structurally the same as every past package ecosystem.** JavaScript resolved it with scoped packages (`@org/package`); Python with namespaced packages; PHP with vendor-prefixed namespaces. In each case, flat names won early, then conflicts forced namespacing as the ecosystem grew. The agent runtime ecosystem is at that early phase — skills are new, libraries are small, conflicts are rare. Prefixed-form-plus-fuzzy-search is the path that avoids repeating that history.

## Confidence

High — primary official documentation consulted for all major tools. One ambiguity: Codex CLI's internal `plugin-name:skill-name` namespace is described in an unofficial source and may or may not be user-visible on conflict.

## Strongest support

- Direct observation: Claude Code commands are already prefixed (`/plugin:command`) while skills are not — the asymmetry confirms prefixed skills is the natural completion, not a new ask (E10, E11)
- Direct observation: tab-completing `/community-post` expands to `/research-workbench:community-post` — the qualified form already works; the only gap is surfacing it as primary in the list (E11)
- @francisco-perez-sorrosal (anthropics/claude-code#50486): confirms asymmetry across multiple plugins and marketplaces; explicitly prefers uniform-prefixed with bare aliases secondary
- @kriscoleman (anthropics/claude-code#50486): same request, with AC that unprefixed invocations continue working for backwards compat

## Strongest counterevidence

- GitHub Copilot explicitly warns that manual namespace prefixes cause silent failures (E04) — though this may reflect Copilot-specific registration constraints rather than a general UX argument against prefixing
- Windsurf, Antigravity, Gemini CLI show no plugin-prefix form at all (E05, E06, E07) — suggests the ecosystem default is currently flat; prefixed-as-primary would be a divergence from peers

## Not supported

- Any claim that the agent runtime ecosystem has converged on a shared namespacing standard
- Any evidence that Cursor has a conflict resolution mechanism beyond last-installed-wins

## Thin evidence

- Codex CLI plugin invocation on conflict (E03 is unofficial)
- Antigravity plugin-specific behavior — codelab only shows standalone skills
- What fuzzy completion quality looks like in practice across runtimes — the prefixed-plus-fuzzy model depends on good autocomplete that no runtime has yet demonstrated

## Recheck triggers

- Claude Code ships prefixed skills (`/plugin:skill` as primary) with fuzzy completion — confirms or disproves the model in practice
- Any runtime ships prefixed-form-as-primary for skills and documents the fuzzy-search behavior
- vercel-labs/open-plugin-spec adopts a normative position on skill invocation format
- GitHub Copilot updates its guidance on namespace prefixes (E04)

## Filed

- https://github.com/anthropics/claude-code/issues/50486#issuecomment-4588493786 (2026-05-31) — comment on open issue requesting uniform prefix for skills. Position: prefixed form (`/plugin:skill`) is better for consistency with commands; good fuzzy completion removes the typing-friction objection and makes prefixed-as-primary viable.
