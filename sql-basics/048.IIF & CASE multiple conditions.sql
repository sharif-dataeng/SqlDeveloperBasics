select 
ProductKey,EnglishProductName,Color,ListPrice from DimProduct

SELECT ProductKey,EnglishProductName,Color,ListPrice,
IIF(Color='Red' and ListPrice>=3000,'Rd-3k',
IIF(Color='Red' and ListPrice>=2000,'Rd-2k',
IIF(Color='Red','Rd-<2k',
IIF(Color='Silver' and ListPrice>=3000,'Sl-3k',
IIF(Color='Silver' and ListPrice>=2000,'Sl-2k',
IIF(Color='Silver','Sl-<2k','na'))))))
FROM DimProduct


SELECT ProductKey,EnglishProductName,Color,ListPrice,
CASE 
	WHEN Color='Red' and ListPrice>=3000 THEN 'Rd-3k'
	WHEN Color='Red' and ListPrice>=2000 THEN 'Rd-2k'
	WHEN Color='Red' THEN 'Rd<-2k'
	WHEN Color='Silver' and ListPrice>=3000 THEN 'Sl-3k'
	WHEN Color='Silver' and ListPrice>=3000 THEN 'Sl-2k'
	WHEN Color='Silver'  THEN 'Sl<-2k'
	ELSE 'na'
END Category
FROM DimProduct