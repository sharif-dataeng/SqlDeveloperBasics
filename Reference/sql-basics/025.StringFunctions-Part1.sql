-- -- SELECT * FROM DimProduct

-- -- SELECT UPPER('hello')

-- -- SELECT EnglishProductName,
-- -- UPPER(EnglishProductName) EnglishProductName FROM DimProduct


-- -- SELECT LOWER('HELLO')

-- -- SELECT EnglishProductName,
-- -- LOWER(EnglishProductName) EnglishProductName FROM DimProduct

-- -- SELECT LEFT('HELLO',2)

-- -- SELECT EnglishProductName,
-- -- LEFT(EnglishProductName,3) EnglishProductName FROM DimProduct

-- SELECT EnglishProductName,
-- LEFT(EnglishProductName,30) EnglishProductName FROM DimProduct


-- SELECT RIGHT('HELLO',3)

-- SELECT EnglishProductName,
-- RIGHT(EnglishProductName,3) EnglishProductName FROM DimProduct


SELECT SUBSTRING('HELLO',2,3)

SELECT EnglishProductName,
SUBSTRING(EnglishProductName,3,4) EnglishProductName FROM DimProduct


-- SELECT LEN(' H EL LO ')

-- SELECT EnglishProductName,
-- LEN(EnglishProductName) EnglishProductName FROM DimProduct


-- SELECT TRIM(' H EL LO ')

-- SELECT EnglishProductName,
-- TRIM(EnglishProductName) EnglishProductName FROM DimProduct

-- SELECT LTRIM(' H EL LO ')

-- SELECT RTRIM(' H EL LO ')

-- ' H EL LO'