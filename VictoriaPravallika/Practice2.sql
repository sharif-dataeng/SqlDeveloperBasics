-- use VDB;
-- GO
-- BEGIN 
-- create table employees (
--     employee_id INT PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     email VARCHAR(100),
--     hire_date DATE


-- );

-- END;

-- use VDB;
-- GO
-- BEGIN  
-- INSERT INTO employees
--  (employee_id, first_name, last_name, email, hire_date)
-- VALUES
--  (1, 'John', 'Doe', 'john.doe@example.com', '2020-01-15'),
--  (2, 'Jane', 'Smith', 'jane.smith@example.com', '2020-02-20'),
--  (3, 'Michael', 'Johnson', 'michael.johnson@example.com', 
--  '2020-03-10');
-- END;

-- SELECT * FROM employees;

use VDB;
GO
BEGIN  
CREATE TABLE