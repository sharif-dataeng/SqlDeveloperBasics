

CREATE PROCEDURE sp_SelectData
AS
SELECT * FROM DimProduct

EXECUTE sp_SelectData



CREATE PROC sp_SelectData2
AS
SELECT * FROM DimProduct

EXEC sp_SelectData2


CREATE PROCEDURE sp_Products(@color varchar(20))
AS
SELECT * FROM DimProduct WHERE COLOR = @color


EXEC sp_Products 'Silver'


CREATE PROCEDURE sp_Products2(@color varchar(20),@price money)
AS
SELECT * FROM DimProduct 
WHERE COLOR = @color and ListPrice > @price


EXEC sp_Products2 'Red',1000


CREATE PROCEDURE sp_Products3(@color varchar(20)='Red')
AS
SELECT * FROM DimProduct WHERE COLOR = @color


EXEC sp_Products3 

EXEC sp_Products3 'White'


ALTER PROCEDURE sp_SelectData
AS
SELECT ProductKey,EnglishProductName,ListPrice FROM DimProduct

EXEC sp_SelectData


DROP PROCEDURE sp_SelectData