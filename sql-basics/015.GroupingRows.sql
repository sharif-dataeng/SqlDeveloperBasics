




SELECT DISTINCT ProductKey FROM FactInternetSales


SELECT SUM(SalesAmount) TotalSales
FROM FactInternetSales

SELECT ProductKey,SUM(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY ProductKey

SELECT ProductKey,CustomerKey, SUM(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY ProductKey,CustomerKey

SELECT ProductKey,CustomerKey, avg(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY ProductKey,CustomerKey

SELECT ProductKey,SUM(SalesAmount) TotalSales,
AVG(SalesAmount) AvgSales
FROM FactInternetSales
GROUP BY ProductKey

SELECT ProductKey,SUM(SalesAmount) TotalSales,
SUM(TaxAmt) TotalTax
FROM FactInternetSales
GROUP BY ProductKey