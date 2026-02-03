select * from sourcetable
select * from targettable

alter table targettable  add modified_date datetime

insert into sourcetable values(7,'rajuaro','rao@gmail.com','warangal')



MERGE INTO TargetTable AS T
USING SourceTable AS S
ON T.CustomerID = S.CustomerID
WHEN MATCHED  and S.city <> t.city THEN
    UPDATE SET T.CustomerName = S.CustomerName,
               T.Email = S.Email,
               T.City = S.City,
			   T.modified_date = getdate()
WHEN NOT MATCHED BY TARGET THEN
    INSERT (CustomerID, CustomerName, Email, City)
    VALUES (S.CustomerID, S.CustomerName, S.Email, S.City)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;


	insert into sourcetable(customerid,customername,email,city) values(99,'somesh','soma@gmail.com','warangal')


	update sourcetable set city = 'huzurabad' where customerid=3

	update sourcetable set city ='dubai' where customerid=4


	insert into sourcetable(customerid,customername,email,city)values(100,'maheshbabu','mahesh@gmail.com','hyderabad')

	delete from sourcetable where customerid = 3