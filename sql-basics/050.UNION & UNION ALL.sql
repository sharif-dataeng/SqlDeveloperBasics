


SELECT * into tblEmps2 FROM tblEmps

SELECT * FROM tblEmps
UNION
SELECT * FROM tblEmps2

SELECT * FROM tblEmps
UNION ALL
SELECT * FROM tblEmps2


SELECT EmployeeId,EmployeeName,Title,Salary FROM tblEmps
UNION ALL
SELECT EmployeeId,EmployeeName,Title,Salary FROM tblEmps2


SELECT EmployeeId,EmployeeName,NULL Title,Salary FROM tblEmps
UNION ALL
SELECT EmployeeId,EmployeeName,Title,Salary FROM tblEmps2