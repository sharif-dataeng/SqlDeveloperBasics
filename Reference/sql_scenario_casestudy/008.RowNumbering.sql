--DROP TABLE IF EXIST Countries
CREATE TABLE Countries(
	Country varchar(20)
)


INSERT INTO Countries(Country)VALUES
('India'),('UK'),('Germany'),('China'),('US')

SELECT * FROM Countries

SELECT COUNTRY, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) RowNum FROM Countries

SELECT COUNTRY, ROW_NUMBER() OVER(ORDER BY (SELECT 0)) RowNum FROM Countries

SELECT COUNTRY, ROW_NUMBER() OVER(ORDER BY (SELECT 10)) RowNum FROM Countries