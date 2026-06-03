--Using SELECT/FROM

SELECT *
FROM customers

SELECT *
FROM orders

--Retrive each customers name, country, and score

SELECT 
	first_name,
	country,
	score
FROM customers

--Using WHERE

SELECT *
FROM customers
WHERE score > 500

--Retrieve customers with a score not equal to 0

SELECT *
FROM customers
WHERE score != 0;

--Retrieve customers from Germany

SELECT
*
FROM customers
WHERE country = 'Germany';

--Using ORDER BY(Sorting Data)
-- Retrieve all customers and sort the results by the lowest/highest score first.

SELECT
*
FROM customers
ORDER BY score DESC

SELECT
*
FROM customers
ORDER BY score ASC

--Retrieve all customers and sort the results by the country and then by the highest score

SELECT
*
FROM customers
ORDER BY 
country ASC,
score DESC

--Using GROUP BY(Aggregate data)
--Find the total score for each country

SELECT
	country,
	SUM(score) AS total_score
FROM customers
GROUP BY country

--Find the total score and total number of customers for each country

SELECT
	country,
	COUNT(id) AS total_customers,
	SUM(score) AS total_score
FROM customers
GROUP BY country

--Using HAVING(Filter Aggregated Data)
/*Find the avg score for each country 
considering only customers with a score not equal to 0
and return only those countries with an avg score greater than 430 */

SELECT
country,
AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;

--Using DISTINCT(Removes duplicates)
--Return unique list of all countries

SELECT DISTINCT country
FROM customers

--Using TOP(Limit data)

SELECT TOP 3
*
FROM customers

-- Retreieving the Top 3 Customers with the highest score

SELECT TOP 3
*
FROM customers
ORDER BY score DESC

--Get the two most recent orders

SELECT TOP 2 
*
FROM orders
ORDER BY order_date DESC