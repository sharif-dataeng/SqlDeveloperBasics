IF DB_ID(N'AdventureWorkMock') IS NOT NULL
BEGIN
    ALTER DATABASE [AdventureWorkMock] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [AdventureWorkMock];
END
GO
CREATE DATABASE [AdventureWorkMock];
GO
USE [AdventureWorkMock];
GO

-- Ordered DDLs with detailed comments for mock tables
-- Source: sharif/ddl_mock_database.sql (AdventureWorksMock)
-- Purpose: create schemas, types, helper functions, then tables for
-- the mock data groups (dimcustomer, dimemployee, dimproduct)
-- The order below ensures that referenced parent objects exist before children.
-- Assumptions: original script did not include explicit FOREIGN KEY clauses
-- for several relationships; dependencies are inferred from column names.

/* ===== SCHEMAS =====
   Create the schemas first so subsequent CREATE TABLE statements can reference them.
*/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Person')
    EXEC('CREATE SCHEMA [Person]');
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'HumanResources')
    EXEC('CREATE SCHEMA [HumanResources]');
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Production')
    EXEC('CREATE SCHEMA [Production]');
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Sales')
    EXEC('CREATE SCHEMA [Sales]');
 

/* ===== DATABASE TYPES (dbo) =====
   These user-defined types are used by many tables below (e.g. [dbo].[Name], [dbo].[Flag]).
   Create them before tables.
*/

/* (Replaced UDTs with native types below: Name->nvarchar(50), Flag->bit, Phone->nvarchar(25), NameStyle->bit) */

/* Helper function `dbo.ufnLeadingZeros` removed.
  Its logic (pad integer to 8 digits with leading zeros) is inlined
  in the Sales.Customer computed `AccountNumber` expression below.
*/

/* ===== TABLES: dimcustomer group (ordered by inferred dependency) =====
   Order rationale:
     1) CountryRegion: independent lookup for state/province
     2) StateProvince: references CountryRegionCode (logical dependency)
     3) BusinessEntity: core identity referenced by Person, EmailAddress, Vendor, etc.
     4) AddressType: lookup used by BusinessEntityAddress
     5) Address: physical addresses
     6) BusinessEntityAddress: junction (BusinessEntity + Address + AddressType)
     7) Person: core contact (references BusinessEntity)
     8) PhoneNumberType: lookup used by PersonPhone
     9) PersonPhone: uses Person and PhoneNumberType
    10) EmailAddress: per BusinessEntity contact emails
    11) SalesTerritory: independent sales territory lookup
    12) Customer: references Person (PersonID -> BusinessEntityID) and SalesTerritory
*/

-- 1) Person.CountryRegion
/*
  Purpose: country/region lookup used by StateProvince.
  Key: CountryRegionCode (PK)
*/
CREATE TABLE  [Person].[CountryRegion](
    [CountryRegionCode] [nvarchar](3) NOT NULL,
  [Name] [nvarchar](50) NOT NULL,
  [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_CountryRegion_CountryRegionCode] PRIMARY KEY CLUSTERED ([CountryRegionCode] ASC)
);
GO

-- 2) Person.StateProvince
/*
  Purpose: state/province lookup. Logical dependency on CountryRegion via CountryRegionCode.
  Notes: Identity PK, contains TerritoryID used elsewhere.
*/
CREATE TABLE  [Person].[StateProvince](
    [StateProvinceID] [int] IDENTITY(1,1) NOT NULL,
    [StateProvinceCode] [nchar](3) NOT NULL,
    [CountryRegionCode] [nvarchar](3) NOT NULL,
  [IsOnlyStateProvinceFlag] [bit] NOT NULL,
  [Name] [nvarchar](50) NOT NULL,
    [TerritoryID] [int] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_StateProvince_StateProvinceID] PRIMARY KEY CLUSTERED ([StateProvinceID] ASC)
);
-- Comment: This table logically references [Person].[CountryRegion] on CountryRegionCode.
GO

-- 3) Person.BusinessEntity
/*
  Purpose: central identity table. Many tables reference BusinessEntityID.
  Notes: identity PK, rowguid used for replication/sample uniqueness.
*/
CREATE TABLE  [Person].[BusinessEntity](
    [BusinessEntityID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_BusinessEntity_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC)
);
GO

