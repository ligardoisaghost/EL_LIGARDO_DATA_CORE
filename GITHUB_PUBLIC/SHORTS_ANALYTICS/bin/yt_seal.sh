#!/bin/zsh
set -euo pipefail

ROOT="$HOME/EL_LIGARDO_DATA_CORE/01_YT_ANALYTICS"
DAILY="$ROOT/DAILY_METRICS"
ARCHIVE="$HOME/EL_LIGARDO_DATA_CORE/00_MASTER_ARCHIVE"
FINAL="$ROOT/../YT_ANALYTICS_MASTER_$(date +%Y%m%d)_FINAL.csv"

cd "$DAILY"

# sanity
for f in "Chart data.csv" "Table data.csv" "Totals.csv"; do
  [[ -f "$f" ]] || { echo "MISSING: $DAILY/$f"; exit 2; }
done

# build, clean, finalize
cat "Chart data.csv" "Table data.csv" "Totals.csv" > ../YT_ANALYTICS_MASTER_$(date +%Y%m%d)_NORMALIZED.csv
awk -F',' 'NF==6' ../YT_ANALYTICS_MASTER_$(date +%Y%m%d)_NORMALIZED.csv > ../YT_ANALYTICS_MASTER_$(date +%Y%m%d)_CLEAN.csv
mv ../YT_ANALYTICS_MASTER_$(date +%Y%m%d)_CLEAN.csv "$FINAL"

# archive and checksum
mkdir -p "$ARCHIVE"
cp "$FINAL" "$ARCHIVE"/
shasum "$ARCHIVE/$(basename "$FINAL")" | tee "$ARCHIVE/$(basename "$FINAL").sha1"
echo "[ytseal] sealed $(basename "$FINAL")"
