CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductName VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductName, Quantity, Price) VALUES
(1, 101, 'Laptop', 1, 500),
(2, 102, 'Phone', 2, 600),
(3, 103, 'Tablet', 1, 700),
(4, 104, 'Headphones', 3, 100),
(5, 105, 'Laptop', 1, 1500);

