CREATE TABLE EMPLOYEES5(
	EmployeeId int primary key ,
	EmployeeName varchar(100) ,
	DOJ datetime,
	Salary float,
	Email varchar(100) unique not null,
	Pan varchar(100) unique
)