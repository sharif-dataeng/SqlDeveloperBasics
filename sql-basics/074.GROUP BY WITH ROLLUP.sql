

SELECT YEAR(OrderDate) OrderYear ,SUM(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY YEAR(OrderDate)


SELECT YEAR(OrderDate) OrderYear ,SUM(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY ROLLUP(YEAR(OrderDate))

SELECT YEAR(OrderDate) OrderYear ,FORMAT(OrderDate,'MMM') MonthNm,
SUM(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY YEAR(OrderDate),FORMAT(OrderDate,'MMM')


SELECT YEAR(OrderDate) OrderYear , MONTH(OrderDate) MonthNum,
SUM(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY ROLLUP(YEAR(OrderDate),MONTH(OrderDate))


SELECT ISNULL(FORMAT(OrderDate,'yyyy'),'Grand Total') OrderYear ,
SUM(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY ROLLUP(FORMAT(OrderDate,'yyyy'))


SELECT ISNULL(FORMAT(OrderDate,'yyyy'),'Grand Total') OrderYear ,
ISNULL(FORMAT(OrderDate,'MM'),FORMAT(OrderDate,'yyyy') + ' Total') MonthNum,
SUM(SalesAmount) TotalSales
FROM FactInternetSales
GROUP BY ROLLUP(FORMAT(OrderDate,'yyyy'),FORMAT(OrderDate,'MM'))