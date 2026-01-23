drop table if exists salestran;
CREATE TABLE salesTran ( productId int, InvoiceNum varchar(10), Qty int, sales money );
select * from salesTran; 
INSERT INTO salesTran(productId,InvoiceNum,Qty,sales) 
VALUES
(1,'S0B982',10,3000), 
(2,'S0B983',5,2500),
(3,'S0B984',5,376), 
(1,'S0B985',10,2100),
(2,'S0B986',10,4000), 
(4,'S0B987',10,838); 
drop table if exists products;
CREATE TABLE products( productid int, productName Varchar(50), unitprice money ); 
INSERT INTO products (productid,productName,unitprice)
VALUES 
(1,'ABC Logo Cap',300), 
(2,'Ball Bearing',500), 
(3,'Bell',75.2), 
(4,'Trousers',83.8), 
(5,'Shirt',200);
SELECT * FROM salesTran; 
SELECT * FROM products;
SELECT * FROM salesTran, products 
SELECT * FROM salesTran 
JOIN Products ON salesTran.productId = products.productId 
SELECT * FROM salesTran INNER JOIN products ON salesTran.productId = products.productId 
SELECT * FROM salesTran INNER JOIN products ON salesTran.productId = products.productId