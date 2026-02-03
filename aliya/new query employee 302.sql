create table empnew
(id int,
name varchar(50),
salary float,
email varchar(25)
);
insert into empnew values(1,'aliya',20000,'aliya@gmail.com')
insert into empnew values(2,'shravya',25000,'shravya@gmail.com')

select * from empnew;

update empnew set salary = 4000 where id=1 or id=2