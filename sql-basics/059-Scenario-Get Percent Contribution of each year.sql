
SELECT SUM(SalesAmount) FROM FactInternetSales

SELECT YEAR(OrderDate) OrderYear,SUM(SalesAmount) TotalSales,
FORMAT(SUM(SalesAmount) /(SELECT SUM(SalesAmount) FROM FactInternetSales),'P')
Contribution
FROM FactInternetSales
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate)
