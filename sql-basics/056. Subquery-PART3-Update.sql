

SELECT * INTO DimEmps FROM DimEmployee

SELECT * FROM DimEmps

UPDATE DimEmps SET BaseRate = BaseRate * 1.1

SELECT * FROM DimSalesTerritory

UPDATE DimEmps SET BaseRate = BaseRate * 1.1
FROM DimEmps E JOIN DimSalesTerritory S 
ON E.SalesTerritoryKey = S.SalesTerritoryKey
WHERE S.SalesTerritoryCountry='Canada'

UPDATE DimEmps SET BaseRate = BaseRate * 1.1
WHERE SalesTerritoryKey 
IN(SELECT SalesTerritoryKey FROM DimSalesTerritory 
WHERE SalesTerritoryCountry='Canada')
