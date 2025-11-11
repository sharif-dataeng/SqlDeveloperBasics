CREATE TABLE EMPLOYEES(
	EmployeeId int,
	Employeename varchar(100),
	DOJ datetime,
	Department varchar(20),
	Salary float
)

INSERT INTO EMPLOYEES(EmployeeId,Employeename,DOJ,Department,Salary) VALUES
(1,'RAKESH', '2023-01-12','IT',40000),
(2,'AMAN', '2023-01-12','SALES',40400),
(3,'YUSUF', '2022-01-12','IT',44000)

SELECT * FROM EMPLOYEES


--Identify duplicates using subquery
SELECT * FROM(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY EmployeeId,Employeename,DOJ,Department,Salary
ORDER BY EmployeeId) RowNum
FROM EMPLOYEES)T
where RowNum>1

--Identify duplicates using CTE
WITH CteDuplicates
AS
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY EmployeeId,Employeename,DOJ,Department,
	Salary ORDER BY EmployeeId) RowNum
	FROM EMPLOYEES
)SELECT * FROM CteDuplicates
where RowNum>1


--Delete duplicate rows using CTE
WITH CteDuplicates
AS
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY EmployeeId,Employeename,DOJ,Department,
	Salary ORDER BY EmployeeId) RowNum
	FROM EMPLOYEES
)DELETE FROM CteDuplicates
where RowNum>1
