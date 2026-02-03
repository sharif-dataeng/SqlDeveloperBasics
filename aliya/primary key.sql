
CREATE TABLE EMPLOYEES5(
   EmployeeId int primary key ,
   Employeename varchar(100) ,
   DOJ datetime,
   salary float,
   Email varchar(100) unique
)

insert into employees5 values(1,'aliya','2025-12-10',2000,null)

select * from employees5