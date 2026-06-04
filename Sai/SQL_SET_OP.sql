--Combine the data from employees and customers into one table

SELECT
FirstName,
LastName
FROM Sales.Employees
UNION
SELECT
FirstName,
LastName
FROM Sales.Customers;

--Combine the data from employees anf customers into one table including duplicates

SELECT
FirstName,
LastName
FROM Sales.Employees
UNION ALL
SELECT
FirstName,
LastName
FROM Sales.Customers;

--Find employees who are not customers at the same time

SELECT
FirstName,
LastName
FROM Sales.Employees
EXCEPT
SELECT
FirstName,
LastName
FROM Sales.Customers;

--Find the employees who are also customers

SELECT
FirstName,
LastName
FROM Sales.Employees
INTERSECT
SELECT
FirstName,
LastName
FROM Sales.Customers;
