

CREATE TABLE SalesTran(
	ProductId int,
	InvoiceNum varchar(10),
	Qty int,
	Sales money
)


INSERT INTO SalesTran(ProductId,InvoiceNum,Qty,Sales) VALUES
(1,'SOB982',10,3000),
(2,'SOB983',5,2500),
(3,'SOB984',5,376),
(1,'SOB985',7,2100),
(2,'SOB986',8,4000),
(4,'SOB987',10,838)

CREATE TABLE Products(
	ProductId int,
	ProductName varchar(50),
	UnitPrice money
)

INSERT INTO Products(ProductId,ProductName,UnitPrice) VALUES
(1,'ABC Logo Cap',300),
(2,'Ball Bearing',500),
(3,'Bell',75.2),
(4,'Trousers',83.8),
(5,'Shirt',200)


SELECT * FROM SalesTran

SELECT * FROM Products


SELECT * FROM SalesTran, Products

SELECT * FROM SalesTran JOIN Products 
ON SalesTran.ProductId = Products.ProductId

SELECT * FROM SalesTran INNER JOIN Products 
ON SalesTran.ProductId = Products.ProductId

SELECT SalesTran.* FROM SalesTran INNER JOIN Products 
ON SalesTran.ProductId = Products.ProductId

SELECT Products.* FROM SalesTran INNER JOIN Products 
ON SalesTran.ProductId = Products.ProductId

SELECT * FROM SalesTran AS S INNER JOIN Products AS P
ON S.ProductId = P.ProductId


SELECT S.* FROM SalesTran AS S INNER JOIN Products AS P
ON S.ProductId = P.ProductId


SELECT P.* FROM SalesTran AS S INNER JOIN Products AS P
ON S.ProductId = P.ProductId


SELECT P.ProductId,P.ProductName,S.InvoiceNum,S.Qty,S.Sales
FROM SalesTran AS S INNER JOIN Products AS P
ON S.ProductId = P.ProductId

SELECT P.ProductId,P.ProductName,S.InvoiceNum,S.Qty,S.Sales
FROM SalesTran  S INNER JOIN Products  P
ON S.ProductId = P.ProductId

SELECT * FROM SalesTran INNER JOIN Products 
ON SalesTran.ProductId = Products.ProductId

SELECT * FROM Products INNER JOIN   SalesTran
ON SalesTran.ProductId = Products.ProductId

SELECT * FROM SalesTran LEFT JOIN Products 
ON SalesTran.ProductId = Products.ProductId

SELECT * FROM Products LEFT JOIN  SalesTran
ON SalesTran.ProductId = Products.ProductId

SELECT * FROM SalesTran RIGHT JOIN Products 
ON SalesTran.ProductId = Products.ProductId