

CREATE TABLE emps(
	empid int,
	empname varchar(100),
	isactive bit
)

insert into emps(empid,empname,isactive)values(1,'alice',0)

insert into emps(empid,empname,isactive)values(5,'robert',1)


insert into emps(empid,empname,isactive)values(3,'sarah',1)

insert into emps(empid,empname,isactive)values(7,'mike',0)

select * from emps