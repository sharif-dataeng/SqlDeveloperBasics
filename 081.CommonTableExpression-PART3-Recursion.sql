

WITH CteNumbers(n)
AS
(
	SELECT 1 as nums
	UNION ALL
	SELECT n + 1 FROM CteNumbers
	WHERE n < 10
)SELECT * FROM CteNumbers



WITH CteNumbers(n)
AS
(
	SELECT 1 as nums
	UNION ALL
	SELECT n + 2 FROM CteNumbers
	WHERE n < 10
)SELECT * FROM CteNumbers


WITH CteNumbers(n)
AS
(
	SELECT 2 as nums
	UNION ALL
	SELECT n + 2 FROM CteNumbers
	WHERE n < 10
)SELECT * FROM CteNumbers

WITH CteNumbers(n)
AS
(
	SELECT 1 as nums
	UNION ALL
	SELECT n +1 FROM CteNumbers
	WHERE n < 10
)SELECT * FROM CteNumbers
--OPTION (MAXRECURSION 32768)