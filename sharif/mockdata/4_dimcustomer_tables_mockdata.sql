
-- =========================================================
-- dimcustomer_tables_mockdata.sql
-- Purpose: Small dependency-aware seed data for Person / Sales
-- tables (CountryRegion, SalesTerritory, StateProvince, Address,
-- BusinessEntityAddress, PhoneNumberType, Person, PersonPhone,
-- EmailAddress, Sales.Customer).
--
-- Usage:
-- - The script contains sample INSERT statements which are commented
--   out. To run a block, remove the leading `--` for the statements
--   you want to execute (or copy them into a new script) and run
--   them in the order shown below.
-- - If a target table uses an IDENTITY column and the sample uses
--   explicit keys, enable `SET IDENTITY_INSERT <schema>.<table> ON` as
--   needed, or adapt the INSERTs to omit identity columns.
--
-- Dependency / run order (to avoid FK constraint errors):
-- 1) Person.CountryRegion
-- 2) Sales.SalesTerritory  (depends on CountryRegion via CountryRegionCode)
-- 3) Person.StateProvince  (depends on CountryRegion; often stores TerritoryID FK)
-- 4) Person.Address        (depends on StateProvince)
-- 5) Person.AddressType / Person.BusinessEntity (if using AddressType or BusinessEntity)
-- 6) Person.BusinessEntityAddress (depends on BusinessEntity, Address, AddressType)
-- 7) Person.PhoneNumberType
-- 8) Person.Person         (may reference BusinessEntityID)
-- 9) Person.PersonPhone    (depends on Person and PhoneNumberType)
--10) Person.EmailAddress  (depends on Person)
--11) Sales.Customer       (depends on PersonID/StoreID/TerritoryID)
--
-- Notes & assumptions:
-- - This file provides small illustrative data only. Adjust IDs
--   and values to match your environment (existing keys, identity
--   columns, constraints).
-- - Where the sample refers to `BusinessEntityID`, ensure the
--   `Person.BusinessEntity` (or equivalent) rows exist, or change to
--   use `PersonID`/`CustomerID` as appropriate for your schema.
-- - If using a transactional run, wrap related inserts in an explicit
--   transaction so you can roll back on error.
-- - Keep the order above to satisfy typical FK relationships.
-- =========================================================

-- =========================
-- 1) CountryRegion
-- =========================

--INSERT INTO Person.CountryRegion (CountryRegionCode, Name, ModifiedDate)
--VALUES
--('US', 'United States', GETDATE()),
--('CA', 'Canada', GETDATE()),
--('MX', 'Mexico', GETDATE()),
--('UK', 'United Kingdom', GETDATE()),
--('IN', 'India', GETDATE());

--select * from Person.CountryRegion


-- =========================
-- 2) SalesTerritory (depends on CountryRegion)
-- =========================

--INSERT INTO Sales.SalesTerritory (
--    Name,
--    CountryRegionCode,
--    [Group],
--    SalesYTD,
--    SalesLastYear,
--    CostYTD,
--    CostLastYear
--)
--VALUES
--('Northwest', 'US', 'North America', 0, 0, 0, 0),
--('Southwest', 'US', 'North America', 0, 0, 0, 0),
--('West Coast', 'US', 'North America', 0, 0, 0, 0),
--('Mountain', 'US', 'North America', 0, 0, 0, 0),
--('South Central', 'US', 'North America', 0, 0, 0, 0);

--select * from Sales.SalesTerritory


-- =========================
-- 3) StateProvince (depends on CountryRegion, may reference TerritoryID)
-- =========================

--INSERT INTO Person.StateProvince (
--    StateProvinceCode,
--    CountryRegionCode,
--    IsOnlyStateProvinceFlag,
--    Name,
--    TerritoryID
--)
--VALUES
--('WA ', 'US', 1, 'Washington', 1),
--('OR ', 'US', 1, 'Oregon', 2),
--('CA ', 'US', 1, 'California', 3),
--('CO ', 'US', 1, 'Colorado', 4),
--('TX ', 'US', 1, 'Texas', 5);

--select * from Person.StateProvince


-- =========================
-- 4) Address (depends on StateProvince)
-- =========================

