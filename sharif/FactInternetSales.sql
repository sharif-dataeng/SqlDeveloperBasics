SELECT 
    soh.SalesOrderNumber,
    p.ProductKey,
    c.CustomerKey,
    e.EmployeeKey,
    CAST(FORMAT(soh.OrderDate, 'yyyyMMdd') AS INT) AS OrderDateKey,
    sod.OrderQty,
    sod.UnitPrice,
    (sod.OrderQty * sod.UnitPrice) AS SalesAmount,
    soh.TaxAmt / COUNT(*) OVER(PARTITION BY soh.SalesOrderID) AS ItemTaxAmt -- Pro-rating tax per line
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
-- Join your DIM tables to get the Surrogate Keys
JOIN DimProduct p ON sod.ProductID = p.ProductAlternateKey
JOIN DimCustomer c ON soh.CustomerID = c.CustomerAlternateKey
LEFT JOIN DimEmployee e ON soh.SalesPersonID = e.EmployeeAlternateKey;