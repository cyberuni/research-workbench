# AGENTS.md

This file provides guidance to AI coding assistants when working with code in this repository.

## Skill Augmentations

When reading any `SKILL.md` file, always check whether a `SKILL.local.md` exists in the same directory. If it does, treat its contents as additional instructions that extend the base skill. Local augmentations take precedence over the base skill where they conflict.

## Repository Purpose

This repository defines reusable research workflows that store durable artifacts in the local repository.

Keep the distinction clear:

- `skills/` contains reusable public skills
- `docs/research/sources/` contains long-lived source registries
- `docs/research/topics/` contains topic-specific investigation notes
- `docs/research/evidence/` contains structured evidence logs
- `docs/research/syntheses/` contains outputs that support decisions, proposals, or downstream documentation

## Authoring Rules

- Write all content in en-US.
- Prefer markdown and plain text artifacts that are easy to diff and review.
- Keep skill bodies agent-first and workflow-oriented.
- Do not treat `docs/research/` as scratch space; durable work belongs there only when it is useful to revisit or cross-check later.
- When a skill defines a template or file structure, keep the skill concise and put reusable examples in repository files.

## Commit Discipline

- Make one logical change per commit.
- Stage only intended files for the current change.
- Use Conventional Commits.
- Run the smallest meaningful verification before committing.
