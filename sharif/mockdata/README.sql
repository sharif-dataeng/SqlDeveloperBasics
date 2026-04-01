-- ===== ADVENTUREWORKMOCK DATABASE BUILD SEQUENCE =====
-- 
-- This folder contains scripts for building the AdventureWorkMock database
-- and populating it with dimension tables and mock data.
-- 
-- EXECUTION ORDER:
-- ===============

-- 1. PRIMARY SETUP
-- ================

-- 1_mock_database.sql
--   • Creates AdventureWorkMock database
--   • Creates schemas: Person, HumanResources, Production, Sales
--   • Creates all OLTP base tables with proper constraints
--   • Creates update triggers for ModifiedDate fields
--   Execution Time: ~30 seconds
--   Dependencies: None

-- 2. SECURITY SETUP
-- ====================

-- 2_create_users.sql
--   • Creates database users and roles
--   • Sets up permissions and access controls
--   • Assigns roles to users
--   Execution Time: ~10 seconds
--   Dependencies: 1_mock_database.sql

-- 3. DATA WAREHOUSE LAYER
-- =======================

-- 3_dimension_tables.sql
--   • Creates dimension tables: DimCustomer, DimEmployee, DimProduct
--   • Creates indexes for performance optimization
--   • Defines surrogate keys for DW usage
--   Execution Time: ~5 seconds
--   Dependencies: 1_mock_database.sql

-- 4_populate_dimensions_scd1.sql
--   • Populates dimension tables from OLTP base tables
--   • Uses MERGE statements for SCD Type 1 logic
--   • Overwrites dimensional attributes when changed
--   • Includes data validation queries
--
--   Joins:
--     - DimCustomer: Customer → Person → Address → EmailAddress → Phone
--     - DimEmployee: Employee → Person → Department → Shift
--     - DimProduct: Product → ProductModel → Category → Subcategory
--   
--   Execution Time: Depends on data volume
--   Dependencies: 1_mock_database.sql, 3_dimension_tables.sql

-- 4. MOCK DATA LOADING (CONSOLIDATED)
-- =====================================

-- 4_mockdataload.sql
--   • CONSOLIDATED script loading all mock data in one file
--   • Section 1: Customer data (BusinessEntity, Person, Customer, EmailAddress, Phone, Address)
--   • Section 2: Employee data (Department, Shift, Employee, EmployeeDepartmentHistory)
--   • Section 3: Product data (ProductCategory, ProductSubcategory, ProductModel, Product)
--   • Sample data: ~100-500 customers, ~50-300 employees, ~500-2000 products
--   • Execution Time: ~45 seconds
--   Dependencies: 1_mock_database.sql

-- 5. DIMENSION POPULATION (SCD TYPE 1)
-- =====================================

-- 5_populate_dimensions_scd1.sql
--   • Populates dimension tables from OLTP base tables
--   • Uses MERGE statements for SCD Type 1 logic
--   • Overwrites dimensional attributes when changed
--   • Populates DimCustomer, DimEmployee, DimProduct
--   • Includes data validation queries
--   Execution Time: Depends on data volume
--   Dependencies: 1_mock_database.sql, 3_dimension_tables.sql, 4_mockdataload.sql

-- 6. FACT TABLES & DATA WAREHOUSE ANALYTICS
-- ==========================================

-- 6_fact_tables.sql
--   • Creates three fact tables: FactSales, FactInventory, FactProductionCost
--   • FactSales: Transaction fact table for sales analysis (grain: order line)
--   • FactInventory: Snapshot fact table for inventory management (grain: product/date)
--   • FactProductionCost: Semi-additive for manufacturing analysis (grain: product/date)
--   • Includes foreign keys and performance indexes
--   Execution Time: ~10 seconds
--   Dependencies: 3_dimension_tables.sql

-- 7_populate_fact_sales.sql
--   • Populates FactSales with transaction data
--   • Simulates 500+ sales orders with line items
--   • Uses MERGE for SCD Type 1 logic
--   • Joins Customer → Product → Employee relationships
--   • Calculates LineTotal, Discount, Tax, Freight
--   Execution Time: ~15 seconds
--   Dependencies: 3_dimension_tables.sql, 6_fact_tables.sql, 5_populate_dimensions_scd1.sql

-- 8_populate_fact_inventory.sql
--   • Populates FactInventory with snapshot data
--   • Creates 12-month inventory history (one row per product per month)
--   • Calculates inventory status (Critical, Low, Optimal, Overstock)
--   • Computes DaysOfSupply and InventoryTurnoverRatio
--   • Identifies stock-outs and backorder situations
--   Execution Time: ~20 seconds
--   Dependencies: 3_dimension_tables.sql, 6_fact_tables.sql, 5_populate_dimensions_scd1.sql

