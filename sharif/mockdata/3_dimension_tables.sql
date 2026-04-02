-- ===== DIMENSION TABLES =====
-- Purpose: Create dimension tables (DimCustomer, DimEmployee, DimProduct) 
-- for the AdventureWorkMock data warehouse
-- These tables are used for analytics and reporting

USE [AdventureWorkMock];
GO

/* ===== DimCustomer =====
   Purpose: Customer dimension for sales analysis
   Contains customer profile, contact, and address information
*/
CREATE TABLE [dbo].[DimCustomer](
    [CustomerKey] [int] IDENTITY(1,1) NOT NULL,
    [CustomerAlternateKey] [int] NOT NULL,
    [AccountNumber] [nvarchar](15) NULL,
    [FirstName] [nvarchar](50) NOT NULL,
    [MiddleName] [nvarchar](50) NULL,
    [LastName] [nvarchar](50) NOT NULL,
    [FullName] [nvarchar](151) NULL,
    [Title] [nvarchar](8) NULL,
    [Suffix] [nvarchar](10) NULL,
    [PersonType] [nchar](2) NOT NULL,
    [EmailAddress] [nvarchar](50) NULL,
    [PhoneNumber] [nvarchar](25) NULL,
    [AddressLine1] [nvarchar](60) NULL,
    [AddressLine2] [nvarchar](60) NULL,
    [City] [nvarchar](30) NULL,
    [StateProvinceID] [int] NULL,
    [StateProvinceName] [nvarchar](50) NULL,
    [PostalCode] [nvarchar](15) NULL,
    [CountryRegionCode] [nvarchar](3) NULL,
    [CountryRegionName] [nvarchar](50) NULL,
    [AddressType] [nvarchar](50) NULL,
    [TerritoryID] [int] NULL,
    [EmailPromotion] [int] NOT NULL,
    [RowGUID] [uniqueidentifier] NULL,
    [ModifiedDate] [datetime] NOT NULL,
    CONSTRAINT [PK_DimCustomer_CustomerKey] PRIMARY KEY CLUSTERED ([CustomerKey] ASC)
);
GO

/* ===== DimEmployee =====
   Purpose: Employee dimension for HR and operations analysis
   Contains employee profile, department, and employment information
*/
CREATE TABLE [dbo].[DimEmployee](
    [EmployeeKey] [int] IDENTITY(1,1) NOT NULL,
    [BusinessEntityID] [int] NOT NULL,
    [NationalIDNumber] [nvarchar](15) NOT NULL,
    [LoginID] [nvarchar](256) NOT NULL,
    [JobTitle] [nvarchar](50) NOT NULL,
    [BirthDate] [date] NULL,
    [Gender] [nchar](1) NULL,
    [MaritalStatus] [nchar](1) NULL,
    [HireDate] [date] NULL,
    [SalariedFlag] [bit] NOT NULL,
    [VacationHours] [smallint] NULL,
    [SickLeaveHours] [smallint] NULL,
    [CurrentFlag] [bit] NOT NULL,
    [DepartmentID] [smallint] NULL,
    [DepartmentName] [nvarchar](50) NULL,
    [GroupName] [nvarchar](50) NULL,
    [ShiftID] [tinyint] NULL,
    [ShiftName] [nvarchar](50) NULL,
    [DepartmentStartDate] [date] NULL,
    [DepartmentEndDate] [date] NULL,
    [FirstName] [nvarchar](50) NOT NULL,
    [MiddleName] [nvarchar](50) NULL,
    [LastName] [nvarchar](50) NOT NULL,
    [FullName] [nvarchar](151) NULL,
    [Title] [nvarchar](8) NULL,
    [Suffix] [nvarchar](10) NULL,
    [EmailPromotion] [int] NOT NULL,
    [Demographics] [varchar](max) NULL,
    [RowGUID] [uniqueidentifier] NULL,
    [ModifiedDate] [datetime] NOT NULL,
    CONSTRAINT [PK_DimEmployee_EmployeeKey] PRIMARY KEY CLUSTERED ([EmployeeKey] ASC)
);
GO

/* ===== DimProduct =====
   Purpose: Product dimension for sales and inventory analysis
   Contains product profile, pricing, and model/category information
*/
CREATE TABLE [dbo].[DimProduct](
    [ProductKey] [int] IDENTITY(1,1) NOT NULL,
    [ProductAlternateKey] [int] NOT NULL,
    [ProductName] [nvarchar](50) NOT NULL,
    [ProductNumber] [nvarchar](25) NOT NULL,
    [MakeFlag] [bit] NOT NULL,
    [FinishedGoodsFlag] [bit] NOT NULL,
    [Color] [nvarchar](15) NULL,
    [Size] [nvarchar](5) NULL,
    [SizeUnitMeasureCode] [nchar](3) NULL,
    [Weight] [decimal](8, 2) NULL,
    [WeightUnitMeasureCode] [nchar](3) NULL,
    [SafetyStockLevel] [smallint] NOT NULL,
    [ReorderPoint] [smallint] NOT NULL,
    [StandardCost] [money] NOT NULL,
    [ListPrice] [money] NOT NULL,
    [DaysToManufacture] [int] NOT NULL,
    [ProductLine] [nchar](2) NULL,
    [Class] [nchar](2) NULL,
    [Style] [nchar](2) NULL,
    [SellStartDate] [datetime] NOT NULL,
    [SellEndDate] [datetime] NULL,
    [DiscontinuedDate] [datetime] NULL,
    [ProductModelID] [int] NULL,
    [ProductModelName] [nvarchar](50) NULL,
    [CatalogDescription] [varchar](max) NULL,
    [Instructions] [varchar](max) NULL,
    [ProductSubcategoryID] [int] NULL,
    [ProductSubcategoryName] [nvarchar](50) NULL,
    [ProductCategoryID] [int] NULL,
    [ProductCategoryName] [nvarchar](50) NULL,
    [RowGUID] [uniqueidentifier] NULL,
    [ModifiedDate] [datetime] NOT NULL,
    CONSTRAINT [PK_DimProduct_ProductKey] PRIMARY KEY CLUSTERED ([ProductKey] ASC)
);
GO

/* ===== END OF DIMENSION TABLES =====*/
