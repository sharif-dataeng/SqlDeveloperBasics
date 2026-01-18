SELECT 
    c.CustomerID AS CustomerAlternateKey,
    p.Title,
    p.FirstName,
    p.LastName,
    e.EmailAddress,
    ph.PhoneNumber,
    a.AddressLine1,
    a.City,
    sp.Name AS StateProvinceName,
    cr.Name AS CountryRegionName
FROM Sales.Customer c
INNER JOIN Person.Person p 
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Person.EmailAddress e 
    ON p.BusinessEntityID = e.BusinessEntityID
LEFT JOIN Person.PersonPhone ph 
    ON p.BusinessEntityID = ph.BusinessEntityID
LEFT JOIN Person.BusinessEntityAddress bea 
    ON p.BusinessEntityID = bea.BusinessEntityID
LEFT JOIN Person.Address a 
    ON bea.AddressID = a.AddressID
LEFT JOIN Person.StateProvince sp 
    ON a.StateProvinceID = sp.StateProvinceID
LEFT JOIN Person.CountryRegion cr 
    ON sp.CountryRegionCode = cr.CountryRegionCode;