--drop table customers

create table customers(
	id int primary key identity(1,1),
	firstname varchar(100),
	lastname varchar(100)
)

insert into customers(firstname,lastname)
select firstname,lastname  from dimcustomer


select * from customers
where firstname = 'John'

create index Nic_Firstname on customers(Firstname)

select * from customers where Firstname = 'John'

select * from customers where Lastname = 'Smith'

select * from customers where id = 33

drop index Nic_Firstname on customers

create index Nic_names on customers (FirstName,LastName)


select * from customers where Firstname = 'John'

select * from customers where Lastname = 'Smith'

select * from customers where Firstname = 'John' and lastname = 'Smith'

Index seek > Index scan > Table scan