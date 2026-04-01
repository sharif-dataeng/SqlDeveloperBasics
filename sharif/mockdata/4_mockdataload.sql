-- ===== COMBINED MOCK DATA LOAD SCRIPT =====
-- Purpose: Load mock data for Customer, Employee, and Product dimensions
-- This script combines data loading for all three main entity types
-- Execution Time: ~1 minute total
-- Dependencies: 3_dimension_tables.sql

USE [AdventureWorkMock];
GO

/* ===== SECTION 1: CUSTOMER DATA LOAD =====
   Loads Customer, Person, Address, Contact Information
*/

-- =========================
-- 1) CountryRegion
-- =========================

INSERT INTO Person.CountryRegion (CountryRegionCode, Name, ModifiedDate)
VALUES
('US', 'United States', GETDATE()),
('CA', 'Canada', GETDATE()),
('MX', 'Mexico', GETDATE()),
('UK', 'United Kingdom', GETDATE()),
('IN', 'India', GETDATE());

-- =========================
-- 2) SalesTerritory (depends on CountryRegion)
-- =========================

INSERT INTO Sales.SalesTerritory (
   Name,
   CountryRegionCode,
   [Group],
   SalesYTD,
   SalesLastYear,
   CostYTD,
   CostLastYear
)
VALUES
('Northwest', 'US', 'North America', 0, 0, 0, 0),
('Southwest', 'US', 'North America', 0, 0, 0, 0),
('West Coast', 'US', 'North America', 0, 0, 0, 0),
('Mountain', 'US', 'North America', 0, 0, 0, 0),
('South Central', 'US', 'North America', 0, 0, 0, 0);

-- =========================
-- 3) StateProvince (depends on CountryRegion, may reference TerritoryID)
-- =========================

INSERT INTO Person.StateProvince (
   StateProvinceCode,
   CountryRegionCode,
   IsOnlyStateProvinceFlag,
   Name,
   TerritoryID
)
VALUES
('WA ', 'US', 1, 'Washington', 1),
('OR ', 'US', 1, 'Oregon', 2),
('CA ', 'US', 1, 'California', 3),
('CO ', 'US', 1, 'Colorado', 4),
('TX ', 'US', 1, 'Texas', 5);

-- =========================
-- 4) Address (depends on StateProvince) - 50 records
-- =========================

INSERT INTO Person.Address (
   AddressLine1,
   AddressLine2,
   City,
   StateProvinceID,
   PostalCode
)
VALUES
('123 Main Street', NULL, 'Seattle', 1, '98101'), ('456 Oak Avenue', 'Apt 2B', 'Portland', 2, '97205'),
('789 Pine Road', NULL, 'San Francisco', 3, '94107'), ('101 Maple Blvd', 'Suite 300', 'Denver', 4, '80202'),
('202 Birch Lane', NULL, 'Austin', 5, '73301'), ('303 Cedar St', 'Unit 10', 'Seattle', 1, '98102'),
('404 Elm Ave', NULL, 'Portland', 2, '97206'), ('505 Spruce Rd', 'Apt 5C', 'San Francisco', 3, '94108'),
('606 Walnut Blvd', NULL, 'Denver', 4, '80203'), ('707 Ash Lane', 'Suite 100', 'Austin', 5, '73302'),
('808 Oak St', NULL, 'Seattle', 1, '98103'), ('909 Pine Ave', 'Apt 8A', 'Portland', 2, '97207'),
('1010 Maple Rd', NULL, 'San Francisco', 3, '94109'), ('1111 Cedar Blvd', 'Unit 20', 'Denver', 4, '80204'),
('1212 Elm Lane', NULL, 'Austin', 5, '73303'), ('1313 Birch St', 'Suite 200', 'Seattle', 1, '98104'),
('1414 Spruce Ave', 'Apt 12D', 'Portland', 2, '97208'), ('1515 Walnut Rd', NULL, 'San Francisco', 3, '94110'),
('1616 Ash Blvd', 'Unit 30', 'Denver', 4, '80205'), ('1717 Oak Lane', NULL, 'Austin', 5, '73304'),
('1818 Pine St', 'Suite 300', 'Seattle', 1, '98105'), ('1919 Maple Ave', 'Apt 15E', 'Portland', 2, '97209'),
('2020 Cedar Rd', NULL, 'San Francisco', 3, '94111'), ('2121 Elm Blvd', 'Unit 40', 'Denver', 4, '80206'),
('2222 Spruce Lane', NULL, 'Austin', 5, '73305'), ('2323 Walnut St', 'Suite 400', 'Seattle', 1, '98106'),
('2424 Birch Ave', 'Apt 18G', 'Portland', 2, '97210'), ('2525 Ash Rd', NULL, 'San Francisco', 3, '94112'),
('2626 Oak Blvd', 'Unit 50', 'Denver', 4, '80207'), ('2727 Pine Lane', NULL, 'Austin', 5, '73306'),
('2828 Maple St', 'Suite 500', 'Seattle', 1, '98107'), ('2929 Cedar Ave', 'Apt 21H', 'Portland', 2, '97211'),
('3030 Elm Rd', NULL, 'San Francisco', 3, '94113'), ('3131 Spruce Blvd', 'Unit 60', 'Denver', 4, '80208'),
('3232 Walnut Lane', NULL, 'Austin', 5, '73307'), ('3333 Birch St', 'Suite 600', 'Seattle', 1, '98108'),
('3434 Ash Ave', 'Apt 24J', 'Portland', 2, '97212'), ('3535 Oak Rd', NULL, 'San Francisco', 3, '94114'),
('3636 Pine Blvd', 'Unit 70', 'Denver', 4, '80209'), ('3737 Maple Lane', NULL, 'Austin', 5, '73308'),
('3838 Cedar St', 'Suite 700', 'Seattle', 1, '98109'), ('3939 Elm Ave', 'Apt 27K', 'Portland', 2, '97213'),
('4040 Spruce Rd', NULL, 'San Francisco', 3, '94115'), ('4141 Walnut Blvd', 'Unit 80', 'Denver', 4, '80210'),
('4242 Birch Lane', NULL, 'Austin', 5, '73309'), ('4343 Ash St', 'Suite 800', 'Seattle', 1, '98110'),
('4444 Oak Ave', 'Apt 30L', 'Portland', 2, '97214'), ('4545 Pine Rd', NULL, 'San Francisco', 3, '94116');

