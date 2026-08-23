# AGENTS.md

This file provides guidance to AI coding assistants when working with code in this repository.

## Skill Augmentations

When reading any `SKILL.md` file, always check whether a `SKILL.local.md` exists in the same directory. If it does, treat its contents as additional instructions that extend the base skill. Local augmentations take precedence over the base skill where they conflict.

## Repository Purpose

This repository defines reusable research workflows that store durable artifacts in the local repository.

This repository is also a multi-runtime agent plugin named `research-workbench`. Skills in `skills/` work across Claude Code, Codex CLI, Cursor, and GitHub Copilot. Each runtime reads from its own manifest directory; all manifests point at the same `skills/` tree.

Keep the distinction clear:

- `.claude-plugin/plugin.json` — manifest for Claude Code and GitHub Copilot
- `.codex-plugin/plugin.json` — manifest for Codex CLI
- `.cursor-plugin/plugin.json` — manifest for Cursor
- `skills/deep-research/` contains the deep-research skill and all its supporting files
- `skills/deep-research/governances/` contains shared research contracts
- `skills/deep-research/assets/templates/` contains reusable topic file templates
- `skills/deep-research/scripts/` contains helper scripts
- `skills/community-post/SKILL.md` contains the community-post skill
- `skills/formulate/` contains the formulate skill, its log templates, and `scripts/new-log.sh`
- `.research/_sources/` contains long-lived source registries
- `.research/<topic-slug>/` contains one topic workspace. A research topic holds investigation, conclusion, evidence, and change history; a design log holds the question, the log, and change history, and deliberately no conclusion

## Authoring Rules

- Write all content in en-US.
- Prefer markdown and plain text artifacts that are easy to diff and review.
- Keep skill bodies agent-first and workflow-oriented.
- Under `.research/`, topic directories are the primary user-facing unit. Shared infrastructure should recede behind `_sources/`.
- `conclusion.md` is the default consumption surface for agents and humans. It should be complete enough to stand on its own for most reads.
- Do not treat `.research/` as scratch space; durable work belongs there only when it is useful to revisit or cross-check later.
- When a skill defines a template or file structure, keep the skill concise and put reusable examples in repository files.

## Commit Discipline

**Auto-commit rule:** When a unit of work is complete and verified, commit it immediately — do not wait for the user to ask. Batching multiple units into one commit, or finishing all work before committing, are both violations of this rule.

**Unit of work:** one coherent, independently revertable change — one domain's refactor, one feature, one bugfix, one test suite expansion for one concern, one config change. Never two unrelated concerns in the same commit. A TDD red-green-refactor cycle alone is not a commit boundary; commit when the full intended change is complete and tests pass. If the working tree has unrelated changes, leave them unstaged — commit the current unit first, then continue.

- Conventional Commits: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`
- One concern per commit; never batch unrelated changes
- Stage only files for this unit: `git add <files>`, then verify with `git diff --cached`
- Never use `git add .`, `git add -A`, or `git add -p` (interactive commands agents cannot run)
- Never commit with red tests; run validation commands first

### References

- **`commit-work` skill** — staging, splitting, and message writing when committing
