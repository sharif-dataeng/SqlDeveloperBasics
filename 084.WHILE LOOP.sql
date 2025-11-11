
DECLARE @x int = 0


WHILE @x < 100 --loop will run until the condition is true
	BEGIN
		SET @x = @x + 1
		print(@x)
	END

----------------------------------
DECLARE @x int = 0


WHILE @x < 10 --loop will run until the condition is true
	BEGIN
		SET @x = @x + 1
		IF @x < 6 
			print(@x)
		ELSE
			print('loop is running')
	END

----------------------------

DECLARE @x int = 0


WHILE @x < 10 --loop will run until the condition is true
	BEGIN
		SET @x = @x + 1
		IF @x < 6 
			print(@x)
		ELSE
			BREAK
			
	END