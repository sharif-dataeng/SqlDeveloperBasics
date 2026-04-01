-- ===== FACT TABLES CREATION SCRIPT =====
-- Purpose: Create fact tables for AdventureWorkMock data warehouse
-- Fact Tables: FactSales, FactInventory, FactProductionCost

USE [AdventureWorkMock];
GO

/* ===== FactSales =====
   Purpose: Core fact table for sales transactions
   Grain: One row per sales order line item
   Type: Transaction fact table
   
   Keys: CustomerKey, ProductKey, EmployeeKey (salesperson), FactSalesKey
   Dimensions: Time (Order Date, Ship Date, Due Date), Customer, Product, Employee
   
   Business Event: Customer purchase transaction
   Measures: Quantity, Revenue, Discount, Tax, Freight
*/
CREATE TABLE [dbo].[FactSales](
    [FactSalesKey] [int] IDENTITY(1,1) NOT NULL,
    [CustomerKey] [int] NOT NULL,
    [ProductKey] [int] NOT NULL,
    [EmployeeKey] [int] NULL,  -- Salesperson who made the sale
    [OrderDateKey] [int] NOT NULL,  -- Date key for order date (will join to DimTime if created)
    [ShipDateKey] [int] NULL,
    [DueDateKey] [int] NULL,
    
    -- Degenerate Dimensions (attributes that don't warrant their own dimension)
    [OrderID] [int] NOT NULL,
    [LineNumber] [smallint] NOT NULL,
    [OrderQuantity] [smallint] NOT NULL,
    [UnitPrice] [money] NOT NULL,
    [LineTotal] [numeric](18, 2) NOT NULL,
    [DiscountAmount] [money] NULL,
    [DiscountPercent] [decimal](8, 4) NULL,
    [TaxAmount] [money] NULL,
    [FreightAmount] [money] NULL,
    [CarrierTrackingNumber] [nvarchar](25) NULL,
    [OrderStatus] [nvarchar](50) NULL,
    [ShipMethod] [nvarchar](50) NULL,
    
    -- Audit Fields
    [LoadDate] [datetime] NOT NULL DEFAULT GETDATE(),
    [UpdateDate] [datetime] NOT NULL DEFAULT GETDATE(),
    
    CONSTRAINT [PK_FactSales_FactSalesKey] PRIMARY KEY CLUSTERED ([FactSalesKey] ASC),
    CONSTRAINT [FK_FactSales_Customer] FOREIGN KEY ([CustomerKey]) REFERENCES [dbo].[DimCustomer]([CustomerKey]),
    CONSTRAINT [FK_FactSales_Product] FOREIGN KEY ([ProductKey]) REFERENCES [dbo].[DimProduct]([ProductKey]),
    CONSTRAINT [FK_FactSales_Employee] FOREIGN KEY ([EmployeeKey]) REFERENCES [dbo].[DimEmployee]([EmployeeKey])
);
GO

-- Create indexes on fact table
CREATE NONCLUSTERED INDEX [IX_FactSales_CustomerKey] 
ON [dbo].[FactSales] ([CustomerKey]);
GO

CREATE NONCLUSTERED INDEX [IX_FactSales_ProductKey] 
ON [dbo].[FactSales] ([ProductKey]);
GO

CREATE NONCLUSTERED INDEX [IX_FactSales_OrderDateKey] 
ON [dbo].[FactSales] ([OrderDateKey]);
GO

CREATE NONCLUSTERED INDEX [IX_FactSales_EmployeeKey] 
ON [dbo].[FactSales] ([EmployeeKey]);
GO

/* ===== FactInventory =====
   Purpose: Snapshot fact table for inventory levels
   Grain: One row per product per date
   Type: Accumulating snapshot fact table
   
   Keys: InventoryKey, ProductKey, InventoryDateKey
   Dimensions: Product, Time (Inventory Date)
   
   Business Event: Daily inventory snapshot
   Measures: QuantityOnHand, QuantityReserved, QuantityAvailable
*/
CREATE TABLE [dbo].[FactInventory](
    [FactInventoryKey] [int] IDENTITY(1,1) NOT NULL,
    [ProductKey] [int] NOT NULL,
    [InventoryDateKey] [int] NOT NULL,
    
    -- Inventory Metrics
    [QuantityOnHand] [int] NOT NULL,
    [QuantityReserved] [int] NOT NULL,
    [QuantityAvailable] [int] NOT NULL,
    [SafetyStockLevel] [smallint] NOT NULL,
    [ReorderPoint] [smallint] NOT NULL,
    [UnitsToManufacture] [int] NULL,
    [UnitsToOrder] [int] NULL,
    [DaysOfSupply] [decimal](8, 2) NULL,
    [InventoryTurnoverRatio] [decimal](8, 4) NULL,
    
    -- Inventory Status
    [InventoryStatus] [nvarchar](50) NULL,  -- Optimal, Low, Critical, Overstock, Discontinued
    [IsStockOut] [bit] NOT NULL DEFAULT 0,
    [IsBackorder] [bit] NOT NULL DEFAULT 0,
    
    -- Audit Fields
    [LoadDate] [datetime] NOT NULL DEFAULT GETDATE(),
    [UpdateDate] [datetime] NOT NULL DEFAULT GETDATE(),
    
    CONSTRAINT [PK_FactInventory_FactInventoryKey] PRIMARY KEY CLUSTERED ([FactInventoryKey] ASC),
    CONSTRAINT [FK_FactInventory_Product] FOREIGN KEY ([ProductKey]) REFERENCES [dbo].[DimProduct]([ProductKey])
);
GO

-- Create indexes on inventory fact table
CREATE NONCLUSTERED INDEX [IX_FactInventory_ProductKey] 
ON [dbo].[FactInventory] ([ProductKey]);
GO

CREATE NONCLUSTERED INDEX [IX_FactInventory_InventoryDateKey] 
ON [dbo].[FactInventory] ([InventoryDateKey]);
GO

CREATE NONCLUSTERED INDEX [IX_FactInventory_InventoryStatus] 
ON [dbo].[FactInventory] ([InventoryStatus]);
GO

/* ===== FactProductionCost =====
   Purpose: Fact table for production and manufacturing costs
   Grain: One row per product per production batch/date
   Type: Semi-additive fact table (some measures cannot be summed across all dimensions)
   
   Keys: FactProductionCostKey, ProductKey, EmployeeKey, ProductionDateKey
   Dimensions: Product, Employee (Production Worker), Time (Production Date)
   
   Business Event: Manufacturing/production transaction
   Measures: Cost, Labor, Materials, Quantity Produced, Defects, Scrap
*/
CREATE TABLE [dbo].[FactProductionCost](
    [FactProductionCostKey] [int] IDENTITY(1,1) NOT NULL,
    [ProductKey] [int] NOT NULL,
    [EmployeeKey] [int] NULL,  -- Production worker/supervisor
    [ProductionDateKey] [int] NOT NULL,
    
    -- Production Metrics
    [StandardCost] [money] NOT NULL,
    [ActualCost] [money] NOT NULL,
    [ActualCostVariance] [money] NULL,  -- ActualCost - StandardCost
    [CostVariancePercent] [decimal](8, 4) NULL,
    
    -- Cost Breakdown
    [MaterialsCost] [money] NOT NULL,
    [LaborCost] [money] NOT NULL,
    [OverheadCost] [money] NOT NULL,
    
    -- Production Metrics
    [UnitsProduced] [int] NOT NULL,
    [UnitsCompleted] [int] NOT NULL,
    [UnitsDefective] [int] NOT NULL,
    [DefectRate] [decimal](8, 4) NULL,
    [ScrapAmount] [money] NULL,
    [ScrapWeight] [decimal](12, 2) NULL,
    
    -- Efficiency Metrics
    [PlannedProductionHours] [decimal](10, 2) NULL,
    [ActualProductionHours] [decimal](10, 2) NULL,
    [LaborEfficiencyRatio] [decimal](8, 4) NULL,
    [MachineryUtilizationRate] [decimal](8, 4) NULL,
    
    -- Production Status
    [ProductionStatus] [nvarchar](50) NULL,  -- Planned, In Progress, Completed, Delayed
    [OnTimeCompletion] [bit] NOT NULL DEFAULT 1,
    
    -- Audit Fields
    [LoadDate] [datetime] NOT NULL DEFAULT GETDATE(),
    [UpdateDate] [datetime] NOT NULL DEFAULT GETDATE(),
    
    CONSTRAINT [PK_FactProductionCost_FactProductionCostKey] PRIMARY KEY CLUSTERED ([FactProductionCostKey] ASC),
    CONSTRAINT [FK_FactProductionCost_Product] FOREIGN KEY ([ProductKey]) REFERENCES [dbo].[DimProduct]([ProductKey]),
    CONSTRAINT [FK_FactProductionCost_Employee] FOREIGN KEY ([EmployeeKey]) REFERENCES [dbo].[DimEmployee]([EmployeeKey])
);
GO

-- Create indexes on production cost fact table
CREATE NONCLUSTERED INDEX [IX_FactProductionCost_ProductKey] 
ON [dbo].[FactProductionCost] ([ProductKey]);
GO

CREATE NONCLUSTERED INDEX [IX_FactProductionCost_EmployeeKey] 
ON [dbo].[FactProductionCost] ([EmployeeKey]);
GO

CREATE NONCLUSTERED INDEX [IX_FactProductionCost_ProductionDateKey] 
ON [dbo].[FactProductionCost] ([ProductionDateKey]);
GO

CREATE NONCLUSTERED INDEX [IX_FactProductionCost_ProductionStatus] 
ON [dbo].[FactProductionCost] ([ProductionStatus]);
GO

PRINT 'All fact tables created successfully!';
GO

/* ===== FACT TABLE SUMMARY =====
   
   FactSales:
   - Transaction fact table for sales analysis
   - Measures: OrderQuantity, UnitPrice, LineTotal, Discount, Tax, Freight
   - Dimensions: Customer, Product, Employee (Salesperson), Order Date, Ship Date, Due Date
   - Grain: One row per sales order line
   - Usage: Revenue analysis, sales performance, product mix
   
   FactInventory:
   - Snapshot fact table for inventory management
   - Measures: QuantityOnHand, QuantityReserved, SafetyStock, DaysOfSupply, TurnoverRatio
   - Dimensions: Product, Inventory Date
   - Grain: One row per product per date
   - Usage: Inventory optimization, stock planning, supply chain
   
   FactProductionCost:
   - Semi-additive fact table for manufacturing analysis
   - Measures: StandardCost, ActualCost, MaterialsCost, LaborCost, UnitsProduced, DefectRate
   - Dimensions: Product, Employee (Production Worker), Production Date
   - Grain: One row per production batch/date
   - Usage: Cost control, profitability, production efficiency
*/
GO
