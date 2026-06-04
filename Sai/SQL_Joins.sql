--Retrieve all data from customers and ordersas separate results

SELECT * FROM customers;

SELECT * FROM orders;

--Get all customers along with their orders, but only for customers who have placed an order

SELECT
	c.id,
	c.first_name,
	c.country,
	o.order_id,
	o.order_date,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;

--Get all customers along with their orders, including those without orders

SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id;

--Get all customers along with their orders including orders without matching customers

SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id;

SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id;

--Get all customers and all orders even i there's no match

SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id;

--Get all customers who haven't place any order

SELECT
*
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

--Get all orders without matching customers

SELECT
*
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL;

SELECT
*
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL;

--Find customers without orders and orders without customers

SELECT
*
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL;

--Get all customers along with their orders, but only for customers who have placed an order
--(without using INNER JOIN)

SELECT
*
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;

--Generate all possible combinations of customers and orders

SELECT
*
FROM customers
CROSS JOIN orders
 
--Using SalesDB, retrieve a list of all orders, along with the related customer,product and employee details

SELECT
o.OrderID,
CONCAT_WS('',c.FirstName, c.LastName) AS CustomerName,
p.Product AS ProductName,
o.Sales,
p.Price,
CONCAT_WS('',e.FirstName, e.LastName) AS SalesPName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON p.ProductID = o.ProductID
LEFT JOIN Sales.Employees AS e
ON e.EmployeeID = o.SalesPersonID

