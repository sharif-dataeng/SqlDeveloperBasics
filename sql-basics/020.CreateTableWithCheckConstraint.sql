

CREATE TABLE EMPLOYEES5(
	EmployeeId int,
	EmployeeName varchar(100),
	DOJ datetime,
	Salary float check(salary>=10000)
)


INSERT INTO EMPLOYEES VALUES(1,'JOHN','2023-01-14',40000)

INSERT INTO EMPLOYEES5(EmployeeId,EmployeeName,DOJ,Salary) 
VALUES(1,'JACK','2022-11-24',30000)

INSERT INTO EMPLOYEES5(EmployeeId,EmployeeName,DOJ,Salary) 
VALUES(2,'JACKson','2022-11-24',9999)