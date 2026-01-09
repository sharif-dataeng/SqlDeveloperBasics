
SELECT AVG(TotalTransactions) FROM(
SELECT CustomerKey,COUNT(*) TotalTransactions FROM FactInternetSales
GROUP BY CustomerKey)T