-- =========================
-- 5) AddressType
-- =========================

INSERT INTO Person.AddressType (Name)
VALUES ('Home'), ('Work'), ('Billing'), ('Shipping'), ('Temporary');

-- =========================
-- 6) BusinessEntityAddress - 50 records
-- =========================

INSERT INTO Person.BusinessEntityAddress (BusinessEntityID, AddressID, AddressTypeID)
VALUES
(1, 2, 1), (2, 3, 2), (3, 4, 3), (4, 5, 4), (5, 6, 5),
(6, 7, 1), (7, 8, 2), (8, 9, 3), (9, 10, 4), (10, 11, 5),
(11, 12, 1), (12, 13, 2), (13, 14, 3), (14, 15, 4), (15, 16, 5),
(16, 17, 1), (17, 18, 2), (18, 19, 3), (19, 20, 4), (20, 21, 5),
(21, 22, 1), (22, 23, 2), (23, 24, 3), (24, 25, 4), (25, 26, 5),
(26, 27, 1), (27, 28, 2), (28, 29, 3), (29, 30, 4), (30, 31, 5),
(31, 32, 1), (32, 33, 2), (33, 34, 3), (34, 35, 4), (35, 36, 5),
(36, 37, 1), (37, 38, 2), (38, 39, 3), (39, 40, 4), (40, 41, 5),
(41, 42, 1), (42, 43, 2), (43, 44, 3), (44, 45, 4), (45, 46, 5),
(46, 47, 1), (47, 48, 2), (48, 49, 3), (49, 50, 4), (50, 51, 5);

-- =========================
-- 7) PhoneNumberType
-- =========================

INSERT INTO Person.PhoneNumberType (Name)
VALUES ('Home'), ('Work'), ('Mobile'), ('Fax'), ('Other');

-- =========================
-- 8) Person - 50 records
-- =========================

INSERT INTO Person.Person (BusinessEntityID, PersonType, NameStyle, FirstName, LastName, EmailPromotion)
VALUES
(1, 'EM', 0, 'John', 'Doe', 0), (2, 'EM', 0, 'Jane', 'Smith', 1), (3, 'EM', 0, 'Robert', 'Brown', 0),
(4, 'EM', 0, 'Emily', 'Davis', 1), (5, 'EM', 0, 'Michael', 'Wilson', 0), (6, 'EM', 0, 'Sarah', 'Moore', 1),
(7, 'EM', 0, 'David', 'Taylor', 0), (8, 'EM', 0, 'Lisa', 'Anderson', 1), (9, 'EM', 0, 'James', 'Thomas', 0),
(10, 'EM', 0, 'Mary', 'Jackson', 1), (11, 'EM', 0, 'William', 'White', 0), (12, 'EM', 0, 'Patricia', 'Harris', 1),
(13, 'EM', 0, 'Richard', 'Martin', 0), (14, 'EM', 0, 'Jennifer', 'Garcia', 1), (15, 'EM', 0, 'Charles', 'Rodriguez', 0),
(16, 'EM', 0, 'Barbara', 'Lee', 1), (17, 'EM', 0, 'Joseph', 'Perez', 0), (18, 'EM', 0, 'Susan', 'Thompson', 1),
(19, 'EM', 0, 'Thomas', 'Martinez', 0), (20, 'EM', 0, 'Jessica', 'Ortega', 1), (21, 'EM', 0, 'Christopher', 'Morales', 0),
(22, 'EM', 0, 'Karen', 'Flores', 1), (23, 'EM', 0, 'Daniel', 'Rivera', 0), (24, 'EM', 0, 'Nancy', 'Powers', 1),
(25, 'EM', 0, 'Matthew', 'Simpson', 0), (26, 'EM', 0, 'Lisa', 'Foster', 1), (27, 'EM', 0, 'Mark', 'Jimenez', 0),
(28, 'EM', 0, 'Betty', 'Leonard', 1), (29, 'EM', 0, 'Donald', 'Garrett', 0), (30, 'EM', 0, 'Margaret', 'Heath', 1),
(31, 'EM', 0, 'Steven', 'Howell', 0), (32, 'EM', 0, 'Sandra', 'Graves', 1), (33, 'EM', 0, 'Paul', 'Hubbard', 0),
(34, 'EM', 0, 'Ashley', 'Hunt', 1), (35, 'EM', 0, 'Andrew', 'Hunter', 0), (36, 'EM', 0, 'Kathleen', 'Ingram', 1),
(37, 'EM', 0, 'Joshua', 'Ingram', 0), (38, 'EM', 0, 'Shirley', 'Iverson', 1), (39, 'EM', 0, 'Kenneth', 'Ivey', 0),
(40, 'EM', 0, 'Angela', 'Jacobs', 1), (41, 'EM', 0, 'Kevin', 'James', 0), (42, 'EM', 0, 'Anna', 'Jarrell', 1),
(43, 'EM', 0, 'Brian', 'Jefferson', 0), (44, 'EM', 0, 'Brenda', 'Jenkins', 1), (45, 'EM', 0, 'Edward', 'Jennings', 0),
(46, 'EM', 0, 'Pamela', 'Jensen', 1), (47, 'EM', 0, 'Ronald', 'Jessup', 0), (48, 'EM', 0, 'Katharine', 'Jimenez', 1),
(49, 'EM', 0, 'Anthony', 'Johns', 0), (50, 'EM', 0, 'Carolyn', 'Johnson', 1);

