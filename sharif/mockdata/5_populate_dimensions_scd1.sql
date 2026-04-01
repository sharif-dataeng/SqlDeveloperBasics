-- ===== POPULATE DIMENSION TABLES - SCD TYPE 1 =====
-- Purpose: Load/Update dimension tables from OLTP source tables
-- SCD Type 1: Overwrite old values with new values (no historical tracking)
-- This script uses MERGE to handle both INSERT and UPDATE operations

USE [AdventureWorkMock];
GO

/* ===== POPULATE DimCustomer (SCD Type 1) =====
   Logic:
   - MATCH on CustomerAlternateKey (business key)
   - INSERT new customers
   - UPDATE existing customer attributes
*/
MERGE INTO [dbo].[DimCustomer] AS target
USING (
    SELECT
        c.CustomerID AS CustomerAlternateKey,
        c.AccountNumber,
        p.FirstName,
        p.MiddleName,
        p.LastName,
        LTRIM(RTRIM(COALESCE(p.Title, '') + ' ' + COALESCE(p.FirstName, '') + ' ' + COALESCE(p.MiddleName, '') + ' ' + COALESCE(p.LastName, '') + ' ' + COALESCE(p.Suffix, ''))) AS FullName,
        p.Title,
        p.Suffix,
        p.PersonType,
        ea.EmailAddress,
        pp.PhoneNumber,
        a.AddressLine1,
        a.AddressLine2,
        a.City,
        a.StateProvinceID,
        sp.Name AS StateProvinceName,
        a.PostalCode,
        sp.CountryRegionCode,
        cr.Name AS CountryRegionName,
        at.Name AS AddressType,
        c.TerritoryID,
        p.EmailPromotion,
        be.rowguid,
        GETDATE() AS ModifiedDate
    FROM [Sales].[Customer] c
    INNER JOIN [Person].[Person] p ON c.PersonID = p.BusinessEntityID
    INNER JOIN [Person].[BusinessEntity] be ON p.BusinessEntityID = be.BusinessEntityID
    LEFT JOIN [Person].[EmailAddress] ea ON p.BusinessEntityID = ea.BusinessEntityID
    LEFT JOIN [Person].[PersonPhone] pp ON p.BusinessEntityID = pp.BusinessEntityID
    LEFT JOIN [Person].[BusinessEntityAddress] bea ON p.BusinessEntityID = bea.BusinessEntityID
    LEFT JOIN [Person].[Address] a ON bea.AddressID = a.AddressID
    LEFT JOIN [Person].[StateProvince] sp ON a.StateProvinceID = sp.StateProvinceID
    LEFT JOIN [Person].[CountryRegion] cr ON sp.CountryRegionCode = cr.CountryRegionCode
    LEFT JOIN [Person].[AddressType] at ON bea.AddressTypeID = at.AddressTypeID
) AS source
ON target.CustomerAlternateKey = source.CustomerAlternateKey
WHEN MATCHED THEN
    UPDATE SET
        target.AccountNumber = source.AccountNumber,
        target.FirstName = source.FirstName,
        target.MiddleName = source.MiddleName,
        target.LastName = source.LastName,
        target.FullName = source.FullName,
        target.Title = source.Title,
        target.Suffix = source.Suffix,
        target.PersonType = source.PersonType,
        target.EmailAddress = source.EmailAddress,
        target.PhoneNumber = source.PhoneNumber,
        target.AddressLine1 = source.AddressLine1,
        target.AddressLine2 = source.AddressLine2,
        target.City = source.City,
        target.StateProvinceID = source.StateProvinceID,
        target.StateProvinceName = source.StateProvinceName,
        target.PostalCode = source.PostalCode,
        target.CountryRegionCode = source.CountryRegionCode,
        target.CountryRegionName = source.CountryRegionName,
        target.AddressType = source.AddressType,
        target.TerritoryID = source.TerritoryID,
        target.EmailPromotion = source.EmailPromotion,
        target.RowGUID = source.rowguid,
        target.ModifiedDate = source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (
        CustomerAlternateKey, AccountNumber, FirstName, MiddleName, LastName, 
        FullName, Title, Suffix, PersonType, EmailAddress, PhoneNumber, 
        AddressLine1, AddressLine2, City, StateProvinceID, StateProvinceName, 
        PostalCode, CountryRegionCode, CountryRegionName, AddressType, 
        TerritoryID, EmailPromotion, RowGUID, ModifiedDate
    )
    VALUES (
        source.CustomerAlternateKey, source.AccountNumber, source.FirstName, 
        source.MiddleName, source.LastName, source.FullName, source.Title, 
        source.Suffix, source.PersonType, source.EmailAddress, source.PhoneNumber, 
        source.AddressLine1, source.AddressLine2, source.City, source.StateProvinceID, 
        source.StateProvinceName, source.PostalCode, source.CountryRegionCode, 
        source.CountryRegionName, source.AddressType, source.TerritoryID, 
        source.EmailPromotion, source.rowguid, source.ModifiedDate
    );

PRINT 'DimCustomer populated successfully (SCD Type 1)';
GO

/* ===== POPULATE DimEmployee (SCD Type 1) =====
   Logic:
   - MATCH on BusinessEntityID (natural key)
   - INSERT new employees
   - UPDATE existing employee attributes
*/
MERGE INTO [dbo].[DimEmployee] AS target
USING (
    SELECT
        e.BusinessEntityID,
        e.NationalIDNumber,
        e.LoginID,
        e.JobTitle,
        e.BirthDate,
        e.Gender,
        e.MaritalStatus,
        e.HireDate,
        e.SalariedFlag,
        e.VacationHours,
        e.SickLeaveHours,
        e.CurrentFlag,
        edh.DepartmentID,
        d.Name AS DepartmentName,
        d.GroupName,
        edh.ShiftID,
        s.Name AS ShiftName,
        edh.StartDate AS DepartmentStartDate,
        edh.EndDate AS DepartmentEndDate,
        p.FirstName,
        p.MiddleName,
        p.LastName,
        LTRIM(RTRIM(COALESCE(p.FirstName, '') + ' ' + COALESCE(p.MiddleName, '') + ' ' + COALESCE(p.LastName, ''))) AS FullName,
        p.Title,
        p.Suffix,
        p.EmailPromotion,
        p.Demographics,
        e.rowguid,
        GETDATE() AS ModifiedDate
    FROM [HumanResources].[Employee] e
    INNER JOIN [Person].[Person] p ON e.BusinessEntityID = p.BusinessEntityID
    LEFT JOIN [HumanResources].[EmployeeDepartmentHistory] edh ON e.BusinessEntityID = edh.BusinessEntityID 
        AND edh.EndDate IS NULL  -- Get current department assignment
    LEFT JOIN [HumanResources].[Department] d ON edh.DepartmentID = d.DepartmentID
    LEFT JOIN [HumanResources].[Shift] s ON edh.ShiftID = s.ShiftID
) AS source
ON target.BusinessEntityID = source.BusinessEntityID
WHEN MATCHED THEN
    UPDATE SET
        target.NationalIDNumber = source.NationalIDNumber,
        target.LoginID = source.LoginID,
        target.JobTitle = source.JobTitle,
        target.BirthDate = source.BirthDate,
        target.Gender = source.Gender,
        target.MaritalStatus = source.MaritalStatus,
        target.HireDate = source.HireDate,
        target.SalariedFlag = source.SalariedFlag,
        target.VacationHours = source.VacationHours,
        target.SickLeaveHours = source.SickLeaveHours,
        target.CurrentFlag = source.CurrentFlag,
        target.DepartmentID = source.DepartmentID,
        target.DepartmentName = source.DepartmentName,
        target.GroupName = source.GroupName,
        target.ShiftID = source.ShiftID,
        target.ShiftName = source.ShiftName,
        target.DepartmentStartDate = source.DepartmentStartDate,
        target.DepartmentEndDate = source.DepartmentEndDate,
        target.FirstName = source.FirstName,
        target.MiddleName = source.MiddleName,
        target.LastName = source.LastName,
        target.FullName = source.FullName,
        target.Title = source.Title,
        target.Suffix = source.Suffix,
        target.EmailPromotion = source.EmailPromotion,
        target.Demographics = source.Demographics,
        target.RowGUID = source.rowguid,
        target.ModifiedDate = source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (
        BusinessEntityID, NationalIDNumber, LoginID, JobTitle, BirthDate, 
        Gender, MaritalStatus, HireDate, SalariedFlag, VacationHours, 
        SickLeaveHours, CurrentFlag, DepartmentID, DepartmentName, GroupName, 
        ShiftID, ShiftName, DepartmentStartDate, DepartmentEndDate, FirstName, 
        MiddleName, LastName, FullName, Title, Suffix, EmailPromotion, Demographics, 
        RowGUID, ModifiedDate
    )
    VALUES (
        source.BusinessEntityID, source.NationalIDNumber, source.LoginID, 
        source.JobTitle, source.BirthDate, source.Gender, source.MaritalStatus, 
        source.HireDate, source.SalariedFlag, source.VacationHours, 
        source.SickLeaveHours, source.CurrentFlag, source.DepartmentID, 
        source.DepartmentName, source.GroupName, source.ShiftID, source.ShiftName, 
        source.DepartmentStartDate, source.DepartmentEndDate, source.FirstName, 
        source.MiddleName, source.LastName, source.FullName, source.Title, 
        source.Suffix, source.EmailPromotion, source.Demographics, 
        source.rowguid, source.ModifiedDate
    );

PRINT 'DimEmployee populated successfully (SCD Type 1)';
GO

