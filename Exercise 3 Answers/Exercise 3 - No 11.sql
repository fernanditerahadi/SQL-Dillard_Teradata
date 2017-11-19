--No. 11. What is the city and state of the store that had the greatest decrease
--        in average daily sales revenue from August to September?

SELECT str.city, str.state, str.store,
  SUM(CASE WHEN EXTRACT(MONTH FROM t.saledate)=8 THEN t.amt END) AS AugSales,
  SUM(CASE WHEN EXTRACT(MONTH FROM t.saledate)=9 THEN t.amt END) AS SepSales,
  COUNT(DISTINCT (CASE WHEN EXTRACT(MONTH FROM t.saledate)=8 THEN t.saledate END)) AS AugSalesDay,
  COUNT(DISTINCT (CASE WHEN EXTRACT(MONTH FROM t.saledate)=9 THEN t.saledate END)) AS SepSalesDay,
  AugSales/AugSalesDay AS AugAvgDailySales,
  SepSales/SepSalesDay AS SepAvgDailySales,
  (SepAvgDailySales - AugAvgDailySales) AS ChangeInSales

FROM trnsact t
JOIN strinfo str ON str.store=t.store
WHERE t.stype = 'p' AND (TRIM(EXTRACT(YEAR FROM t.saledate))||TRIM(EXTRACT(MONTH FROM t.saledate)) <> 20058)
GROUP BY str.city, str.state, str.store
HAVING AugSalesDay >=20 AND SepSalesDay >= 20
ORDER BY ChangeInSales DESC;

--Answer:
-- City : West Des Moi, State : IA, Store : 4003, ChangeInSales : -6479.60
