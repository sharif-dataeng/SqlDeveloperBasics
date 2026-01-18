CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    CustomerAlternateKey INT NOT NULL,         -- Sales.Customer.CustomerID
    Title NVARCHAR(8) NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    EmailAddress NVARCHAR(50) NULL,
    PhoneNumber NVARCHAR(25) NULL,
    AddressLine1 NVARCHAR(60) NULL,
    City NVARCHAR(30) NULL,
    StateProvinceName NVARCHAR(50) NULL,
    CountryRegionName NVARCHAR(50) NULL
);