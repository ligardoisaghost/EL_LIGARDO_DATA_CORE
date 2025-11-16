#!/usr/bin/env bash
set -e

RAW_DIR="data/raw"
PROCESSED_DIR="data/processed"
LOG_DIR="logs/automation"
LOG_FILE="$LOG_DIR/$(date +%Y%m%d_%H%M%S)_run_ingestion.log"

mkdir -p "$PROCESSED_DIR" "$LOG_DIR"

echo "[START] Full YouTube ingestion" | tee -a "$LOG_FILE"

if [ ! -d "$RAW_DIR" ]; then
  echo "[ERROR] Raw dir missing: $RAW_DIR" | tee -a "$LOG_FILE"
  exit 1
fi

shopt -s nullglob
CSV_FILES=("$RAW_DIR"/*.csv)
shopt -u nullglob

if [ ${#CSV_FILES[@]} -eq 0 ]; then
  echo "[WARN] No CSV files found in $RAW_DIR" | tee -a "$LOG_FILE"
  exit 0
fi

for csv in "${CSV_FILES[@]}"; do
  base=$(basename "$csv")
  stem="${base%.*}"
  out="$PROCESSED_DIR/${stem}.jsonl"
  echo "[FILE] Ingesting $base -> $out" | tee -a "$LOG_FILE"

  python3 << PY 2>> "$LOG_FILE"
import csv, json, pathlib

csv_path = pathlib.Path(r"""$csv""")
out_path = pathlib.Path(r"""$out""")

with csv_path.open("r", encoding="utf-8-sig", newline="") as f_in:
    reader = csv.DictReader(f_in)
    rows = list(reader)

out_path.parent.mkdir(parents=True, exist_ok=True)
with out_path.open("w", encoding="utf-8") as f_out:
    for row in rows:
        clean = {(k or "").strip(): (v or "").strip() for k, v in row.items()}
        json.dump(clean, f_out)
        f_out.write("\\n")

print(f"[OK] Wrote {len(rows)} rows to {out_path}")
PY

  echo "[DONE] $base" | tee -a "$LOG_FILE"
done

echo "[COMPLETE] Ingestion finished" | tee -a "$LOG_FILE"
