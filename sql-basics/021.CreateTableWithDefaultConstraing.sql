CREATE TABLE EMPLOYEES8(
	EmployeeId int,
	EmployeeName varchar(100),
	DOJ datetime,
	Salary float,
	City varchar(30) default 'London'
)



INSERT INTO EMPLOYEES8(EmployeeId,EmployeeName,DOJ,Salary) 
VALUES(1,'JACK','2022-11-24',30000)

INSERT INTO EMPLOYEES8(EmployeeId,EmployeeName,DOJ,Salary,City) 
VALUES(2,'JACK','2022-11-24',30000,'nyc')

select * from EMPLOYEES8
