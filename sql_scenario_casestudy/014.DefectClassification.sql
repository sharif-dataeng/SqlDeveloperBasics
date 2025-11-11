--DROP TABLE IF EXISTS Defects
CREATE TABLE Defects(
	DefectId int primary key,
	ProductId int,
	RaisedDate datetime,
	ClosedDate datetime
)

INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10001,402,'2021-02-04 13:34:12','2021-03-14 14:14:12')
GO
INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10002,403,'2021-06-04 16:14:12',null)
GO
INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10003,404,'2023-12-04 16:54:11','2023-12-14 12:14:12')
GO
INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10004,402,'2021-10-14 10:14:10',null)
GO
INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10005,406,'2021-07-14 09:34:12','2021-09-12 11:11:10')
GO
INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10006,407,'2023-07-04 09:14:07',null)
GO
INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10007,403,'2022-12-04 13:34:12','2023-03-02 10:14:12')
GO
INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10008,409,'2021-06-01 13:34:12','2021-09-14 14:14:12')
GO
INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10009,410,'2021-01-04 13:34:12',null)
GO
INSERT INTO Defects(DefectId,ProductId,RaisedDate,ClosedDate) VALUES
(10010,404,'2022-01-03 13:34:12','2022-03-14 14:14:12')
GO

SELECT * FROM Defects

SELECT * ,
CASE  
	WHEN CLOSEDDATE is NULL THEN 'Open'
	ELSE 'Closed'
END DefectStatus
FROM Defects


SELECT * FROM (
SELECT * ,
CASE  
	WHEN CLOSEDDATE is NULL THEN 'Open'
	ELSE 'Closed'
END DefectStatus
FROM Defects)T
WHERE DefectStatus = 'Open'


SELECT *,
DATEDIFF(DD,raiseddate,getdate()) NoOfOpenDays from Defects
where ClosedDate is null