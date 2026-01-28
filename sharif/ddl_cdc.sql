USE AdventureWorks;
GO

ALTER AUTHORIZATION ON DATABASE::AdventureWorks TO [sa];

GO

EXEC sys.sp_cdc_enable_db;

GO

EXEC sys.sp_cdc_enable_table @source_schema = N'Person', @source_name = N'Address', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'Person', @source_name = N'AddressType', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'Person', @source_name = N'BusinessEntityAddress', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'Person', @source_name = N'PersonPhone', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'Person', @source_name = N'EmailAddress', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'Person', @source_name = N'Person', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'Person', @source_name = N'BusinessEntity', @role_name = NULL, @supports_net_changes = 1;

EXEC sys.sp_cdc_enable_table @source_schema = N'Sales', @source_name = N'Customer', @role_name = NULL, @supports_net_changes = 1;

EXEC sys.sp_cdc_enable_table @source_schema = N'HumanResources', @source_name = N'Department', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'HumanResources', @source_name = N'Employee', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'HumanResources', @source_name = N'EmployeeDepartmentHistory', @role_name = NULL, @supports_net_changes = 1;

EXEC sys.sp_cdc_enable_table @source_schema = N'Production', @source_name = N'Product', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'Production', @source_name = N'ProductCategory', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'Production', @source_name = N'ProductModel', @role_name = NULL, @supports_net_changes = 1;
EXEC sys.sp_cdc_enable_table @source_schema = N'Production', @source_name = N'ProductSubcategory', @role_name = NULL, @supports_net_changes = 1;
GO