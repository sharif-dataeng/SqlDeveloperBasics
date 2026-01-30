DROP TABLE Orders
CREATE TABLE Orders(
	ProductId int NULL,
	InvoiceNum varchar(10) NULL,
	OrderDate date NULL,
	City varchar(20) NULL,
	Qty int NULL
) 

INSERT INTO Orders (ProductId, InvoiceNum, OrderDate, City, Qty) VALUES 
(1, 'SOB982', '2022-01-02' , 'Delhi', 3000),
(2, 'SOB983', '2022-01-02' , 'NYC', 2500),
(3, 'SOB984', '2022-01-02' , 'London', 376),
(1, 'SOB985', '2022-01-03' , 'London', 2100),
(2, 'SOB986', '2022-01-03' , 'NYC', 4000),
(4, 'SOB987', '2022-01-03' , 'Delhi', 838),
(1, 'SOB988', '2022-01-04' , 'London', 2100),
(2, 'SOB989', '2022-01-04' , 'NYC', 4000),
(4, 'SOB990', '2022-01-04' , 'Delhi', 838)

select * from Orders

select productid,invoicenum,orderdate,city,qty,
lag(qty,3) over (partition by city order by orderdate) from orders

select productid,invoicenum,orderdate,city,qty,
lag(qty,2) over (partition by city order by orderdate) from orders

select productid,invoicenum,orderdate,city,qty,
lag(qty,1) over (partition by city order by orderdate) from orders


select productid,invoicenum,orderdate,city,qty,
lead(qty,1) over (partition by city order by orderdate) from orders

select productid,invoicenum,orderdate,city,qty,
lead(qty,2) over (partition by city order by orderdate) from orders

select productid,invoicenum,orderdate,city,qty,
lead(qty,3) over (partition by city order by orderdate) from orders

SELECT ProductId,InvoiceNum,OrderDate,City,Qty,
LAG(Qty,1,0) OVER(PARTITION BY CITY ORDER BY OrderDate )
FROM Orders

