SELECT 
    e.BusinessEntityID AS EmployeeAlternateKey,
    -- Self-join logic for manager would go here in an ETL tool
    p.FirstName,
    p.LastName,
    e.JobTitle,
    e.BirthDate,
    e.HireDate,
    d.Name AS DepartmentName,
    e.CurrentFlag AS IsCurrent
FROM HumanResources.Employee e
INNER JOIN Person.Person p 
    ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh 
    ON e.BusinessEntityID = edh.BusinessEntityID 
    AND edh.EndDate IS NULL -- Get only the CURRENT department
INNER JOIN HumanResources.Department d 
    ON edh.DepartmentID = d.DepartmentID;