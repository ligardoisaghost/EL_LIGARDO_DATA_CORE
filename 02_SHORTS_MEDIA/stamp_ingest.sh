#!/bin/zsh
set -euo pipefail
SRC="${1:?Drag a video file onto this script or pass a path}"
BASE=$(basename "$SRC")
TS=$(date +%Y%m%d-%H%M%S)
OUT="$HOME/EL_LIGARDO_DATA_CORE/02_SHORTS_MEDIA/staged/${TS}__${BASE}"
cp "$SRC" "$OUT"
printf "%s,%s\n" "$TS" "$OUT" >> "$HOME/EL_LIGARDO_DATA_CORE/02_SHORTS_MEDIA/ingest_index.csv"
echo "[ingest] staged $OUT"
