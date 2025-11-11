

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

INSERT INTO SalesTran(ProductId,InvoiceNum,Qty,Sales) VALUES
(6,'SOB988',1,900)

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




SELECT * FROM SalesTran LEFT JOIN Products 
ON SalesTran.ProductId = Products.ProductId



CREATE TABLE SalesTran2(
	ProductId int foreign key references Products2(ProductId) ,
	InvoiceNum varchar(10),
	Qty int,
	Sales money
)


INSERT INTO SalesTran2(ProductId,InvoiceNum,Qty,Sales) VALUES
(1,'SOB982',10,3000),
(2,'SOB983',5,2500),
(3,'SOB984',5,376),
(1,'SOB985',7,2100),
(2,'SOB986',8,4000),
(4,'SOB987',10,838)

INSERT INTO SalesTran2(ProductId,InvoiceNum,Qty,Sales) VALUES
(6,'SOB988',1,900)

drop table Products2

CREATE TABLE Products2(
	ProductId int primary key,
	ProductName varchar(50),
	UnitPrice money
)

INSERT INTO Products2(ProductId,ProductName,UnitPrice) VALUES
(1,'ABC Logo Cap',300),
(2,'Ball Bearing',500),
(3,'Bell',75.2),
(4,'Trousers',83.8),
(5,'Shirt',200)


SELECT * FROM SalesTran2

SELECT * FROM Products2


SELECT * FROM SalesTran2 s LEFT JOIN Products2  p
ON s.ProductId = p.ProductId