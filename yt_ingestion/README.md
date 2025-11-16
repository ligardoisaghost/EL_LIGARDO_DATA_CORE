# yt_ingestion/

Home for anything that pulls, reshapes, or tags YouTube analytics:

- pipeline/   → scripts / notebooks that transform raw exports into tables
- snapshots/  → frozen copies of key datasets at specific dates (e.g. Phase-2 baselines)

Nothing here should depend on secret keys in plain text. Use env vars or local-only configs.
