# FMCG Data Merger Pipeline 🚀  
**Scalable ELT Pipeline using Databricks & AWS**

A production-grade ELT pipeline designed to integrate a newly acquired startup’s sales data into a global FMCG enterprise data ecosystem using **Medallion Architecture**.

---

## 📋 Project Overview

<img width="20005" height="11129" alt="project_architecture" src="https://github.com/user-attachments/assets/0381fd35-7375-4e1c-ae43-e7c939997d92" />


### 🏢 Business Scenario
A global FMCG enterprise (**Atlikon**) acquired a nutrition startup (**SportsBar**).

- **Atlikon** operates on a modern **Databricks Lakehouse**
- **SportsBar** delivers raw **CSV files in AWS S3**
- No unified or trusted view of **global revenue**

### ❌ The Problem
- Disparate data platforms  
- Dirty, inconsistent schemas  
- No incremental processing  
- No enterprise-level governance  

### ✅ The Solution
Designed and implemented a **scalable, auditable, incremental ELT pipeline** that:
- Ingests startup data from S3
- Cleans and standardizes it
- Merges it into the enterprise **Gold layer**
- Produces a **single source of truth** for analytics

---

## 🏗️ Architecture

AWS S3 (Raw CSVs) --> 
Bronze Layer (Raw Ingest) -->
Silver Layer (Cleansed & Standardized) -->
Gold Layer (Business-Ready Facts & Dimensions) -->
Semantic View (BI / Dashboards)


---

## 🧰 Tech Stack

| Layer | Technology |
|------|-----------|
| Cloud Storage | AWS S3 |
| Compute & Orchestration | Databricks Workflows & Jobs |
| Transformations | PySpark & Spark SQL |
| Lakehouse | Delta Lake |
| Architecture Pattern | Medallion (Bronze → Silver → Gold) |
| Governance | Unity Catalog |

---

## 🚀 Key Features

### 🔄 Incremental Loading
- Implemented **Staging Table Pattern**
- Processes **only new daily files**
- Recomputes monthly aggregates to handle **late-arriving data**

### 🧹 Data Quality & Schema Handling
- Schema mismatches handled:
  - `product_id` → `product_code`
- City typos corrected:
  - `"Bengaluruu"` → `"Bengaluru"`
- Implemented **Dictionary Mapping + Regex Cleaning**

### 🧠 SCD Type Logic
- Implemented **Price Versioning**
- Used **Window Functions** to select latest valid price per fiscal year

### ⏱️ Orchestration
- Automated Databricks **DAGs**
- Dependency-driven execution:
  - Dimensions → Facts
- Email alerting on failures

### 🔍 Auditability & Lineage
- Metadata columns added:
  - `ingestion_timestamp`
  - `source_file`
- Enables full **data lineage & debugging**

---

## 📂 Repository Structure

```bash
├── 01_setup/
│   ├── 01_setup_catalog.sql      # Unity Catalog schemas & tables
│   ├── 01_dim_date.py            # Programmatic Date Dimension
│   └── 03_config.py              # Centralized configuration
│
├── 02_dimension_processing/
│   ├── 1_customers.py            # Customer cleaning & ID mapping
│   ├── 2_products.py             # Regex cleanup & hashing
│   └── 3_pricing.py              # Dirty dates & price versioning
│
├── 03_fact_processing/
│   ├── 01_full_load.py           # Historical load
│   └── 02_incremental_load.py    # Daily incremental upsert logic
│
└── README.md
