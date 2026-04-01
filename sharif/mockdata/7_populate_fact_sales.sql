-- ===== FACT SALES POPULATION SCRIPT - SCD TYPE 1 =====
-- Purpose: Populate FactSales from OLTP source tables
-- Logic: MERGE statement to INSERT new sales and UPDATE existing ones
-- Note: In a real scenario, you would have actual SalesOrderHeader and SalesOrderDetail tables

USE [AdventureWorkMock];
GO

/* ===== POPULATE FactSales =====
   Source Tables:
   - Sales.Customer (business key for customer)
   - Person.Person (salesperson information)
   - Production.Product (product information)
   - Sales.SalesTerritory (territory info)
   
   Join Logic:
   - Map Customer to DimCustomer via CustomerID
   - Map Product to DimProduct via ProductID
   - Map Employee (salesperson) to DimEmployee via BusinessEntityID
   - Generate date keys from order dates (simplified: using day as key)
*/

-- First, create a working table to simulate sales data
-- In production, this would come from actual SalesOrderHeader and SalesOrderDetail tables

IF OBJECT_ID('tempdb..#SalesData') IS NOT NULL
    DROP TABLE #SalesData;

CREATE TABLE #SalesData(
    OrderID INT,
    LineNumber SMALLINT,
    CustomerID INT,
    ProductID INT,
    EmployeeID INT,
    OrderDate DATE,
    ShipDate DATE,
    DueDate DATE,
    OrderQuantity SMALLINT,
    UnitPrice MONEY,
    DiscountPercent DECIMAL(8,4),
    TaxAmount MONEY,
    FreightAmount MONEY,
    CarrierTrackingNumber NVARCHAR(25),
    OrderStatus NVARCHAR(50),
    ShipMethod NVARCHAR(50)
);

-- Simulate sales transactions by creating sample orders
INSERT INTO #SalesData
SELECT
    ROW_NUMBER() OVER (ORDER BY c.CustomerID, p.ProductID) AS OrderID,
    1 AS LineNumber,
    c.CustomerID,
    p.ProductID,
    CASE WHEN e.BusinessEntityID IS NOT NULL THEN e.BusinessEntityID ELSE NULL END AS EmployeeID,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE()) AS OrderDate,
    DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 30), GETDATE()) AS ShipDate,
    DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 15), GETDATE()) AS DueDate,
    ABS(CHECKSUM(NEWID()) % 50) + 1 AS OrderQuantity,
    p.ListPrice AS UnitPrice,
    CASE WHEN ABS(CHECKSUM(NEWID()) % 100) > 80 THEN 0.10 ELSE 0.00 END AS DiscountPercent,
    p.ListPrice * (ABS(CHECKSUM(NEWID()) % 10) / 100.0) AS TaxAmount,
    CASE WHEN ABS(CHECKSUM(NEWID()) % 100) > 70 THEN 50.00 ELSE 0.00 END AS FreightAmount,
    SUBSTRING(MD5(CAST(RAND() AS VARCHAR(100))), 1, 15) AS CarrierTrackingNumber,
    CASE ABS(CHECKSUM(NEWID()) % 4)
        WHEN 0 THEN 'Pending'
        WHEN 1 THEN 'Shipped'
        WHEN 2 THEN 'Delivered'
        ELSE 'Completed'
    END AS OrderStatus,
    CASE ABS(CHECKSUM(NEWID()) % 3)
        WHEN 0 THEN 'Standard'
        WHEN 1 THEN 'Express'
        ELSE 'Overnight'
    END AS ShipMethod
FROM [Sales].[Customer] c
CROSS JOIN [Production].[Product] p
LEFT JOIN [HumanResources].[Employee] e ON ABS(CHECKSUM(NEWID()) % 100) > 50
WHERE ROW_NUMBER() OVER (ORDER BY c.CustomerID, p.ProductID) <= 500;  -- Limit to 500 sample records

-- Merge into FactSales
MERGE INTO [dbo].[FactSales] AS target
USING (
    SELECT
        dc.CustomerKey,
        dp.ProductKey,
        de.EmployeeKey,
        CAST(FORMAT(sd.OrderDate, 'yyyyMMdd') AS INT) AS OrderDateKey,
        CAST(FORMAT(sd.ShipDate, 'yyyyMMdd') AS INT) AS ShipDateKey,
        CAST(FORMAT(sd.DueDate, 'yyyyMMdd') AS INT) AS DueDateKey,
        sd.OrderID,
        sd.LineNumber,
        sd.OrderQuantity,
        sd.UnitPrice,
        CAST(sd.OrderQuantity * sd.UnitPrice * (1 - sd.DiscountPercent) AS NUMERIC(18, 2)) AS LineTotal,
        CAST(sd.OrderQuantity * sd.UnitPrice * sd.DiscountPercent AS MONEY) AS DiscountAmount,
        sd.DiscountPercent,
        sd.TaxAmount,
        sd.FreightAmount,
        sd.CarrierTrackingNumber,
        sd.OrderStatus,
        sd.ShipMethod
    FROM #SalesData sd
    INNER JOIN [dbo].[DimCustomer] dc ON sd.CustomerID = dc.CustomerAlternateKey
    INNER JOIN [dbo].[DimProduct] dp ON sd.ProductID = dp.ProductAlternateKey
    LEFT JOIN [dbo].[DimEmployee] de ON sd.EmployeeID = de.BusinessEntityID
) AS source
ON target.OrderID = source.OrderID AND target.LineNumber = source.LineNumber
WHEN MATCHED THEN
    UPDATE SET
        target.CustomerKey = source.CustomerKey,
        target.ProductKey = source.ProductKey,
        target.EmployeeKey = source.EmployeeKey,
        target.OrderQuantity = source.OrderQuantity,
        target.UnitPrice = source.UnitPrice,
        target.LineTotal = source.LineTotal,
        target.DiscountAmount = source.DiscountAmount,
        target.DiscountPercent = source.DiscountPercent,
        target.TaxAmount = source.TaxAmount,
        target.FreightAmount = source.FreightAmount,
        target.CarrierTrackingNumber = source.CarrierTrackingNumber,
        target.OrderStatus = source.OrderStatus,
        target.ShipMethod = source.ShipMethod,
        target.UpdateDate = GETDATE()
WHEN NOT MATCHED THEN
    INSERT (
        CustomerKey, ProductKey, EmployeeKey, OrderDateKey, ShipDateKey, DueDateKey,
        OrderID, LineNumber, OrderQuantity, UnitPrice, LineTotal, DiscountAmount,
        DiscountPercent, TaxAmount, FreightAmount, CarrierTrackingNumber, OrderStatus,
        ShipMethod, UpdateDate
    )
    VALUES (
        source.CustomerKey, source.ProductKey, source.EmployeeKey, source.OrderDateKey,
        source.ShipDateKey, source.DueDateKey, source.OrderID, source.LineNumber,
        source.OrderQuantity, source.UnitPrice, source.LineTotal, source.DiscountAmount,
        source.DiscountPercent, source.TaxAmount, source.FreightAmount,
        source.CarrierTrackingNumber, source.OrderStatus, source.ShipMethod, GETDATE()
    );

-- Cleanup
DROP TABLE #SalesData;

PRINT 'FactSales populated successfully!';
GO

-- Validation Query
SELECT 'FactSales' AS FactTable, COUNT(*) AS RecordCount FROM [dbo].[FactSales];
GO
