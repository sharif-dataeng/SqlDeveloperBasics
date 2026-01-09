SELECT ProductId,InvoiceNum,OrderDate,City,Qty,
FIRST_VALUE(QTY) OVER(ORDER BY OrderDate) FirstVal
FROM Orders

SELECT ProductId,InvoiceNum,OrderDate,City,Qty,
FIRST_VALUE(QTY) OVER(PARTITION BY City ORDER BY OrderDate) FirstVal
FROM Orders


SELECT ProductId,InvoiceNum,OrderDate,City,Qty,
LAST_VALUE(QTY) OVER(ORDER BY OrderDate) LastVal
FROM Orders

SELECT ProductId,InvoiceNum,OrderDate,City,Qty,
LAST_VALUE(QTY) OVER(ORDER BY (SELECT 0)) LastVal
FROM Orders

SELECT ProductId,InvoiceNum,OrderDate,City,Qty,
LAST_VALUE(QTY) OVER(PARTITION BY CITY ORDER BY (SELECT 0)) LastVal
FROM Orders
