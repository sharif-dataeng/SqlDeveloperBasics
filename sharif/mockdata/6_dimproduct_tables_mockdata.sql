-- =========================================================
-- dimproduct_tables_mockdata.sql
-- Purpose: Small product-dimension seed data for Production schema.
-- Dependency order and notes:
-- 1) ProductCategory  - master lookup for product categories
-- 2) ProductSubcategory - FK -> ProductCategory (ProductCategoryID)
-- 3) ProductModel     - product model metadata referenced by Product
-- 4) Product          - references ProductSubcategoryID and ProductModelID
--
-- Usage:
-- - Run the sections in the order above to avoid FK constraint errors.
-- - Many tables include `rowguid` and `ModifiedDate` populated here
--   using `NEWID()` and `GETDATE()` for convenience.
-- - If any table uses an IDENTITY primary key and you want to insert
--   explicit integer keys (e.g., ProductCategoryID = 1), enable:
--     SET IDENTITY_INSERT Production.<TableName> ON
--   then run the INSERTs and disable it afterwards.
-- - Consider wrapping the whole run in a transaction to roll back on error.
-- =========================================================


-- =========================
-- 1) ProductCategory (lookup)
-- =========================

-- select * from [Production].[ProductCategory]

INSERT INTO [Production].[ProductCategory]
    (Name, rowguid, ModifiedDate)
VALUES
    ('Bikes', NEWID(), GETDATE()),
    ('Components', NEWID(), GETDATE()),
    ('Clothing', NEWID(), GETDATE()),
    ('Accessories', NEWID(), GETDATE()),
    ('Services', NEWID(), GETDATE());


-- =========================
-- 2) ProductSubcategory (depends on ProductCategory)
-- Notes: `ProductCategoryID` must match inserted ProductCategory keys.
-- If ProductCategory uses identity PKs, either insert without explicit
-- IDs or use `SET IDENTITY_INSERT` as described above.
-- =========================

-- select * from [Production].[ProductSubcategory]

INSERT INTO [Production].[ProductSubcategory]
    (ProductCategoryID, Name, rowguid, ModifiedDate)
VALUES
    (1, 'Mountain Bikes', NEWID(), GETDATE()),   -- under Bikes
    (2, 'Brakes', NEWID(), GETDATE()),           -- under Components
    (3, 'Jerseys', NEWID(), GETDATE()),          -- under Clothing
    (4, 'Helmets', NEWID(), GETDATE()),          -- under Accessories
    (5, 'Maintenance Plans', NEWID(), GETDATE());-- under Services


-- =========================
-- 3) ProductModel (independent metadata used by Product)
-- Notes: ProductModel rows are referenced by Product.ProductModelID.
-- Ensure the ProductModelID values align with your Product inserts.
-- =========================

-- select * from [Production].[ProductModel]

INSERT INTO [Production].[ProductModel]
    (Name, CatalogDescription, Instructions, rowguid, ModifiedDate)
VALUES
    ('Mountain Bike Model A', NULL, NULL, NEWID(), GETDATE()),
    ('Road Bike Model B', NULL, NULL, NEWID(), GETDATE()),
    ('Hybrid Bike Model C', NULL, NULL, NEWID(), GETDATE()),
    ('Helmet Model D', NULL, NULL, NEWID(), GETDATE()),
    ('Jersey Model E', NULL, NULL, NEWID(), GETDATE());


-- =========================
-- 4) Product (depends on ProductSubcategory and ProductModel)
-- Notes:
-- - `ProductSubcategoryID` must reference a valid ProductSubcategory row.
-- - `ProductModelID` must reference a valid ProductModel row.
-- - Numeric/cost fields (StandardCost, ListPrice) use sample values —
--   adjust precision/scales to match your schema.
-- =========================

-- select * from [Production].[Product]

INSERT INTO [Production].[Product]
    (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color,
     SafetyStockLevel, ReorderPoint, StandardCost, ListPrice,
     Size, Weight, ProductSubcategoryID, ProductModelID,
     DaysToManufacture, SellStartDate, SellEndDate, DiscontinuedDate,
     rowguid, ModifiedDate)
VALUES
    ('Mountain Bike 100', 'BK-M100', 1, 1, 'Red',
     100, 50, 500.00, 800.00, 'M', 15.0, 1, 1,
     5, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),

    ('Road Bike 200', 'BK-R200', 1, 1, 'Blue',
     120, 60, 700.00, 1200.00, 'L', 14.5, 2, 2,
     6, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),

    ('Hybrid Bike 300', 'BK-H300', 1, 1, 'Green',
     80, 40, 600.00, 1000.00, 'M', 13.0, 3, 3,
     4, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),

    ('Helmet Pro', 'HL-PRO', 0, 1, 'Black',
     50, 20, 25.00, 50.00, NULL, NULL, 4, 4,
     0, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),

    ('Jersey Elite', 'JS-ELT', 0, 1, 'White',
     60, 30, 30.00, 75.00, 'L', NULL, 5, 5,
     0, '2020-01-01', NULL, NULL, NEWID(), GETDATE());