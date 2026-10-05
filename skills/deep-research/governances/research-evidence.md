# Research Evidence

Each topic directory must include `evidence.md` with structured evidence entries.

Required fields per entry:

- `claim_id`
- `date`
- `status`
- `confidence`
- `source.label`
- `source.url`
- `source.type`
- `notes`

Evidence should be traceable enough to support or challenge the current conclusion without reconstructing the entire research process from prose alone.

A recommended structure is one markdown section per claim or evidence item, using consistent field labels so agents can read it reliably.

Entries must appear in ascending numeric order by claim ID (E01, E02, … E10). New entries go at the end; do not insert mid-file.

## Evidence weight

Weight evidence by how close it is to observed practice:

- **Strongest:** incidents and postmortems, benchmarks with published method, production reports, issue threads with reproductions, spec or standards decisions with their rationale, maintainer or builder write-ups of what they tried and what happened.
- **Supporting:** reference documentation, specifications as written, source code — authoritative for what a thing *is* or *claims*, not for how it behaves in use.
- **Weak:** documentation intros, marketing pages, and opinion without data. Record them only as context or as a claim to verify, never as the sole support for a verdict.

Prefer "we tried X and it failed because Y" over "X is considered best practice". Record the weight in each entry's `confidence` and `notes` so the conclusion's strongest-support section can rank by it.
