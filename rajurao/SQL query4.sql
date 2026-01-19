SELECT productkey,frenchproductname,listprice FROM DimProduct
WHERE ListPrice = 3399.99
select * from Dimproduct
select count(*) from dimproduct----606
SELECT productkey,frenchproductname,listprice  FROM DimProduct
WHERE ListPrice <= 550

SELECT productkey,frenchproductname,listprice FROM DimProduct
WHERE ListPrice <> 3399.99-

SELECT * FROM DimProduct
WHERE COLOR = 'blue'

SELECT * FROM DimProduct
WHERE COLOR = 'green' OR COLOR='blue' OR COLOR='red'

SELECT * FROM DimProduct
WHERE COLOR = 'Red' AND COLOR='Silver'

SELECT * FROM DimProduct
WHERE COLOR = 'Red' OR COLOR='Silver' OR COLOR='wHITE'
order by Color

SELECT * FROM DimProduct
WHERE COLOR IN('Red','Silver','WHITE')


SELECT * FROM DimProduct
WHERE COLOR = 'Red' AND ListPrice >2000 

SELECT * FROM DimProduct
WHERE COLOR = 'Red' OR ListPrice >5000

SELECT * FROM DimProduct
WHERE COLOR IN('Red','Silver','WHITE') AND ListPrice>2000

SELECT * FROM DimProduct
WHERE ListPrice >= 1000 AND ListPrice <= 2000

SELECT * FROM DimProduct
WHERE ListPrice BETWEEN 2000 AND 5000

SELECT * FROM DimProduct
WHERE ListPrice >= 1000 OR ListPrice <= 3000