SELECT EmployeeKey,FirstName,MiddleName,LastName FROM DimEmployee

SELECT FirstName + ' ' +  LastName as fullname  FROM DimEmployee

SELECT FirstName + SPACE(1) + ISNULL(MiddleName,'') 
+ SPACE(1) + LastName FROM DimEmployee

SELECT CONCAT(FirstName,space(1),MiddleName,space(1),LastName) 
FROM DimEmployee

SELECT CONCAT_WS(SPACE(1),FirstName,MiddleName,LastName) FROM DimEmployee

SELECT CONCAT_WS('-',FirstName,MiddleName,LastName) FROM DimEmployee

SELECT EmployeeKey,FirstName,MiddleName,LastName,
CONCAT_WS(SPACE(1),FirstName,MiddleName,LastName) FullName
FROM DimEmployee

SELECT EmployeeKey,FirstName,MiddleName,LastName 
into EmployeesBk
FROM DimEmployee


select * from EmployeesBk


ALTER TABLE EmployeesBk
ADD Fullname varchar(50)


UPDATE EmployeesBk
SET FULLNAME = CONCAT_WS(SPACE(1),FirstName,MiddleName,LastName)