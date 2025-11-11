
CREATE TABLE EMPLOYEES_AutoIncrement(
	EmployeeId int primary key identity(1,1),
	EmployeeName varchar(100),
	DOJ datetime,
	Salary float
)

select * from EMPLOYEES_AutoIncrement

INSERT INTO EMPLOYEES_AutoIncrement(EmployeeName,DOJ,Salary) 
VALUES('JACK','2022-11-24',30000)

INSERT INTO EMPLOYEES_AutoIncrement(EmployeeName,DOJ,Salary) 
VALUES('JACKson','2023-11-24',30320)