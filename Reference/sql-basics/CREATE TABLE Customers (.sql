
WITH CustomerTotals AS (
    SELECT c.Name, SUM(o.TotalAmount) AS TotalSpent
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.Name
)
SELECT *
FROM CustomerTotals
WHERE TotalSpent > 1000;