-- 4) Person.AddressType
/*
  Purpose: lookup describing the type of address (Home, Work, etc.)
*/
CREATE TABLE  [Person].[AddressType](
    [AddressTypeID] [int] IDENTITY(1,1) NOT NULL,
  [Name] [nvarchar](50) NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_AddressType_AddressTypeID] PRIMARY KEY CLUSTERED ([AddressTypeID] ASC)
);
GO

-- 5) Person.Address
/*
  Purpose: stores address rows; referenced by BusinessEntityAddress
  Important columns: AddressID (PK), StateProvinceID links to StateProvince
*/
CREATE TABLE  [Person].[Address](
    [AddressID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
    [AddressLine1] [nvarchar](60) NOT NULL,
    [AddressLine2] [nvarchar](60) NULL,
    [City] [nvarchar](30) NOT NULL,
    [StateProvinceID] [int] NOT NULL,
    [PostalCode] [nvarchar](15) NOT NULL,
    [SpatialLocation] [nvarchar](250) NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED ([AddressID] ASC)
);
-- Comment: StateProvinceID logically references [Person].[StateProvince].
GO

-- 6) Person.BusinessEntityAddress (junction)
/*
  Purpose: associates BusinessEntity <-> Address with an AddressType.
  Dependencies: BusinessEntity, Address, AddressType.
  Keys: composite PK (BusinessEntityID, AddressID, AddressTypeID).
*/
CREATE TABLE  [Person].[BusinessEntityAddress](
    [BusinessEntityID] [int] NOT NULL,
    [AddressID] [int] NOT NULL,
    [AddressTypeID] [int] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID] PRIMARY KEY CLUSTERED (
    [BusinessEntityID] ASC, [AddressID] ASC, [AddressTypeID] ASC)
);
GO

-- 7) Person.Person
/*
  Purpose: person/contact details mapped to BusinessEntity.
  Dependencies: BusinessEntity (BusinessEntityID)
  Notes: includes xml columns and ROWGUID; Primary key is BusinessEntityID.
*/
CREATE TABLE  [Person].[Person](
    [BusinessEntityID] [int] NOT NULL,
    [PersonType] [nchar](2) NOT NULL,
  [NameStyle] [bit] NOT NULL,
    [Title] [nvarchar](8) NULL,
  [FirstName] [nvarchar](50) NOT NULL,
  [MiddleName] [nvarchar](50) NULL,
  [LastName] [nvarchar](50) NOT NULL,
    [Suffix] [nvarchar](10) NULL,
    [EmailPromotion] [int] NOT NULL,
    [AdditionalContactInfo] [xml] NULL,
    [Demographics] [xml] NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC)
);
GO

-- 8) Person.PhoneNumberType
/* Purpose: lookup for phone number type; used by PersonPhone */
CREATE TABLE  [Person].[PhoneNumberType](
    [PhoneNumberTypeID] [int] IDENTITY(1,1) NOT NULL,
  [Name] [nvarchar](50) NOT NULL,
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_PhoneNumberType_PhoneNumberTypeID] PRIMARY KEY CLUSTERED ([PhoneNumberTypeID] ASC)
);
GO

-- 9) Person.PersonPhone
/*
  Purpose: phone numbers for BusinessEntity/Person.
  Dependencies: Person (BusinessEntityID) and PhoneNumberType.
  PK: composite on (BusinessEntityID, PhoneNumber, PhoneNumberTypeID).
*/
CREATE TABLE  [Person].[PersonPhone](
    [BusinessEntityID] [int] NOT NULL,
   [PhoneNumber] [nvarchar](25) NOT NULL,
    [PhoneNumberTypeID] [int] NOT NULL,
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID] PRIMARY KEY CLUSTERED (
    [BusinessEntityID] ASC, [PhoneNumber] ASC, [PhoneNumberTypeID] ASC)
);
GO

