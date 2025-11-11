SELECT * FROM DimProduct
WHERE ListPrice = 3399.99

SELECT * FROM DimProduct
WHERE ListPrice <= 3399.99

SELECT * FROM DimProduct
WHERE ListPrice <> 3399.99

SELECT * FROM DimProduct
WHERE COLOR = 'Red'

SELECT * FROM DimProduct
WHERE COLOR = 'Red' OR COLOR='Silver' OR COLOR='wHITE'

SELECT * FROM DimProduct
WHERE COLOR = 'Red' AND COLOR='Silver'

SELECT * FROM DimProduct
WHERE COLOR = 'Red' OR COLOR='Silver' OR COLOR='wHITE'
order by Color

SELECT * FROM DimProduct
WHERE COLOR IN('Red','Silver','WHITE')


SELECT * FROM DimProduct
WHERE COLOR = 'Red' AND ListPrice >1000 

SELECT * FROM DimProduct
WHERE COLOR = 'Red' OR ListPrice >1000

SELECT * FROM DimProduct
WHERE COLOR IN('Red','Silver','WHITE') AND ListPrice>2000

SELECT * FROM DimProduct
WHERE ListPrice >= 1000 AND ListPrice <= 2000

SELECT * FROM DimProduct
WHERE ListPrice BETWEEN 1000 AND 2000

SELECT * FROM DimProduct
WHERE ListPrice >= 1000 OR ListPrice <= 2000