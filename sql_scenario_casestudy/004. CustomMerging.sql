DROP TABLE IF EXISTS EMPLOYEES_stage

CREATE TABLE EMPLOYEES_stage(
	EmployeeId int primary key,
	EmpName varchar(100),
	City varchar(30),
	Department varchar(50),
	Salary money
)

INSERT INTO EMPLOYEES_stage(EmployeeId,EmpName,City,Department,Salary)VALUES
(1,'John','NYC','IT',40000),
(2,'Amanda','London','Sales',40000),
(3,'Aman','Delhi','IT',30000),
(4,'Rahul','Pune','IT',29000),
(5,'Sam','London','Sales',30000),
(6,'Rakesh','Delhi','IT',20000)


DROP TABLE IF EXISTS EMPLOYEES

CREATE TABLE EMPLOYEES(
	EmployeeId int primary key,
	EmpName varchar(100),
	City varchar(30),
	Department varchar(50),
	Salary money
)

INSERT INTO EMPLOYEES(EmployeeId,EmpName,City,Department,Salary)VALUES
(1,'John','NYC','IT',40000),
(2,'Amanda','London','Sales',40000),
(3,'Aman','Pune','IT',30000),
(4,'Rahul','Pune','IT',26000)


SELECT * FROM EMPLOYEES_stage
SELECT * FROM EMPLOYEES

ALTER TABLE EMPLOYEES
ADD DML_Flag int

WITH CteUpsert
AS
(
SELECT EmployeeId,EmpName,City,Department,Salary FROM EMPLOYEES_stage
EXCEPT
SELECT EmployeeId,EmpName,City,Department,Salary FROM EMPLOYEES
)
MERGE EMPLOYEES T
	USING CteUpsert S
	ON T.EmployeeId = S.EmployeeId

WHEN MATCHED THEN
	UPDATE SET EmpName=S.EmpName,
			City=S.City,
			Department=S.Department,
			Salary=S.Salary

WHEN NOT MATCHED THEN
	INSERT (EmployeeId,EmpName,City,Department,Salary) VALUES
	(S.EmployeeId,S.EmpName,S.City,S.Department,S.Salary);

UPDATE EMPLOYEES SET DML_Flag = null



WITH CteUpsert
AS
(
SELECT EmployeeId,EmpName,City,Department,Salary FROM EMPLOYEES_stage
EXCEPT
SELECT EmployeeId,EmpName,City,Department,Salary FROM EMPLOYEES
)
MERGE EMPLOYEES T
	USING CteUpsert S
	ON T.EmployeeId = S.EmployeeId

WHEN MATCHED THEN
	UPDATE SET EmpName=S.EmpName,
			City=S.City,
			Department=S.Department,
			Salary=S.Salary,
			DML_Flag = 2

WHEN NOT MATCHED THEN
	INSERT (EmployeeId,EmpName,City,Department,Salary,DML_Flag) VALUES
	(S.EmployeeId,S.EmpName,S.City,S.Department,S.Salary,1);
