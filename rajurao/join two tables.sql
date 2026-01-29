CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(30),
    signup_date DATE
);

INSERT INTO customers VALUES
(1, 'Alice', 'alice@gmail.com', 'New York', '2023-01-10'),
(2, 'Bob', 'bob@gmail.com', 'Chicago', '2023-01-12'),
(3, 'Charlie', 'charlie@gmail.com', 'Boston', '2023-01-15'),
(4, 'David', 'david@gmail.com', 'Seattle', '2023-01-18'),
(5, 'Eva', 'eva@gmail.com', 'Miami', '2023-01-20'),
(6, 'Frank', 'frank@gmail.com', 'Dallas', '2023-01-22'),
(7, 'Grace', 'grace@gmail.com', 'Denver', '2023-01-25'),
(8, 'Helen', 'helen@gmail.com', 'Austin', '2023-01-27'),
(9, 'Ian', 'ian@gmail.com', 'Chicago', '2023-02-01'),
(10, 'Jane', 'jane@gmail.com', 'Boston', '2023-02-05'),
(11, 'Kevin', 'kevin@gmail.com', 'New York', '2023-02-10'),
(12, 'Laura', 'laura@gmail.com', 'Seattle', '2023-02-12'),
(13, 'Mike', 'mike@gmail.com', 'Miami', '2023-02-15'),
(14, 'Nina', 'nina@gmail.com', 'Dallas', '2023-02-18'),
(15, 'Oscar', 'oscar@gmail.com', 'Denver', '2023-02-20'),
(16, 'Paula', 'paula@gmail.com', 'Austin', '2023-02-22'),
(17, 'Quinn', 'quinn@gmail.com', 'Chicago', '2023-02-25'),
(18, 'Rachel', 'rachel@gmail.com', 'Boston', '2023-03-01'),
(19, 'Steve', 'steve@gmail.com', 'New York', '2023-03-05'),
(20, 'Tina', 'tina@gmail.com', 'Seattle', '2023-03-10');
insert into customers values
(99,'rajurao','rao@gmail.com','warangal','2026-01-29');






CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(10,2)
);

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 900.00),
(2, 'Phone', 'Electronics', 600.00),
(3, 'Tablet', 'Electronics', 400.00),
(4, 'Headphones', 'Electronics', 150.00),
(5, 'Keyboard', 'Accessories', 50.00),
(6, 'Mouse', 'Accessories', 40.00),
(7, 'Monitor', 'Electronics', 300.00),
(8, 'Printer', 'Electronics', 200.00),
(9, 'Desk', 'Furniture', 250.00),
(10, 'Chair', 'Furniture', 180.00),
(11, 'Lamp', 'Furniture', 60.00),
(12, 'Notebook', 'Stationery', 5.00),
(13, 'Pen', 'Stationery', 2.00),
(14, 'Backpack', 'Accessories', 80.00),
(15, 'Camera', 'Electronics', 700.00),
(16, 'Smart Watch', 'Electronics', 220.00),
(17, 'Router', 'Electronics', 120.00),
(18, 'USB Drive', 'Accessories', 25.00),
(19, 'Power Bank', 'Accessories', 45.00),
(20, 'Microphone', 'Electronics', 160.00);



CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO orders VALUES
(1, 1, 1, 1, '2023-03-01'),
(2, 2, 2, 2, '2023-03-02'),
(3, 3, 3, 1, '2023-03-03'),
(4, 4, 4, 3, '2023-03-04'),
(5, 5, 5, 2, '2023-03-05'),
(6, 6, 6, 1, '2023-03-06'),
(7, 7, 7, 2, '2023-03-07'),
(8, 8, 8, 1, '2023-03-08'),
(9, 9, 9, 1, '2023-03-09'),
(10, 10, 10, 2, '2023-03-10'),
(11, 11, 11, 1, '2023-03-11'),
(12, 12, 12, 10, '2023-03-12'),
(13, 13, 13, 20, '2023-03-13'),
(14, 14, 14, 1, '2023-03-14'),
(15, 15, 15, 1, '2023-03-15'),
(16, 16, 16, 2, '2023-03-16'),
(17, 17, 17, 1, '2023-03-17'),
(18, 18, 18, 5, '2023-03-18'),
(19, 19, 19, 2, '2023-03-19'),
(20, 20, 20, 1, '2023-03-20');



select * from customers
select * from products
select * from orders

--customers who placed order   (inner join)
select * from customers
select * from orders

select c.name,c.email,c.city,c.signup_date,o.order_id,o.product_id,o.quantity,o.order_date from customers c inner join orders o on c.customer_id=o.customer_id 
--order with product details (inner join)
SELECT o.order_id, p.product_name, o.quantity, p.price
FROM orders o
INNER JOIN products p
    ON o.product_id = p.product_id;

	--customers who are not placed order (left join)
	
SELECT c.customer_id, c.name, o.order_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
--customers with no orders
SELECT c.customer_id, c.name, o.order_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
	WHERE o.order_id IS NULL;
	--All orders, even if customer data is missing
	
	
SELECT c.name, o.order_id, o.order_date
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;
