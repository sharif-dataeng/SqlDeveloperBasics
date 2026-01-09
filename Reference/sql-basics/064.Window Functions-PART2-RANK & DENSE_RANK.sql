

SELECT EmployeeId, EmpName, City, Department,Salary,
RANK() OVER(ORDER BY Salary DESC) Ranks
FROM EMPLOYEES

SELECT EmployeeId, EmpName, City, Department,Salary,
RANK() OVER(PARTITION BY CITY ORDER BY Salary DESC) Ranks
FROM EMPLOYEES


SELECT EmployeeId, EmpName, City, Department,Salary,
DENSE_RANK() OVER(ORDER BY Salary DESC) Ranks
FROM EMPLOYEES


SELECT EmployeeId, EmpName, City, Department,Salary,
DENSE_RANK() OVER(PARTITION BY CITY ORDER BY Salary DESC) Ranks
FROM EMPLOYEES