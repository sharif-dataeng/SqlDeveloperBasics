
WITH CteMTD
as
(
SELECT OrderDate,SUM(SalesAmount) TotalSales FROM FactInternetSales
GROUP BY OrderDate)
SELECT OrderDate,TotalSales , 
SUM(TotalSales) OVER(PARTITION BY MONTH(OrderDate) ORDER BY OrderDate) MTDTotal 
FROM CteMTD
order by OrderDate