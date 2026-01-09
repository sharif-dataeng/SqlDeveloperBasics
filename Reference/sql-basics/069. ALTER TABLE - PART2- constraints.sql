

CREATE TABLE EmpNew(
	Empid int,
	Empname varchar(100)
)


ALTER TABLE EmpNew
ALTER COLUMN Empid int not null

ALTER TABLE EmpNew
ADD CONSTRAINT Pk_empid PRIMARY KEY(Empid)


CREATE TABLE Salaries(
	Empid int,
	Salary money
)

ALTER TABLE Salaries
ADD CONSTRAINT Fk_emp FOREIGN KEY(Empid) REFERENCES EmpNew(Empid)


ALTER TABLE Salaries
DROP Fk_emp

ALTER TABLE EmpNew
DROP Pk_empid