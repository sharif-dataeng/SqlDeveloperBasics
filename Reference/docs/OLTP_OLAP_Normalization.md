# OLTP, OLAP, Normalized & Denormalized Data — Explanations + Visuals

This document provides step-by-step explanations and visual diagrams for:
- OLTP (Online Transaction Processing)
- OLAP (Online Analytical Processing)
- Normalized data
- Denormalized data

Open the images in docs\images for the diagrams referenced below.

---

## OLTP (Online Transaction Processing)

Definition
- Systems for day-to-day transactional workloads (INSERT/UPDATE/DELETE). Examples: POS, order-entry, banking.

Key points (step-by-step)
1. High volume of short, atomic transactions.
2. Strong concurrency for many users.
3. Low-latency response and ACID guarantees.
4. Schema is normalized to avoid redundancy.
5. Optimized for row operations, indexes for point lookups.

Visual
![OLTP diagram](images/oltp.svg)

---

## OLAP (Online Analytical Processing)

Definition
- Systems for analytics, reporting and aggregations. Examples: data warehouse, BI cubes.

Key points (step-by-step)
1. Read-heavy complex queries and aggregations.
2. Data loaded in batches via ETL/ELT from OLTP or sources.
3. Schema optimized for queries (star/snowflake) and often denormalized.
4. Uses columnar storage, materialized views or pre-aggregations for speed.
5. Lower concurrency but heavier queries.

Visual
![OLAP diagram](images/olap.svg)

---

## Normalized Data

Definition
- Schema organized by normal forms (1NF, 2NF, 3NF...) to reduce redundancy and anomalies.

Step-by-step normalization
1. 1NF: Ensure atomic column values.
2. 2NF: Remove partial dependencies.
3. 3NF: Remove transitive dependencies.

Example (before / after)
- Denormalized table: OrderID, CustomerName, CustomerEmail, ProductID, ProductName, Qty, Price
- Normalized result: Customers, Products, Orders, OrderItems

Visual
![Normalization diagram](images/normalization.svg)

Pros / Cons
- Pros: Less storage, consistent updates, fewer anomalies.
- Cons: More joins in queries → can be slower for analytical reads.

---

## Denormalized Data

Definition
- Intentional duplication of data to reduce JOINs and speed reads (common in OLAP / reporting).

Techniques
1. Add redundant columns to reduce joins (store CustomerName on Orders).
2. Create summary/aggregate tables or materialized views.
3. Flatten dimensional model for fast reads.

Example
- Normalized multi-join report vs single wide denormalized OrdersFlat table.

Visual
![Denormalization diagram](images/denormalization.svg)

Pros / Cons
- Pros: Faster reads and simpler queries.
- Cons: Extra storage and more complex writes / risk of inconsistency.

---

## How to get a PowerPoint with these visuals

A script is included to generate a PPTX that embeds these diagram images.

See: scripts\create_presentation.py

Windows run steps (from repository root)
1. Open PowerShell or cmd in the repository folder:
   cd c:\gitroot\SqlDeveloperBasicsX
2. Install requirements:
   python -m pip install python-pptx cairosvg
3. Run the script:
   python .\scripts\create_presentation.py
4. Output: ppt\OLTP_OLAP_Normalization.pptx

---

If you want the PPTX created directly in the repository now, confirm and I will generate the files (slides + embedded images).