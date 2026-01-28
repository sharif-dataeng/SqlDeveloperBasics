IF OBJECT_ID('dbo.DataLoad_Control','U') IS NULL
BEGIN
	CREATE TABLE dbo.DataLoad_Control
	(
		schemaname varchar(255) NOT NULL,
		tablename  varchar(255) NOT NULL,
		keycolumns varchar(255) NULL,
		loadtype   char(1) NOT NULL DEFAULT ('F'),
		isactive   char(1) NOT NULL DEFAULT ('Y'),
		watermark  varchar(255) NULL,
		loadedon   datetime NOT NULL DEFAULT ('1900-01-01 00:00:00'),
		loadstatus varchar(15) NULL
	);
END
GO

-- INSERT INTO dbo.dataload_control (SchemaName, TableName, KeyColumns)
-- VALUES
-- ('HumanResources','Department','DepartmentID'),
-- ('HumanResources','Employee','BusinessEntityID'),
-- ('HumanResources','EmployeeDepartmentHistory','BusinessEntityID, StartDate, DepartmentID, ShiftID'),
-- ('HumanResources','EmployeePayHistory','BusinessEntityID, RateChangeDate'),
-- ('HumanResources','JobCandidate','JobCandidateID'),
-- ('HumanResources','Shift','ShiftID'),
-- ('Person','Address','AddressID'),
-- ('Person','AddressType','AddressTypeID'),
-- ('Person','BusinessEntity','BusinessEntityID'),
-- ('Person','BusinessEntityAddress','BusinessEntityID, AddressID, AddressTypeID'),
-- ('Person','BusinessEntityContact','BusinessEntityID, PersonID, ContactTypeID'),
-- ('Person','ContactType','ContactTypeID'),
-- ('Person','CountryRegion','CountryRegionCode'),
-- ('Person','EmailAddress','BusinessEntityID, EmailAddressID'),
-- ('Person','Password','BusinessEntityID'),
-- ('Person','Person','BusinessEntityID'),
-- ('Person','PersonPhone','BusinessEntityID, PhoneNumber, PhoneNumberTypeID'),
-- ('Person','PhoneNumberType','PhoneNumberTypeID'),
-- ('Person','StateProvince','StateProvinceID'),
-- ('Production','BillOfMaterials','BillOfMaterialsID'),
-- ('Production','Culture','CultureID'),
-- ('Production','Document','DocumentNode'),
-- ('Production','Illustration','IllustrationID'),
-- ('Production','Location','LocationID'),
-- ('Production','Product','ProductID'),
-- ('Production','ProductCategory','ProductCategoryID'),
-- ('Production','ProductCostHistory','ProductID, StartDate'),
-- ('Production','ProductDescription','ProductDescriptionID'),
-- ('Production','ProductDocument','ProductID, DocumentNode'),
-- ('Production','ProductInventory','ProductID, LocationID'),
-- ('Production','ProductListPriceHistory','ProductID, StartDate'),
-- ('Production','ProductModel','ProductModelID'),
-- ('Production','ProductModelIllustration','ProductModelID, IllustrationID'),
-- ('Production','ProductModelProductDescriptionCulture','ProductModelID, ProductDescriptionID, CultureID'),
-- ('Production','ProductPhoto','ProductPhotoID'),
-- ('Production','ProductProductPhoto','ProductID, ProductPhotoID'),
-- ('Production','ProductReview','ProductReviewID'),
-- ('Production','ProductSubcategory','ProductSubcategoryID'),
-- ('Production','ScrapReason','ScrapReasonID'),
-- ('Production','TransactionHistory','TransactionID'),
-- ('Production','TransactionHistoryArchive','TransactionID'),
-- ('Production','UnitMeasure','UnitMeasureCode'),
-- ('Production','WorkOrder','WorkOrderID'),
-- ('Production','WorkOrderRouting','WorkOrderID, ProductID, OperationSequence'),
-- ('Purchasing','ProductVendor','ProductID, BusinessEntityID'),
-- ('Purchasing','PurchaseOrderDetail','PurchaseOrderID, PurchaseOrderDetailID'),
-- ('Purchasing','PurchaseOrderHeader','PurchaseOrderID'),
-- ('Purchasing','ShipMethod','ShipMethodID'),
-- ('Purchasing','Vendor','BusinessEntityID'),
-- ('Sales','CountryRegionCurrency','CountryRegionCode, CurrencyCode'),
-- ('Sales','CreditCard','CreditCardID'),
-- ('Sales','Currency','CurrencyCode'),
-- ('Sales','CurrencyRate','CurrencyRateID'),
-- ('Sales','Customer','CustomerID'),
-- ('Sales','PersonCreditCard','BusinessEntityID, CreditCardID'),
-- ('Sales','SalesOrderDetail','SalesOrderID, SalesOrderDetailID'),
-- ('Sales','SalesOrderHeader','SalesOrderID'),
-- ('Sales','SalesOrderHeaderSalesReason','SalesOrderID, SalesReasonID'),
-- ('Sales','SalesPerson','BusinessEntityID'),
-- ('Sales','SalesPersonQuotaHistory','BusinessEntityID, QuotaDate'),
-- ('Sales','SalesReason','SalesReasonID'),
-- ('Sales','SalesTaxRate','SalesTaxRateID'),
-- ('Sales','SalesTerritory','TerritoryID'),
-- ('Sales','SalesTerritoryHistory','BusinessEntityID, StartDate, TerritoryID'),
-- ('Sales','ShoppingCartItem','ShoppingCartItemID'),
-- ('Sales','SpecialOffer','SpecialOfferID'),
-- ('Sales','SpecialOfferProduct','SpecialOfferID, ProductID'),
-- ('Sales','Store','BusinessEntityID');

 --update dbo.dataload_control set loadtype = 'I'
 --where tablename in ('Customer','Person','PersonPhone','EmailAddress','AddressType','BusinessEntityAddress',
 --'Address','Employee','Department','EmployeeDepartmentHistory','Product','ProductModel','ProductCategory',
 --'ProductSubcategory','BusinessEntity');

 --update dbo.dataload_control set isactive = 'N'
 --where tablename not in ('Customer','Person','PersonPhone','EmailAddress','AddressType','BusinessEntityAddress',
 --'Address','Employee','Department','EmployeeDepartmentHistory','Product','ProductModel','ProductCategory',
 --'ProductSubcategory','BusinessEntity');

-- update dataload_control set watermark = 'ModifiedDate' where loadtype = 'I'