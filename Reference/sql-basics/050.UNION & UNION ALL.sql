


SELECT *INTO tblsemps2 FROM tblsemp

SELECT * FROM tblEmps
UNION
SELECT * FROM tblemps2

SELECT * FROM tblsemps
UNION ALL
SELECT * FROM TBLSEMPS2


SELECT EmployeeId,EmployeeName,Title,Salary FROM tblEmps
UNION ALL
SELECT EmployeeId,EmployeeName,Title,Salary FROM tblEmps2


SELECT EmployeeId,EmployeeName,NULL Title,Salary FROM tblEmps
UNION ALL
SELECT EmployeeId,EmployeeName,Title,Salary FROM tblEmps2