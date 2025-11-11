

SELECT ProductKey,EnglishProductName,Color,
CASE Color
	WHEN 'Red' THEN 'Rd'
	ELSE 'na'
END code
FROM DimProduct

SELECT ProductKey,EnglishProductName,Color,
CASE Color
	WHEN 'Red' THEN 'Rd'
	WHEN 'Silver' THEN 'Sl'
	WHEN 'White' THEN 'Wh'
	ELSE 'na'
END code
FROM DimProduct

SELECT ProductKey,EnglishProductName, ListPrice,
CASE 
	WHEN ListPrice>=3000 THEN 'High'
	WHEN ListPrice>=2000 THEN 'Avg'
	ELSE 'Low'
END Category
FROM DimProduct