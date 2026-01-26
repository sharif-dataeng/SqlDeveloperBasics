CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    ProductAlternateKey INT NOT NULL,         -- Production.Product.ProductID
    ProductNumber NVARCHAR(25) NOT NULL,
    ProductName NVARCHAR(50) NOT NULL,
    Color NVARCHAR(15) NULL,
    Size NVARCHAR(5) NULL,
    ProductModelName NVARCHAR(50) NULL,
    ProductSubcategoryName NVARCHAR(50) NULL,
    ProductCategoryName NVARCHAR(50) NULL,
    StandardCost MONEY NOT NULL,
    ListPrice MONEY NOT NULL,
    SellStartDate DATETIME NOT NULL,
    SellEndDate DATETIME NULL
);

dont use this ddl script anymore