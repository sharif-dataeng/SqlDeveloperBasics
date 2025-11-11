--DROP TABLE IF EXISTS EMPLOYEESNEW


CREATE TABLE EMPLOYEESNEW(
	EmployeeId int primary key,
	EmpName varchar(100),
	City varchar(30),
	Gender char(1),
	Salary money
)

INSERT INTO EMPLOYEESNEW(EmployeeId,EmpName,City,Gender,Salary)VALUES
(1,'John','NYC','F',40000),
(2,'Amanda','London','M',40000),
(3,'Aman','Pune','F',30000),
(4,'Rahul','Pune','F',26000),
(5,'Alice','London','M',30000),
(6,'Rakesh','Delhi','F',20000),
(7,'Suraj','Pune','F',12000),
(8,'Ajay','Delhi','F',10000),
(9,'Ankita','Delhi','M',10000),
(10,'Sudeep','Delhi','F',36000)


SELECT * FROM EMPLOYEESNEW

SELECT *,
CASE GENDER
	WHEN 'F' THEN 'M'
	WHEN 'M' THEN 'F'
END NG
FROM EMPLOYEESNEW


UPDATE EMPLOYEESNEW
SET GENDER = CASE GENDER
	WHEN 'F' THEN 'M'
	WHEN 'M' THEN 'F'
END




