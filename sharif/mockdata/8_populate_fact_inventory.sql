-- ===== FACT INVENTORY POPULATION SCRIPT =====
-- Purpose: Populate FactInventory snapshot from product inventory data
-- Type: Daily/periodic snapshot of inventory levels
-- Logic: One row per product per date

USE [AdventureWorkMock];
GO

/* ===== POPULATE FactInventory =====
   Source: DimProduct with calculated inventory metrics
   
   Note: In production, would source from:
   - Production.ProductInventory (actual inventory tables)
   - Actual warehouse data
   
   For this demo, generates inventory snapshots based on product data
*/

-- Create working table for inventory data
IF OBJECT_ID('tempdb..#InventoryData') IS NOT NULL
    DROP TABLE #InventoryData;

CREATE TABLE #InventoryData(
    ProductID INT,
    InventoryDate DATE,
    QuantityOnHand INT,
    QuantityReserved INT,
    SafetyStockLevel SMALLINT,
    ReorderPoint SMALLINT
);

-- Simulate inventory snapshots
-- In production, this would come from actual inventory tables
INSERT INTO #InventoryData
SELECT
    p.ProductAlternateKey AS ProductID,
    CAST(EOMONTH(GETDATE(), -N) AS DATE) AS InventoryDate,
    ABS(CHECKSUM(NEWID()) % 500) + p.SafetyStockLevel AS QuantityOnHand,
    ABS(CHECKSUM(NEWID()) % 100) AS QuantityReserved,
    p.SafetyStockLevel,
    p.ReorderPoint
FROM [dbo].[DimProduct] p
CROSS APPLY (VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11)) AS N(N)
WHERE p.ProductAlternateKey IS NOT NULL;

-- MERGE into FactInventory
MERGE INTO [dbo].[FactInventory] AS target
USING (
    SELECT
        dp.ProductKey,
        CAST(FORMAT(id.InventoryDate, 'yyyyMMdd') AS INT) AS InventoryDateKey,
        id.QuantityOnHand,
        id.QuantityReserved,
        id.QuantityOnHand - id.QuantityReserved AS QuantityAvailable,
        id.SafetyStockLevel,
        id.ReorderPoint,
        CASE 
            WHEN (id.QuantityOnHand - id.QuantityReserved) <= id.ReorderPoint THEN id.ReorderPoint - (id.QuantityOnHand - id.QuantityReserved)
            ELSE 0
        END AS UnitsToOrder,
        CASE 
            WHEN (id.QuantityOnHand - id.QuantityReserved) <= id.SafetyStockLevel THEN id.SafetyStockLevel - (id.QuantityOnHand - id.QuantityReserved)
            ELSE 0
        END AS UnitsToManufacture,
        CAST(
            CASE 
                WHEN ABS(CHECKSUM(NEWID()) % 100) > 80 THEN (id.QuantityOnHand - id.QuantityReserved) / NULLIF(ABS(CHECKSUM(NEWID()) % 50) + 1, 0)
                ELSE 30.0
            END AS DECIMAL(8, 2)
        ) AS DaysOfSupply,
        CAST(ABS(CHECKSUM(NEWID()) % 8) + 2 AS DECIMAL(8, 4)) AS InventoryTurnoverRatio,
        CASE 
            WHEN (id.QuantityOnHand - id.QuantityReserved) = 0 THEN 'Discontinued'
            WHEN (id.QuantityOnHand - id.QuantityReserved) < id.SafetyStockLevel THEN 'Critical'
            WHEN (id.QuantityOnHand - id.QuantityReserved) < id.ReorderPoint THEN 'Low'
            WHEN (id.QuantityOnHand - id.QuantityReserved) > id.SafetyStockLevel * 2 THEN 'Overstock'
            ELSE 'Optimal'
        END AS InventoryStatus,
        CASE WHEN (id.QuantityOnHand - id.QuantityReserved) = 0 THEN 1 ELSE 0 END AS IsStockOut,
        CASE WHEN (id.QuantityOnHand - id.QuantityReserved) < 0 THEN 1 ELSE 0 END AS IsBackorder
    FROM #InventoryData id
    INNER JOIN [dbo].[DimProduct] dp ON id.ProductID = dp.ProductAlternateKey
) AS source
ON target.ProductKey = source.ProductKey 
   AND target.InventoryDateKey = source.InventoryDateKey
WHEN MATCHED THEN
    UPDATE SET
        target.QuantityOnHand = source.QuantityOnHand,
        target.QuantityReserved = source.QuantityReserved,
        target.QuantityAvailable = source.QuantityAvailable,
        target.SafetyStockLevel = source.SafetyStockLevel,
        target.ReorderPoint = source.ReorderPoint,
        target.UnitsToManufacture = source.UnitsToManufacture,
        target.UnitsToOrder = source.UnitsToOrder,
        target.DaysOfSupply = source.DaysOfSupply,
        target.InventoryTurnoverRatio = source.InventoryTurnoverRatio,
        target.InventoryStatus = source.InventoryStatus,
        target.IsStockOut = source.IsStockOut,
        target.IsBackorder = source.IsBackorder,
        target.UpdateDate = GETDATE()
WHEN NOT MATCHED THEN
    INSERT (
        ProductKey, InventoryDateKey, QuantityOnHand, QuantityReserved, QuantityAvailable,
        SafetyStockLevel, ReorderPoint, UnitsToManufacture, UnitsToOrder, DaysOfSupply,
        InventoryTurnoverRatio, InventoryStatus, IsStockOut, IsBackorder, UpdateDate
    )
    VALUES (
        source.ProductKey, source.InventoryDateKey, source.QuantityOnHand, source.QuantityReserved,
        source.QuantityAvailable, source.SafetyStockLevel, source.ReorderPoint,
        source.UnitsToManufacture, source.UnitsToOrder, source.DaysOfSupply,
        source.InventoryTurnoverRatio, source.InventoryStatus, source.IsStockOut,
        source.IsBackorder, GETDATE()
    );

-- Cleanup
DROP TABLE #InventoryData;

PRINT 'FactInventory populated successfully!';
GO

-- Validation Query
SELECT 
    'FactInventory' AS FactTable, 
    COUNT(*) AS RecordCount,
    COUNT(DISTINCT ProductKey) AS DistinctProducts,
    COUNT(DISTINCT InventoryDateKey) AS DistinctDates
FROM [dbo].[FactInventory];
GO

-- Inventory Status Summary
SELECT 
    InventoryStatus,
    COUNT(*) AS RecordCount,
    AVG(QuantityOnHand) AS AvgQuantityOnHand,
    AVG(QuantityAvailable) AS AvgQuantityAvailable,
    AVG(DaysOfSupply) AS AvgDaysOfSupply
FROM [dbo].[FactInventory]
GROUP BY InventoryStatus;
GO
