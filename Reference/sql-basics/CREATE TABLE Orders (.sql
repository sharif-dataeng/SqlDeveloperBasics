CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(101, 1, '2025-12-01', 500),
(102, 2, '2025-12-02', 1200),
(103, 1, '2025-12-05', 700),
(104, 3, '2025-12-07', 300),
(105, 2, '2025-12-10', 1500);

