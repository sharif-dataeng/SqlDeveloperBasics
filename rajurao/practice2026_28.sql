select * from FactInternetSales
SELECT SalesOrderNumber, SUM(SalesAmount) TotalSales FROM FactInternetSales
GROUP BY SalesOrderNumber
HAVING SUM(SalesAmount)<10000 order by totalsales desc

SELECT ProductKey, SUM(SalesAmount) TotalSales  FROM FactInternetSales
WHERE YEAR(OrderDate)=2012
GROUP BY ProductKey
HAVING SUM(SalesAmount) >=100000 