--INSERT INTO Person.Address (
--    AddressLine1,
--    AddressLine2,
--    City,
--    StateProvinceID,
--    PostalCode
--)
--VALUES
--('123 Main Street', NULL, 'Seattle', 1, '98101'),
--('456 Oak Avenue', 'Apt 2B', 'Portland', 2, '97205'),
--('789 Pine Road', NULL, 'San Francisco', 3, '94107'),
--('101 Maple Blvd', 'Suite 300', 'Denver', 4, '80202'),
--('202 Birch Lane', NULL, 'Austin', 5, '73301');

--select * from Person.Address


-- =========================
-- 5) AddressType (lookup used by BusinessEntityAddress)
-- =========================

--INSERT INTO Person.AddressType (Name)
--VALUES
--('Home'),
--('Work'),
--('Billing'),
--('Shipping'),
--('Temporary');

--select * from Person.AddressType


-- =========================
-- 6) BusinessEntity / BusinessEntityAddress
--    (BusinessEntity rows assumed present; Address/AddressType required)
-- =========================

--select * from Person.BusinessEntity

--INSERT INTO Person.BusinessEntityAddress (
--    BusinessEntityID,
--    AddressID,
--    AddressTypeID
--)
--VALUES
--(1, 2, 1),  -- Entity 1 → Address 2 → AddressType 1
--(2, 3, 2),  -- Entity 2 → Address 3 → AddressType 2
--(3, 4, 3),  -- Entity 3 → Address 4 → AddressType 3
--(4, 5, 4),  -- Entity 4 → Address 5 → AddressType 4
--(5, 6, 5);  -- Entity 5 → Address 6 → AddressType 5

-- select * from Person.BusinessEntityAddress


-- =========================
-- 7) PhoneNumberType (lookup for PersonPhone)
-- =========================

--INSERT INTO Person.PhoneNumberType (Name)
--VALUES
--('Home'),
--('Work'),
--('Mobile'),
--('Fax'),
--('Other');

--select * from Person.PhoneNumberType


-- =========================
-- 8) Person (depends on BusinessEntity if using BusinessEntityID)
-- =========================

--INSERT INTO Person.Person (
--    BusinessEntityID,
--    PersonType,
--    NameStyle,
--    FirstName,
--    LastName,
--    EmailPromotion
--)
--VALUES
--(1, 'EM', 0, 'John', 'Doe', 0),
--(2, 'EM', 0, 'Jane', 'Smith', 1),
--(3, 'EM', 0, 'Robert', 'Brown', 0),
--(4, 'EM', 0, 'Emily', 'Davis', 1),
--(5, 'EM', 0, 'Michael', 'Wilson', 0);

--select * from Person.Person


-- =========================
-- 9) PersonPhone (depends on Person and PhoneNumberType)
-- =========================

--INSERT INTO Person.PersonPhone (
--    BusinessEntityID,
--    PhoneNumber,
--    PhoneNumberTypeID
--)
--VALUES
--(1, '206-555-0101', 1),  -- Home
--(2, '503-555-0102', 2),  -- Work
--(3, '415-555-0103', 3),  -- Mobile
--(4, '303-555-0104', 4),  -- Fax
--(5, '512-555-0105', 5);  -- Other

--select * from Person.PersonPhone


-- =========================
-- 10) EmailAddress (depends on Person)
-- =========================

--INSERT INTO Person.EmailAddress (
--    BusinessEntityID,
--    EmailAddress
--)
--VALUES
--(1, 'john.doe@example.com'),
--(2, 'jane.smith@example.com'),
--(3, 'robert.brown@example.com'),
--(4, 'emily.davis@example.com'),
--(5, 'michael.wilson@example.com');

--select * from Person.EmailAddress


-- =========================
-- 11) Sales.Customer (depends on Person and SalesTerritory)
-- =========================

--INSERT INTO Sales.Customer (
--    PersonID,
--    StoreID,
--    TerritoryID
--)
--VALUES
--(1, NULL, 1),  -- John Doe in Northwest
--(2, NULL, 2),  -- Jane Smith in Southwest
--(3, NULL, 3),  -- Robert Brown in West Coast
--(4, NULL, 4),  -- Emily Davis in Mountain
--(5, NULL, 5);  -- Michael Wilson in South Central

--select * from Sales.Customer