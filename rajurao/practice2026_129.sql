select *  from dbo.students
insert into students values('900','somesh','computer science',45,'fail')
 select rollno,name,branch from students where division= 'first class' group by rollno,branch,name

 select branch,max(marks) as maxmarks from students group by branch

select name,branch,division from students where division='fail'

select rollno,name,branch,division from Students where division='second class' 