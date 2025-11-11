

SELECT NEWID()

'69DE598E-B199-47C2-9025-8B5C7F54C7C5'

'A6C563A7-A78B-425F-9878-A0AB1F5F1428'


CREATE TABLE tblEmployees(
	Employeeid uniqueidentifier,
	Empname varchar(100)
)

insert into tblEmployees(Employeeid,Empname) values
(newid(),'john')


select * from tblEmployees

CREATE TABLE tblEmployees2(
	Employeeid uniqueidentifier default newid(),
	Empname varchar(100)
)


insert into tblEmployees2(Empname) values
('jack')

select * from tblEmployees2