SELECT * FROM tblEmps
UNION
SELECT * FROM tblEmps2

SELECT * FROM tblEmps
INTERSECT
SELECT * FROM tblEmps2


DELETE FROM tblEmps2 WHERE EMPLOYEEID = 10


SELECT A.* FROM tblEmps A JOIN tblEmps B
ON A.EmployeeId = B.EmployeeId AND A.ParentEmployeeId = B.ParentEmployeeId