-- 10) Person.EmailAddress
/*
  Purpose: email addresses associated with BusinessEntity (person/vendor/store).
  Dependencies: BusinessEntity table.
  PK: (BusinessEntityID, EmailAddressID)
*/
CREATE TABLE  [Person].[EmailAddress](
    [BusinessEntityID] [int] NOT NULL,
    [EmailAddressID] [int] IDENTITY(1,1) NOT NULL,
    [EmailAddress] [nvarchar](50) NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_EmailAddress_BusinessEntityID_EmailAddressID] PRIMARY KEY CLUSTERED (
    [BusinessEntityID] ASC, [EmailAddressID] ASC)
);
GO

-- 11) Sales.SalesTerritory
/* Simple territory lookup, independent. */
CREATE TABLE  [Sales].[SalesTerritory](
    [TerritoryID] [int] IDENTITY(1,1) NOT NULL,
  [Name] [nvarchar](50) NOT NULL,
    [CountryRegionCode] [nvarchar](3) NOT NULL,
    [Group] [nvarchar](50) NOT NULL,
    [SalesYTD] [money] NOT NULL,
    [SalesLastYear] [money] NOT NULL,
    [CostYTD] [money] NOT NULL,
    [CostLastYear] [money] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED ([TerritoryID] ASC)
);
GO

-- 12) Sales.Customer
/*
  Purpose: Customers table; computed AccountNumber uses dbo.ufnLeadingZeros.
  Dependencies: Person.Person / Person.BusinessEntity for PersonID mapping, SalesTerritory (TerritoryID)
  Note: PersonID column stores a BusinessEntityID when the customer is an individual.
*/
CREATE TABLE  [Sales].[Customer](
    [CustomerID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
    [PersonID] [int] NULL,
    [StoreID] [int] NULL,
    [TerritoryID] [int] NULL,
    [AccountNumber] AS (isnull('AW'+ RIGHT('00000000' + CONVERT(varchar(8), [CustomerID]), 8),'')),
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);
GO


/* ===== TABLES: dimemployee group (ordered) =====
   Order rationale:
     - Department and Shift are independent lookups.
     - BusinessEntity must exist (already created).
     - Employee references BusinessEntity; EmployeeDepartmentHistory depends on Employee/Department/Shift.
*/

-- HumanResources.Department
CREATE TABLE  [HumanResources].[Department](
    [DepartmentID] [smallint] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [GroupName] [nvarchar](50) NOT NULL,
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_Department_DepartmentID] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);
GO

-- HumanResources.Shift
CREATE TABLE  [HumanResources].[Shift](
    [ShiftID] [tinyint] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [StartTime] [time](7) NOT NULL,
    [EndTime] [time](7) NOT NULL,
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_Shift_ShiftID] PRIMARY KEY CLUSTERED ([ShiftID] ASC)
);
GO

-- HumanResources.Employee
/*
  Purpose: employee master row; references BusinessEntityID as PK/foreign mapping.
  Important: JobTitle, HireDate and flags used by views and joins.
*/
CREATE TABLE  [HumanResources].[Employee](
    [BusinessEntityID] [int] NOT NULL,
    [NationalIDNumber] [nvarchar](15) NOT NULL,
    [LoginID] [nvarchar](256) NOT NULL,
    [OrganizationNode] [varchar](250) NULL,
    [OrganizationLevel] [varchar](250) NULL,
    [JobTitle] [nvarchar](50) NOT NULL,
    [BirthDate] [date] NOT NULL,
    [MaritalStatus] [nchar](1) NOT NULL,
    [Gender] [nchar](1) NOT NULL,
    [HireDate] [date] NOT NULL,
    [SalariedFlag] [bit] NOT NULL,
    [VacationHours] [smallint] NOT NULL,
    [SickLeaveHours] [smallint] NOT NULL,
    [CurrentFlag] [bit] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_Employee_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC)
);
GO

-- HumanResources.EmployeeDepartmentHistory
/*
  Purpose: historical mapping of employee to department & shift.
  Composite PK ensures uniqueness per (BusinessEntityID, StartDate, DepartmentID, ShiftID).
*/
CREATE TABLE  [HumanResources].[EmployeeDepartmentHistory](
    [BusinessEntityID] [int] NOT NULL,
    [DepartmentID] [smallint] NOT NULL,
    [ShiftID] [tinyint] NOT NULL,
    [StartDate] [date] NOT NULL,
    [EndDate] [date] NULL,
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID] PRIMARY KEY CLUSTERED (
    [BusinessEntityID] ASC, [StartDate] ASC, [DepartmentID] ASC, [ShiftID] ASC)
);
GO


