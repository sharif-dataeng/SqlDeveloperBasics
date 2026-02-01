CREATE TABLE TargetTable (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(50),
    Email NVARCHAR(50),
    City NVARCHAR(50)
);

INSERT INTO TargetTable (CustomerID, CustomerName, Email, City)
VALUES
(1, 'Alice Johnson', 'alice@example.com', 'New York'),
(2, 'Bob Smith', 'bob@example.com', 'Chicago'),
(3, 'Charlie Brown', 'charlie@example.com', 'Los Angeles');

CREATE TABLE SourceTable (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(50),
    Email NVARCHAR(50),
    City NVARCHAR(50)
);

INSERT INTO SourceTable (CustomerID, CustomerName, Email, City)
VALUES
(2, 'Bob Smith', 'bob_new@example.com', 'Chicago'),   
(3, 'Charlie Brown', 'charlie@example.com', 'San Diego'), 
(4, 'Diana Prince', 'diana@example.com', 'Boston');  

update sourcetable set city= 'warangal' where customerid=4
 insert into sourcetable values(6,'somesh','som@gmail.com','kazipet')


select * from sourcetable
select * from targettable
MERGE INTO TargetTable AS T
USING SourceTable AS S
ON T.CustomerID = S.CustomerID
WHEN MATCHED THEN
    UPDATE SET T.CustomerName = S.CustomerName,
               T.Email = S.Email,
               T.City = S.City
WHEN NOT MATCHED BY TARGET THEN
    INSERT (CustomerID, CustomerName, Email, City)
    VALUES (S.CustomerID, S.CustomerName, S.Email, S.City)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;


	delete from sourcetable where customerid=2






