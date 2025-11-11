

SELECT MAX(SalesAmount) FROM FactInternetSales


SELECT * FROM FactInternetSales 
WHERE SalesAmount=(SELECT MAX(SalesAmount) FROM FactInternetSales)

SELECT * FROM FactInternetSales 
WHERE SalesAmount=(SELECT MIN(SalesAmount) FROM FactInternetSales)

SELECT * FROM FactInternetSales 
WHERE SalesAmount>=(SELECT AVG(SalesAmount) FROM FactInternetSales)