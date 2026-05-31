# Skill Namespacing Across Agent Runtimes — Conclusion

## Question

When a human explicitly invokes a skill, what syntax do they type — and does that change when the skill comes from a plugin vs. standalone?

## Verdict

Most agent runtimes today keep plugin namespacing invisible to the user. Windsurf and Antigravity use `@skill-name`; Cursor and GitHub Copilot use `/skill-name`; Codex CLI uses `$skill-name`. In all of these, the invocation is the same whether the skill comes from a plugin or a standalone file. Conflict resolution is handled by scope precedence or last-installed-wins — not by exposing a namespace to the user.

**Claude Code is the outlier: it is the only runtime that surfaces the plugin name in the human invocation.** A standalone skill is invoked as `/deep-research`; the same skill installed via the `research-workbench` plugin becomes `/research-workbench:deep-research`. This is a real UX cost — longer to type, harder to discover — but it is also the architecturally correct approach.

**Claude Code's approach is the proper solution to the namespacing problem.** The alternative — hiding the plugin name and resolving conflicts silently by scope or installation order — means a user who installs two plugins with a skill named `deploy` gets one of them with no indication of which, and no way to address the other. That is the same unresolved conflict that prompted namespacing in every major package ecosystem.

The precedent is well-established. JavaScript (`npm`) resolved this with scoped packages (`@org/package`). Python resolved it with namespaced packages (PEP 402, later `pkgutil`-style namespaces). PHP resolved it with vendor-prefixed namespaces (`Vendor\Package\Class`). In each case, the ecosystem resisted namespacing early ("too verbose"), then adopted it as the plugin library grew large enough that flat names collided in practice.

The agent runtime ecosystem is at the early phase of that same curve. Skills are new, plugin libraries are small, and conflicts are rare — so the UX cost of typing `@plugin:skill` feels unnecessary. As the ecosystem matures and skill marketplaces grow, unresolved flat-name conflicts will become the more painful problem.

**The ideal runtime behavior combines both:** use the namespaced form (`/plugin-name:skill-name`) as the canonical, unambiguous invocation, but allow the short form (`/skill-name`) as a convenience shortcut when there is exactly one skill with that name currently installed. This matches how Python `import` works — you can `from vendor.pkg import Foo` or just `import Foo` if nothing else shadows it, but the qualified form is always available and unambiguous.

Claude Code does not yet offer this shortcut (as of May 2026), but it is the natural next step. Other runtimes (Cursor, Copilot, Windsurf) currently have only the short form with no escape hatch when conflicts arise.

## Confidence

High — primary official documentation consulted for all major tools. One ambiguity: Codex CLI's internal `plugin-name:skill-name` namespace is described in an unofficial source and may or may not be user-visible on conflict.

## Strongest support

- Claude Code official docs explicitly document `/plugin-name:skill-name` and state it prevents conflicts (E01)
- GitHub Copilot explicitly warns that manual namespace prefixes cause silent failures, confirming flat-only invocation (E04)
- Windsurf, Antigravity, and Gemini CLI docs show no plugin-prefix form at all (E05, E06, E07)

## Strongest counterevidence

- Codex CLI may expose `plugin-name:skill-name` on conflict (E03) — would make it the second runtime with user-visible namespacing, weakening "Claude Code is the only outlier"

## Not supported

- Any claim that the agent runtime ecosystem has converged on a shared namespacing standard
- Any evidence that Cursor has a conflict resolution mechanism beyond last-installed-wins

## Thin evidence

- Codex CLI plugin invocation on conflict (E03 is unofficial)
- Antigravity plugin-specific behavior — codelab only shows standalone skills
- Whether any runtime currently offers the "short form as convenience alias" pattern

## Recheck triggers

- Cursor, Windsurf, Copilot, or Codex adds explicit plugin namespacing in human invocation
- A shared SKILL.md or plugin spec proposes a cross-runtime namespace standard
- Claude Code adds short-form aliases for unambiguous plugin skills
