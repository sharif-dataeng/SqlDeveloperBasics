


create table tblTxtDatatypes(
	employeename char,
	city varchar
)

select * from tblTxtDatatypes

insert into tblTxtDatatypes(employeename,city) values('a','x')
insert into tblTxtDatatypes(employeename,city) values('abc','xyz')

create table tblTxtDatatypes2(
	employeename char(5),
	city varchar(5)
)

select * from tblTxtDatatypes2

insert into tblTxtDatatypes2(employeename,city) values('abc','xyz')

'abc  '
'xyz'


create table tblTxtDatatypes3(
	employeename char(8000),
	city varchar(8000)
)


create table tblTxtDatatypes4(
	employeename char(8000),
	city varchar(max)
)

create table tblTxtDatatypes5(
	employeename nchar(4000),
	city nvarchar(4000),
	city2 nvarchar(max)
)