-- =========================
-- 9) PersonPhone - 50 records
-- =========================

INSERT INTO Person.PersonPhone (BusinessEntityID, PhoneNumber, PhoneNumberTypeID)
VALUES
(1, '206-555-0101', 1), (2, '503-555-0102', 2), (3, '415-555-0103', 3), (4, '303-555-0104', 4), (5, '512-555-0105', 5),
(6, '206-555-0106', 1), (7, '503-555-0107', 2), (8, '415-555-0108', 3), (9, '303-555-0109', 4), (10, '512-555-0110', 5),
(11, '206-555-0111', 1), (12, '503-555-0112', 2), (13, '415-555-0113', 3), (14, '303-555-0114', 4), (15, '512-555-0115', 5),
(16, '206-555-0116', 1), (17, '503-555-0117', 2), (18, '415-555-0118', 3), (19, '303-555-0119', 4), (20, '512-555-0120', 5),
(21, '206-555-0121', 1), (22, '503-555-0122', 2), (23, '415-555-0123', 3), (24, '303-555-0124', 4), (25, '512-555-0125', 5),
(26, '206-555-0126', 1), (27, '503-555-0127', 2), (28, '415-555-0128', 3), (29, '303-555-0129', 4), (30, '512-555-0130', 5),
(31, '206-555-0131', 1), (32, '503-555-0132', 2), (33, '415-555-0133', 3), (34, '303-555-0134', 4), (35, '512-555-0135', 5),
(36, '206-555-0136', 1), (37, '503-555-0137', 2), (38, '415-555-0138', 3), (39, '303-555-0139', 4), (40, '512-555-0140', 5),
(41, '206-555-0141', 1), (42, '503-555-0142', 2), (43, '415-555-0143', 3), (44, '303-555-0144', 4), (45, '512-555-0145', 5),
(46, '206-555-0146', 1), (47, '503-555-0147', 2), (48, '415-555-0148', 3), (49, '303-555-0149', 4), (50, '512-555-0150', 5);

-- =========================
-- 10) EmailAddress - 50 records
-- =========================

INSERT INTO Person.EmailAddress (BusinessEntityID, EmailAddress)
VALUES
(1, 'john.doe@example.com'), (2, 'jane.smith@example.com'), (3, 'robert.brown@example.com'), (4, 'emily.davis@example.com'),
(5, 'michael.wilson@example.com'), (6, 'sarah.moore@example.com'), (7, 'david.taylor@example.com'), (8, 'lisa.anderson@example.com'),
(9, 'james.thomas@example.com'), (10, 'mary.jackson@example.com'), (11, 'william.white@example.com'), (12, 'patricia.harris@example.com'),
(13, 'richard.martin@example.com'), (14, 'jennifer.garcia@example.com'), (15, 'charles.rodriguez@example.com'), (16, 'barbara.lee@example.com'),
(17, 'joseph.perez@example.com'), (18, 'susan.thompson@example.com'), (19, 'thomas.martinez@example.com'), (20, 'jessica.ortega@example.com'),
(21, 'christopher.morales@example.com'), (22, 'karen.flores@example.com'), (23, 'daniel.rivera@example.com'), (24, 'nancy.powers@example.com'),
(25, 'matthew.simpson@example.com'), (26, 'lisa.foster@example.com'), (27, 'mark.jimenez@example.com'), (28, 'betty.leonard@example.com'),
(29, 'donald.garrett@example.com'), (30, 'margaret.heath@example.com'), (31, 'steven.howell@example.com'), (32, 'sandra.graves@example.com'),
(33, 'paul.hubbard@example.com'), (34, 'ashley.hunt@example.com'), (35, 'andrew.hunter@example.com'), (36, 'kathleen.ingram@example.com'),
(37, 'joshua.ingram@example.com'), (38, 'shirley.iverson@example.com'), (39, 'kenneth.ivey@example.com'), (40, 'angela.jacobs@example.com'),
(41, 'kevin.james@example.com'), (42, 'anna.jarrell@example.com'), (43, 'brian.jefferson@example.com'), (44, 'brenda.jenkins@example.com'),
(45, 'edward.jennings@example.com'), (46, 'pamela.jensen@example.com'), (47, 'ronald.jessup@example.com'), (48, 'katharine.jimenez@example.com'),
(49, 'anthony.johns@example.com'), (50, 'carolyn.johnson@example.com');

-- =========================
-- 11) Customer - 50 records
-- =========================

INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID)
VALUES
(1, NULL, 1), (2, NULL, 2), (3, NULL, 3), (4, NULL, 4), (5, NULL, 5),
(6, NULL, 1), (7, NULL, 2), (8, NULL, 3), (9, NULL, 4), (10, NULL, 5),
(11, NULL, 1), (12, NULL, 2), (13, NULL, 3), (14, NULL, 4), (15, NULL, 5),
(16, NULL, 1), (17, NULL, 2), (18, NULL, 3), (19, NULL, 4), (20, NULL, 5),
(21, NULL, 1), (22, NULL, 2), (23, NULL, 3), (24, NULL, 4), (25, NULL, 5),
(26, NULL, 1), (27, NULL, 2), (28, NULL, 3), (29, NULL, 4), (30, NULL, 5),
(31, NULL, 1), (32, NULL, 2), (33, NULL, 3), (34, NULL, 4), (35, NULL, 5),
(36, NULL, 1), (37, NULL, 2), (38, NULL, 3), (39, NULL, 4), (40, NULL, 5),
(41, NULL, 1), (42, NULL, 2), (43, NULL, 3), (44, NULL, 4), (45, NULL, 5),
(46, NULL, 1), (47, NULL, 2), (48, NULL, 3), (49, NULL, 4), (50, NULL, 5);

