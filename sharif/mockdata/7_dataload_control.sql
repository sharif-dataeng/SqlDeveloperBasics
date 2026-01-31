
/*
  Active script: ensure `dbo.DataLoad_Control` exists and populate it
  with each table's PRIMARY KEY columns (comma-aggregated for composite PKs)
  only for tables that contain a `ModifiedDate` column. The `watermark`
  column will be set to 'ModifiedDate'. Existing rows are not duplicated.
*/
SET NOCOUNT ON;

IF OBJECT_ID('dbo.DataLoad_Control','U') IS NULL
BEGIN
	CREATE TABLE dbo.DataLoad_Control
	(
		schemaname varchar(255) NOT NULL,
		tablename  varchar(255) NOT NULL,
		keycolumns varchar(4000) NULL,
		loadtype   char(1) NOT NULL DEFAULT ('F'),
		isactive   char(1) NOT NULL DEFAULT ('Y'),
		watermark  varchar(255) NULL,
		loadedon   datetime NOT NULL DEFAULT ('1900-01-01 00:00:00'),
		loadstatus varchar(15) NULL
	);
END
GO

-- Populate entries for tables that have a primary key and a ModifiedDate column
;WITH PKInfo AS (
	SELECT
		s.name AS SchemaName,
		t.name AS TableName,
		STRING_AGG(c.name, ', ') WITHIN GROUP (ORDER BY ic.key_ordinal) AS KeyColumns
	FROM sys.tables t
	JOIN sys.schemas s ON t.schema_id = s.schema_id
	JOIN sys.indexes i ON i.object_id = t.object_id AND i.is_primary_key = 1
	JOIN sys.index_columns ic ON ic.object_id = t.object_id AND ic.index_id = i.index_id
	JOIN sys.columns c ON c.object_id = t.object_id AND c.column_id = ic.column_id
	-- require ModifiedDate column to be present
	JOIN sys.columns md ON md.object_id = t.object_id AND md.name = 'ModifiedDate'
	WHERE t.is_ms_shipped = 0
	GROUP BY s.name, t.name
)
INSERT INTO dbo.DataLoad_Control (schemaname, tablename, keycolumns, loadtype, isactive, watermark, loadedon, loadstatus)
SELECT
	p.SchemaName,
	p.TableName,
	p.KeyColumns,
	'I', -- loadtype: I = incremental
	'Y', -- isactive
	'ModifiedDate',
	'1900-01-01 00:00:00',
	NULL
FROM PKInfo p
WHERE NOT EXISTS (
	SELECT 1 FROM dbo.DataLoad_Control d
	WHERE d.schemaname = p.SchemaName AND d.tablename = p.TableName
);
GO

/*
	Loadtype rationale (I = incremental, F = full)

	Criteria:
		- I (incremental): transactional or frequently-changing tables where capturing deltas
			via `ModifiedDate` is efficient and preferred.
		- F (full): stable lookup/metadata tables or slowly-changing small tables where
			a full refresh is simpler and less error-prone.

	Per-table reasons:
		Person.Address                -> I  (addresses change/added frequently)
		Person.AddressType            -> F  (static lookup)
		Person.BusinessEntity         -> I  (central master, new/updated records)
		Person.BusinessEntityAddress  -> I  (associations change)
		Person.CountryRegion          -> F  (stable lookup)
		Sales.Customer                -> I  (customer records change)
		HumanResources.Department     -> F  (organizational lookup)
		Person.EmailAddress           -> I  (contact emails update/add)
		HumanResources.Employee       -> I  (employee master changes)
		HumanResources.EmployeeDepartmentHistory -> I (historical/transactional)
		Person.Person                 -> I  (person master updates)
		Person.PersonPhone            -> I  (contact phone changes)
		Person.PhoneNumberType        -> F  (lookup)
		Production.Product            -> I  (product master can change)
		Production.ProductCategory    -> F  (lookup)
		Production.ProductModel       -> F  (metadata/infrequent changes)
		Production.ProductSubcategory -> F  (lookup)
		Sales.SalesTerritory          -> F  (slow-changing lookup)
		HumanResources.Shift          -> F  (lookup)
		Person.StateProvince         -> F  (geographic lookup)

	These notes explain why the script sets `loadtype = 'I'` or `'F'` below.
*/
-- Set incremental ('I') tables
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'Person' AND tablename = 'Address';
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'Person' AND tablename = 'BusinessEntity';
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'Person' AND tablename = 'BusinessEntityAddress';
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'Sales' AND tablename = 'Customer';
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'Person' AND tablename = 'EmailAddress';
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'HumanResources' AND tablename = 'Employee';
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'HumanResources' AND tablename = 'EmployeeDepartmentHistory';
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'Person' AND tablename = 'Person';
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'Person' AND tablename = 'PersonPhone';
UPDATE dbo.DataLoad_Control SET loadtype = 'I' WHERE schemaname = 'Production' AND tablename = 'Product';

-- Set full ('F') tables (explicit to ensure correct values)
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'Person' AND tablename = 'AddressType';
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'Person' AND tablename = 'CountryRegion';
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'HumanResources' AND tablename = 'Department';
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'Person' AND tablename = 'PhoneNumberType';
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'Production' AND tablename = 'ProductCategory';
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'Production' AND tablename = 'ProductModel';
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'Production' AND tablename = 'ProductSubcategory';
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'Sales' AND tablename = 'SalesTerritory';
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'HumanResources' AND tablename = 'Shift';
UPDATE dbo.DataLoad_Control SET loadtype = 'F' WHERE schemaname = 'Person' AND tablename = 'StateProvince';

-- Verify applied values (optional)
SELECT schemaname, tablename, loadtype FROM dbo.DataLoad_Control
WHERE (schemaname IN ('Person','Sales','HumanResources','Production'))
	AND tablename IN (
		'Address','AddressType','BusinessEntity','BusinessEntityAddress','CountryRegion','Customer',
		'Department','EmailAddress','Employee','EmployeeDepartmentHistory','Person','PersonPhone','PhoneNumberType',
		'Product','ProductCategory','ProductModel','ProductSubcategory','SalesTerritory','Shift','StateProvince'
	)
ORDER BY schemaname, tablename;
GO
