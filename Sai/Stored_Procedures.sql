--Step 1: Write a query
--For US customers Find the total number of customers and the average score

SELECT
COUNT(*) TotalCustomers,
AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country = 'USA'

--Step 2: Turning the query into stored procedure

CREATE PROCEDURE GetCustomerSummary AS
BEGIN
	SELECT
	COUNT(*) TotalCustomers,
	AVG(Score) AvgScore
	FROM Sales.Customers
	WHERE Country = 'USA'
END

--Step 3: Execute the stored procedure

EXEC GetCustomerSummary

--Adding Parameters

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS
BEGIN
SELECT
	COUNT(*) TotalCustomers,
	AVG(Score) AvgScore
FROM Sales.Customers
WHERE Country = @Country;

-- Find the total number of orders and total sales

SELECT
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE Country = @Country;

END

EXEC GetCustomerSummary @Country = 'Germany'


--Using Variables

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS
BEGIN

DECLARE @TotalCustomers INT, @AvgScore FLOAT;

--Generating Reports

SELECT
	@TotalCustomers = COUNT(*),
	@AvgScore = AVG(Score)
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

SELECT
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE Country = @Country;

END

EXEC GetCustomerSummary;
EXEC GetCustomerSummary @Country = 'Germany';

--Using IF ELSE

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS
BEGIN

DECLARE @TotalCustomers INT, @AvgScore FLOAT;

--Prepare & Cleanup Data

IF EXISTS(SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
BEGIN
	PRINT('Updating Null Scores to 0');
	UPDATE Sales.Customers
	SET Score = 0
	WHERE Score IS NULL AND Country = @Country;
END

ELSE 
BEGIN
	PRINT('No NULL Scores found')
END;

--Generating Reports

SELECT
	@TotalCustomers = COUNT(*),
	@AvgScore = AVG(Score)
FROM Sales.Customers
WHERE Country = @Country;

PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

SELECT
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE Country = @Country;

END

EXEC GetCustomerSummary;
EXEC GetCustomerSummary @Country = 'Germany';


--Error Handling TRY & CATCH

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS
BEGIN
	BEGIN TRY

		DECLARE @TotalCustomers INT, @AvgScore FLOAT;

		--Prepare & Cleanup Data

		IF EXISTS(SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
		BEGIN
			PRINT('Updating Null Scores to 0');
			UPDATE Sales.Customers
			SET Score = 0
			WHERE Score IS NULL AND Country = @Country;
		END

		ELSE 
		BEGIN
			PRINT('No NULL Scores found')
		END;

		--Generating Reports

		SELECT
			@TotalCustomers = COUNT(*),
			@AvgScore = AVG(Score)
		FROM Sales.Customers
		WHERE Country = @Country;

		PRINT 'Total Customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
		PRINT 'Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

		SELECT
			COUNT(OrderID) TotalOrders,
			SUM(Sales) TotalSales,
			1/0
		FROM Sales.Orders o
		JOIN Sales.Customers c
		ON c.CustomerID = o.CustomerID
		WHERE Country = @Country;

	END TRY
	BEGIN CATCH
		PRINT('An error occured');
		PRINT('Error Message: ' + ERROR_MESSAGE());
		PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
		PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
		PRINT('Error Procedure: ' + ERROR_PROCEDURE());
	END CATCH
END

EXEC GetCustomerSummary;
EXEC GetCustomerSummary @Country = 'Germany';