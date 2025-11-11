
CREATE TABLE Vendors(
	VendorId int primary key,
	VendorName varchar(50),
	Yearly money,
	HalfYearly money,
	Quaterly money,
	Monthly money
)

INSERT INTO Vendors(VendorId,VendorName,Yearly,HalfYearly,Quaterly,Monthly)values
(1,'xyz company',20000,NULL,NULL,NULL),
(2,'abc express',NULL,10000,NULL,NULL),
(3,'door step delivery',NULL,NULL,6000,NULL),
(4,'tcl telecom',NULL,NULL,NULL,1200)


SELECT * FROM Vendors

SELECT COALESCE(NULL,1)


SELECT COALESCE(NULL,41,100,NULL,80)

SELECT ISNULL(NULL,1)


SELECT ISNULL(100,1)


SELECT VendorId,VendorName,
COALESCE(Yearly,HalfYearly*2,Quaterly*4,Monthly*12) Rate
FROM Vendors