GO

/* ===== SECTION 2: EMPLOYEE DATA LOAD =====
   Loads Employee, Department, and Shift Information
*/

-- =========================
-- 1) Department
-- =========================

INSERT INTO [HumanResources].[Department] (Name, GroupName, ModifiedDate)
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
-- 2) Shift
-- =========================

INSERT INTO [HumanResources].[Shift] (Name, StartTime, EndTime, ModifiedDate)
VALUES
('Day', '07:00:00', '15:00:00', GETDATE()),
('Evening', '15:00:00', '23:00:00', GETDATE()),
('Night', '23:00:00', '07:00:00', GETDATE());

-- =========================
-- 3) Employee - 50 records
-- =========================

INSERT INTO [HumanResources].[Employee]
    (BusinessEntityID, NationalIDNumber, LoginID, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SalariedFlag, VacationHours, SickLeaveHours, CurrentFlag)
VALUES
    (1, '123456789', 'adventure-works\\jdoe', 'Software Engineer', '1985-04-12', 'M', 'M', '2015-06-01', 1, 10, 5, 1),
    (2, '987654321', 'adventure-works\\asmith', 'HR Specialist', '1990-09-23', 'S', 'F', '2017-03-15', 0, 8, 2, 1),
    (3, '456789123', 'adventure-works\\bwhite', 'Data Analyst', '1988-11-05', 'M', 'M', '2016-01-20', 1, 12, 4, 1),
    (4, '654321987', 'adventure-works\\cgreen', 'Project Manager', '1979-07-30', 'M', 'F', '2014-09-10', 1, 15, 6, 1),
    (5, '321987654', 'adventure-works\\dblack', 'Network Admin', '1992-02-18', 'S', 'M', '2018-12-05', 0, 9, 3, 1),
    (6, '159753486', 'adventure-works\\elopez', 'Database Admin', '1987-01-30', 'M', 'F', '2016-05-15', 1, 11, 5, 1),
    (7, '258147369', 'adventure-works\\fking', 'Business Analyst', '1991-03-22', 'S', 'M', '2018-08-10', 0, 7, 2, 1),
    (8, '369258147', 'adventure-works\\gmart', 'Systems Engineer', '1986-06-15', 'M', 'F', '2015-11-01', 1, 13, 5, 1),
    (9, '741852963', 'adventure-works\\hwilson', 'QA Tester', '1993-09-17', 'S', 'M', '2019-02-20', 0, 8, 3, 1),
    (10, '852963741', 'adventure-works\\ijones', 'Tech Lead', '1984-12-05', 'M', 'F', '2014-01-15', 1, 16, 7, 1),
    (11, '963741852', 'adventure-works\\kjohnson', 'Developer', '1989-05-12', 'M', 'M', '2016-09-01', 1, 12, 4, 1),
    (12, '147369258', 'adventure-works\\lbrown', 'IT Support', '1992-08-23', 'S', 'F', '2018-04-10', 0, 10, 3, 1),
    (13, '258369147', 'adventure-works\\mdavis', 'DevOps Engineer', '1988-02-14', 'M', 'M', '2017-06-15', 1, 11, 5, 1),
    (14, '369147258', 'adventure-works\\nmiller', 'Scrum Master', '1985-11-30', 'M', 'F', '2015-03-01', 1, 14, 6, 1),
    (15, '741159753', 'adventure-works\\ogarcia', 'UI Designer', '1994-04-08', 'S', 'M', '2019-09-15', 0, 9, 2, 1),
    (16, '852147963', 'adventure-works\\prodriguez', 'Backend Dev', '1990-07-19', 'M', 'F', '2017-10-01', 1, 10, 5, 1),
    (17, '963258741', 'adventure-works\\qlee', 'Frontend Dev', '1991-01-25', 'S', 'M', '2018-05-15', 0, 8, 3, 1),
    (18, '147741258', 'adventure-works\\rwhite', 'DevOps Specialist', '1987-03-17', 'M', 'F', '2016-08-01', 1, 12, 6, 1),
    (19, '258741147', 'adventure-works\\sthomas', 'Security Officer', '1989-09-11', 'S', 'M', '2017-01-15', 0, 11, 4, 1),
    (20, '369741147', 'adventure-works\\tjackson', 'Architect', '1983-12-22', 'M', 'F', '2013-06-01', 1, 18, 8, 1),
    (21, '741258369', 'adventure-works\\umartin', 'Software Dev', '1992-05-08', 'M', 'M', '2018-11-15', 1, 9, 4, 1),
    (22, '852369147', 'adventure-works\\vperez', 'QA Engineer', '1991-10-14', 'S', 'F', '2019-03-10', 0, 7, 2, 1),
    (23, '963147369', 'adventure-works\\wtaylor', 'Senior Dev', '1984-06-30', 'M', 'M', '2014-04-01', 1, 15, 7, 1),
    (24, '147258963', 'adventure-works\\xanderson', 'Manager', '1985-02-20', 'M', 'F', '2015-08-15', 1, 13, 6, 1),
    (25, '258369963', 'adventure-works\\yharris', 'Consultant', '1986-11-03', 'S', 'M', '2016-12-01', 0, 10, 5, 1),
    (26, '369258963', 'adventure-works\\zclark', 'Developer', '1993-04-11', 'M', 'F', '2019-07-01', 1, 8, 3, 1),
    (27, '741963147', 'adventure-works\\alewis', 'Analyst', '1990-09-27', 'S', 'M', '2018-02-15', 0, 9, 4, 1),
    (28, '852147741', 'adventure-works\\bwalker', 'Engineer', '1988-01-30', 'M', 'F', '2016-10-01', 1, 12, 5, 1),
    (29, '963369258', 'adventure-works\\chall', 'Specialist', '1991-08-15', 'S', 'M', '2017-05-15', 0, 8, 3, 1),
    (30, '147852369', 'adventure-works\\dyoung', 'Coordinator', '1992-12-21', 'M', 'F', '2019-04-01', 1, 10, 4, 1),
    (31, '258963147', 'adventure-works\\eking', 'Supervisor', '1985-10-08', 'M', 'M', '2015-09-15', 1, 14, 6, 1),
    (32, '369852147', 'adventure-works\\fwright', 'Associate', '1991-05-17', 'S', 'F', '2018-07-01', 0, 9, 3, 1),
    (33, '741369258', 'adventure-works\\glópez', 'Specialist', '1989-03-24', 'M', 'M', '2017-02-15', 1, 11, 5, 1),
    (34, '852258963', 'adventure-works\\hhills', 'Technician', '1993-07-10', 'S', 'F', '2019-08-15', 0, 7, 2, 1),
    (35, '963741369', 'adventure-works\\igreen', 'Operator', '1987-11-19', 'M', 'M', '2016-03-01', 1, 10, 4, 1),
    (36, '147963741', 'adventure-works\\jadams', 'Technician', '1990-06-05', 'S', 'F', '2018-09-15', 0, 8, 3, 1),
    (37, '258147963', 'adventure-works\\knelson', 'Coordinator', '1988-09-13', 'M', 'M', '2017-04-01', 1, 12, 5, 1),
    (38, '369963741', 'adventure-works\\lcarter', 'Manager', '1985-01-28', 'S', 'F', '2015-11-15', 1, 15, 6, 1),
    (39, '741147258', 'adventure-works\\mmitchell', 'Associate', '1992-08-22', 'M', 'M', '2019-01-10', 0, 9, 4, 1),
    (40, '852963258', 'adventure-works\\nroberts', 'Specialist', '1989-04-30', 'S', 'F', '2017-10-15', 1, 11, 5, 1),
    (41, '963852369', 'adventure-works\\ophillips', 'Engineer', '1986-12-14', 'M', 'M', '2016-06-01', 1, 13, 6, 1),
    (42, '147456789', 'adventure-works\\pcampbell', 'Developer', '1993-02-25', 'S', 'F', '2019-05-15', 0, 8, 3, 1),
    (43, '258654321', 'adventure-works\\qparker', 'Analyst', '1990-10-30', 'M', 'M', '2018-03-01', 1, 10, 4, 1),
    (44, '369456321', 'adventure-works\\revans', 'Technician', '1991-05-16', 'S', 'F', '2017-08-15', 0, 9, 3, 1),
    (45, '741654123', 'adventure-works\\sedwards', 'Coordinator', '1988-08-09', 'M', 'M', '2016-12-01', 1, 12, 5, 1),
    (46, '852321654', 'adventure-works\\tcolins', 'Supervisor', '1985-07-03', 'S', 'F', '2015-04-15', 1, 14, 6, 1),
    (47, '963654789', 'adventure-works\\ustewar', 'Manager', '1989-11-12', 'M', 'M', '2017-09-01', 0, 11, 5, 1),
    (48, '147789456', 'adventure-works\\vmorris', 'Associate', '1991-06-21', 'S', 'F', '2018-11-15', 1, 9, 4, 1),
    (49, '258456789', 'adventure-works\\wrogers', 'Technician', '1990-03-08', 'M', 'M', '2018-01-10', 0, 8, 3, 1),
    (50, '369789654', 'adventure-works\\xmorgna', 'Specialist', '1987-09-20', 'S', 'F', '2016-07-15', 1, 10, 5, 1);

