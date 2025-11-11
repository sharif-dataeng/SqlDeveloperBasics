

SELECT TOP 10 ProductKey, SUM(SalesAmount) TotalSales 
FROM FactInternetSales
GROUP BY ProductKey
ORDER BY TotalSales DESC

SELECT TOP 10 ProductKey, SUM(SalesAmount) TotalSales 
FROM FactInternetSales
GROUP BY ProductKey
ORDER BY TotalSales 


SELECT TOP 10 P.EnglishProductName, SUM(F.SalesAmount) TotalSales 
FROM FactInternetSales F JOIN DimProduct P 
ON F.ProductKey = P.ProductKey
GROUP BY P.EnglishProductName
ORDER BY TotalSales DESC


SELECT TOP 10 P.EnglishProductName, SUM(F.SalesAmount) TotalSales 
FROM FactInternetSales F JOIN DimProduct P 
ON F.ProductKey = P.ProductKey
GROUP BY P.EnglishProductName
ORDER BY TotalSales 