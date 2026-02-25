-- Step 1: Create sample tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    item VARCHAR(50)
);

-- Step 2: Insert sample data
INSERT INTO Customers (customer_id, first_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana');

INSERT INTO Orders (order_id, customer_id, item) VALUES
(101, 1, 'Laptop'),
(102, 2, 'Phone'),
(103, 2, 'Tablet'),
(104, 5, 'Camera'); -- Notice: customer_id=5 doesn’t exist in Customers

---------------------------------------------------
-- Step 3: Demonstrate different JOINs
---------------------------------------------------

-- INNER JOIN: Only matching rows
SELECT c.customer_id, c.first_name, o.item
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;

-- LEFT JOIN: All customers, even without orders
SELECT c.customer_id, c.first_name, o.item
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id;

-- RIGHT JOIN: All orders, even if customer missing
SELECT c.customer_id, c.first_name, o.item
FROM Customers c
RIGHT JOIN Orders o
ON c.customer_id = o.customer_id;

-- FULL OUTER JOIN: All customers and all orders
-- (Note: Some SQL dialects like MySQL don’t support FULL JOIN directly)
SELECT c.customer_id, c.first_name, o.item
FROM Customers c
FULL OUTER JOIN Orders o
ON c.customer_id = o.customer_id;

-- CROSS JOIN: Cartesian product (every combination)
SELECT c.first_name, o.item
FROM Customers c
CROSS JOIN Orders o;

-- SELF JOIN: Example with Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

INSERT INTO Employees (employee_id, name, manager_id) VALUES
(1, 'John', NULL),
(2, 'Mary', 1),
(3, 'Steve', 1),
(4, 'Anna', 2);

-- Self join to find employees and their managers
SELECT e1.name AS Employee, e2.name AS Manager
FROM Employees e1
INNER JOIN Employees e2
ON e1.manager_id = e2.employee_id;