CREATE TABLE EMPLOYEES_New(
	EmployeeId int primary key,
	EmployeeName varchar(100),
	DOJ datetime,
	Salary float
)

SELECT * FROM EMPLOYEES_New

INSERT INTO EMPLOYEES_New VALUES(1,'JOHN','2023-01-14',40000)

INSERT INTO EMPLOYEES_New(EmployeeId,EmployeeName,DOJ,Salary) 
VALUES(2,'JACK','2022-11-24',30000)

INSERT INTO EMPLOYEES_New(EmployeeId,EmployeeName,DOJ,Salary) 
VALUES(NULL,'AMAN','2021-11-24',30400)