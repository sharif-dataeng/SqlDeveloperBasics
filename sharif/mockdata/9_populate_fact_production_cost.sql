-- ===== FACT PRODUCTION COST POPULATION SCRIPT =====
-- Purpose: Populate FactProductionCost from manufacturing/production data
-- Type: Semi-additive fact table (some measures cannot be summed across all dimensions)
-- Logic: One row per product per production date/batch

USE [AdventureWorkMock];
GO

/* ===== POPULATE FactProductionCost =====
   Source: Production data combined with employee and product information
   
   Note: In production, would source from:
   - Manufacturing execution system (MES)
   - Production control tables
   - Cost accounting system
   
   For this demo, generates production cost records
*/

-- Create working table for production data
IF OBJECT_ID('tempdb..#ProductionData') IS NOT NULL
    DROP TABLE #ProductionData;

CREATE TABLE #ProductionData(
    ProductID INT,
    EmployeeID INT,
    ProductionDate DATE,
    StandardCost MONEY,
    ActualCost MONEY,
    MaterialsCost MONEY,
    LaborCost MONEY,
    OverheadCost MONEY,
    UnitsProduced INT,
    UnitsCompleted INT,
    UnitsDefective INT,
    ScrapAmount MONEY,
    ScrapWeight DECIMAL(12, 2),
    PlannedProductionHours DECIMAL(10, 2),
    ActualProductionHours DECIMAL(10, 2),
    MachineryUtilizationRate DECIMAL(8, 4),
    ProductionStatus NVARCHAR(50),
    OnTimeCompletion BIT
);

-- Simulate production records
INSERT INTO #ProductionData
SELECT
    p.ProductAlternateKey AS ProductID,
    CASE WHEN e.BusinessEntityID IS NOT NULL THEN e.BusinessEntityID ELSE NULL END AS EmployeeID,
    DATEADD(DAY, -N, CAST(GETDATE() AS DATE)) AS ProductionDate,
    p.StandardCost,
    p.StandardCost * (1 + CAST(ABS(CHECKSUM(NEWID()) % 20) / 100.0 AS DECIMAL(8, 4))) AS ActualCost,
    p.StandardCost * 0.6 AS MaterialsCost,
    p.StandardCost * 0.25 AS LaborCost,
    p.StandardCost * 0.15 AS OverheadCost,
    ABS(CHECKSUM(NEWID()) % 500) + 10 AS UnitsProduced,
    ABS(CHECKSUM(NEWID()) % 500) + 5 AS UnitsCompleted,
    ABS(CHECKSUM(NEWID()) % 50) AS UnitsDefective,
    CAST(ABS(CHECKSUM(NEWID()) % 500) * 0.50 AS MONEY) AS ScrapAmount,
    CAST(ABS(CHECKSUM(NEWID()) % 100) * 0.25 AS DECIMAL(12, 2)) AS ScrapWeight,
    CAST(ABS(CHECKSUM(NEWID()) % 100) + 10 AS DECIMAL(10, 2)) AS PlannedProductionHours,
    CAST(ABS(CHECKSUM(NEWID()) % 120) + 5 AS DECIMAL(10, 2)) AS ActualProductionHours,
    CAST(ABS(CHECKSUM(NEWID()) % 100) / 100.0 AS DECIMAL(8, 4)) + 0.5 AS MachineryUtilizationRate,
    CASE ABS(CHECKSUM(NEWID()) % 4)
        WHEN 0 THEN 'Planned'
        WHEN 1 THEN 'In Progress'
        WHEN 2 THEN 'Completed'
        ELSE 'Delayed'
    END AS ProductionStatus,
    CASE WHEN ABS(CHECKSUM(NEWID()) % 100) > 20 THEN 1 ELSE 0 END AS OnTimeCompletion
FROM [dbo].[DimProduct] p
CROSS JOIN (SELECT TOP 365 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS N FROM master..spt_values) AS dates
CROSS APPLY (SELECT TOP 1 BusinessEntityID FROM [dbo].[DimEmployee] ORDER BY NEWID()) AS e
WHERE p.ProductAlternateKey IS NOT NULL
  AND CAST(GETDATE() AS DATE) = DATEADD(DAY, -N, CAST(GETDATE() AS DATE)) OR N < 30;  -- Limit to recent 30 days

-- Remove duplicates
DELETE FROM #ProductionData
WHERE ProductID NOT IN (SELECT DISTINCT ProductAlternateKey FROM [dbo].[DimProduct] WHERE ProductAlternateKey <= 50);

