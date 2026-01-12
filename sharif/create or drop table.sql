use training;
 create table dbo.students(
 	EmployeeId INT PRIMARY KEY,
	EmployeeName VARCHAR(100),
	Location VARCHAR(100),
	Sex CHAR(1),
	Age INT,
	Email VARCHAR(255),
	Department VARCHAR(100),
	HireDate DATE,
	Salary DECIMAL(10,2),
	IsActive BIT
 );