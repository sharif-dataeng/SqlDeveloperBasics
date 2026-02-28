-- =========================================================
-- dimemployee_tables_mockdata.sql
-- Purpose: Seed data for HumanResources Employee-related dimension
-- tables with dependency-aware ordering.
-- Usage: Run the sections in the order shown. Adjust identity or
-- primary key usages to match your environment (use
-- `SET IDENTITY_INSERT` if inserting explicit keys into identity cols).
--
-- Dependency order:
-- 1) Department (lookup)
-- 2) Shift (lookup)
-- 3) Employee (core person/employee rows)
-- 4) EmployeeDepartmentHistory (depends on Employee, Department, Shift)
-- =========================================================


-- =========================
-- 1) Department (lookup)
-- =========================

-- select * from [HumanResources].[Department]

INSERT INTO [HumanResources].[Department]
    (Name, GroupName, ModifiedDate)
VALUES
    ('Engineering', 'Research and Development', GETDATE()),
    ('Human Resources', 'Executive General and Administration', GETDATE()),
    ('Finance', 'Executive General and Administration', GETDATE()),
    ('Sales', 'Sales and Marketing', GETDATE()),
    ('IT Support', 'Information Services', GETDATE()),
    ('Production', 'Manufacturing', GETDATE()),
    ('Quality Assurance', 'Manufacturing', GETDATE()),
    ('Training', 'Human Resources', GETDATE());


-- =========================
-- 2) Shift (lookup)
-- =========================

-- select * from [HumanResources].[Shift]

INSERT INTO [HumanResources].[Shift]
    (Name, StartTime, EndTime, ModifiedDate)
VALUES
    ('Day', '07:00:00', '15:00:00', GETDATE()),
    ('Evening', '15:00:00', '23:00:00', GETDATE()),
    ('Night', '23:00:00', '07:00:00', GETDATE());


-- =========================
-- 3) Employee (core rows)
-- =========================

-- select * from [HumanResources].[Employee]

INSERT INTO [HumanResources].[Employee]
    (BusinessEntityID, NationalIDNumber, LoginID, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SalariedFlag, VacationHours, SickLeaveHours, CurrentFlag)
VALUES
    (1, '123456789', 'adventure-works\\jdoe', 'Software Engineer', '1985-04-12', 'M', 'M', '2015-06-01', 1, 10, 5, 1),
    (2, '987654321', 'adventure-works\\asmith', 'HR Specialist', '1990-09-23', 'S', 'F', '2017-03-15', 0, 8, 2, 1),
    (3, '456789123', 'adventure-works\\bwhite', 'Data Analyst', '1988-11-05', 'M', 'M', '2016-01-20', 1, 12, 4, 1),
    (4, '654321987', 'adventure-works\\cgreen', 'Project Manager', '1979-07-30', 'M', 'F', '2014-09-10', 1, 15, 6, 1),
    (5, '321987654', 'adventure-works\\dblack', 'Network Admin', '1992-02-18', 'S', 'M', '2018-12-05', 0, 9, 3, 1);


-- =========================
-- 4) EmployeeDepartmentHistory (depends on Employee, Department, Shift)
-- =========================

-- select * from [HumanResources].[EmployeeDepartmentHistory]

INSERT INTO [HumanResources].[EmployeeDepartmentHistory]
    (BusinessEntityID, DepartmentID, ShiftID, StartDate, EndDate, ModifiedDate)
VALUES
    (1, 1, 1, '2015-06-01', NULL, GETDATE()),   -- Employee 1 in Engineering, Day shift
    (2, 2, 2, '2017-03-15', NULL, GETDATE()),   -- Employee 2 in HR, Evening shift
    (3, 3, 1, '2016-01-20', NULL, GETDATE()),   -- Employee 3 in Finance, Day shift
    (4, 4, 3, '2014-09-10', '2020-12-31', GETDATE()), -- Employee 4 in Sales, Night shift (ended)
    (5, 5, 1, '2018-12-05', NULL, GETDATE());   -- Employee 5 in IT Support, Day shift