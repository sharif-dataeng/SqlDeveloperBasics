SELECT * FROM EMPLOYEES

ALTER TABLE EMPLOYEES
ADD Email varchar(100)

ALTER TABLE EMPLOYEES
ADD Phone varchar(20), city varchar(20)

ALTER TABLE EMPLOYEES
DROP COLUMN Ema

ALTER TABLE EMPLOYEES
DROP COLUMN Phone,city


ALTER TABLE EMPLOYEES
ALTER COLUMN EmployeeName varchar(200)

-- Examples: renaming columns in different RDBMS
-- SQL Server: use sp_rename (metadata-level rename)
-- Note: sp_rename is a stored procedure, not standard SQL
EXEC sp_rename 'EMPLOYEES.EmployeeName', 'FullName', 'COLUMN';

-- PostgreSQL / MySQL 8.0 (ANSI): ALTER TABLE RENAME COLUMN
ALTER TABLE EMPLOYEES RENAME COLUMN EmployeeName TO FullName;

-- MySQL older syntax: CHANGE COLUMN (can also change type)
ALTER TABLE EMPLOYEES CHANGE COLUMN EmployeeName FullName varchar(200);