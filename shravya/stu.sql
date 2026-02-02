CREATE TABLE Stu1 (
    Stu1ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Grade INT
);
INSERT INTO Stu1 (Stu1ID, Name, Grade)
VALUES (1, 'Alice', 85);
INSERT INTO Stu1 (Stu1ID, Name, Grade)
VALUES (2, 'Bob', 90);

UPDATE Stu1
SET Grade = 95
WHERE Stu1ID = 1;
UPDATE Stu1
SET Grade = 90
WHERE Grade < 90;

MERGE Stu1 AS target
USING (VALUES (3, 'Charlie', 88)) AS source (Stu1ID, Name, Grade)
ON target.Stu1ID = source.Stu1ID
WHEN MATCHED THEN
    UPDATE SET Name = source.Name, Grade = source.Grade
WHEN NOT MATCHED THEN
    INSERT (Stu1ID, Name, Grade)
    VALUES (source.Stu1ID, source.Name, source.Grade);


select * from Stu1
