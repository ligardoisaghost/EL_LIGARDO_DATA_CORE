#!/usr/bin/env bash
set -e

# Pick the latest DAILY processed file
INPUT_FILE=$(ls data/processed | grep 'YT_ANALYTICS_DAILY_' | sort | tail -1)
INFILE="data/processed/$INPUT_FILE"

OUT_DIR="public_exports"
mkdir -p "$OUT_DIR"
OUT="$OUT_DIR/daily_summary_$(date +%Y%m%d).json"

echo "[START] Daily summary from $INFILE"

# File is JSONL (one JSON object per line), so we slurp (-s) into an array.
jq -s '{
  total_views: (map(.views) | add),
  total_videos: length,
  first_date: (map(.date) | min),
  last_date: (map(.date) | max)
}' "$INFILE" > "$OUT"

echo "[DONE] Wrote summary to $OUT"
