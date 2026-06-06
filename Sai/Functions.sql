--Show a list of customers first names together with their country in one column

SELECT
first_name,
country,
CONCAT(first_name, ' ', country) AS Name_Country
FROM customers;

--Transform the customers name to lowercase and uppercase

SELECT
first_name,
LOWER(first_name) AS low_name,
UPPER(first_name) AS up_name
FROM customers;

--Calculate the length of each customer's first name

SELECT
first_name,
LEN(first_name) AS len_name
FROM customers;

--Retrieve the first 2 characters of each first name

SELECT
first_name,
LEFT(TRIM(first_name), 2) AS first_two --TRIM is used to remove leading or trailing spaces
FROM customers;

--Retrieve last two characters of each first name

SELECT
first_name,
RIGHT(TRIM(first_name), 2) AS first_two --TRIM is used to remove leading or trailing spaces
FROM customers;

--Retrieve a list of customers first names removing the first character

SELECT
first_name,
SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS sub_name
FROM customers;

--Using ROUND

SELECT
3.516,
ROUND(3.516, 2) AS round_2,
ROUND(3.516, 1) AS round_1,
ROUND(3.516, 0) AS round_0

--Using ABS

SELECT
-10,
ABS(-10),
ABS(10)

--Using Date & Time functions

SELECT
OrderID,
CreationTime
FROM Sales.Orders

SELECT
OrderID,
CreationTime,
YEAR(CreationTime) Year,
MONTH(CreationTime) Month,
DAY(CreationTime) Day
FROM Sales.Orders;

--Using DATEPART()

SELECT
OrderID,
CreationTime,
DATEPART(year, CreationTime) Year_dp,
DATEPART(month, CreationTime) Month_dp,
DATEPART(day, CreationTime) Day_dp,
DATEPART(hour, CreationTime) Hours_dp,
DATEPART(quarter, CreationTime) Quarter_dp,
DATEPART(week, CreationTime) Week_dp
FROM Sales.Orders;

--Using DATENAME()

SELECT
OrderID,
CreationTime,
DATENAME(month, CreationTime) MonthName,
DATENAME(weekday, CreationTime) AS WDayName
FROM Sales.Orders;

--Using DATETRUNC()

SELECT
OrderID,
CreationTime,
DATETRUNC(minute, CreationTime) AS minute_dt,
DATETRUNC(hour, CreationTime) AS hour_dt,
DATETRUNC(day, CreationTime) AS day_dt,
DATETRUNC(month, CreationTime) AS month_dt,
DATETRUNC(year, CreationTime) year_dt
FROM Sales.Orders;

SELECT
DATETRUNC(month, CreationTime) Creation,
COUNT(*) AS count
FROM Sales.Orders
GROUP BY DATETRUNC(month, CreationTime)

SELECT
DATETRUNC(year, CreationTime) Creation,
COUNT(*) AS count
FROM Sales.Orders
GROUP BY DATETRUNC(year, CreationTime);

--Using EOMONTH()

SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) EndofMonth,
CAST((DATETRUNC(month, CreationTime)) AS DATE) StartofMonth
FROM Sales.Orders;

--How many orders were placed each year

SELECT
YEAR(OrderDate) Year,
COUNT(*) NoOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

--How many orders were placed each month

SELECT
DATENAME(month, OrderDate) OrderMonth,
COUNT(*) NoOfOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)

--Show all orders that were placed during the month of FEB

SELECT
*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 02

--Using FORMAT()

SELECT
OrderID,
CreationTime,
FORMAT(CreationTime, 'dd-MM-yyyy') EURO_Format,
FORMAT(CreationTime, 'dd') dd,
FORMAT(CreationTime, 'ddd') ddd,
FORMAT(CreationTime, 'dddd') dddd,
FORMAT(CreationTime, 'MM') MM,
FORMAT(CreationTime, 'MMM') MMM,
FORMAT(CreationTime, 'MMMM') MMMM
FROM Sales.Orders;

--Show CreationTime with the following format:
--Day Wed Jan Q1 2025 12:34:56 PM

SELECT
OrderID,
CreationTime,
'Day ' + FORMAT(CreationTime, 'ddd MMM') 
+ ' Q' + DATENAME(quarter, CreationTime) + 
FORMAT(CreationTime, ' yyyy HH:mm:ss tt')
FROM Sales.Orders;

--Using CONVERT()

SELECT
CreationTime,
CONVERT(DATE, CreationTime) [DateTime to Date Convert]
FROM Sales.Orders;

--Using CAST()

SELECT
CAST('123' AS INT) [Strint to Int],
CAST(123 AS VARCHAR) [Int to String],
CAST('2025-08-20' AS DATE) [String to Date],
CAST('2025-08-20' AS DATETIME) [String to DateTime]

SELECT 
CreationTime,
CAST(CreationTime AS DATE)
FROM Sales.Orders;

--Using DATEADD()

