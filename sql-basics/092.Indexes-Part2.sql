--DROP TABLE EMPLOYEES4


CREATE TABLE EMPLOYEES4(
	EmployeeId int ,
	EmpName varchar(100),
	City varchar(30),
	Department varchar(50),
	Salary money,
	Email varchar(100)
)

INSERT INTO EMPLOYEES4(EmployeeId,EmpName,City,Department,Salary,Email)VALUES
(1,'John','NYC','IT',40000,'abc@gmail.com'),
(2,'Amanda','London','Sales',40000,'abc1@gmail.com'),
(3,'Aman','Pune','IT',30000,'ab2c@gmail.com'),
(4,'Rahul','Pune','IT',26000,'ab3c@gmail.com'),
(5,'Sam','London','Sales',30000,null)


SELECT * FROM EMPLOYEES4
where EmpName = 'john'

CREATE NONCLUSTERED INDEX Nic_empname ON EMPLOYEES4(EmpName)


CREATE INDEX Nic_deptcity ON EMPLOYEES4(Department,City)

DROP INDEX Nic_deptcity ON EMPLOYEES4

DROP INDEX [PK__EMPLOYEE__7AD04F11E76A4CAC] ON EMPLOYEES4

ALTER  INDEX Nic_empname ON EMPLOYEES4 DISABLE


ALTER  INDEX Nic_empname ON EMPLOYEES4 REBUILD


CREATE NONCLUSTERED INDEX Nic_empname2 
ON EMPLOYEES4(EmpName)
INCLUDE (Department,City)


CREATE UNIQUE NONCLUSTERED INDEX Nic_Email ON EMPLOYEES4(Email)