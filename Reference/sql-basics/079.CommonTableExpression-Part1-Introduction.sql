

WITH CteSelectData
AS
(
	SELECT ProductKey,YEAR(OrderDate) OrderYear ,SalesAmount 
	FROM FactInternetSales
)
SELECT ProductKey,OrderYear,SUM(SalesAmount) TotalSales FROM CteSelectData
GROUP BY ProductKey,OrderYear

