#!/usr/bin/env bash
set -e

INPUT_FILE=$(ls data/processed | grep 'YT_ANALYTICS_MASTER_' | sort | tail -1)
INFILE="data/processed/$INPUT_FILE"

OUT_DIR="public_exports"
mkdir -p "$OUT_DIR"
OUT="$OUT_DIR/category_breakdown_$(date +%Y%m%d).json"

jq -s '
  map({
    content: (
      if has("Content") then .Content
      elif has("content") then .content
      else "unknown" end
    ),
    views: (
      if has("Views") then (.Views|tonumber? // 0)
      elif has("views") then (.views|tonumber? // 0)
      else 0 end
    )
  })
  | group_by(.content)
  | map({
      content: .[0].content,
      total_views: (map(.views)|add),
      videos: length
    })
' "$INFILE" > "$OUT"

echo "[DONE] Category breakdown written to $OUT"
