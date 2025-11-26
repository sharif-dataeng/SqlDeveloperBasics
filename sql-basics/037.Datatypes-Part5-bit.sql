

CREATE TABLE tblemps(
CREATE TABLE emps(
	empid int,
	empname varchar(100),
	isactive bit
)

insert into tblemps(empid,empname,isactive)values(1,'john',1)
insert into emps(empid,empname,isactive)values(1,'alice',0)

insert into tblemps(empid,empname,isactive)values(2,'jack',0)
insert into emps(empid,empname,isactive)values(5,'robert',1)


insert into tblemps(empid,empname,isactive)values(3,'yusuf','True')
insert into emps(empid,empname,isactive)values(3,'sarah',1)

insert into tblemps(empid,empname,isactive)values(4,'sam','False')
insert into emps(empid,empname,isactive)values(7,'mike',0)

select * from tblempsselect * from emps