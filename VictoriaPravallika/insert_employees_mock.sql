-- Mock INSERTs for EMPLOYEES
-- Assumes schema:
-- CREATE TABLE EMPLOYEES(
--   EmployeeId INT PRIMARY KEY IDENTITY(1,1),
--   EmpName VARCHAR(100),
--   City VARCHAR(30),
--   Department VARCHAR(50),
--   Salary INT
-- );

INSERT INTO EMPLOYEES (EmpName, City, Department, Salary) VALUES
('John Doe','New York','IT',45000),
('Amanda Smith','London','Sales',52000),
('Aman Patel','Pune','IT',38000),
('Rahul Sharma','Pune','IT',36000),
('Sam Wilson','London','Sales',39500),
('Rakesh Kumar','Delhi','IT',41000),
('Suraj Gupta','Pune','Sales',28000),
('Ajay Mehta','Delhi','Sales',27000),
('Ankita Singh','Delhi','HR',30000),
('Sudeep Reddy','Mumbai','IT',62000),
('Sanket Rao','Pune','Operations',47000),
('Priya Nair','Bengaluru','Finance',55000),
('Maria Garcia','Madrid','Marketing',48000),
('Li Wei','Shanghai','Support',42000),
('Chen Liu','Beijing','IT',43000),
('Fatima Khan','Dubai','HR',51000),
('Omar Ali','Dubai','Finance',67000),
('Elena Petrova','Moscow','Operations',39000),
('Tom Brown','Chicago','IT',75000),
('Lisa Wong','San Francisco','Marketing',92000),
('Carlos Mendes','Sao Paulo','Sales',44000),
('Ingrid Berg','Stockholm','Support',48000),
('Noah Davis','Toronto','IT',58000),
('Emma Johnson','New York','HR',47000),
('Michael Scott','Scranton','Sales',65000);

-- If your EMPLOYEES table does NOT use IDENTITY for EmployeeId,
-- use this variant (includes EmployeeId values):
--
-- INSERT INTO EMPLOYEES (EmployeeId, EmpName, City, Department, Salary) VALUES
-- (1,'John Doe','New York','IT',45000.00),
-- ... etc;

-- End of mock data
