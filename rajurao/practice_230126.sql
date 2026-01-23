select * from dimaccount
select * from dimcustomer 
select * from dimcustomer where birthdate = (select datediff(year,'1987-11-15',
getdate()) 
select datediff(year,'1987-11-15',
getdate()) as age

select count(*) from dimaccount where accounttype is null