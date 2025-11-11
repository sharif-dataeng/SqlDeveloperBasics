

CREATE TABLE EMPLOYEES6(
	EmployeeId int,
	EmployeeName varchar(100),
	DOJ datetime,
	Salary float check(salary>=10000),
	Gender char(1) check(Gender = 'M' or Gender = 'F' or Gender = 'O') 
	--Gender char(1) check(Gender IN('M','F','O')) 
)

DROP TABLE EMPLOYEES6

INSERT INTO EMPLOYEES6(EmployeeId,EmployeeName,DOJ,Salary,Gender) 
VALUES(1,'JACK','2022-11-24',30000,'M')


INSERT INTO EMPLOYEES6(EmployeeId,EmployeeName,DOJ,Salary,Gender) 
VALUES(2,'AMANDA','2022-11-24',30000,'F')



INSERT INTO EMPLOYEES6(EmployeeId,EmployeeName,DOJ,Salary,Gender) 
VALUES(3,'XYZ','2022-11-24',30000,'O')

INSERT INTO EMPLOYEES6(EmployeeId,EmployeeName,DOJ,Salary,Gender) 
VALUES(4,'XYZ','2022-11-24',30000,'X')