-- =========================
-- 4) EmployeeDepartmentHistory - 50 records
-- =========================

INSERT INTO [HumanResources].[EmployeeDepartmentHistory]
    (BusinessEntityID, DepartmentID, ShiftID, StartDate, EndDate, ModifiedDate)
VALUES
    (1, 1, 1, '2015-06-01', NULL, GETDATE()), (2, 2, 2, '2017-03-15', NULL, GETDATE()), (3, 3, 1, '2016-01-20', NULL, GETDATE()),
    (4, 4, 3, '2014-09-10', NULL, GETDATE()), (5, 5, 1, '2018-12-05', NULL, GETDATE()), (6, 6, 2, '2016-05-15', NULL, GETDATE()),
    (7, 7, 1, '2018-08-10', NULL, GETDATE()), (8, 1, 3, '2015-11-01', NULL, GETDATE()), (9, 2, 1, '2019-02-20', NULL, GETDATE()),
    (10, 3, 2, '2014-01-15', NULL, GETDATE()), (11, 4, 1, '2016-09-01', NULL, GETDATE()), (12, 5, 3, '2018-04-10', NULL, GETDATE()),
    (13, 6, 1, '2017-06-15', NULL, GETDATE()), (14, 7, 2, '2015-03-01', NULL, GETDATE()), (15, 1, 1, '2019-09-15', NULL, GETDATE()),
    (16, 2, 3, '2017-10-01', NULL, GETDATE()), (17, 3, 1, '2018-05-15', NULL, GETDATE()), (18, 4, 2, '2016-08-01', NULL, GETDATE()),
    (19, 5, 1, '2017-01-15', NULL, GETDATE()), (20, 6, 3, '2013-06-01', NULL, GETDATE()), (21, 7, 1, '2018-11-15', NULL, GETDATE()),
    (22, 1, 2, '2019-03-10', NULL, GETDATE()), (23, 2, 1, '2014-04-01', NULL, GETDATE()), (24, 3, 3, '2015-08-15', NULL, GETDATE()),
    (25, 4, 1, '2016-12-01', NULL, GETDATE()), (26, 5, 2, '2019-07-01', NULL, GETDATE()), (27, 6, 1, '2018-02-15', NULL, GETDATE()),
    (28, 7, 3, '2016-10-01', NULL, GETDATE()), (29, 1, 1, '2017-05-15', NULL, GETDATE()), (30, 2, 2, '2019-04-01', NULL, GETDATE()),
    (31, 3, 1, '2015-09-15', NULL, GETDATE()), (32, 4, 3, '2018-07-01', NULL, GETDATE()), (33, 5, 1, '2017-02-15', NULL, GETDATE()),
    (34, 6, 2, '2019-08-15', NULL, GETDATE()), (35, 7, 1, '2016-03-01', NULL, GETDATE()), (36, 1, 3, '2018-09-15', NULL, GETDATE()),
    (37, 2, 1, '2017-04-01', NULL, GETDATE()), (38, 3, 2, '2015-11-15', NULL, GETDATE()), (39, 4, 1, '2019-01-10', NULL, GETDATE()),
    (40, 5, 3, '2017-10-15', NULL, GETDATE()), (41, 6, 1, '2016-06-01', NULL, GETDATE()), (42, 7, 2, '2019-05-15', NULL, GETDATE()),
    (43, 1, 1, '2018-03-01', NULL, GETDATE()), (44, 2, 3, '2017-08-15', NULL, GETDATE()), (45, 3, 1, '2016-12-01', NULL, GETDATE()),
    (46, 4, 2, '2015-04-15', NULL, GETDATE()), (47, 5, 1, '2017-09-01', NULL, GETDATE()), (48, 6, 3, '2018-11-15', NULL, GETDATE()),
    (49, 7, 1, '2018-01-10', NULL, GETDATE()), (50, 1, 2, '2016-07-15', NULL, GETDATE());

GO

/* ===== SECTION 3: PRODUCT DATA LOAD =====
   Loads Product, Category, Subcategory, and Model Information
*/

-- =========================
-- 1) ProductCategory
-- =========================

INSERT INTO [Production].[ProductCategory] (Name)
VALUES ('Bikes'), ('Components'), ('Clothing'), ('Accessories'), ('Services');

-- =========================
-- 2) ProductSubcategory - 25 records
-- =========================

INSERT INTO [Production].[ProductSubcategory]
    (ProductCategoryID, Name, rowguid, ModifiedDate)
VALUES
    (1, 'Mountain Bikes', NEWID(), GETDATE()), (1, 'Road Bikes', NEWID(), GETDATE()), (1, 'Hybrid Bikes', NEWID(), GETDATE()),
    (1, 'Touring Bikes', NEWID(), GETDATE()), (1, 'BMX Bikes', NEWID(), GETDATE()), (2, 'Brakes', NEWID(), GETDATE()),
    (2, 'Gears', NEWID(), GETDATE()), (2, 'Chains', NEWID(), GETDATE()), (2, 'Wheels', NEWID(), GETDATE()),
    (2, 'Handlebars', NEWID(), GETDATE()), (3, 'Jerseys', NEWID(), GETDATE()), (3, 'Shorts', NEWID(), GETDATE()),
    (3, 'Gloves', NEWID(), GETDATE()), (3, 'Socks', NEWID(), GETDATE()), (3, 'Jackets', NEWID(), GETDATE()),
    (4, 'Helmets', NEWID(), GETDATE()), (4, 'Lights', NEWID(), GETDATE()), (4, 'Locks', NEWID(), GETDATE()),
    (4, 'Pumps', NEWID(), GETDATE()), (4, 'Tool Kits', NEWID(), GETDATE()), (5, 'Maintenance Plans', NEWID(), GETDATE()),
    (5, 'Repair Services', NEWID(), GETDATE()), (5, 'Installation', NEWID(), GETDATE()), (5, 'Training', NEWID(), GETDATE()),
    (5, 'Consulting', NEWID(), GETDATE());

-- =========================
-- 3) ProductModel - 30 records
-- =========================

INSERT INTO [Production].[ProductModel]
    (Name, CatalogDescription, Instructions, rowguid, ModifiedDate)
VALUES
    ('Mountain Bike Model A', NULL, NULL, NEWID(), GETDATE()), ('Road Bike Model B', NULL, NULL, NEWID(), GETDATE()),
    ('Hybrid Bike Model C', NULL, NULL, NEWID(), GETDATE()), ('Helmet Model D', NULL, NULL, NEWID(), GETDATE()),
    ('Jersey Model E', NULL, NULL, NEWID(), GETDATE()), ('Brake System F', NULL, NULL, NEWID(), GETDATE()),
    ('Gear Set Model G', NULL, NULL, NEWID(), GETDATE()), ('Chain Model H', NULL, NULL, NEWID(), GETDATE()),
    ('Wheel Model I', NULL, NULL, NEWID(), GETDATE()), ('Handlebar Model J', NULL, NULL, NEWID(), GETDATE()),
    ('Shorts Model K', NULL, NULL, NEWID(), GETDATE()), ('Gloves Model L', NULL, NULL, NEWID(), GETDATE()),
    ('Socks Model M', NULL, NULL, NEWID(), GETDATE()), ('Jacket Model N', NULL, NULL, NEWID(), GETDATE()),
    ('Light Model O', NULL, NULL, NEWID(), GETDATE()), ('Lock Model P', NULL, NULL, NEWID(), GETDATE()),
    ('Pump Model Q', NULL, NULL, NEWID(), GETDATE()), ('Tool Kit Model R', NULL, NULL, NEWID(), GETDATE()),
    ('Pedal Model S', NULL, NULL, NEWID(), GETDATE()), ('Saddle Model T', NULL, NULL, NEWID(), GETDATE()),
    ('Frame Model U', NULL, NULL, NEWID(), GETDATE()), ('Fork Model V', NULL, NULL, NEWID(), GETDATE()),
    ('Stem Model W', NULL, NULL, NEWID(), GETDATE()), ('Headset Model X', NULL, NULL, NEWID(), GETDATE()),
    ('Bottom Bracket Model Y', NULL, NULL, NEWID(), GETDATE()), ('Crank Model Z', NULL, NULL, NEWID(), GETDATE()),
    ('Cassette Model AA', NULL, NULL, NEWID(), GETDATE()), ('Derailleur Model BB', NULL, NULL, NEWID(), GETDATE()),
    ('Shifter Model CC', NULL, NULL, NEWID(), GETDATE()), ('Cable Model DD', NULL, NULL, NEWID(), GETDATE());

