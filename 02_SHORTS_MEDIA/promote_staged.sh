#!/bin/zsh
set -euo pipefail

ROOT="$HOME/EL_LIGARDO_DATA_CORE/02_SHORTS_MEDIA"
STAGED="$ROOT/staged"
FINAL="$ROOT/final"
LOG="$ROOT/promote.log"
IDX="$ROOT/promotion_index.csv"

mkdir -p "$FINAL"
[[ -f "$IDX" ]] || echo "ts,src,final,sha256,bytes" > "$IDX"

for SRC in $STAGED/*.mov(N) $STAGED/*.mp4(N); do
  [[ -e "$SRC" ]] || exit 0
  BASENAME="${SRC:t}"
  TS="$(date +%Y-%m-%dT%H:%M:%S)"
  BYTES="$(stat -f %z "$SRC")"
  SUM_SRC="$(shasum -a 256 "$SRC" | awk '{print $1}')"

  TMP="$FINAL/.tmp_${BASENAME}"
  OUT="$FINAL/${BASENAME}"

  cp -p "$SRC" "$TMP"
  SUM_TMP="$(shasum -a 256 "$TMP" | awk '{print $1}')"

  if [[ "$SUM_SRC" == "$SUM_TMP" ]]; then
    mv "$TMP" "$OUT"
    echo "$TS,$SRC,$OUT,$SUM_SRC,$BYTES" >> "$IDX"
    echo "[$TS] PROMOTED: $BASENAME" >> "$LOG"
    rm -f "$SRC"
  else
    echo "[$TS] CHECKSUM MISMATCH: $BASENAME" >> "$LOG"
    rm -f "$TMP"
  fi
done
