--Find the total number of orders, additionally provide order ID and order date details
--Find the total number of orders for each customers

SELECT
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(*) OVER() TotalOrders,
	COUNT(*) OVER(PARTITION BY CustomerID) TOrderByCustomer
FROM Sales.Orders;

--Find the total number of customers, additionally provide all customers details
--Find the total number of scores for the customers

SELECT 
*,
COUNT(*) OVER() TotalCustomers,
COUNT(Score) OVER() TotalScore
FROM Sales.Customers

--Check for the duplicates in orders table

SELECT
OrderID,
COUNT(*) OVER(PARTITION BY OrderID) CheckPk
FROM Sales.Orders

SELECT
*
FROM(
	SELECT
		OrderID,
		COUNT(*) OVER(PARTITION BY OrderID) CheckPk
	FROM Sales.OrdersArchive
)t
WHERE CheckPk > 1

/* Find the total sales across all orders and the total sales for each product.
	Additionally provide setails such as order id and order date */

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER() TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) SalesByProduct
FROM Sales.Orders;