SELECT * INTO DimProduct_BkUP FROM DimProduct

drop table DimProduct_BkUP

SELECT * FROM DimProduct_BkUP

UPDATE DimProduct_BkUP SET COLOR = 'No Color'
WHERE COLOR = 'NA'

UPDATE DimProduct_BkUP SET COLOR = 'Red-High', standardcost = 1000
WHERE COLOR = 'Red' AND listprice>3000

UPDATE DimProduct_BkUP SET COLOR = 'Red-Low' ,  standardcost = 1000
WHERE COLOR = 'Red' AND listprice<1500


UPDATE DimProduct_BkUP SET listprice = listprice * 1.1

UPDATE DimProduct_BkUP SET listprice = listprice * 0.9