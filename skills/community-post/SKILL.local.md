# community-post local augmentation

## Skill name

This skill is named `community-post` in this repository.

## Modes

This skill operates in three modes depending on what research exists:

- **New** — no prior research exists. Run the `deep-research` skill first (durable mode), then draft the post from the resulting artifacts.
- **Existing** — research already lives in `.research/<topic-slug>/`. Read `conclusion.md` and `evidence.md` directly; skip to step 4 below.
- **Follow-up** — a post has already been filed and new research updates exist. Run the `deep-research` skill in update mode, then draft a follow-up post referencing the original issue URL.

Choose the mode by checking whether `.research/<topic-slug>/` exists and whether a prior issue URL is recorded in `conclusion.md`.

## Step 4 replacement: use the deep-research workbench

Do not create a `docs/research/YYYY-MM-<topic>.md` file. Instead:

1. Use the `deep-research` skill to produce or update the topic workspace at `.research/<topic-slug>/`.
2. The research must capture, at minimum:
   - Author handles (`@username`) for every prior-art reference found in steps 2–3
   - Community position table (agreements vs. counterarguments)
   - Open questions and confidence level
3. `conclusion.md` becomes the primary input for drafting the post (step 5). Read it in full before writing anything.
4. After the post is filed, append the live issue URL to `conclusion.md` under a `## Filed` section.

## References section

Ignore the upstream `## References` section. The governance files for this repo are in `skills/deep-research/governances/`.
