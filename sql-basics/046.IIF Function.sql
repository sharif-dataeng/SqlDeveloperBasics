=
>
>=
<
<=
<>

SELECT ProductKey,EnglishProductName,Color FROM DimProduct


SELECT IIF(10=10,1,0)
SELECT IIF(10=100,1,0)

SELECT ProductKey,EnglishProductName,Color,
IIF(Color = 'Red','Rd','na') Code
FROM DimProduct

SELECT ProductKey,EnglishProductName,Color,
IIF(Color = 'Red','Rd',IIF(Color = 'Silver','Sl','na')) Code
FROM DimProduct

SELECT ProductKey,EnglishProductName,ListPrice,
IIF(ListPrice>3000,'High',IIF(ListPrice>2000,'Avg','Low')) Category
FROM DimProduct