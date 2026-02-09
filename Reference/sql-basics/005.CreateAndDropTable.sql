-- Drop if exists, create table, insert sample data, then randomize values
DROP TABLE IF EXISTS dbo.EMPLOYEES;
GO

CREATE TABLE dbo.EMPLOYEES (
-- Drop existing table if it exists, then recreate and populate with sample rows
DROP TABLE IF EXISTS dbo.STUDENTS;
GO

CREATE TABLE dbo.STUDENTS (
	EmployeeId INT PRIMARY KEY,
		EmployeeName VARCHAR(100),
	Location VARCHAR(100),
	Sex CHAR(1),
	Age INT,
	Email VARCHAR(255),
	Department VARCHAR(100),
	HireDate DATE,
	Salary DECIMAL(10,2),
	IsActive BIT
);
GO

INSERT INTO dbo.EMPLOYEES (EmployeeId, EmployeeName, Location, Sex, Age, Email, Department, HireDate, Salary, IsActive) VALUES
	(1, 'Alice Johnson', 'New York', 'F', 34, 'alice.johnson@example.com', 'Finance', '2017-05-10', 82000.00, 1),
	(2, 'Bob Smith', 'Chicago', 'M', 41, 'bob.smith@example.com', 'Sales', '2014-11-03', 94000.00, 1),
	(3, 'Carmen Lee', 'San Francisco', 'F', 29, 'carmen.lee@example.com', 'Engineering', '2020-02-17', 78000.00, 1),
	(4, 'David Miller', 'Los Angeles', 'M', 29, 'david.miller@example.com', 'Support', '2019-08-22', 56000.00, 1),
	(5, 'Eve Torres', 'Seattle', 'F', 36, 'eve.torres@example.com', 'HR', '2015-03-30', 73000.00, 1),
	(6, 'Frank Zhang', 'Austin', 'M', 32, 'frank.zhang@example.com', 'Engineering', '2018-07-12', 81000.00, 1),
	(7, 'Grace Park', 'Boston', 'F', 27, 'grace.park@example.com', 'Marketing', '2021-09-01', 67000.00, 1);
	GO

-- Randomize existing rows (updates all rows with random picks/values)
UPDATE dbo.EMPLOYEES
SET
	Location = (SELECT TOP (1) v.val FROM (VALUES ('New York'),('Chicago'),('San Francisco'),('Los Angeles'),('Seattle'),('Austin'),('Boston'),('Denver'),('Miami')) v(val) ORDER BY NEWID()),
	Sex = CASE WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN 'M' ELSE 'F' END,
	Age = 22 + (ABS(CHECKSUM(NEWID())) % 43),
	Email = LOWER(REPLACE(EmployeeName,' ','_')) + CAST((ABS(CHECKSUM(NEWID())) % 9000 + 1000) AS VARCHAR(10)) + '@example.com',
	Department = (SELECT TOP (1) v.val FROM (VALUES ('Finance'),('Sales'),('Engineering'),('HR'),('Marketing'),('Support'),('Operations')) v(val) ORDER BY NEWID()),
	HireDate = DATEADD(day, - (ABS(CHECKSUM(NEWID())) % 4000), CAST(GETDATE() AS DATE)),
	Salary = 40000 + (ABS(CHECKSUM(NEWID())) % 90001),
	IsActive = CASE WHEN ABS(CHECKSUM(NEWID())) % 5 = 0 THEN 0 ELSE 1 END
;
GO

-- Verification
SELECT EmployeeId, EmployeeName, Location, Sex, Age, Email, Department, HireDate, Salary, IsActive FROM dbo.EMPLOYEES;
	Age INT
);
GO

-- Insert some sample rows
INSERT INTO dbo.EMPLOYEES (EmployeeId, EmployeeName, Location, Sex, Age) VALUES
	(1, 'Alice Johnson', 'New York', 'F', 34),
	(2, 'Bob Smith', 'Chicago', 'M', 41),
	(3, 'Carmen Lee', 'San Francisco', 'F', 29);
GO

-- Quick verification
SELECT * FROM dbo.EMPLOYEES;
GO