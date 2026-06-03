/*Create a new table called persons
with columns: id, person_name, birth_date and phone */

CREATE TABLE persons(
	id INT PRIMARY KEY,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL
)

SELECT * FROM persons

-- Add a new column called email to the persons table

ALTER TABLE persons
ADD
email VARCHAR(50) NOT NULL

--Remove the column phone from the persons table

ALTER TABLE persons
DROP COLUMN phone

--Delete the table from the database

DROP TABLE persons 

--Using INSERT INTO

INSERT INTO customers (id, first_name, country, score)
VALUES
    (6, 'Anna', 'USA', NULL),
    (7, 'Sam', NULL, 100)

SELECT * FROM customers

INSERT INTO customers
VALUES
    (8, 'Andrea', 'Germany', NULL)

INSERT INTO customers (id, first_name)
VALUES
    (9, 'Sahra')

--Copy data from 'customers' table into 'persons'

INSERT INTO persons (id, person_name, birth_date, phone)
SELECT
    id,
    first_name,
    NULL,
    'UNKNOWN'
FROM
customers;

SELECT * FROM persons;

--Using UPDATE
--Change the score of customer with ID 6 to 0

--Make sure updating only target row
SELECT * FROM customers
WHERE id = 6

UPDATE customers
SET
	score = 0
WHERE id = 6;

--Change the score of customer with ID 9 to 0 and update the country to UK

SELECT * FROM customers
WHERE id = 9

UPDATE customers
SET
	score = 0,
	country = 'UK'
WHERE id = 9

--Update all customers with a NULL score by setting their score to 0

SELECT * FROM customers
WHERE score IS NULL

UPDATE customers
SET 
	score = 0
WHERE score IS NULL

--Using DELETE 
--Delete all customers with a ID greater than 5

DELETE FROM customers
WHERE id > 5

--DELETE all data from the persons table

TRUNCATE TABLE persons