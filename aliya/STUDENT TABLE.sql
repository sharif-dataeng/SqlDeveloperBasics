
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    Course VARCHAR(50),
    Email VARCHAR(100)
);
SELECT * FROM Student;

INSERT INTO Student (StudentID, FirstName, LastName, Age, Course, Email)
VALUES
(1, 'Alice', 'Brown', 20, 'Computer Science', 'alice@example.com'),
(2, 'Rahul', 'Sharma', 21, 'Mechanical Engineering', 'rahul@example.com'),
(3, 'Maria', 'Lopez', 22, 'Business Administration', 'maria@example.com'),
(4, 'John', 'Smith', 19, 'Information Technology', 'john@example.com');

SELECT * FROM Student;