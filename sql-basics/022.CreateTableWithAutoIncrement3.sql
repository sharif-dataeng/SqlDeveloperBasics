
CREATE TABLE EMPLOYEES_AutoIncrement3(
	EmployeeId int primary key identity(200,5),
	EmployeeName varchar(100),
	DOJ datetime,
	Salary float
)

select * from EMPLOYEES_AutoIncrement3

INSERT INTO EMPLOYEES_AutoIncrement3(EmployeeName,DOJ,Salary) 
VALUES('JACK','2022-11-24',30000)

INSERT INTO EMPLOYEES_AutoIncrement3(EmployeeName,DOJ,Salary) 
VALUES('JACKson','2023-11-24',30320)