SELECT
OrderID,
OrderDate,
DATEADD(day, -10, OrderDate) TenDaysBefore,
DATEADD(month, 3, OrderDate) ThreemonthsLater,
DATEADD(year, 2, OrderDate) TwoYearsLater
FROM Sales.Orders;

--Using DATEDIFF()

SELECT
OrderDate,
ShipDate,
DATEDIFF(year, OrderDate, ShipDate) YearDiff,
DATEDIFF(month, OrderDate, ShipDate) monthDiff,
DATEDIFF(day, OrderDate, ShipDate) dayDiff
FROM Sales.Orders;

--Calculate the age of employees

SELECT
EmployeeID,
BirthDate,
DATEDIFF(year, BirthDate, GETDATE()) Age
FROM Sales.Employees;

--Find the average shipping duration in days for each month

SELECT
FORMAT(ShipDate, 'MMM') AS Month,
AVG(DATEDIFF(day, OrderDate, ShipDate)) AS AvgDuration
FROM
Sales.Orders
GROUP BY FORMAT(ShipDate, 'MMM');

--Using ISDATE()

SELECT 
ISDATE(123) DateCheck1,
ISDATE('2025-09-21') DateCheck2,
ISDATE('21-09-2025') DateCheck3,
ISDATE('2025') DateCheck4,
ISDATE('09') DateCheck5

--Find the average scores of the customers

SELECT
AVG(ISNULL(Score,0)) AS AvgScore
FROM Sales.Customers

/*Display the full name of customers in a single field
by merging their first and last names,
and add 10 bonus points to each customer's score. */

SELECT
CustomerID,
FirstName,
LastName,
FirstName + COALESCE(LastName, '') AS FullName,
Score,
COALESCE(Score, 0) + 10 AS ScoreWithBonus
FROM Sales.Customers;

--Sort the customers from lowest to highest scores, with NULLs appearing last

SELECT
CustomerID,
Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END

--Find the sales price for each order by dividing the sales by the quantity

SELECT
OrderID,
Sales,
Sales / NULLIF(Quantity, 0) AS Price
FROM Sales.Orders

--Identify the customers who have no scores

SELECT 
*
FROM Sales.Customers
WHERE Score IS NULL

--List all customers who have scores

SELECT 
*
FROM Sales.Customers
WHERE Score IS NOT NULL

--List all details for customers who have not placed any orders

SELECT
c.*,
o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL

/* Generate a report showing the total sales for each category:
	-High: If the sales is higher than 50
	-Medium: If the sales is betwen 20 and 50
	-Low: If the sales equal or lower than 20
Sort the result from highest to lowest. */

SELECT
Category,
SUM(Sales) TotalSales
FROM(
	SELECT
	OrderID,
	Sales,
	CASE
		WHEN Sales > 50 THEN 'High'
		WHEN Sales BETWEEN 20 AND 50 THEN 'Medium'
		ELSE 'Low'
	END Category
	FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC;

--Retrieve employee details with gender displayed as full text

SELECT
EmployeeID,
FirstName,
LastName,
CASE 
	WHEN Gender = 'M' THEN 'Male'
	WHEN Gender = 'F' THEN 'Female'
	ELSE 'N/A'
END Gender
FROM Sales.Employees;

--Retrieve customer details with abbreviated country code
SELECT DISTINCT Country
FROM Sales.Customers;

SELECT
CustomerID,
FirstName,
LastName,
CASE
	WHEN Country = 'Germany' THEN 'DE'
	WHEN Country = 'USA' THEN 'US'
	ELSE 'N/A'
END CountryAbb
FROM Sales.Customers;

/* Find the average scores of customers and treat Nulls as 0
and additional provide details such as CustomerID & LastName */

--Count how many times each customer has made an order with sales greater than 30

SELECT
CustomerID,
SUM(
	CASE 
		WHEN Sales > 30 THEN 1
		ELSE 0
	END
	) TotalCount
FROM Sales.Orders
GROUP BY CustomerID;

--Window Functions
--Find the total sales across all orders

SELECT
SUM(Sales) TotalSales
FROM Sales.Orders;

--Find the total sales for each product

SELECT
ProductID,
SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID;

/* Find the total sales accross all orders,
addionally provide details such as order id and order date */

SELECT
OrderID,
OrderDate,
SUM(Sales) OVER() TotalSales
FROM Sales.Orders

/* Find the total sales for each product,
addionally provide details such as order id and order date */

SELECT
OrderID,
OrderDate,
ProductID,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSales
FROM Sales.Orders

/* Find the total sales accross all orders,
Find the total sales for each product,
addionally provide details such as order id and order date */

SELECT
OrderID,
OrderDate,
ProductID,
OrderStatus,
Sales,
SUM(Sales) OVER() TotalSales,
SUM(Sales) OVER(PARTITION BY ProductID) SalesByProducts,
SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) SalesByProductsAndStatus
FROM Sales.Orders

/* Rank each order based on their sales from highest to lowest,
additionally provide details such as order id and order date */

SELECT
OrderID,
OrderDate,
Sales,
RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders