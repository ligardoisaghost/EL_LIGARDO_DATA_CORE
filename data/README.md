# data/

Central store for all EL_LIGARDO analytics and research tables.

- raw/           → direct exports from YouTube / DSPs / tools (no edits)
- processed/     → cleaned / joined tables ready for analysis
- public_exports/→ CSVs and subsets that can be safely pushed to GitHub
- reference/     → codebooks, dimension tables, mapping files

Rule: never mutate files in raw/. All cleaning steps are reproducible and scripted.
