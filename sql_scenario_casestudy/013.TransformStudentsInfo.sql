--DROP TABLE IF EXISTS Students
CREATE TABLE Students(
	Student int primary key,
	Maths float,
	Science float

)

INSERT INTO Students(Student,Maths,Science) VALUES(1,12,17)

INSERT INTO Students(Student,Maths,Science) VALUES(2,18,19)

INSERT INTO Students(Student,Maths,Science) VALUES(3,7,8)

SELECT * FROM Students

--Method1: Using UNPIVOT

SELECT Student,[Subject],Marks FROM (
SELECT Student,Maths,Science FROM Students)T
UNPIVOT(Marks FOR [Subject] IN(Maths,Science))U


--Method2: using union and suqbuery

SELECT * FROM(
SELECT Student, 'Maths' [Subject] ,Maths FROM Students
UNION ALL
SELECT Student, 'Science' [Subject] ,Science FROM Students)T
ORDER BY Student


--Method 3 : Union and cte


WITH Cte_Transform
AS
(SELECT Student, 'Maths' [Subject] ,Maths FROM Students
UNION ALL
SELECT Student, 'Science' [Subject] ,Science FROM Students)
SELECT * FROM Cte_Transform
ORDER BY Student

--Method4: Using case and cross join


SELECT Student,Subs.[Subject],
	CASE Subs.[Subject]
		WHEN 'Maths' THEN s.Maths
		WHEN 'Science' THEN s.Science
	END Marks

FROM STUDENTS AS S
CROSS JOIN
(
SELECT 'Maths' as [Subject]
UNION ALL
SELECT 'Science')Subs