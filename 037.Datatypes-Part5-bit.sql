

CREATE TABLE tblemps(
	empid int,
	empname varchar(100),
	isactive bit
)

insert into tblemps(empid,empname,isactive)values(1,'john',1)

insert into tblemps(empid,empname,isactive)values(2,'jack',0)


insert into tblemps(empid,empname,isactive)values(3,'yusuf','True')

insert into tblemps(empid,empname,isactive)values(4,'sam','False')

select * from tblemps