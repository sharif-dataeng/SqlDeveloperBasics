# SQL Scenario & Case Studies

This folder contains scenario-driven T-SQL scripts and supporting utilities. Each file is a self-contained case study or helper script designed to demonstrate real-world workflows combining tables, joins, CTEs, window functions, MERGE, SCDs, JSON output, and indexing.

Files in this folder
- CaseStudy_01_Sales_Analysis.sql — End-to-end sales reporting: staging, fact/dim joins, aggregates, window functions, and sample report queries.
- CaseStudy_02_Inventory_Replenishment.sql — Identify low-stock items, calculate reorder quantities, and generate replenishment batches.
- CaseStudy_03_Slowly_Changing_Dimensions_Type1_Type2.sql — Examples implementing SCD Type 1 and Type 2 using MERGE and history tables.
- CaseStudy_04_Performance_Tuning.sql — Query rewrites, index recommendations, and before/after performance comparisons.
- CaseStudy_05_Data_Validation_Cleaning.sql — Data quality checks, normalization routines, and idempotent cleanup steps.
- prep_sample_data.sql — Creates sample schema and seed data used by the case studies.
- cleanup_sample_data.sql — Removes objects created by prep_sample_data.sql.
- utilities/ — Optional helper scripts (data generators, small loaders, splitters). Keep utility scripts short and focused.

How to run a case study
1. Read the header comments in the chosen CaseStudy_*.sql for prerequisites and required objects.
2. Run prep_sample_data.sql in a test database (if the case study depends on it).
3. Execute the CaseStudy_*.sql in SSMS or via sqlcmd.
4. When finished, run cleanup_sample_data.sql to drop sample objects.

Conventions
- File names use the prefix "CaseStudy_##_" for ordering.
- Each case study must include a header with: purpose, prerequisites, required objects, steps to run, and expected outcome.
- Helper scripts should be idempotent where possible (safe to run multiple times).

Contributing
- Add new case studies with clear headers and minimal external dependencies.
- Place reusable helpers in utilities/ and reference them from the case study headers.
- Keep examples small, focused, and documented.

README.md describes only the files inside this folder.
