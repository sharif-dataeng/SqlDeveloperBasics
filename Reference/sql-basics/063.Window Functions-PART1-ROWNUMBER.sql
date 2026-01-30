DROP TABLE EMPLOYEES


CREATE TABLE EMPLOYEES(
	EmployeeId int primary key identity(1,1),
	EmpName varchar(100),
	City varchar(30),
	Department varchar(50),
	Salary money
)

INSERT INTO EMPLOYEES(EmpName,City,Department,Salary)VALUES
('John','NYC','IT',40000),
('Amanda','London','Sales',40000),
('Aman','Pune','IT',30000),
('Rahul','Pune','IT',25000),
('Sam','London','Sales',30000),
('Rakesh','Delhi','IT',20000),
('Suraj','Pune','Sales',12000),
('Ajay','Delhi','Sales',10000),
('Ankita','Delhi','Sales',10000),
('Sudeep','Delhi','IT',36000),
('Sanket','Pune','IT',40000)


SELECT EmpName, City, Department,Salary,
ROW_NUMBER() OVER(ORDER BY EmpName) RowNum
FROM EMPLOYEES


SELECT EmpName, City, Department,Salary,
100+ROW_NUMBER() OVER(ORDER BY EmpName) RowNum
FROM EMPLOYEES

SELECT EmpName, City, Department,Salary,
ROW_NUMBER() OVER(PARTITION BY CITY ORDER BY EmpName) RowNum
FROM EMPLOYEES

SELECT EmpName, City, Department,Salary,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY EmpName) RowNum
FROM EMPLOYEES

SELECT EmpName, City, Department,Salary,
ROW_NUMBER() OVER(PARTITION BY CITY,Department ORDER BY EmpName) RowNum
FROM EMPLOYEES