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