/* ===== POPULATE DimProduct (SCD Type 1) =====
   Logic:
   - MATCH on ProductAlternateKey (business key - ProductID)
   - INSERT new products
   - UPDATE existing product attributes
*/
MERGE INTO [dbo].[DimProduct] AS target
USING (
    SELECT
        prod.ProductID AS ProductAlternateKey,
        prod.Name AS ProductName,
        prod.ProductNumber,
        prod.MakeFlag,
        prod.FinishedGoodsFlag,
        prod.Color,
        prod.Size,
        prod.SizeUnitMeasureCode,
        prod.Weight,
        prod.WeightUnitMeasureCode,
        prod.SafetyStockLevel,
        prod.ReorderPoint,
        prod.StandardCost,
        prod.ListPrice,
        prod.DaysToManufacture,
        prod.ProductLine,
        prod.Class,
        prod.Style,
        prod.SellStartDate,
        prod.SellEndDate,
        prod.DiscontinuedDate,
        prod.ProductModelID,
        pm.Name AS ProductModelName,
        pm.CatalogDescription,
        pm.Instructions,
        prod.ProductSubcategoryID,
        psc.Name AS ProductSubcategoryName,
        psc.ProductCategoryID,
        pc.Name AS ProductCategoryName,
        prod.rowguid,
        GETDATE() AS ModifiedDate
    FROM [Production].[Product] prod
    LEFT JOIN [Production].[ProductModel] pm ON prod.ProductModelID = pm.ProductModelID
    LEFT JOIN [Production].[ProductSubcategory] psc ON prod.ProductSubcategoryID = psc.ProductSubcategoryID
    LEFT JOIN [Production].[ProductCategory] pc ON psc.ProductCategoryID = pc.ProductCategoryID
) AS source
ON target.ProductAlternateKey = source.ProductAlternateKey
WHEN MATCHED THEN
    UPDATE SET
        target.ProductName = source.ProductName,
        target.ProductNumber = source.ProductNumber,
        target.MakeFlag = source.MakeFlag,
        target.FinishedGoodsFlag = source.FinishedGoodsFlag,
        target.Color = source.Color,
        target.Size = source.Size,
        target.SizeUnitMeasureCode = source.SizeUnitMeasureCode,
        target.Weight = source.Weight,
        target.WeightUnitMeasureCode = source.WeightUnitMeasureCode,
        target.SafetyStockLevel = source.SafetyStockLevel,
        target.ReorderPoint = source.ReorderPoint,
        target.StandardCost = source.StandardCost,
        target.ListPrice = source.ListPrice,
        target.DaysToManufacture = source.DaysToManufacture,
        target.ProductLine = source.ProductLine,
        target.Class = source.Class,
        target.Style = source.Style,
        target.SellStartDate = source.SellStartDate,
        target.SellEndDate = source.SellEndDate,
        target.DiscontinuedDate = source.DiscontinuedDate,
        target.ProductModelID = source.ProductModelID,
        target.ProductModelName = source.ProductModelName,
        target.CatalogDescription = source.CatalogDescription,
        target.Instructions = source.Instructions,
        target.ProductSubcategoryID = source.ProductSubcategoryID,
        target.ProductSubcategoryName = source.ProductSubcategoryName,
        target.ProductCategoryID = source.ProductCategoryID,
        target.ProductCategoryName = source.ProductCategoryName,
        target.RowGUID = source.rowguid,
        target.ModifiedDate = source.ModifiedDate
WHEN NOT MATCHED THEN
    INSERT (
        ProductAlternateKey, ProductName, ProductNumber, MakeFlag, FinishedGoodsFlag, 
        Color, Size, SizeUnitMeasureCode, Weight, WeightUnitMeasureCode, 
        SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, 
        ProductLine, Class, Style, SellStartDate, SellEndDate, DiscontinuedDate, 
        ProductModelID, ProductModelName, CatalogDescription, Instructions, 
        ProductSubcategoryID, ProductSubcategoryName, ProductCategoryID, 
        ProductCategoryName, RowGUID, ModifiedDate
    )
    VALUES (
        source.ProductAlternateKey, source.ProductName, source.ProductNumber, 
        source.MakeFlag, source.FinishedGoodsFlag, source.Color, source.Size, 
        source.SizeUnitMeasureCode, source.Weight, source.WeightUnitMeasureCode, 
        source.SafetyStockLevel, source.ReorderPoint, source.StandardCost, 
        source.ListPrice, source.DaysToManufacture, source.ProductLine, source.Class, 
        source.Style, source.SellStartDate, source.SellEndDate, source.DiscontinuedDate, 
        source.ProductModelID, source.ProductModelName, source.CatalogDescription, 
        source.Instructions, source.ProductSubcategoryID, source.ProductSubcategoryName, 
        source.ProductCategoryID, source.ProductCategoryName, source.rowguid, 
        source.ModifiedDate
    );

PRINT 'DimProduct populated successfully (SCD Type 1)';
GO

/* ===== DATA VALIDATION =====
   Check record counts in dimension tables
*/
SELECT 'DimCustomer' AS TableName, COUNT(*) AS RecordCount FROM [dbo].[DimCustomer]
UNION ALL
SELECT 'DimEmployee' AS TableName, COUNT(*) AS RecordCount FROM [dbo].[DimEmployee]
UNION ALL
SELECT 'DimProduct' AS TableName, COUNT(*) AS RecordCount FROM [dbo].[DimProduct];

PRINT 'Dimension tables populated successfully!';
GO

/* ===== END OF SCD TYPE 1 POPULATION SCRIPT ===== */
