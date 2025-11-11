
DECLARE @x int --declare a variable

SET @x = 100 --set the value of variable

SELECT @x --fetch the value of variable

-----------------------------
DECLARE @x int
DECLARE @y varchar(10)

SET @x = 100
SET @y = 'HELLO'

SELECT @x
SELECT @y


---------------------------------

DECLARE @x int, @y varchar(10)

SELECT @x = 100 , @y = 'HELLO'

SELECT @x,@y

------------------------------

DECLARE @x int

SET @x = 100

SET @x = 200

SELECT @x

---------------------------------
DECLARE @x int = 100

SET @x = 200

SELECT @x