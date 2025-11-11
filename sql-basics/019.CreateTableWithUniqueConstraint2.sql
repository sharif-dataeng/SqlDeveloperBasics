CREATE TABLE EMPLOYEES4(
	EmployeeId int primary key ,
	EmployeeName varchar(100) ,
	DOJ datetime,
	Salary float,
	Email varchar(100) unique not null
)



INSERT INTO EMPLOYEES3(EmployeeId,EmployeeName,DOJ,Salary,Email) 
VALUES(1,'JACK','2022-11-24',30000,'jack123@gmail.com')

INSERT INTO EMPLOYEES4(EmployeeId,EmployeeName,DOJ,Salary,Email) 
VALUES(2,'JACKson','2021-11-24',40000,'jack123@gmail.com')


INSERT INTO EMPLOYEES4(EmployeeId,EmployeeName,DOJ,Salary,Email) 
VALUES(3,'JACKson','2021-11-24',40000,null)

INSERT INTO EMPLOYEES3(EmployeeId,EmployeeName,DOJ,Salary,Email) 
VALUES(4,'JACKson','2021-11-24',40000,null)

select * from EMPLOYEES3