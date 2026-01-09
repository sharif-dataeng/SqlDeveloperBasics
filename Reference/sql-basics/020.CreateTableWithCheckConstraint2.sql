

CREATE TABLE EMPLOYEES8(
	EmployeeId int,
	EmployeeName varchar(100),
	DOJ datetime,
	Salary float CHECK (Salary >= 10000),
	Gender char(1) CHECK (Gender IN ('M','F'))
);

INSERT INTO EMPLOYEES8(EmployeeId,EmployeeName,DOJ,Salary,Gender)
VALUES (1, 'JACK', '2022-11-24', 30000, 'M');


INSERT INTO EMPLOYEES8(EmployeeId,EmployeeName,DOJ,Salary,Gender)
VALUES (2, 'AMANDA', '2022-11-24', 30000, 'F');

INSERT INTO EMPLOYEES8(EmployeeId,EmployeeName,DOJ,Salary,Gender)
VALUES (3, 'lokesh', '2022-11-24', 30000, 'M');

INSERT INTO EMPLOYEES8(EmployeeId,EmployeeName,DOJ,Salary,Gender)
VALUES (4, 'swetha', '2022-11-24', 30000, 'F');