-- MERGE into FactProductionCost
MERGE INTO [dbo].[FactProductionCost] AS target
USING (
    SELECT
        dp.ProductKey,
        de.EmployeeKey,
        CAST(FORMAT(pd.ProductionDate, 'yyyyMMdd') AS INT) AS ProductionDateKey,
        pd.StandardCost,
        pd.ActualCost,
        pd.ActualCost - pd.StandardCost AS ActualCostVariance,
        CAST((pd.ActualCost - pd.StandardCost) / NULLIF(pd.StandardCost, 0) * 100 AS DECIMAL(8, 4)) AS CostVariancePercent,
        pd.MaterialsCost,
        pd.LaborCost,
        pd.OverheadCost,
        pd.UnitsProduced,
        pd.UnitsCompleted,
        pd.UnitsDefective,
        CAST(CASE WHEN pd.UnitsProduced > 0 THEN CAST(pd.UnitsDefective AS DECIMAL(8, 4)) / pd.UnitsProduced ELSE 0 END AS DECIMAL(8, 4)) AS DefectRate,
        pd.ScrapAmount,
        pd.ScrapWeight,
        pd.PlannedProductionHours,
        pd.ActualProductionHours,
        CAST(CASE WHEN pd.PlannedProductionHours > 0 THEN pd.ActualProductionHours / pd.PlannedProductionHours ELSE 0 END AS DECIMAL(8, 4)) AS LaborEfficiencyRatio,
        pd.MachineryUtilizationRate,
        pd.ProductionStatus,
        pd.OnTimeCompletion
    FROM #ProductionData pd
    INNER JOIN [dbo].[DimProduct] dp ON pd.ProductID = dp.ProductAlternateKey
    LEFT JOIN [dbo].[DimEmployee] de ON pd.EmployeeID = de.BusinessEntityID
) AS source
ON target.ProductKey = source.ProductKey 
   AND target.ProductionDateKey = source.ProductionDateKey
   AND (target.EmployeeKey = source.EmployeeKey OR (target.EmployeeKey IS NULL AND source.EmployeeKey IS NULL))
WHEN MATCHED THEN
    UPDATE SET
        target.StandardCost = source.StandardCost,
        target.ActualCost = source.ActualCost,
        target.ActualCostVariance = source.ActualCostVariance,
        target.CostVariancePercent = source.CostVariancePercent,
        target.MaterialsCost = source.MaterialsCost,
        target.LaborCost = source.LaborCost,
        target.OverheadCost = source.OverheadCost,
        target.UnitsProduced = source.UnitsProduced,
        target.UnitsCompleted = source.UnitsCompleted,
        target.UnitsDefective = source.UnitsDefective,
        target.DefectRate = source.DefectRate,
        target.ScrapAmount = source.ScrapAmount,
        target.ScrapWeight = source.ScrapWeight,
        target.PlannedProductionHours = source.PlannedProductionHours,
        target.ActualProductionHours = source.ActualProductionHours,
        target.LaborEfficiencyRatio = source.LaborEfficiencyRatio,
        target.MachineryUtilizationRate = source.MachineryUtilizationRate,
        target.ProductionStatus = source.ProductionStatus,
        target.OnTimeCompletion = source.OnTimeCompletion,
        target.UpdateDate = GETDATE()
WHEN NOT MATCHED THEN
    INSERT (
        ProductKey, EmployeeKey, ProductionDateKey, StandardCost, ActualCost, ActualCostVariance,
        CostVariancePercent, MaterialsCost, LaborCost, OverheadCost, UnitsProduced, UnitsCompleted,
        UnitsDefective, DefectRate, ScrapAmount, ScrapWeight, PlannedProductionHours,
        ActualProductionHours, LaborEfficiencyRatio, MachineryUtilizationRate, ProductionStatus,
        OnTimeCompletion, UpdateDate
    )
    VALUES (
        source.ProductKey, source.EmployeeKey, source.ProductionDateKey, source.StandardCost,
        source.ActualCost, source.ActualCostVariance, source.CostVariancePercent,
        source.MaterialsCost, source.LaborCost, source.OverheadCost, source.UnitsProduced,
        source.UnitsCompleted, source.UnitsDefective, source.DefectRate, source.ScrapAmount,
        source.ScrapWeight, source.PlannedProductionHours, source.ActualProductionHours,
        source.LaborEfficiencyRatio, source.MachineryUtilizationRate, source.ProductionStatus,
        source.OnTimeCompletion, GETDATE()
    );

-- Cleanup
DROP TABLE #ProductionData;

PRINT 'FactProductionCost populated successfully!';
GO

-- Validation Query
SELECT 
    'FactProductionCost' AS FactTable, 
    COUNT(*) AS RecordCount,
    COUNT(DISTINCT ProductKey) AS DistinctProducts,
    COUNT(DISTINCT EmployeeKey) AS DistinctEmployees,
    AVG(ActualCost) AS AvgActualCost,
    AVG(DefectRate) AS AvgDefectRate,
    AVG(LaborEfficiencyRatio) AS AvgLaborEfficiency
FROM [dbo].[FactProductionCost];
GO

-- Cost Variance Summary
SELECT 
    ProductionStatus,
    COUNT(*) AS RecordCount,
    AVG(ActualCost) AS AvgActualCost,
    AVG(ActualCostVariance) AS AvgCostVariance,
    AVG(CostVariancePercent) AS AvgVariancePercent,
    AVG(DefectRate) AS AvgDefectRate,
    SUM(ScrapAmount) AS TotalScrapAmount
FROM [dbo].[FactProductionCost]
GROUP BY ProductionStatus;
GO
