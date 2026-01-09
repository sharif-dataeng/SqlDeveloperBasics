

WITH CTE_PreviousYearTotal
AS
(
SELECT YEAR(OrderDate) OrderYear,SUM(SalesAmount) TotalSales FROM FactInternetSales
GROUP BY YEAR(OrderDate)

)
SELECT OrderYear, TotalSales, LAG(TotalSales,1) OVER(ORDER BY OrderYear) PrevYearTotal 
FROM CTE_PreviousYearTotal





WITH CTE_PreviousYearTotal
AS
(
SELECT YEAR(OrderDate) OrderYear,SUM(SalesAmount) TotalSales FROM FactInternetSales
GROUP BY YEAR(OrderDate)

)
SELECT OrderYear, TotalSales, LAG(TotalSales,1) OVER(ORDER BY OrderYear) PrevYearTotal,
FORMAT((TotalSales-LAG(TotalSales,1) OVER(ORDER BY OrderYear))/
LAG(TotalSales,1) OVER(ORDER BY OrderYear),'P') YOYGrowth
FROM CTE_PreviousYearTotal


WITH CTE_PreviousYearTotal
AS
(
SELECT YEAR(OrderDate) OrderYear,SUM(SalesAmount) TotalSales FROM FactInternetSales
GROUP BY YEAR(OrderDate)
),
CTE_2
AS
(
SELECT OrderYear, TotalSales, LAG(TotalSales,1) OVER(ORDER BY OrderYear) PrevYearTotal 
FROM CTE_PreviousYearTotal)
SELECT *,FORMAT((TotalSales-PrevYearTotal)/PrevYearTotal,'P') YOYGrowth FROM CTE_2
