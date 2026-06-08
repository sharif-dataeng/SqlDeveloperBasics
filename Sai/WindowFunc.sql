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

/* Find the average sales across all orders and the average sales for each product.
Additonally, provide details such as order id and order date */

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG(Sales) OVER() AvgSales,
	AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct
FROM Sales.Orders;

--Find the avg scores of customers. Additionally proovide details such as CustomerID and LastName

SELECT
	CustomerID,
	LastName,
	Score,
	AVG(Score) OVER() AvgScore,
	AVG(COALESCE(Score,0)) OVER() AvgScoreWithoutNulls
FROM Sales.Customers;

--Find all orders where sales are higher than the average sales across all orders

SELECT
*
FROM(
	SELECT
	OrderID,
	Sales,
	AVG(Sales) OVER() AvgSales
	FROM Sales.Orders
)t
WHERE Sales > AvgSales;

--Find the highest and lowest sales of all orders
--Find the highest and lowest sales for each product
--Additionally provide details such as order ID and order date

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() MaxSales,
	MIN(Sales) OVER() MinSales,
	MAX(Sales) OVER(PARTITION BY ProductID) MaxSalesByProduct,
	MIN(Sales) OVER(PARTITION BY ProductID) MinSalesByProduct
FROM Sales.Orders;

--Show the employees with highest salaries

SELECT
*
FROM (
	SELECT
	*,
	MAX(Salary) OVER() HighestSalary
	FROM Sales.Employees
	)t
WHERE Salary = HighestSalary;

--Calculate moving average of sales for each product over time

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg
FROM Sales.Orders;

--Calculate moving average of sales for each product over time, including only the next order

SELECT
OrderID,
OrderDate,
ProductID,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAvg,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Sales.Orders;

--Rank the orders based on their sales from highest to lowest

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders;

--Rank the orders based on their sales from highest to lowest using RANK()

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders;

--Rank the orders based on their sales from highest to lowest using DENSE_RANK()

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	DENSE_RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders;

--Rank the top highest sales for each product

SELECT
*
FROM(
	SELECT
		OrderID,
		OrderDate,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankSalesByProduct
	FROM Sales.Orders
	)t
WHERE RankSalesBYProduct = 1;

--Find the lowest two customers based on their total sales

SELECT
*
FROM (
	SELECT
		CustomerID,
		SUM(Sales) TotalSales,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankCustomer
		FROM Sales.Orders
		GROUP BY CustomerID
		)t
WHERE RankCustomer <= 2;

--Assign unique IDs to the rows of the Orders Archive table

SELECT
ROW_NUMBER() OVER(ORDER BY OrderID) UniqueID,
*
FROM Sales.OrdersArchive;

--Identify duplicate rows in the table OrderArchive and return a clean result without any duplicates

SELECT * FROM(
	SELECT
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
	*
	FROM Sales.OrdersArchive
	)t
WHERE rn = 1;

--Find the products that fall within the highest 40% of the prices

SELECT * FROM(
	SELECT
		Product,
		Price,
		CUME_DIST() OVER(ORDER BY Price DESC) RankPrice
		FROM Sales.Products
	)t
WHERE RankPrice <= 0.4;

--Segment all orders into 3 categories: High, Medium and Low sales

SELECT 
	*, 
	CASE
	WHEN BucketSales = 1 THEN 'High'
	WHEN BucketSales = 2 THEN 'Medium'
	ELSE 'Low'
	END SalesCategory
FROM (
	SELECT 
	OrderID,
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) BucketSales
	FROM Sales.Orders
	)t

--Analyze the month-over-month performance by finding the percentage change in sales between the current and previous months

SELECT
CurrentMonthSales,
PreviousMonthSales,
CurrentMonthSales - PreviousMonthSales AS MoM_Change,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales *100, 1) AS MoM_ChangePerc
FROM (
SELECT
MONTH(OrderDate) OrderMonth,
SUM(Sales) CurrentMonthSales,
LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate)
)t

--In order to analyze customer loyalty, rank customers based on the average days between their orders

SELECT
CustomerID,
AVG(DaysUntilNextOrder) AvgDays,
RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder), 99999)) RankAvg
FROM (
	SELECT
		CustomerID,
		OrderDate CurrentOrder,
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
		DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
	FROM Sales.Orders
	)t
GROUP BY CustomerID;

--Find the average shipping duration in days for each month

SELECT
MONTH(OrderDate) OrderMonth,
AVG(DATEDIFF(day, OrderDate, ShipDate)) Duration_Days
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

-- Time Gap Analysis - Find the number of days between each order and the previous order

SELECT
OrderID,
OrderDate CurrentOrderDate,
LAG(OrderDate) OVER(ORDER BY OrderDate) PreviousOrderDate,
DATEDIFF(day,LAG(OrderDate) OVER(ORDER BY OrderDate), OrderDate) Duration_days
FROM Sales.Orders;

--Find the lowest and highest sales for each product

SELECT
ProductID,
Sales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSales,
LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales
FROM Sales.Orders;