#!/usr/bin/env bash
set -e

INPUT_FILE=$(ls data/processed | grep 'YT_ANALYTICS_DAILY_' | sort | tail -1)
INFILE="data/processed/$INPUT_FILE"

OUT_DIR="public_exports"
mkdir -p "$OUT_DIR"
OUT="$OUT_DIR/monthly_summary_$(date +%Y%m%d).json"

echo "[START] Monthly summary from $INFILE"

jq -s '
  group_by(.date[0:7]) |
  map({
    month: .[0].date[0:7],
    total_views: (map(.views) | add),
    days: length
  })
' "$INFILE" > "$OUT"

echo "[DONE] Wrote monthly summary to $OUT"
