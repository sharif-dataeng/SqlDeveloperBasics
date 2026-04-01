-- ===================================================================
-- DATA VALIDATION - COUNT ALL RECORDS
-- Purpose: Verify mock data was loaded successfully by counting 
--          records in all tables
-- ===================================================================

USE [AdventureWorkMock];
GO

SELECT 
    'Person.CountryRegion' AS TableName, COUNT(*) AS RecordCount FROM Person.CountryRegion
UNION ALL SELECT 'Person.SalesTerritory', COUNT(*) FROM Sales.SalesTerritory
UNION ALL SELECT 'Person.StateProvince', COUNT(*) FROM Person.StateProvince
UNION ALL SELECT 'Person.Address', COUNT(*) FROM Person.Address
UNION ALL SELECT 'Person.AddressType', COUNT(*) FROM Person.AddressType
UNION ALL SELECT 'Person.BusinessEntityAddress', COUNT(*) FROM Person.BusinessEntityAddress
UNION ALL SELECT 'Person.PhoneNumberType', COUNT(*) FROM Person.PhoneNumberType
UNION ALL SELECT 'Person.Person', COUNT(*) FROM Person.Person
UNION ALL SELECT 'Person.PersonPhone', COUNT(*) FROM Person.PersonPhone
UNION ALL SELECT 'Person.EmailAddress', COUNT(*) FROM Person.EmailAddress
UNION ALL SELECT 'Sales.Customer', COUNT(*) FROM Sales.Customer
UNION ALL SELECT 'HumanResources.Department', COUNT(*) FROM HumanResources.Department
UNION ALL SELECT 'HumanResources.Shift', COUNT(*) FROM HumanResources.Shift
UNION ALL SELECT 'HumanResources.Employee', COUNT(*) FROM HumanResources.Employee
UNION ALL SELECT 'HumanResources.EmployeeDepartmentHistory', COUNT(*) FROM HumanResources.EmployeeDepartmentHistory
UNION ALL SELECT 'Production.ProductCategory', COUNT(*) FROM Production.ProductCategory
UNION ALL SELECT 'Production.ProductSubcategory', COUNT(*) FROM Production.ProductSubcategory
UNION ALL SELECT 'Production.ProductModel', COUNT(*) FROM Production.ProductModel
UNION ALL SELECT 'Production.Product', COUNT(*) FROM Production.Product
ORDER BY TableName;

