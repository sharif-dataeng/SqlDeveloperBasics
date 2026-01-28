
CREATE TABLE EMPLOYEES_AutoIncrement14(
	EmployeeId int primary key identity(1,2),
	EmployeeName varchar(100),
	DOJ datetime,
	Salary float
)


INSERT INTO EMPLOYEES_AutoIncrement1(EmployeeName,DOJ,Salary) 
VALUES('JACK','2022-11-24',30000)

INSERT INTO EMPLOYEES_AutoIncrement1(EmployeeName,DOJ,Salary) 
VALUES('lokesh','2023-11-24',30320)

INSERT INTO EMPLOYEES_AutoIncrement1(EmployeeName,DOJ,Salary) 
VALUES('sai','2023-11-24',40000)


select * from employees_autoincrement1