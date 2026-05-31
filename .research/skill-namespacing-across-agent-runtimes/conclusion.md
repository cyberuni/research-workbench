# Skill Namespacing Across Agent Runtimes — Conclusion

## Question

When a human explicitly invokes a skill, what syntax do they type — and does that change when the skill comes from a plugin vs. standalone?

## Verdict

Most agent runtimes keep plugin namespacing invisible to the user. Windsurf and Antigravity use `@skill-name`; Cursor and GitHub Copilot use `/skill-name`; Codex CLI uses `$skill-name`. The invocation is the same whether the skill comes from a plugin or a standalone file.

**Claude Code converged to the same short-form invocation as of 2026-05-31.** A plugin skill that was previously invoked as `/research-workbench:deep-research` is now invoked as `/deep-research`. The plugin name is shown parenthetically in the skill list — `/deep-research    (research-workbench) <description>` — preserving discoverability without requiring the user to type the namespace.

Tab-completing the short form expands it to the full `/plugin-name:skill-name` form, confirming the short form is a true alias and the long form is the canonical underlying invocation. The long form is intentionally absent from the skill list — only the short form appears — which avoids duplicate entries while keeping the namespace discoverable via tab. This is a cleaner implementation than surfacing both forms.

**The namespacing problem remains unsolved at conflict time.** All runtimes now use short-form invocation by default. None has documented what happens when two installed plugins provide a skill with the same name. The ecosystem has prioritized UX convenience over conflict correctness — the same pattern every package ecosystem followed before scoped names became standard.

The precedent is well-established. JavaScript (`npm`) resolved this with scoped packages (`@org/package`). Python resolved it with namespaced packages. PHP resolved it with vendor-prefixed namespaces. In each case, flat names won early, then conflicts forced namespacing as the ecosystem grew.

The agent runtime ecosystem is at that early phase. Skills are new, plugin libraries are small, and conflicts are rare. As skill marketplaces grow, unresolved flat-name conflicts will become the more painful problem — and some runtime will be first to require the namespaced form on conflict.

## Confidence

High — primary official documentation consulted for all major tools. One ambiguity: Codex CLI's internal `plugin-name:skill-name` namespace is described in an unofficial source and may or may not be user-visible on conflict.

## Strongest support

- Direct observation: tab-completing `/community-post` in Claude Code expands to `/research-workbench:community-post` — confirms short form is an alias, long form is canonical and works (E11)
- Direct observation: Claude Code skill list shows `/deep-research    (research-workbench) <description>` — short-form only, with parenthetical plugin attribution (E10)
- GitHub Copilot explicitly warns that manual namespace prefixes cause silent failures, confirming flat-only invocation (E04)
- Windsurf, Antigravity, and Gemini CLI docs show no plugin-prefix form at all (E05, E06, E07)

## Strongest counterevidence

- Claude Code docs (E01) described `/plugin-name:skill-name` as the canonical plugin invocation — now superseded by observed runtime behavior (E10, E11). The long form still works (confirmed by tab expansion) but is hidden from the skill list.

## Not supported

- Any claim that the agent runtime ecosystem has converged on a shared namespacing standard
- Any evidence that Cursor has a conflict resolution mechanism beyond last-installed-wins

## Thin evidence

- Codex CLI plugin invocation on conflict (E03 is unofficial)
- Antigravity plugin-specific behavior — codelab only shows standalone skills
- What Claude Code does when two plugins conflict on the same skill name (short form would be ambiguous; behavior undocumented)

## Recheck triggers

- Claude Code documents conflict resolution behavior for duplicate skill names across plugins
- Cursor, Windsurf, Copilot, or Codex adds explicit plugin namespacing or conflict resolution
- A shared SKILL.md or plugin spec proposes a cross-runtime namespace standard
- Claude Code plugin docs are updated to reflect the new short-form display behavior
