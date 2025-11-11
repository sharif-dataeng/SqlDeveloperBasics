

SELECT * FROM Products P LEFT JOIN SalesTran S
ON P.ProductId = S.ProductId

SELECT * FROM Products P LEFT OUTER JOIN SalesTran S
ON P.ProductId = S.ProductId

SELECT * FROM SalesTran S RIGHT JOIN Products P
ON P.ProductId = S.ProductId


SELECT * FROM SalesTran S RIGHT OUTER JOIN Products P
ON P.ProductId = S.ProductId

SELECT * FROM SalesTran S FULL OUTER JOIN Products P
ON P.ProductId = S.ProductId