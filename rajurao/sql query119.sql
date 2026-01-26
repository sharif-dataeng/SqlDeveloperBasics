SELECT DISTINCT Color FROM DimProduct


SELECT * FROM DimProduct where productkey=10     


SELECT DISTINCT Color,ListPrice FROM DimProduct

SELECT DISTINCT * FROM DimProduct

update dimproduct set standardcost=100 where StandardCost is null

select count(standardcost) from dimproduct

update dimproduct set standardcost=null where productkey=1