

WITH CTE_Ytd
AS
(
SELECT OrderDate,SUM(SalesAmount) TotalSales FROM FactInternetSales
GROUP BY OrderDate
)
SELECT OrderDate,TotalSales,
SUM(TotalSales) OVER(PARTITION BY YEAR(OrderDate) ORDER BY OrderDate) YTDTotal
FROM CTE_Ytd



WITH CTE_Ytd
AS
(
SELECT YEAR(OrderDate) OrderYear,MONTH(OrderDate) OrderMonth,
SUM(SalesAmount) TotalSales FROM FactInternetSales
GROUP BY YEAR(OrderDate),MONTH(OrderDate) 
)
SELECT OrderYear,OrderMonth,TotalSales,
SUM(TotalSales) OVER(PARTITION BY OrderYear ORDER BY OrderYear,OrderMonth) YTDTotal
FROM CTE_Ytd
