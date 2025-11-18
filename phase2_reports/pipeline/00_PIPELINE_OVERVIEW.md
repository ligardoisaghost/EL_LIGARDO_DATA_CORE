# Phase-2 YouTube Pipeline · EL_LIGARDO_DATA_CORE

Primary data and scripts live in the companion repository:

- Repo: EL_LIGARDO_DATA_CORE
- Role: ingestion, JSONL processing, summary exports, markdown dashboards
- Current pinned snapshot: dashboard_20251117.md

### Main steps

1. Rebuild MASTER from DAILY  
   - `yt_ingestion/pipeline/steps/rebuild_master_from_daily.sh`

2. Generate summaries  
   - `yt_ingestion/pipeline/steps/daily_summary.sh`  
   - `yt_ingestion/pipeline/steps/monthly_summary.sh`  
   - `yt_ingestion/pipeline/steps/lifetime_summary.sh`  
   - `yt_ingestion/pipeline/steps/category_breakdown.sh`  
   - `yt_ingestion/pipeline/steps/search_terms_top100.sh`

3. Sanity-check DAILY titles  
   - `yt_ingestion/pipeline/steps/check_daily_titles.sh`

4. Build markdown dashboard  
   - `dashboards/make_markdown_dashboard.py`  
   - Output → `reports/dashboard_YYYYMMDD.md`

5. Optional nightly automation  
   - `automation/nightly_run.sh` (called by crontab)
   - Log → `cron.log`

This architecture repo treats EL_LIGARDO_DATA_CORE as the **authoritative data engine** and keeps
only high-level descriptions, schemas, and selected dashboards.
