DimCustomer
-----------
Table Creation Sequence

| Step | Table Name             | Depends On                           |
|------|------------------------|--------------------------------------|
| 1    | BusinessEntity         | —                                    |
| 2    | AddressType            | —                                    |
| 3    | Address                | —                                    |
| 4    | Person                 | BusinessEntity                       |
| 5    | PersonPhone            | BusinessEntity                       |
| 6    | EmailAddress           | BusinessEntity                       |
| 7    | BusinessEntityAddress  | BusinessEntity, Address, AddressType |
| 8    | Customer               | Person                               |

---

Explanation of Dependencies

- BusinessEntity is the root table — all others reference it.
- Person, PersonPhone, and EmailAddress each require BusinessEntityID.
- AddressType and Address are standalone but needed before BusinessEntityAddress.
- BusinessEntityAddress links three tables: BusinessEntity, Address, and AddressType.
- Customer references Person, which in turn depends on BusinessEntity.

This order ensures all foreign key constraints are satisfied during table creation or data insertion.

Dimemployee
-----------

Table Creation Sequence

| Step | Table Name              | Depends On                    |
|------|-------------------------|-------------------------------|
| 1  | Department                | —                             |
| 2  | Person                    | —                             |
| 3  | Employee                  | Person                        |
| 4  | EmployeeDepartmentHistory | Employee, Department          |

---

Explanation of Dependencies

- Department is standalone — no foreign keys.
- Person is also standalone — its the source of BusinessEntityID.
- Employee depends on Person.BusinessEntityID.
- EmployeeDepartmentHistory depends on both Employee.BusinessEntityID and Department.DepartmentID.

This order ensures all foreign key constraints are satisfied during creation and mock data insertion.

Dimproduct
----------

Table Creation Order

| Step | Table Name              | Depends On              |
|------|-------------------------|-------------------------|
| 1  | ProductCategory      | —                       |
| 2  | ProductModel         | —                       |
| 3  | ProductSubcategory   | ProductCategory         |
| 4  | Product              | ProductSubcategory, ProductModel |

---

Explanation of Dependencies

- ProductCategory is standalone — no foreign keys.
- ProductModel is also standalone — used for product descriptions.
- ProductSubcategory depends on ProductCategoryID.
- Product depends on both ProductSubcategoryID and ProductModelID.

This order ensures all foreign key constraints are satisfied during table creation and mock data insertion.