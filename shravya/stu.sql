CREATE TABLE Stu (
    StuID INT PRIMARY KEY,
    Name VARCHAR(50),
    Grade INT
);
INSERT INTO Stu (StuID, Name, Grade)
VALUES (1, 'Alice', 85);

select * from Stu