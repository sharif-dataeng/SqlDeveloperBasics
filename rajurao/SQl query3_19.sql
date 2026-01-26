SELECT distinct color FROM DimProduct
ORDER BY Color desc


SELECT * FROM DimProduct
ORDER BY Color DESC


SELECT ProductKey,EnglishProductName,COLOR,ListPrice
FROM DimProduct
ORDER BY ListPrice asc


SELECT ProductKey,EnglishProductName,COLOR
FROM DimProduct
ORDER BY ListPrice DESC


select count(*) from dimproduct


SELECT ProductKey,EnglishProductName,COLOR,ListPrice
FROM DimProduct
ORDER BY COLOR,ListPrice

SELECT ProductKey,EnglishProductName,COLOR,ListPrice
FROM DimProduct
ORDER BY COLOR asc,ListPrice DESC

SELECT ProductKey,EnglishProductName,COLOR,ListPrice
FROM DimProduct
ORDER BY COLOR DESC,ListPrice DESC

SELECT ProductKey,EnglishProductName,COLOR,ListPrice
FROM DimProduct
ORDER BY 1 asc

SELECT ProductKey,EnglishProductName,COLOR,ListPrice
FROM DimProduct
ORDER BY 4 desc
SELECT ProductKey,EnglishProductName,COLOR,ListPrice
FROM DimProduct
ORDER BY 4 asc

SELECT ProductKey,EnglishProductName,COLOR,ListPrice
FROM DimProduct
ORDER BY 3,4