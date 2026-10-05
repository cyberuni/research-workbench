# Research Layout

The durable research workspace uses this layout:

- `<research-root>/_sources/` for shared source registries
- `<research-root>/<topic-slug>/topic.md` for the working investigation
- `<research-root>/<topic-slug>/conclusion.md` for the primary consumption surface
- `<research-root>/<topic-slug>/evidence.md` for structured evidence
- `<research-root>/<topic-slug>/changes.md` for material update history

Topic directories are the primary unit that should be visible to readers and agents.

Shared infrastructure should recede behind underscored directories or package-level support folders.

## Index

`<research-root>/README.md` carries an `## Index` table with one row per topic, so the set of topics is browsable without listing directories.

```markdown
## Index

| Topic | Question |
| --- | --- |
| [<topic-slug>](<topic-slug>/conclusion.md) | <The question from conclusion.md, one line> |
```

- Add the row when a topic is first written to the research root, and update it when the question changes. Rows stay sorted by slug.
- Link to `conclusion.md`, the default consumption surface. Do not copy the verdict or its date into the row; they live in the conclusion and would go stale here.
- If `README.md` exists without an `## Index` section, append one. If `README.md` does not exist, create it with a `# Research` heading followed by the section.
- Draft-mode temp workspaces are not indexed; the row is written when the topic is saved.
