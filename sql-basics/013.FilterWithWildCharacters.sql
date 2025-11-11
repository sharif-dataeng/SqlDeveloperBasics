/*
LIKE

% - any number of unknown chars
_ - one underscore means one unknown chars

*/
SELECT * FROM DimProduct
WHERE EnglishProductName LIKE 'A%'

SELECT * FROM DimProduct
WHERE EnglishProductName LIKE 'AW%'

SELECT * FROM DimProduct
WHERE ProductKey LIKE '4%'


SELECT * FROM DimProduct
WHERE EnglishProductName LIKE '%e'

SELECT * FROM DimProduct
WHERE EnglishProductName LIKE '%ce'


SELECT * FROM DimProduct
WHERE EnglishProductName LIKE '%a%'

SELECT * FROM DimProduct
WHERE EnglishProductName LIKE 'A%C%'

SELECT * FROM DimProduct
WHERE EnglishProductName LIKE 'A_C%'

SELECT * FROM DimProduct
WHERE EnglishProductName LIKE 'A_C'