select * from products 
select * from customers
select * from orders


SELECT 
c.customer_id, 
c.name, 
c.email, 
c.city, 
c.signup_date, 
o.order_id, 
o.product_id, 
o.quantity, 
o.order_date, 
p.product_name, 
p.price FROM customers c 
INNER JOIN orders o ON c.customer_id = o.customer_id 
INNER JOIN products p ON o.product_id = p.product_id;