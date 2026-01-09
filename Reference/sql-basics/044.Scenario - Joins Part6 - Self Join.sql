
CREATE TABLE tblEmps(
	EmployeeId int primary key,
	ParentEmployeeId int,
	EmployeeName varchar(100),
	Title varchar(100),
	Salary money
)

insert into tblEmps(EmployeeId,ParentEmployeeId,EmployeeName,Title,Salary)
values
(1,null,'John smith','Founder',1000000),
(2,1,'Sam Cook','CEO',500000),
(3,2,'Amanda Johnson','Senior VP',1000000),
(4,3,'Mike Henry','VP',40000),
(5,4,'Rakesh Dev','Manager',50000),
(6,5,'Rehan Shaikh','Architect',60000),
(7,5,'Ankit Kumar','Lead-Developer',30000),
(8,7,'Aman Patel','Associate',15000),
(9,7,'Joe Stone','Associate',13000),
(10,7,'Mitchel woods','Associate',14000)

SELECT * FROM tblemps

SELECT A.EmployeeId,A.EmployeeName,A.ParentEmployeeId,
B.EmployeeName AS ManagerName
FROM tblEmps A LEFT JOIN tblemps B
ON A.ParentEmployeeId = B.EmployeeId

SELECT A.EmployeeId,A.EmployeeName,
B.EmployeeName AS ManagerName
FROM tblEmps A LEFT JOIN tblemps B
ON A.ParentEmployeeId = B.EmployeeId

SELECT A.EmployeeId,A.EmployeeName,
B.EmployeeName AS ManagerName
FROM tblEmps A LEFT JOIN tblemps B
ON A.ParentEmployeeId = B.EmployeeId
WHERE A.Salary > B.Salary