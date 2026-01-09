
DECLARE @x int

SET @x = 10

--SELECT IIF(@x = 10,1,0)

--IF @x = 100
--	SELECT 1  --true part
--ELSE 
--	SELECT 0   --false part


IF @x = 100
	BEGIN
		print(1)
		print('HI')
	END
ELSE 
	IF @x = 10
		BEGIN
			print(10)
			print(20)
		END
	ELSE 
		print(30)