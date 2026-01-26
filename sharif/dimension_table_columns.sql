Recommended Columns for DimCustomer

| Column Name            | Source Table             | Notes                                                 |
|------------------------|--------------------------|-------------------------------------------------------|
| CustomerKey        	 | —                        | Surrogate key (auto-generated in DW)                  |
| CustomerAlternateKey   | Customer.CustomerID   	| Business key from OLTP                                |
| AccountNumber          | Customer.AccountNumber   | Useful for linking to transactional data              |
| FirstName              | Person.FirstName         |                                                       |
| MiddleName             | Person.MiddleName        | Optional                                              |
| LastName               | Person.LastName          |                                                       |
| FullName               | Derived                  | Concatenate First + Middle + Last                     |
| Title                  | Person.Title             | Optional (e.g., Mr., Ms., Dr.)                        |
| Suffix                 | Person.Suffix            | Optional                                              |
| PersonType             | Person.PersonType        | Helps distinguish types (e.g., employee, customer)    |
| EmailAddress           | EmailAddress.EmailAddress| Join via BusinessEntityID                             |
| PhoneNumber            | —                        | Not shown in your diagram, but often from PersonPhone |
| AddressLine1           | Address.AddressLine1     | Join via BusinessEntityAddress                        |
| AddressLine2           | Address.AddressLine2     | Optional                                              |
| City                   | Address.City             |                                                       |
| StateProvinceID        | Address.StateProvinceID  | Can be joined to StateProvince for name               |
| PostalCode             | Address.PostalCode       |                                                       |
| CountryRegion          | Derived or via join      | From StateProvince → CountryRegion                    |
| AddressType            | AddressType.Name         | E.g., Home, Billing – join via BusinessEntityAddress  |
| TerritoryID            | Customer.TerritoryID     | Optional – useful for sales analysis                  |
| StoreID                | Customer.StoreID         | Optional – if customer is associated with a store     |
| EmailPromotion         | Person.EmailPromotion    | Indicates opt-in status                               |
| EffectiveDate          | DW metadata              | For SCD Type 2                                        |
| ExpiryDate             | DW metadata              | For SCD Type 2                                        |
| IsCurrent              | DW metadata              | Flag for current record                               |

---
Join Path Summary

1. Customer.PersonID → Person.BusinessEntityID
2. Person.BusinessEntityID → EmailAddress.BusinessEntityID
3. Person.BusinessEntityID → BusinessEntityAddress.BusinessEntityID → Address.AddressID
4. BusinessEntityAddress.AddressTypeID → AddressType.AddressTypeID
---

Recommended Columns for DimEmployee

| Column Name        | Source Table                           | Notes                                          |
|--------------------|-------------------------------------   |------------------------------------------------|
| EmployeeKey        | —                                      | Surrogate key (DW-generated)                   |
| BusinessEntityID   | Employee.BusinessEntityID              | Natural key, useful for tracing back to OLTP   |
| NationalIDNumber   | Employee.NationalIDNumber              | Unique identifier per employee                 |
| LoginID            | Employee.LoginID                       | Useful for audit or security analysis          |
| JobTitle           | Employee.JobTitle                      | Role or designation                            |
| BirthDate          | Employee.BirthDate                     | For age-based analysis                         |
| Gender             | Employee.Gender                        | M/F                                            |
| MaritalStatus      | Employee.MaritalStatus                 | Single/Married                                 |
| HireDate           | Employee.HireDate                      | Useful for tenure analysis                     |
| SalariedFlag       | Employee.SalariedFlag                  | Indicates salaried vs hourly                   |
| VacationHours      | Employee.VacationHours                 | Optional – HR analytics                        |
| SickLeaveHours     | Employee.SickLeaveHours                | Optional – HR analytics                        |
| CurrentFlag        | Employee.CurrentFlag                   | Indicates active employment                    |
| DepartmentID       | EmployeeDepartmentHistory.DepartmentID | Join to Department for name                    |
| DepartmentName     | Department.Name                        | Human-readable department name                 |
| GroupName          | Department.GroupName                   | Higher-level grouping                          |
| ShiftID            | EmployeeDepartmentHistory.ShiftID      | Optional – if shift analysis is needed         |
| StartDate          | EmployeeDepartmentHistory.StartDate    | Start of department assignment                 |
| EndDate            | EmployeeDepartmentHistory.EndDate      | End of department assignment                   |
| FirstName          | Person.FirstName                       | Join via BusinessEntityID                      |
| MiddleName         | Person.MiddleName                      | Optional                                       |
| LastName           | Person.LastName                        |                                                |
| FullName           | Derived                                | Concatenate First + Middle + Last              |
| Title              | Person.Title                           | Optional                                       |
| Suffix             | Person.Suffix                          | Optional                                       |
| EmailPromotion     | Person.EmailPromotion                  | Indicates marketing opt-in                     |
| Demographics       | Person.Demographics                    | XML – parse if needed                          |
| EffectiveDate      | DW metadata                            | For SCD Type 2                                 |
| ExpiryDate         | DW metadata                            | For SCD Type 2                                 |
| IsCurrent          | DW metadata                            | Flag for current record                        |

