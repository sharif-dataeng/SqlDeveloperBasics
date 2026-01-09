--DROP TABLE IF EXISTS CONTACTS


CREATE TABLE CONTACTS(
	Id int primary key,
	Person varchar(100),
	Email varchar(150)
)

INSERT INTO CONTACTS(ID,Person,Email) VALUES
(1,'Jack','jack123@gmail.com'),
(2,'Aman','Aman123@gmail.com'),
(3,'Joe','joth@gmail.com'),
(4,'Sam','Sam123@gmail.com'),
(5,'Jackson','jack123@gmail.com'),
(6,'Jonathan','joth@gmail.com')


SELECT * FROM CONTACTS

SELECT EMAIL,COUNT(*) Cnts FROM CONTACTS
GROUP BY EMAIL
HAVING COUNT(*)>1

SELECT EMAIL FROM(
SELECT EMAIL,COUNT(*) Cnts FROM CONTACTS
GROUP BY EMAIL
HAVING COUNT(*)>1)T

SELECT EMAIL FROM CONTACTS
GROUP BY EMAIL
HAVING COUNT(*)>1



WITH DuplicateEmails
AS
(
	SELECT EMAIL, ROW_NUMBER() OVER(PARTITION BY EMAIL ORDER BY ID) Cnt FROM CONTACTS
)
SELECT Email FROM DuplicateEmails
WHERE Cnt>1