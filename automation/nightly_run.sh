#!/usr/bin/env bash
set -e

# Always run from repo root
cd "$(dirname "$0")/.."

LOG_DIR="logs/automation"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/nightly_$(date +%Y%m%d_%H%M%S).log"

# Log everything to file + stdout
exec > >(tee -a "$LOG_FILE") 2>&1

echo "[START] Nightly pipeline $(date)"

# 1) Ingest any master CSV currently in data/raw
if ls data/raw/YT_ANALYTICS_MASTER_*.csv >/dev/null 2>&1; then
  echo "[STEP] Running full ingestion"
  ./yt_ingestion/pipeline/run_full_ingestion.sh
else
  echo "[WARN] No YT_ANALYTICS_MASTER_*.csv in data/raw; skipping ingestion"
fi

# 2) Generate all summaries from latest DAILY processed file
echo "[STEP] Running summary suite"
./yt_ingestion/pipeline/run_all_summaries.sh

# 3) Commit + push if anything actually changed
echo "[STEP] Committing any changes"
./git_checkpoint.sh "Nightly auto-ingest $(date +%Y-%m-%d)"

echo "[DONE] Nightly pipeline $(date)"