---
Join Path Summary

1. Employee.BusinessEntityID → Person.BusinessEntityID
2. Employee.BusinessEntityID → EmployeeDepartmentHistory.BusinessEntityID
3. EmployeeDepartmentHistory.DepartmentID → Department.DepartmentID
--

Recommended Columns for DimProduct

| Column Name            | Source Table                         | Notes                                          |
|------------------------|--------------------------------------|------------------------------------------------|
| ProductKey             | —                                    | Surrogate key (DW-generated)                   |
| ProductAlternateKey    | Product.ProductID                    | Business key from OLTP                         |
| ProductName            | Product.Name                         |                                                |
| ProductNumber          | Product.ProductNumber                | Unique product code                            |
| MakeFlag               | Product.MakeFlag                     | Indicates if product is manufactured in-house  |
| FinishedGoodsFlag      | Product.FinishedGoodsFlag            | Indicates if product is sellable               |
| Color                  | Product.Color                        | Optional – useful for filtering                |
| Size                   | Product.Size                         | Optional                                       |
| SizeUnitMeasureCode    | Product.SizeUnitMeasureCode          | Optional – join to unit measure if needed      |
| Weight                 | Product.Weight                       | Optional                                       |
| WeightUnitMeasureCode  | Product.WeightUnitMeasureCode        | Optional – join to unit measure if needed      |
| SafetyStockLevel       | Product.SafetyStockLevel             | Inventory planning                             |
| ReorderPoint           | Product.ReorderPoint                 | Inventory planning                             |
| StandardCost           | Product.StandardCost                 | Cost of production                             |
| ListPrice              | Product.ListPrice                    | Selling price                                  |
| DaysToManufacture      | Product.DaysToManufacture            | Lead time                                      |
| ProductLine            | Product.ProductLine                  | Optional – e.g., R, S, T                       |
| Class                  | Product.Class                        | Optional – e.g., High, Medium, Low             |
| Style                  | Product.Style                        | Optional – e.g., W, M                          |
| SellStartDate          | Product.SellStartDate                | Start of availability                          |
| SellEndDate            | Product.SellEndDate                  | End of availability                            |
| ProductModelID         | Product.ProductModelID               | Join to ProductModel                           |
| ProductModelName       | ProductModel.Name                    | Descriptive model name                         |
| CatalogDescription     | ProductModel.CatalogDescription      | Optional – XML or text                         |
| Instructions           | ProductModel.Instructions            | Optional – manufacturing or usage instructions |
| ProductSubcategoryID   | Product.ProductSubcategoryID         | Join to ProductSubcategory                     |
| ProductSubcategoryName | ProductSubcategory.Name              | Descriptive subcategory name                   |
| ProductCategoryID      | ProductSubcategory.ProductCategoryID | Join to ProductCategory                        |
| ProductCategoryName    | ProductCategory.Name                 | Descriptive category name                      |
| EffectiveDate          | DW metadata                          | For SCD Type 2                                 |
| ExpiryDate             | DW metadata                          | For SCD Type 2                                 |
| IsCurrent              | DW metadata                          | Flag for current record                        |

---
Join Path Summary

1. Product.ProductModelID → ProductModel.ProductModelID
2. Product.ProductSubcategoryID → ProductSubcategory.ProductSubcategoryID
3. ProductSubcategory.ProductCategoryID → ProductCategory.ProductCategoryID
---

Dimcustomer
1. [Sales].[Customer]
2. [Person].[Person]
3. [Person].[PersonPhone]
4. [Person].[EmailAddress]
5. [Person].[AddressType]
6. [Person].[BusinessEntityAddress]
7. [Person].[Address]
Dimemployee
1. [HumanResources].[Employee]
2. [Person].[Person]
3. [HumanResources].[Department]
4. [HumanResources].[EmployeeDepartmentHistory]
Dimproduct
1. [Production].[Product]
2. [Production].[ProductModel]
3. [Production].[ProductCategory]
4. [Production].[ProductSubcategory]