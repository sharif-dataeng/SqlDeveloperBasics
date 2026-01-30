SELECT * FROM EMPLOYEES

alter table employees add email varchar(25) not null
alter table employees drop column email
alter table employees add email varchar(25) not null default 'rao'
alter table employees drop column email
alter table employees drop constraint [DF__EMPLOYEES__email__5CD6CB2B]

alter table employees add gender varchar(6),phonenumber int
alter table employees drop column employeeid -- it can't becuse of consraint

ALTER TABLE EMPLOYEES
DROP COLUMN Phone,city
alter table employees drop column city

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



--renaming of employee table

exec sp_rename 'employees.contact number','contactnumber1','column'