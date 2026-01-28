select * from dbo.employees
select * from dbo.employees where salary > (select avg(salary) from dbo.employees) 