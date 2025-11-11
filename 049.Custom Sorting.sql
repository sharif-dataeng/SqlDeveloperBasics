SELECT EmployeeKey,FirstName,DepartmentName,
CASE DepartmentName
			WHEN 'Sales' THEN 1
			WHEN 'Finance' THEN 2
			WHEN 'Engineering' THEN 3
			WHEN 'Marketing' THEN 4
			ELSE 5
END Category
FROM DimEmployee

SELECT EmployeeKey,FirstName,DepartmentName FROM DimEmployee
ORDER BY CASE DepartmentName
			WHEN 'Sales' THEN 1
			WHEN 'Finance' THEN 2
			WHEN 'Engineering' THEN 3
			WHEN 'Marketing' THEN 4
			ELSE 5
	      END		

SELECT EmployeeKey,FirstName,DepartmentName FROM DimEmployee
ORDER BY CASE DepartmentName
			WHEN 'Sales' THEN 1
			WHEN 'Finance' THEN 2
			WHEN 'Engineering' THEN 3
			WHEN 'Marketing' THEN 4
			ELSE 5
	      END	DESC

SELECT DISTINCT DepartmentName FROM DimEmployee
ORDER BY DepartmentName