-- 9_populate_fact_production_cost.sql
--   • Populates FactProductionCost with production records
--   • Simulates 30 days of production history
--   • Tracks StandardCost vs ActualCost with variance analysis
--   • Calculates DefectRate, LaborEfficiency, MachineryUtilization
--   • Monitors production status (Planned, In Progress, Completed, Delayed)
--   Execution Time: ~15 seconds
--   Dependencies: 3_dimension_tables.sql, 6_fact_tables.sql, 5_populate_dimensions_scd1.sql

-- 7. VALIDATION & CONTROL
-- =======================

-- 10_data_validation.sql
--   • Validates data integrity across all tables
--   • Provides record counts for all tables
--   • Checks for referential integrity issues
--   • Generates data quality reports
--   Execution Time: ~5 seconds
--   Dependencies: All previous scripts

-- 6. REFERENCE DOCUMENTATION
-- ===========================

-- _reference_dimension_columns.sql
--   • Reference guide for dimension table column mappings
--   • Shows which source tables are used
--   • Documents join paths for ETL development
--   • Not executable - for reference only

-- _reference_tables_list.sql
--   • Complete4_mockdataload.sql (consolidated customer, employee, product data)
-- 5. Execute: 5_populate_dimensions_scd1.sql
-- 6. Execute: 6_fact_tables.sql
-- 7. Execute: 7_populate_fact_sales.sql
-- 8. Execute: 8_populate_fact_inventory.sql
-- 9. Execute: 9_populate_fact_production_cost.sql
-- 10. Execute: 10==============================================
-- 1. Execute: 1_mock_database.sql
-- 2. Execute: 2_create_users.sql
-- 3. Execute: 3_dimension_tables.sql
-- 4. Execute: 5_load_customer_mockdata.sql
-- 5. Execute: 6_load_employee_mockdata.sql
-- 6. Execute: 7_load_product_mockdata.sql
-- 7. Execute: 4_populate_dimensions_scd1.sql
-- 8. Execute: 9_fact_tables.sql
-- 9. Execute: 10_populate_fact_sales.sql
-- 10. Execute: 11_populate_fact_inventory.sql
-- 11. Execute: 12_populate_fact_production_cost.sql
-- 12. Execute: 8_data_validation.sql
--
-- Option B: Quick Development Build
-- ==================================
-- 1. Execute: 1_mock_database.sql (includes base tables)
-- 2. Execute: 3_dimension_tables.sql
-- 3. Execute: 4_populate_dimensions_scd1.sql
--
-- Option C: Fact Tables Only (Requires existing Dimensions & Data)
-- ================================================================
-- 1. Execute: 6_fact_tables.sql
-- 2. Execute: 7_populate_fact_sales.sql
-- 3. Execute: 8_populate_fact_inventory.sql
-- 4. Execute: 9_populate_fact_production_cost.sql

-- Option D: Dimension Refresh Only
-- =================================
-- 1. Manually truncate dimension tables
-- 2. Execute: 5_populate_dimensions_scd1.sql

-- ===== COMMAND LINE EXECUTION =====
--
-- Execute all scripts in order (Full Build):
-- sqlcmd -S "YOUR_SERVER" -E -i 1_mock_database.sql
-- sqlcmd -S "YOUR_SERVER" -E -i 2_create_users.sql
-- sqlcmd -S "YOUR_SERVER" -E -i 3_dimension_tables.sql
-- sqlcmd -S "YOUR_SERVER" -E -i 4_mockdataload.sql
-- sqlcmd -S "YOUR_SERVER" -E -i 5_populate_dimensions_scd1.sql
-- sqlcmd -S "YOUR_SERVER" -E -i 6_fact_tables.sql
-- sqlcmd -S "YOUR_SERVER" -E -i 7_populate_fact_sales.sql
-- sqlcmd -S "YOUR_SERVER" -E -i 8_populate_fact_inventory.sql
-- sqlcmd -S "YOUR_SERVER" -E -i 9_populate_fact_production_cost.sql
-- sqlcmd -S "YOUR_SERVER" -E -i 10_data_validation.sql

-- ===== NOTES =====
--
-- • All scripts use DROP IF EXISTS for idempotency
-- • Can be run multiple times safely
-- • Dimension table population uses SCD Type 1 (overwrites old values)
-- • XML data types converted to varchar(max) for compatibility
-- • All tables include audit fields: rowguid, ModifiedDate
-- • Data validation script shows final record counts

-- ===== TROUBLESHOOTING =====
--
-- If execution fails:
-- 1. Verify SQL Server is running and accessible
-- 2. Check user has CREATE DATABASE and dbo permissions
-- 3. Run scripts individually to identify which one fails
-- 4. Check error messages in SQL Server error log
-- 5. Ensure sufficient disk space for database
-- 6. Review dependencies - scripts may need to run in order
