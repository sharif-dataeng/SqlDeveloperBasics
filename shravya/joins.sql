-- Step 1: Create tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Step 2: Insert sample data
INSERT INTO Customers (CustomerID, CustomerName)
VALUES 
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES 
(101, 1, '2024-01-10'),
(102, 1, '2024-02-15'),
(103, 2, '2024-03-05');

-- Step 3: LEFT JOIN query
SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID;