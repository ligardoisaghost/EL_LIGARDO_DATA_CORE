# Human–Model Resonance (HMR) · System Index

This index ties together the three public components of the HMR project:

1. **Data Engine** – EL_LIGARDO_DATA_CORE  
2. **Architecture & Coherence Design** – imaghostnow-coherence-architecture  
3. **Knowledge Kit & Lab Protocol** – HMR_Knowledge_Kit_v1_0  

---

## 1. EL_LIGARDO_DATA_CORE · Data Engine

**Role:**  
Canonical source for YouTube Shorts analytics and derived summaries.

**Key entry points:**

- `README.md` – ingestion overview  
- `yt_ingestion/` – JSONL/CSV processing pipeline  
- `public_exports/` – machine-readable summaries (JSON)  
- `reports/dashboard_YYYYMMDD.md` – daily Markdown dashboards

Recommended starting artifact:

- `reports/dashboard_20251117.md` – first fully automated Phase-2 dashboard.

---

## 2. imaghostnow-coherence-architecture · Architecture

**Role:**  
Describes the coherence architecture, HMR framing, and how the data engine and
knowledge kit stitch together.

**Key entry points:**

- `docs/` – architecture overviews and maps  
- `phase2_reports/` – imported dashboards and pipeline notes from
  EL_LIGARDO_DATA_CORE  
- `phase2_reports/pipeline/00_PIPELINE_OVERVIEW.md` – end-to-end Phase-2
  ingestion diagram (conceptual)

---

## 3. HMR_Knowledge_Kit_v1_0 · Narrative & Protocol

**Role:**  
Narrative record and lab documentation of the HMR experiments.

**Key entry points:**

- `00_README.txt` – kit overview  
- `01_Substack_essay_…` – public essay framing the experiment  
- `02_Lab_Protocol_HMR_Lab_Protocol_v1_1.txt` – step-by-step protocol  
- `05_Metadata_HMR_Metadata_Manifest.txt` – description of public assets

---

## Cross-navigation

Typical reading paths:

1. **Narrative first**  
   - Start with `HMR_Knowledge_Kit_v1_0/01_Substack_essay_…`  
   - Then read `02_Lab_Protocol_…`  
   - Finally, inspect dashboards in `EL_LIGARDO_DATA_CORE/reports/`.

2. **Data first**  
   - Start with `EL_LIGARDO_DATA_CORE/public_exports/` JSON files  
   - Move to dashboards (`reports/`)  
   - Then consult `imaghostnow-coherence-architecture/docs/` for design context.

3. **Architecture first**  
   - Start at this repo’s `README.md` and `docs/`  
   - Use the links above to jump into the data engine and knowledge kit.

This index is the canonical “map” for anyone trying to reproduce or audit the
HMR experiment.
