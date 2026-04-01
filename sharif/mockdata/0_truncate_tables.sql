-- =================================================================
-- STEP 1: TRUNCATE OLTP TABLES (reverse dependency order)
-- =================================================================

-- Truncate dependent tables first
TRUNCATE TABLE [HumanResources].[EmployeeDepartmentHistory];
PRINT 'Truncated: HumanResources.EmployeeDepartmentHistory';

TRUNCATE TABLE [Sales].[Customer];
PRINT 'Truncated: Sales.Customer';

TRUNCATE TABLE [Person].[BusinessEntityAddress];
PRINT 'Truncated: Person.BusinessEntityAddress';

TRUNCATE TABLE [Person].[PersonPhone];
PRINT 'Truncated: Person.PersonPhone';

-- Check if EmailAddress exists (may be PersonEmail in some versions)
IF OBJECT_ID('[Person].[EmailAddress]', 'U') IS NOT NULL
BEGIN
    TRUNCATE TABLE [Person].[EmailAddress];
    PRINT 'Truncated: Person.EmailAddress';
END
ELSE IF OBJECT_ID('[Person].[PersonEmail]', 'U') IS NOT NULL
BEGIN
    TRUNCATE TABLE [Person].[PersonEmail];
    PRINT 'Truncated: Person.PersonEmail';
END

TRUNCATE TABLE [Production].[Product];
PRINT 'Truncated: Production.Product';

TRUNCATE TABLE [Production].[ProductSubcategory];
PRINT 'Truncated: Production.ProductSubcategory';

TRUNCATE TABLE [Production].[ProductModel];
PRINT 'Truncated: Production.ProductModel';

TRUNCATE TABLE [HumanResources].[Employee];
PRINT 'Truncated: HumanResources.Employee';

TRUNCATE TABLE [Person].[Address];
PRINT 'Truncated: Person.Address';

-- Truncate independent lookup tables
TRUNCATE TABLE [Production].[ProductCategory];
PRINT 'Truncated: Production.ProductCategory';

TRUNCATE TABLE [Person].[AddressType];
PRINT 'Truncated: Person.AddressType';

TRUNCATE TABLE [Person].[PhoneNumberType];
PRINT 'Truncated: Person.PhoneNumberType';

TRUNCATE TABLE [HumanResources].[Shift];
PRINT 'Truncated: HumanResources.Shift';

TRUNCATE TABLE [HumanResources].[Department];
PRINT 'Truncated: HumanResources.Department';

TRUNCATE TABLE [Person].[StateProvince];
PRINT 'Truncated: Person.StateProvince';

TRUNCATE TABLE [Sales].[SalesTerritory];
PRINT 'Truncated: Sales.SalesTerritory';

TRUNCATE TABLE [Person].[CountryRegion];
PRINT 'Truncated: Person.CountryRegion';

-- Truncate core Person table (has identity)
TRUNCATE TABLE [Person].[Person];
PRINT 'Truncated: Person.Person';

PRINT 'All tables truncated successfully. Ready for mock data load.';