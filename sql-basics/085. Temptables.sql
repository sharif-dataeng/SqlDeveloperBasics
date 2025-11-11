

CREATE TABLE #Employees(
	Empid int,
	Empname varchar(100)
)

SELECT * FROM #Employees



CREATE TABLE ##Employees(
	EMPID INT,
	EMPNAME VARCHAR(20)
)


SELECT * FROM ##Employees

SELECT * INTO #DIMPRODUCT FROM DIMPRODUCT

select * from #DIMPRODUCT