-- Drop existing table if it exists, then recreate and populate with sample rows
DROP TABLE IF EXISTS dbo.EMPLOYEES;
GO

CREATE TABLE dbo.EMPLOYEES (
	EmployeeId INT PRIMARY KEY,
	EmployeeName VARCHAR(100),
	Location VARCHAR(100),
	Sex CHAR(1),
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