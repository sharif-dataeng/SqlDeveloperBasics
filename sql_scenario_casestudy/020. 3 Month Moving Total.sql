

WITH CTE_Moving3MTotal
AS
(
SELECT YEAR(OrderDate) OrderYear,MONTH(OrderDate) OrderMonth,
SUM(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY YEAR(OrderDate),MONTH(OrderDate)
)
SELECT OrderYear, OrderMonth,TotalSales,
SUM(TotalSales) OVER(ORDER BY OrderYear, OrderMonth ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) Moving3mTotal
FROM CTE_Moving3MTotal
