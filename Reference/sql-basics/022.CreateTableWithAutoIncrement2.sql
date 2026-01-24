DROP TABLE IF EXISTS EMPLOYEES_AutoIncrement2;
GO

CREATE TABLE EMPLOYEES_AutoIncrement2(
	EmployeeId int primary key identity(100,2),
	EmployeeName varchar(100),
	DOJ datetime,
	Salary float
)



INSERT INTO EMPLOYEES_AutoIncrement2(EmployeeName,DOJ,Salary) 
VALUES('JACK','2022-11-24',30000)

INSERT INTO EMPLOYEES_AutoIncrement2(EmployeeName,DOJ,Salary) 
VALUES('JACKson','2023-11-24',30320)

INSERT INTO EMPLOYEES_AutoIncrement2(EmployeeName,DOJ,Salary) 
VALUES('JACKie','2024-11-24',30500)

select * from EMPLOYEES_AutoIncrement2
GO