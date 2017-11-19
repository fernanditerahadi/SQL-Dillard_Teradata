--No. 10. Which department, in which city and state of what store, had the greatest %
--        increase in average daily sales revenue from November to December?

SELECT str.city, str.state, str.store, di.deptdesc,
  SUM(CASE WHEN EXTRACT(MONTH FROM t.saledate)=11 THEN t.amt END) AS NovSales,
  SUM(CASE WHEN EXTRACT(MONTH FROM t.saledate)=12 THEN t.amt END) AS DecSales,
  COUNT(DISTINCT (CASE WHEN EXTRACT(MONTH FROM t.saledate)=11 THEN t.saledate END)) AS NovSalesDay,
  COUNT(DISTINCT (CASE WHEN EXTRACT(MONTH FROM t.saledate)=12 THEN t.saledate END)) AS DecSalesDay,
  NovSales/NovSalesDay AS NovAvgDailySales,
  DecSales/DecSalesDay AS DecAvgDailySales,
  ((DecAvgDailySales - NovAvgDailySales)/NovAvgDailySales*100) AS PercentChangeInSales

FROM trnsact t
JOIN strinfo str ON str.store=t.store
JOIN skuinfo ski ON ski.sku=t.sku
JOIN deptinfo di ON di.dept=ski.dept
WHERE t.stype = 'p' AND (TRIM(EXTRACT(YEAR FROM t.saledate))||TRIM(EXTRACT(MONTH FROM t.saledate)) <> 20058)
GROUP BY str.city, str.state, str.store, di.deptdesc
HAVING NovSalesDay >=20 AND DecSalesDay >= 20
ORDER BY PercentChangeInSales DESC;

--Answer:
-- City : Salina, State : KS, Store : 3403, Deptdesc : Louisvl, PercentChangeInSales : 596
