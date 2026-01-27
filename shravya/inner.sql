CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    course_id INT
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);
INSERT INTO Students (student_id, student_name, course_id)
VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 103),
(4, 'David', NULL);
INSERT INTO Courses (course_id, course_name)
VALUES
(101, 'Mathematics'),
(102, 'Physics'),
(103, 'Chemistry'),
(104, 'Biology');

SELECT 
    Students.student_id,
    Students.student_name,
    Courses.course_name
FROM Students
INNER JOIN Courses
    ON Students.course_id = Courses.course_id;