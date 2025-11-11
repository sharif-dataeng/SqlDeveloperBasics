

SELECT TOP 10 * FROM DimProduct

SELECT TOP 10 ProductKey,EnglishProductName,ListPrice FROM DimProduct

SELECT * FROM(
SELECT TOP 10 * FROM DimProduct
ORDER BY ProductKey DESC)T
ORDER BY ProductKey



SELECT TOP 10 PERCENT * FROM DimProduct