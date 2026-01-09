
WITH CteRunningTotalDayWise
AS
(
SELECT OrderDate,SUM(SalesAmount) TotalSales FROM FactInternetSales
GROUP BY OrderDate)
SELECT OrderDate,TotalSales,SUM(TotalSales) OVER(ORDER BY OrderDate) RunningTotal
FROM CteRunningTotalDayWise
