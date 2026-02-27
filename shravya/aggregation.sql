-- Step 1: Create a sample table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Product VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);

-- Step 2: Insert sample data
INSERT INTO Sales (SaleID, Product, Quantity, Price, SaleDate) VALUES
(1, 'Laptop', 2, 800.00, '2026-02-01'),
(2, 'Phone', 5, 500.00, '2026-02-02'),
(3, 'Tablet', 3, 300.00, '2026-02-03'),
(4, 'Laptop', 1, 850.00, '2026-02-04'),
(5, 'Phone', 2, 450.00, '2026-02-05');

-- Step 3: Use aggregation functions
-- Total quantity sold
SELECT SUM(Quantity) AS TotalQuantity FROM Sales;

-- Average price of products
SELECT AVG(Price) AS AveragePrice FROM Sales;

-- Count of sales records
SELECT COUNT(*) AS TotalSales FROM Sales;

-- Minimum and maximum price
SELECT MIN(Price) AS LowestPrice, MAX(Price) AS HighestPrice FROM Sales;

-- Step 4: Grouping with aggregation
-- Total quantity sold per product
SELECT Product, SUM(Quantity) AS TotalQuantity
FROM Sales
GROUP BY Product;

-- Average price per product
SELECT Product, AVG(Price) AS AveragePrice
FROM Sales
GROUP BY Product;