-- =========================
-- 4) Product - 50 records
-- =========================

INSERT INTO [Production].[Product]
    (Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice,
     Size, Weight, ProductSubcategoryID, ProductModelID, DaysToManufacture, SellStartDate, SellEndDate, DiscontinuedDate,
     rowguid, ModifiedDate)
VALUES
    ('Mountain Bike 100', 'BK-M100', 1, 1, 'Red', 100, 50, 500.00, 800.00, 'M', 15.0, 1, 1, 5, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Mountain Bike 200', 'BK-M200', 1, 1, 'Blue', 120, 60, 550.00, 850.00, 'L', 15.5, 1, 2, 5, '2020-02-01', NULL, NULL, NEWID(), GETDATE()),
    ('Road Bike 100', 'BK-R100', 1, 1, 'Black', 110, 55, 600.00, 950.00, 'M', 14.0, 2, 3, 6, '2020-01-15', NULL, NULL, NEWID(), GETDATE()),
    ('Road Bike 200', 'BK-R200', 1, 1, 'White', 130, 65, 700.00, 1200.00, 'L', 14.5, 2, 4, 6, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Hybrid Bike 100', 'BK-H100', 1, 1, 'Green', 90, 45, 550.00, 850.00, 'M', 13.5, 3, 5, 4, '2020-02-15', NULL, NULL, NEWID(), GETDATE()),
    ('Hybrid Bike 200', 'BK-H200', 1, 1, 'Orange', 100, 50, 600.00, 950.00, 'L', 14.0, 3, 6, 4, '2020-04-01', NULL, NULL, NEWID(), GETDATE()),
    ('Touring Bike 100', 'BK-T100', 1, 1, 'Silver', 80, 40, 650.00, 1050.00, 'M', 16.0, 4, 7, 7, '2020-03-15', NULL, NULL, NEWID(), GETDATE()),
    ('BMX Bike 100', 'BK-B100', 1, 1, 'Yellow', 70, 35, 350.00, 550.00, 'S', 12.0, 5, 8, 3, '2020-05-01', NULL, NULL, NEWID(), GETDATE()),
    ('Brake Set Pro', 'BR-PRO', 0, 1, 'Black', 60, 30, 45.00, 89.00, NULL, 2.5, 6, 9, 1, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Brake Set Elite', 'BR-ELT', 0, 1, 'Red', 65, 32, 55.00, 109.00, NULL, 2.7, 6, 10, 1, '2020-02-01', NULL, NULL, NEWID(), GETDATE()),
    ('Gear Set 16', 'GR-16', 0, 1, 'Silver', 75, 37, 35.00, 69.00, NULL, 1.8, 7, 11, 1, '2020-01-15', NULL, NULL, NEWID(), GETDATE()),
    ('Gear Set 21', 'GR-21', 0, 1, 'Black', 80, 40, 45.00, 89.00, NULL, 2.0, 7, 12, 1, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Chain 8sp', 'CH-8SP', 0, 1, 'Silver', 100, 50, 15.00, 29.00, NULL, 0.5, 8, 13, 0, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Chain 10sp', 'CH-10SP', 0, 1, 'Gold', 110, 55, 18.00, 35.00, NULL, 0.6, 8, 14, 0, '2020-02-15', NULL, NULL, NEWID(), GETDATE()),
    ('Wheel 26', 'WH-26', 0, 1, 'Black', 50, 25, 65.00, 129.00, NULL, 3.5, 9, 15, 2, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Wheel 29', 'WH-29', 0, 1, 'Silver', 55, 27, 75.00, 149.00, NULL, 4.0, 9, 16, 2, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Handlebar Drop', 'HB-DROP', 0, 1, 'Black', 45, 22, 25.00, 49.00, NULL, 0.8, 10, 17, 0, '2020-02-01', NULL, NULL, NEWID(), GETDATE()),
    ('Handlebar Flat', 'HB-FLAT', 0, 1, 'Gray', 40, 20, 20.00, 39.00, NULL, 0.7, 10, 18, 0, '2020-04-01', NULL, NULL, NEWID(), GETDATE()),
    ('Jersey Casual', 'JS-CAS', 0, 1, 'Blue', 90, 45, 18.00, 39.00, 'M', 0.3, 11, 19, 0, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Jersey Performance', 'JS-PER', 0, 1, 'Red', 95, 47, 25.00, 55.00, 'L', 0.35, 11, 20, 0, '2020-02-15', NULL, NULL, NEWID(), GETDATE()),
    ('Shorts Casual', 'SH-CAS', 0, 1, 'Black', 80, 40, 22.00, 45.00, 'M', 0.4, 12, 21, 0, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Shorts Padded', 'SH-PAD', 0, 1, 'Gray', 85, 42, 30.00, 65.00, 'L', 0.45, 12, 22, 0, '2020-04-01', NULL, NULL, NEWID(), GETDATE()),
    ('Gloves Basic', 'GL-BAS', 0, 1, 'Black', 70, 35, 10.00, 19.00, 'M', 0.15, 13, 23, 0, '2020-01-15', NULL, NULL, NEWID(), GETDATE()),
    ('Gloves Gel', 'GL-GEL', 0, 1, 'Blue', 75, 37, 15.00, 29.00, 'L', 0.2, 13, 24, 0, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Socks Coolmax', 'SK-CML', 0, 1, 'White', 100, 50, 5.00, 9.00, 'M', 0.05, 14, 25, 0, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Socks Wool', 'SK-WOL', 0, 1, 'Black', 95, 47, 7.00, 14.00, 'L', 0.08, 14, 26, 0, '2020-02-15', NULL, NULL, NEWID(), GETDATE()),
    ('Jacket Windproof', 'JK-WND', 0, 1, 'Yellow', 60, 30, 45.00, 89.00, 'M', 0.6, 15, 27, 0, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Jacket Waterproof', 'JK-WTR', 0, 1, 'Orange', 65, 32, 55.00, 109.00, 'L', 0.7, 15, 28, 0, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Helmet Basic', 'HM-BAS', 0, 1, 'White', 70, 35, 30.00, 59.00, NULL, 0.4, 16, 29, 0, '2020-02-01', NULL, NULL, NEWID(), GETDATE()),
    ('Helmet Sport', 'HM-SPR', 0, 1, 'Black', 75, 37, 45.00, 89.00, NULL, 0.5, 16, 30, 0, '2020-04-01', NULL, NULL, NEWID(), GETDATE()),
    ('Light Front LED', 'LT-FRT', 0, 1, 'Silver', 50, 25, 20.00, 39.00, NULL, 0.2, 17, 31, 0, '2020-01-15', NULL, NULL, NEWID(), GETDATE()),
    ('Light Rear LED', 'LT-RER', 0, 1, 'Red', 55, 27, 15.00, 29.00, NULL, 0.15, 17, 32, 0, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Lock Cable', 'LK-CBL', 0, 1, 'Black', 60, 30, 12.00, 24.00, NULL, 0.8, 18, 33, 0, '2020-02-01', NULL, NULL, NEWID(), GETDATE()),
    ('Lock U-Lock', 'LK-ULK', 0, 1, 'Silver', 65, 32, 25.00, 49.00, NULL, 2.0, 18, 34, 0, '2020-04-01', NULL, NULL, NEWID(), GETDATE()),
    ('Pump Floor', 'PM-FLR', 0, 1, 'Black', 45, 22, 18.00, 35.00, NULL, 1.2, 19, 35, 0, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Pump Portable', 'PM-POR', 0, 1, 'Silver', 50, 25, 12.00, 24.00, NULL, 0.3, 19, 36, 0, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Tool Kit Basic', 'TK-BAS', 0, 1, 'Red', 40, 20, 25.00, 49.00, NULL, 1.5, 20, 37, 0, '2020-02-15', NULL, NULL, NEWID(), GETDATE()),
    ('Tool Kit Complete', 'TK-CMP', 0, 1, 'Black', 45, 22, 40.00, 79.00, NULL, 2.5, 20, 38, 0, '2020-04-01', NULL, NULL, NEWID(), GETDATE()),
    ('Pedal Flat', 'PD-FLT', 0, 1, 'Black', 70, 35, 20.00, 39.00, NULL, 0.35, 1, 39, 0, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Pedal Clipless', 'PD-CLP', 0, 1, 'Silver', 75, 37, 35.00, 69.00, NULL, 0.45, 1, 40, 0, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Saddle Comfort', 'SD-COM', 0, 1, 'Black', 60, 30, 25.00, 49.00, NULL, 0.5, 2, 41, 0, '2020-02-01', NULL, NULL, NEWID(), GETDATE()),
    ('Saddle Racing', 'SD-RAC', 0, 1, 'White', 65, 32, 35.00, 69.00, NULL, 0.4, 2, 42, 0, '2020-04-01', NULL, NULL, NEWID(), GETDATE()),
    ('Frame Aluminum', 'FR-ALU', 1, 0, 'Silver', 80, 40, 150.00, 299.00, 'M', 2.5, 3, 43, 3, '2020-01-01', NULL, NULL, NEWID(), GETDATE()),
    ('Frame Carbon', 'FR-CAR', 1, 0, 'Black', 85, 42, 200.00, 399.00, 'L', 2.0, 3, 44, 4, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Fork Suspension', 'FK-SUS', 0, 1, 'Silver', 50, 25, 80.00, 159.00, NULL, 2.0, 4, 45, 1, '2020-02-01', NULL, NULL, NEWID(), GETDATE()),
    ('Fork Rigid', 'FK-RIG', 0, 1, 'Black', 45, 22, 50.00, 99.00, NULL, 1.5, 4, 46, 0, '2020-04-01', NULL, NULL, NEWID(), GETDATE()),
    ('Stem 80mm', 'ST-80', 0, 1, 'Silver', 60, 30, 15.00, 29.00, NULL, 0.25, 5, 47, 0, '2020-01-15', NULL, NULL, NEWID(), GETDATE()),
    ('Stem 100mm', 'ST-100', 0, 1, 'Black', 65, 32, 18.00, 35.00, NULL, 0.27, 5, 48, 0, '2020-03-01', NULL, NULL, NEWID(), GETDATE()),
    ('Headset 1-1/8', 'HS-118', 0, 1, 'Silver', 70, 35, 20.00, 39.00, NULL, 0.3, 6, 49, 0, '2020-02-01', NULL, NULL, NEWID(), GETDATE()),
    ('Headset 1-1/4', 'HS-114', 0, 1, 'Black', 75, 37, 25.00, 49.00, NULL, 0.35, 6, 50, 0, '2020-04-01', NULL, NULL, NEWID(), GETDATE());

GO

PRINT 'Mock data load complete - All 3 sections loaded successfully!';
