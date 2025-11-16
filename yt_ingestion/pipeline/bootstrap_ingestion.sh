#!/usr/bin/env bash
set -e

RAW_DIR="data/raw"
LOG_DIR="logs/automation"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/$(date +%Y%m%d_%H%M%S)_ingestion.log"

echo "[START] YouTube ingestion bootstrap" | tee -a "$LOG_FILE"

if [ ! -d "$RAW_DIR" ]; then
  echo "[ERROR] raw data directory not found: $RAW_DIR" | tee -a "$LOG_FILE"
  exit 1
fi

echo "[OK] raw directory present"       | tee -a "$LOG_FILE"
echo "[READY] place your CSVs into $RAW_DIR/ before running full pipeline" | tee -a "$LOG_FILE"
echo "[DONE] bootstrap complete"        | tee -a "$LOG_FILE"
