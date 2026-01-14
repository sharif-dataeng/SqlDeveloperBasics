select 
productkey, 
count(1) productkey_count,
sum(SalesAmount) tot_sal,
min(SalesAmount) min_sal_amount,
max(SalesAmount) max_sal_amount
from FactInternetSales 
group by productkey
order by productkey_count desc

select * from students 

select * INTO Male_students from students where sex = 'M'

select * from Male_students

select * from female_students