CREATE TABLE Students (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50),
    Branch VARCHAR(30),
    Marks INT,
    Division VARCHAR(20)
);

INSERT INTO Students (RollNo, Name, Branch, Marks, Division) VALUES
(101, 'Aakash Kumar', 'Computer Science', 82, 'First Class'),
(102, 'Neha Singh', 'Mechanical', 68, 'Second Class'),
(103, 'Rahul Verma', 'Electrical', 55, 'Third Class'),
(104, 'Priya Patel', 'Civil', 91, 'First Class'),
(105, 'Aman Gupta', 'Computer Science', 44, 'Fail'),
(106, 'Sneha Rao', 'Electronics', 73, 'First Class'),
(107, 'Rohan Mehta', 'Mechanical', 61, 'Second Class'),
(108, 'Kavya Nair', 'Electrical', 39, 'Fail'),
(109, 'Arjun Das', 'Civil', 58, 'Third Class'),
(110, 'Pooja Sharma', 'Electronics', 66, 'Second Class');


select * from students


select branch,max(marks) as maxmarks from students  group by branch