
-- Idempotent create for EMPLOYEES4 with a UNIQUE NOT NULL Email
DROP TABLE IF EXISTS dbo.EMPLOYEES4;
GO

CREATE TABLE dbo.EMPLOYEES4(
	EmployeeId INT PRIMARY KEY,
	EmployeeName VARCHAR(100),
	DOJ DATETIME,
	Salary FLOAT,
	Email VARCHAR(100) UNIQUE NOT NULL
);
GO

-- Seed rows (guaranteed unique, no NULL emails)
INSERT INTO dbo.EMPLOYEES4(EmployeeId,EmployeeName,DOJ,Salary,Email) VALUES
	(1,'Jack','2022-11-24',30000,'jack.jones@example.com'),
	(2,'Jackson','2021-11-24',40000,'jackson.w@example.com'),
	(3,'Jill Tanner','2020-07-15',45000,'jill.tanner@example.com'),
	(4,'John Doe','2019-05-10',52000,'john.doe@example.com');
GO

-- Insert a few more rows with semi-random email suffixes
INSERT INTO dbo.EMPLOYEES4(EmployeeId,EmployeeName,DOJ,Salary,Email) VALUES
	(5,'Anna Bell', DATEADD(day,-(ABS(CHECKSUM(NEWID()))%2000),GETDATE()), 35000 + (ABS(CHECKSUM(NEWID()))%30000), LOWER(REPLACE('Anna Bell',' ','_')) + RIGHT(CONVERT(VARCHAR(10),ABS(CHECKSUM(NEWID()))),4) + '@example.com'),
	(6,'Mark Green', DATEADD(day,-(ABS(CHECKSUM(NEWID()))%3000),GETDATE()), 40000 + (ABS(CHECKSUM(NEWID()))%35000), LOWER(REPLACE('Mark Green',' ','_')) + RIGHT(CONVERT(VARCHAR(10),ABS(CHECKSUM(NEWID()))),4) + '@example.com'),
	(7,'Lucy Hale', DATEADD(day,-(ABS(CHECKSUM(NEWID()))%2500),GETDATE()), 32000 + (ABS(CHECKSUM(NEWID()))%28000), LOWER(REPLACE('Lucy Hale',' ','_')) + RIGHT(CONVERT(VARCHAR(10),ABS(CHECKSUM(NEWID()))),4) + '@example.com');
GO

-- Randomly modify existing rows: change Salary, DOJ and Email (keeps Email unique by appending random digits)
UPDATE E
SET
	Salary = 30000 + (ABS(CHECKSUM(NEWID())) % 90001),
	DOJ = DATEADD(day, - (ABS(CHECKSUM(NEWID())) % 5000), CAST(GETDATE() AS DATE)),
	Email = LOWER(REPLACE(EmployeeName,' ','_')) + '.' + RIGHT(CONVERT(VARCHAR(10),ABS(CHECKSUM(NEWID()))),4) + '@example.com'
FROM dbo.EMPLOYEES4 E;
GO

-- Optionally insert additional random rows (wrapped in TRY/CATCH to avoid primary key collisions)
BEGIN TRY
	INSERT INTO dbo.EMPLOYEES4(EmployeeId,EmployeeName,DOJ,Salary,Email)
	VALUES
		(8,'Tom Hardy', DATEADD(day,-(ABS(CHECKSUM(NEWID()))%4000),GETDATE()), 45000 + (ABS(CHECKSUM(NEWID()))%50000), LOWER(REPLACE('Tom Hardy',' ','_')) + RIGHT(CONVERT(VARCHAR(10),ABS(CHECKSUM(NEWID()))),4) + '@example.com'),
		(9,'Nina Ross', DATEADD(day,-(ABS(CHECKSUM(NEWID()))%4000),GETDATE()), 38000 + (ABS(CHECKSUM(NEWID()))%40000), LOWER(REPLACE('Nina Ross',' ','_')) + RIGHT(CONVERT(VARCHAR(10),ABS(CHECKSUM(NEWID()))),4) + '@example.com');
END TRY
BEGIN CATCH
	-- If a PK or UNIQUE violation occurs, skip inserts (this keeps the script idempotent)
END CATCH
GO

-- Verification
SELECT * FROM dbo.EMPLOYEES4;
GO