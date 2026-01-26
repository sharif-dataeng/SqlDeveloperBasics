CREATE TABLE DimEmployee (
    EmployeeKey INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    EmployeeAlternateKey INT NOT NULL,         -- HR.Employee.BusinessEntityID
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    JobTitle NVARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    HireDate DATE NOT NULL,
    DepartmentName NVARCHAR(50) NULL,
    IsCurrent BIT NOT NULL                     -- HR.Employee.CurrentFlag
);

dont use this ddl script anymore