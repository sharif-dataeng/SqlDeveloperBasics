--SCD 1 : Overwrite

--DROP TABLE IF EXISTS Products
CREATE TABLE Products(
	ProductKey int primary key,
	ProductName varchar(100),
	StockLevel int,
	Price money
)

INSERT INTO Products(ProductKey,ProductName,StockLevel,Price)VALUES
(1,'Adjustable Race',1000,100.50),
(2,'Bearing Ball',800,90.85),
(3,'BB Ball Bearing',1250,120.45),
(4,'Headset Ball Bearings',500,75.10),
(5,'Blade',1500,10.25),
(6,'LL Crankarm',200,2000.45),
(7,'ML Crankarm',200,1980.50),
(8,'HL Crankarm',200,1976.45),
(9,'Chainring Bolts',2000,10.25),
(10,'Chainring Nut',2000,3.45)


--DROP TABLE IF EXISTS Products_Stage
CREATE TABLE Products_Stage(
	ProductKey int primary key,
	ProductName varchar(100),
	StockLevel int,
	Price money
)


INSERT INTO Products_Stage(ProductKey,ProductName,StockLevel,Price)VALUES
(1,'Adjustable Race',1200,100.50),
(2,'Bearing Ball',1200,95.85),
(11,'Crown Race',400,100.25),
(12,'Chain Stays',600,30.45)


SELECT * FROM Products
SELECT * FROM Products_Stage

--SCD1 Implementation
MERGE INTO Products T
	USING Products_Stage S
	ON T.ProductKey = S.ProductKey

WHEN NOT MATCHED THEN
	INSERT(ProductKey,ProductName,StockLevel,Price)
	VALUES(S.ProductKey,S.ProductName,S.StockLevel,S.Price)

WHEN MATCHED THEN
	UPDATE SET T.StockLevel = S.StockLevel,
				T.Price = S.Price;


--SCD 2 : Preserve history by adding a row

--DROP TABLE IF EXISTS Products
CREATE TABLE Products(
	ProductKey int,
	ProductName varchar(100),
	StockLevel int,
	Price money,
	StartDate datetime,
	EndDate datetime,
	IsActive bit
)

INSERT INTO Products(ProductKey,ProductName,StockLevel,Price,StartDate,EndDate,IsActive)VALUES
(1,'Adjustable Race',1000,100.50,'2020-04-03',null,1),
(2,'Bearing Ball',800,90.85,'2021-01-02',null,1),
(3,'BB Ball Bearing',1250,120.45,'2022-07-02',null,1),
(4,'Headset Ball Bearings',500,75.10,'2023-09-02',null,1)



--DROP TABLE IF EXISTS Products_Stage
CREATE TABLE Products_Stage(
	ProductKey int,
	ProductName varchar(100),
	StockLevel int,
	Price money
)


INSERT INTO Products_Stage(ProductKey,ProductName,StockLevel,Price)VALUES
(1,'Adjustable Race',1200,100.50),
(5,'Crown Race',400,100.25),
(6,'Chain Stays',600,30.45)


SELECT * FROM Products
SELECT * FROM Products_Stage

TRUNCATE TABLE Products_Stage

INSERT INTO Products_Stage(ProductKey,ProductName,StockLevel,Price)VALUES
(1,'Adjustable Race',1500,120.50)


--SCD2 Implementation

INSERT INTO Products
	SELECT ProductKey,ProductName,StockLevel,Price,StartDate,EndDate,IsActive
FROM(
MERGE INTO Products T
	USING Products_Stage S
	ON T.ProductKey = S.ProductKey

WHEN NOT MATCHED THEN
	INSERT(ProductKey,ProductName,StockLevel,Price,StartDate,EndDate,IsActive)
	VALUES(S.ProductKey,S.ProductName,S.StockLevel,S.Price,
			FORMAT(GETDATE(),'yyyy-MM-dd'),NULL,1)
			
WHEN MATCHED AND IsActive = 1 THEN
	UPDATE SET EndDate=FORMAT(DATEADD(DD,-1,GETDATE()),'yyyy-MM-dd'),
				IsActive = 0
				
OUTPUT	S.ProductKey,S.ProductName,S.StockLevel,S.Price,
	FORMAT(GETDATE(),'yyyy-MM-dd') StartDate, null as EndDate,1 as Isactive, 
	$Action as Operation) as MergeOp	
	
	WHERE MergeOp.Operation = 'UPDATE';

--SCD 3 : Preserve history by adding column

--DROP TABLE IF EXISTS Products
CREATE TABLE Products(
	ProductKey int,
	ProductName varchar(100),
	StockLevel int,
	Price money,
	PreviousPrice_1 money,
	PreviousPrice_1_EndDate datetime,
	PreviousPrice_2 money,
	PreviousPrice_2_EndDate datetime
)

INSERT INTO Products(ProductKey,ProductName,StockLevel,Price)VALUES
(1,'Adjustable Race',1000,100.50),
(2,'Bearing Ball',800,90.85),
(3,'BB Ball Bearing',1250,120.45),
(4,'Headset Ball Bearings',500,75.10)



--DROP TABLE IF EXISTS Products_Stage
CREATE TABLE Products_Stage(
	ProductKey int,
	ProductName varchar(100),
	StockLevel int,
	Price money
)


INSERT INTO Products_Stage(ProductKey,ProductName,StockLevel,Price)VALUES
(1,'Adjustable Race',1200,102.50),
(5,'Crown Race',400,100.25),
(6,'Chain Stays',600,30.45)


INSERT INTO Products_Stage(ProductKey,ProductName,StockLevel,Price)VALUES
(1,'Adjustable Race',1200,105.50)
SELECT * FROM Products
SELECT * FROM Products_Stage

TRUNCATE TABLE Products_Stage
--SCD3 Implementation


MERGE INTO Products T
	USING Products_Stage S
	ON T.ProductKey = S.ProductKey

WHEN NOT MATCHED THEN
	INSERT(ProductKey,ProductName,StockLevel,Price)
	VALUES(S.ProductKey,S.ProductName,S.StockLevel,S.Price)

WHEN MATCHED AND (T.StockLevel <>S.StockLevel OR T.Price <> S.Price) THEN
	UPDATE SET T.StockLevel = S.StockLevel,
				T.Price = S.Price,
				T.PreviousPrice_1 = T.Price,
				T.PreviousPrice_1_EndDate = DATEADD(DD,-1,FORMAT(GETDATE(),'yyyy-MM-dd')),
				T.PreviousPrice_2 = T.PreviousPrice_1,
				T.PreviousPrice_2_EndDate = PreviousPrice_1_EndDate;
