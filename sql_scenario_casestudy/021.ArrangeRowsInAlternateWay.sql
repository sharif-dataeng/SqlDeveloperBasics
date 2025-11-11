--DROP TABLE Countries

CREATE TABLE Countries(
	Country varchar(20)
)

INSERT INTO Countries(Country) VALUES
('India'),('US'),('US'),('India'),('India'),('US')

SELECT * FROM Countries


SELECT Country, ROW_NUMBER() over (PARTITION BY Country ORDER BY Country) Rownum
FROM Countries
ORDER BY Rownum,Country


SELECT Country
FROM Countries
ORDER BY ROW_NUMBER() over (PARTITION BY Country ORDER BY Country),Country

--------------------------------------------------------------------------------
--DROP TABLE EMPLOYEES


CREATE TABLE EMPLOYEES(
	EmployeeId int primary key identity(1,1),
	EmpName varchar(100),
	City varchar(30),
	Active bit
)

INSERT INTO EMPLOYEES(EmpName,City,Active)VALUES
('John','NYC',0),
('Amanda','London',1),
('Aman','Pune',1),
('Rahul','Pune',0),
('Sam','London',0),
('Rakesh','Delhi',1),
('Suraj','Pune',1),
('Ajay','Delhi',0),
('Ankita','Delhi',0),
('Sudeep','Delhi',1),
('Sanket','Pune',1)


SELECT * FROM EMPLOYEES


SELECT EmployeeId, EmpName,City,Active
FROM EMPLOYEES
ORDER BY ROW_NUMBER() OVER(PARTITION BY Active ORDER BY Active), Active Desc