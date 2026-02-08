
--No changes are allowed once the record is created. The data remains static

CREATE TABLE Customer_SCD0 (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Email VARCHAR(100)
);

INSERT INTO Customer_SCD0 VALUES
(1, 'Alice Brown', 'New York', 'alice@abc.com'),
(2, 'Bob Smith', 'Chicago', 'bob@abc.com'),
(3, 'Carol Jones', 'Dallas', 'carol@abc.com'),
(4, 'David Lee', 'Miami', 'david@abc.com'),
(5, 'Emma White', 'Seattle', 'emma@abc.com');

SELECT CustomerID, Name, City, Email
FROM Customer_SCD0;

--The old value is simply overwritten with the new value. No history is preserved#

CREATE TABLE Customer_SCD1 (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Email VARCHAR(100)
);

INSERT INTO Customer_SCD1 VALUES
(6, 'Frank Green', 'Denver', 'frank@abc.com'),
(7, 'Grace Hall', 'Boston', 'grace@abc.com'),
(8, 'Henry King', 'Austin', 'henry@abc.com'),
(9, 'Irene Scott', 'Phoenix', 'irene@abc.com'),
(10, 'Jack Adams', 'Houston', 'jack@abc.com');

SELECT CustomerID, Name, City, Email
FROM Customer_SCD1
WHERE CustomerID = 7;  


--A new row is added for every change, preserving full history
--Typically includes effective dates or current flag to indicate active records


CREATE TABLE Customer_SCD2 (
    CustomerID INT,
    Name VARCHAR(50),
    City VARCHAR(50),
    Email VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    CurrentFlag CHAR(1)
);

INSERT INTO Customer_SCD2 VALUES
(11, 'Kate Brown', 'Atlanta', 'kate@abc.com', '2023-01-01', '2024-05-01', 'N'),
(11, 'Kate Brown', 'Orlando', 'kate@abc.com', '2024-05-02', NULL, 'Y'),
(12, 'Liam Davis', 'Detroit', 'liam@abc.com', '2022-03-01', '2023-08-15', 'N'),
(12, 'Liam Davis', 'San Jose', 'liam@abc.com', '2023-08-16', NULL, 'Y'),
(13, 'Mia Wilson', 'Portland', 'mia@abc.com', '2021-07-01', NULL, 'Y');

SELECT CustomerID, Name, City, Email
FROM Customer_SCD2
WHERE CurrentFlag = 'Y';

-- Get full history for a specific customer
SELECT CustomerID, Name, City, Email, StartDate, EndDate, CurrentFlag
FROM Customer_SCD2
WHERE CustomerID = 11
ORDER BY StartDate;



--Adds a new column to store the previous value, 
--while keeping the current value in the original column.
 --Only limited history is preserved.

CREATE TABLE Customer_SCD3 (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    CurrentCity VARCHAR(50),
    PreviousCity VARCHAR(50),
    Email VARCHAR(100)
);

INSERT INTO Customer_SCD3 VALUES
(14, 'Noah Clark', 'San Diego', 'Denver', 'noah@abc.com'),
(15, 'Olivia Reed', 'San Francisco', 'Los Angeles', 'olivia@abc.com');

SELECT CustomerID, Name, CurrentCity, PreviousCity, Email
FROM Customer_SCD3
WHERE CustomerID = 14;







