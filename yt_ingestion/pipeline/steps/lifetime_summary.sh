#!/usr/bin/env bash
set -e

INPUT_FILE=$(ls data/processed | grep 'YT_ANALYTICS_DAILY_' | sort | tail -1)
INFILE="data/processed/$INPUT_FILE"

OUT_DIR="public_exports"
mkdir -p "$OUT_DIR"
OUT="$OUT_DIR/lifetime_summary_$(date +%Y%m%d).json"

jq -s '
  {
    total_views: (map(.views) | add),
    total_days: length,
    first_date: (map(.date) | min),
    last_date: (map(.date) | max)
  }
' "$INFILE" > "$OUT"

echo "[DONE] Lifetime summary written to $OUT"
