CREATE TABLE Employees6 (
    EmployeeID INT ,  -- Clustered Index (B+ Tree)
    Name VARCHAR(100),
    Salary DECIMAL(10,2)
);
INSERT INTO Employees6 (EmployeeID, Name, Salary) VALUES 
(100, 'Alice', 50000),
(200, 'Bob', 60000),
(300, 'Charlie', 70000),
(400, 'David', 80000),
(500, 'Eve', 90000);

CREATE NONCLUSTERED INDEX IX_Active_Employees 
ON Employees6(Salary)

select * from Employees6
WHERE Salary > 70000