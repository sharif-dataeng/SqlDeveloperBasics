--Find the products that have a price higher than the average price of all products

SELECT
*
FROM (
	SELECT
		*,
		AVG(Price) OVER() AvgPrice
		FROM Sales.Products
		)t
WHERE Price > AvgPrice;

--Rank the customesrs based on their total amount of sales

SELECT
RANK() OVER(ORDER BY TotalSales DESC) CustomerRank,
*
FROM(
	SELECT
	CustomerID,
	SUM(Sales) TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
	)t;

--Show the product IDs, product names, prices and total number of orders

SELECT
ProductID,
Product,
Price,
(SELECT COUNT(*) FROM Sales.Orders) TotalOrders
FROM Sales.Products;

--Show all customer details and find the total orders for each customer

SELECT
c.*,
o.TotalOrders
FROM Sales.Customers c
LEFT JOIN (
SELECT 
CustomerID,
COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID;

--Find the products that have a price higher than the average price of all products

SELECT
*
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products);

--Show the details of orders made by customers in Germany

SELECT
*
FROM Sales.Orders
WHERE CustomerID IN 
				(SELECT 
				CustomerID 
				FROM Sales.Customers 
				WHERE Country = 'Germany');

--Find female employees whose salaries are greater than the salaries of any male employees

SELECT
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ANY(SELECT Salary FROM Sales.Employees WHERE Gender = 'M');

--Show all customer details and find the total orders for each customer

SELECT
*,
(SELECT COUNT(*) 
FROM Sales.Orders o 
WHERE o.CustomerID = c.CustomerID) TotalOrders
FROM Sales.Customers c;

--Show the details of oders made by customers in Germany

SELECT
*
FROM Sales.Orders o
WHERE EXISTS(SELECT * 
				FROM Sales.Customers c 
				WHERE c.Country = 'Germany'
				AND c.CustomerID = o.CustomerID);

