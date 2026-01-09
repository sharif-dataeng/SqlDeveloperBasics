WITH LatestOrders AS (
    SELECT 
        CustomerID,
        OrderID,
        OrderDate,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS rn
    FROM Orders
)
SELECT CustomerID, OrderID, OrderDate
FROM LatestOrders
WHERE rn = 1;