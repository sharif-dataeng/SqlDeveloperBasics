
SELECT * FROM DimProduct
SELECT * FROM FactInternetSales


SELECT F.* FROM FactInternetSales F JOIN DimProduct P
ON F.ProductKey = P.ProductKey
WHERE P.Color = 'Red'

SELECT * FROM FactInternetSales 
WHERE ProductKey IN(SELECT ProductKey FROM DimProduct WHERE COLOR = 'Red')

SELECT * FROM FactInternetSales 
WHERE ProductKey 
NOT IN(SELECT ProductKey FROM DimProduct WHERE COLOR = 'Red')