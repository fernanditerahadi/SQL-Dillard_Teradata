-- No. 10.Which department in which store had the greatest percent increase in average
--        daily sales revenue from November to December, and what city and state was that store
--        located in? Only examine departments whose total sales were at least $1,000 in Both
--        November and December

SELECT str.store, str.city, str.state, d.deptdesc,

  SUM(CASE WHEN EXTRACT(MONTH FROM t.saledate) = 11 THEN t.amt END) AS NovSales,
  SUM(CASE WHEN EXTRACT(MONTH FROM t.saledate) = 12 THEN t.amt END) AS DecSales,

  COUNT(DISTINCT CASE WHEN EXTRACT(MONTH FROM t.saledate) = 11 THEN t.saledate END) AS NovNumOfSalesDay,
  COUNT(DISTINCT CASE WHEN EXTRACT(MONTH FROM t.saledate) = 12 THEN t.saledate END) AS DecNumOfSalesDay,

  NovSales/NovNumOfSalesDay AS AvgNovDailySales,
  DecSales/DecNumOfSalesDay AS AvgDecDailySales,

  (AvgDecDailySales - AvgNovDailySales)/AvgNovDailySales * 100 AS PercentIncrease

FROM trnsact t

  JOIN strinfo str ON t.store=str.store
  JOIN skuinfo sku ON t.sku = ski.sku
  JOIN deptinfo d ON d.dept=ski.dept

WHERE t.type = 'p'
GROUP BY str.store, str.city, str.state, d.deptdesc
HAVING NovSales >= 1000
  AND DecSales >= 1000
  AND NovNumOfSalesDay >= 20
  AND DecNumOfSalesDay >= 20
ORDER BY PercentIncrease DESC;

--Answer:
--Store : 3403, City : Salina, State : Louisvl, NovSales : 1664.75, DecSales : 12170.25
--NovNumOfSalesDay : 20 , DecNumOfSalesDay : 21, AvgNovDailySales : 83.24, AvgDecDailySales : 579.54
--PercentIncrease : 596.23
