
WITH CTE_QTD
AS
(
SELECT OrderDate,SUM(SalesAmount) TotalSales FROM FactInternetSales
GROUP BY OrderDate)
SELECT OrderDate,TotalSales, 
SUM(TotalSales) OVER(PARTITION BY YEAR(OrderDate),DATEPART(QUARTER,OrderDate) 
ORDER BY OrderDate) QTDTotal
FROM CTE_QTD
ORDER BY OrderDate


