#!/usr/bin/env bash
set -e

echo "[RUN] Daily summary"
./yt_ingestion/pipeline/steps/daily_summary.sh

echo "[RUN] Monthly summary"
./yt_ingestion/pipeline/steps/monthly_summary.sh

echo "[RUN] Lifetime summary"
./yt_ingestion/pipeline/steps/lifetime_summary.sh

echo "[RUN] Category breakdown"
./yt_ingestion/pipeline/steps/category_breakdown.sh

echo "[RUN] Search-term frequency"
./yt_ingestion/pipeline/steps/search_terms_top100.sh

echo "[DONE] All summaries complete"
