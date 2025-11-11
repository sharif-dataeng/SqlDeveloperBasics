

WITH CteSales
AS
(
	SELECT ProductKey, SUM(SalesAmount) TotalSales FROM FactInternetSales
	GROUP BY ProductKey
),
CteProducts
AS
(
	SELECT ProductKey, EnglishProductName FROM DimProduct
)
SELECT p.ProductKey,p.EnglishProductName,s.TotalSales
FROM CteSales S JOIN CteProducts P on s.ProductKey = p.ProductKey