/* ===== TABLES: dimproduct group (ordered) =====
   Order rationale:
     - ProductCategory is parent of ProductSubcategory.
     - ProductModel is independent metadata.
     - Product references ProductSubcategory and ProductModel.
*/

-- Production.ProductCategory
CREATE TABLE  [Production].[ProductCategory](
    [ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_ProductCategory_ProductCategoryID] PRIMARY KEY CLUSTERED ([ProductCategoryID] ASC)
);
GO

-- Production.ProductSubcategory
CREATE TABLE  [Production].[ProductSubcategory](
    [ProductSubcategoryID] [int] IDENTITY(1,1) NOT NULL,
    [ProductCategoryID] [int] NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryID] PRIMARY KEY CLUSTERED ([ProductSubcategoryID] ASC)
);
-- Comment: ProductSubcategory.ProductCategoryID logically references Production.ProductCategory.
GO

-- Production.ProductModel
CREATE TABLE  [Production].[ProductModel](
    [ProductModelID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [CatalogDescription] [xml] NULL,
    [Instructions] [xml] NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_ProductModel_ProductModelID] PRIMARY KEY CLUSTERED ([ProductModelID] ASC)
);
GO

-- Production.Product
CREATE TABLE  [Production].[Product](
    [ProductID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](50) NOT NULL,
    [ProductNumber] [nvarchar](25) NOT NULL,
    [MakeFlag] [bit] NOT NULL,
    [FinishedGoodsFlag] [bit] NOT NULL,
    [Color] [nvarchar](15) NULL,
    [SafetyStockLevel] [smallint] NOT NULL,
    [ReorderPoint] [smallint] NOT NULL,
    [StandardCost] [money] NOT NULL,
    [ListPrice] [money] NOT NULL,
    [Size] [nvarchar](5) NULL,
    [SizeUnitMeasureCode] [nchar](3) NULL,
    [WeightUnitMeasureCode] [nchar](3) NULL,
    [Weight] [decimal](8,2) NULL,
    [DaysToManufacture] [int] NOT NULL,
    [ProductLine] [nchar](2) NULL,
    [Class] [nchar](2) NULL,
    [Style] [nchar](2) NULL,
    [ProductSubcategoryID] [int] NULL,
    [ProductModelID] [int] NULL,
    [SellStartDate] [datetime] NOT NULL,
    [SellEndDate] [datetime] NULL,
    [DiscontinuedDate] [datetime] NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL DEFAULT NEWID(),
    [ModifiedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
 CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);
-- Comment: Product.ProductSubcategoryID -> Production.ProductSubcategory
--          Product.ProductModelID -> Production.ProductModel
GO


/* ===== NOTES on dependencies and next steps =====
 - This script creates schemas, types, helper function, and the requested tables
   in an order that ensures parent objects exist before dependent ones.
 - The source script contains many additional objects (indexes, views, functions,
   constraints). I did not recreate explicit FOREIGN KEY constraints because the
   original mock script either didn't include them in the same block or uses
   naming conventions. If you want, I can:
     a) Add explicit FOREIGN KEY clauses (I will infer them from column names),
     b) Extract and include indexes and non-clustered PKs from the original script,
     c) Split each table into separate files.
*/

GO
/* ===== FOREIGN KEY CONSTRAINTS (explicit) =====
   These constraints enforce the inferred parent-child relationships.
*/
-- FOREIGN KEY CONSTRAINTS removed by script edit. Insert data can be run independently.

GO

/* ===== TRIGGERS: update ModifiedDate on UPDATE =====
   Each trigger updates the table's ModifiedDate column to GETDATE()
   whenever a row in that table is updated.
*/

-- Person.CountryRegion
IF OBJECT_ID('Person.CountryRegion_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.CountryRegion_UpdateTrigger;
GO
CREATE TRIGGER Person.CountryRegion_UpdateTrigger
ON Person.CountryRegion
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.CountryRegion t
  INNER JOIN inserted i ON t.CountryRegionCode = i.CountryRegionCode;
END;
GO

-- Person.StateProvince
IF OBJECT_ID('Person.StateProvince_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.StateProvince_UpdateTrigger;
GO
CREATE TRIGGER Person.StateProvince_UpdateTrigger
ON Person.StateProvince
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.StateProvince t
  INNER JOIN inserted i ON t.StateProvinceID = i.StateProvinceID;
END;
GO

-- Person.BusinessEntity
IF OBJECT_ID('Person.BusinessEntity_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.BusinessEntity_UpdateTrigger;
GO
CREATE TRIGGER Person.BusinessEntity_UpdateTrigger
ON Person.BusinessEntity
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.BusinessEntity t
  INNER JOIN inserted i ON t.BusinessEntityID = i.BusinessEntityID;
END;
GO

-- Person.AddressType
IF OBJECT_ID('Person.AddressType_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.AddressType_UpdateTrigger;
GO
CREATE TRIGGER Person.AddressType_UpdateTrigger
ON Person.AddressType
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.AddressType t
  INNER JOIN inserted i ON t.AddressTypeID = i.AddressTypeID;
END;
GO

-- Person.Address
IF OBJECT_ID('Person.Address_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.Address_UpdateTrigger;
GO
CREATE TRIGGER Person.Address_UpdateTrigger
ON Person.Address
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.Address t
  INNER JOIN inserted i ON t.AddressID = i.AddressID;
END;
GO

-- Person.BusinessEntityAddress (composite PK)
IF OBJECT_ID('Person.BusinessEntityAddress_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.BusinessEntityAddress_UpdateTrigger;
GO
CREATE TRIGGER Person.BusinessEntityAddress_UpdateTrigger
ON Person.BusinessEntityAddress
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.BusinessEntityAddress t
  INNER JOIN inserted i ON t.BusinessEntityID = i.BusinessEntityID
             AND t.AddressID = i.AddressID
             AND t.AddressTypeID = i.AddressTypeID;
END;
GO

-- Person.Person
IF OBJECT_ID('Person.Person_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.Person_UpdateTrigger;
GO
CREATE TRIGGER Person.Person_UpdateTrigger
ON Person.Person
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.Person t
  INNER JOIN inserted i ON t.BusinessEntityID = i.BusinessEntityID;
END;
GO

-- Person.PhoneNumberType
IF OBJECT_ID('Person.PhoneNumberType_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.PhoneNumberType_UpdateTrigger;
GO
CREATE TRIGGER Person.PhoneNumberType_UpdateTrigger
ON Person.PhoneNumberType
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.PhoneNumberType t
  INNER JOIN inserted i ON t.PhoneNumberTypeID = i.PhoneNumberTypeID;
END;
GO

-- Person.PersonPhone (composite PK)
IF OBJECT_ID('Person.PersonPhone_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.PersonPhone_UpdateTrigger;
GO
CREATE TRIGGER Person.PersonPhone_UpdateTrigger
ON Person.PersonPhone
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.PersonPhone t
  INNER JOIN inserted i ON t.BusinessEntityID = i.BusinessEntityID
             AND t.PhoneNumber = i.PhoneNumber
             AND t.PhoneNumberTypeID = i.PhoneNumberTypeID;
END;
GO

-- Person.EmailAddress (composite PK)
IF OBJECT_ID('Person.EmailAddress_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Person.EmailAddress_UpdateTrigger;
GO
CREATE TRIGGER Person.EmailAddress_UpdateTrigger
ON Person.EmailAddress
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Person.EmailAddress t
  INNER JOIN inserted i ON t.BusinessEntityID = i.BusinessEntityID
             AND t.EmailAddressID = i.EmailAddressID;
END;
GO

-- Sales.SalesTerritory
IF OBJECT_ID('Sales.SalesTerritory_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Sales.SalesTerritory_UpdateTrigger;
GO
CREATE TRIGGER Sales.SalesTerritory_UpdateTrigger
ON Sales.SalesTerritory
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Sales.SalesTerritory t
  INNER JOIN inserted i ON t.TerritoryID = i.TerritoryID;
END;
GO

-- Sales.Customer
IF OBJECT_ID('Sales.Customer_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Sales.Customer_UpdateTrigger;
GO
CREATE TRIGGER Sales.Customer_UpdateTrigger
ON Sales.Customer
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Sales.Customer t
  INNER JOIN inserted i ON t.CustomerID = i.CustomerID;
END;
GO

-- HumanResources.Department
IF OBJECT_ID('HumanResources.Department_UpdateTrigger') IS NOT NULL
  DROP TRIGGER HumanResources.Department_UpdateTrigger;
GO
CREATE TRIGGER HumanResources.Department_UpdateTrigger
ON HumanResources.Department
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM HumanResources.Department t
  INNER JOIN inserted i ON t.DepartmentID = i.DepartmentID;
END;
GO

-- HumanResources.Shift
IF OBJECT_ID('HumanResources.Shift_UpdateTrigger') IS NOT NULL
  DROP TRIGGER HumanResources.Shift_UpdateTrigger;
GO
CREATE TRIGGER HumanResources.Shift_UpdateTrigger
ON HumanResources.Shift
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM HumanResources.Shift t
  INNER JOIN inserted i ON t.ShiftID = i.ShiftID;
END;
GO

-- HumanResources.Employee
IF OBJECT_ID('HumanResources.Employee_UpdateTrigger') IS NOT NULL
  DROP TRIGGER HumanResources.Employee_UpdateTrigger;
GO
CREATE TRIGGER HumanResources.Employee_UpdateTrigger
ON HumanResources.Employee
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM HumanResources.Employee t
  INNER JOIN inserted i ON t.BusinessEntityID = i.BusinessEntityID;
END;
GO

-- HumanResources.EmployeeDepartmentHistory (composite PK)
IF OBJECT_ID('HumanResources.EmployeeDepartmentHistory_UpdateTrigger') IS NOT NULL
  DROP TRIGGER HumanResources.EmployeeDepartmentHistory_UpdateTrigger;
GO
CREATE TRIGGER HumanResources.EmployeeDepartmentHistory_UpdateTrigger
ON HumanResources.EmployeeDepartmentHistory
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM HumanResources.EmployeeDepartmentHistory t
  INNER JOIN inserted i ON t.BusinessEntityID = i.BusinessEntityID
             AND t.DepartmentID = i.DepartmentID
             AND t.ShiftID = i.ShiftID
             AND t.StartDate = i.StartDate;
END;
GO

-- Production.ProductCategory
IF OBJECT_ID('Production.ProductCategory_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Production.ProductCategory_UpdateTrigger;
GO
CREATE TRIGGER Production.ProductCategory_UpdateTrigger
ON Production.ProductCategory
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Production.ProductCategory t
  INNER JOIN inserted i ON t.ProductCategoryID = i.ProductCategoryID;
END;
GO

-- Production.ProductSubcategory
IF OBJECT_ID('Production.ProductSubcategory_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Production.ProductSubcategory_UpdateTrigger;
GO
CREATE TRIGGER Production.ProductSubcategory_UpdateTrigger
ON Production.ProductSubcategory
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Production.ProductSubcategory t
  INNER JOIN inserted i ON t.ProductSubcategoryID = i.ProductSubcategoryID;
END;
GO

-- Production.ProductModel
IF OBJECT_ID('Production.ProductModel_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Production.ProductModel_UpdateTrigger;
GO
CREATE TRIGGER Production.ProductModel_UpdateTrigger
ON Production.ProductModel
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Production.ProductModel t
  INNER JOIN inserted i ON t.ProductModelID = i.ProductModelID;
END;
GO

-- Production.Product
IF OBJECT_ID('Production.Product_UpdateTrigger') IS NOT NULL
  DROP TRIGGER Production.Product_UpdateTrigger;
GO
CREATE TRIGGER Production.Product_UpdateTrigger
ON Production.Product
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE t SET ModifiedDate = GETDATE()
  FROM Production.Product t
  INNER JOIN inserted i ON t.ProductID = i.ProductID;
END;
GO
/* ===== END OF SCRIPT ===== */