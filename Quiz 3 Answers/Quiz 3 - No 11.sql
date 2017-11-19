-- No. 11.Which department in which store had the greatest decrease in average daily sales revenue
--        from August to September, and what city and state was that store located in?
SELECT d.deptdesc, str.store, str.state, str.city,

  SUM(CASE WHEN EXTRACT(MONTH FROM t.saledate) = 8 THEN t.amt END) AS AugSales,
  SUM(CASE WHEN EXTRACT(MONTH FROM t.saledate) = 9 THEN t.amt END) AS SepSales,

  COUNT(DISTINCT CASE WHEN EXTRACT(MONTH FROM t.saledate) = 8 THEN t.saledate END) AS AugNumOfSalesDay,
  COUNT(DISTINCT CASE WHEN EXTRACT(MONTH FROM t.saledate) = 9 THEN t.saledate END) AS SepNumOfSalesDay,

  ((SepSales / SepNumOfSalesDay) - (AugSales / AugNumOfSalesDay)) AS SalesChange,

  CASE WHEN EXTRACT(YEAR FROM t.saledate)=2005 AND EXTRACT(MONTH FROM t.saledate)=8 THEN 'YES'
    ELSE 'NO'
    END AS Exclusion

FROM trnsact t

  JOIN strinfo str ON t.store=str.store
  JOIN skuinfo sku ON t.sku = ski.sku
  JOIN deptinfo d ON d.dept=ski.dept

WHERE t.type = 'p'AND Exclusion = 'NO'
GROUP BY d.deptdesc, str.store, str.state, str.city, Exclusion
HAVING AugSales >= 1000
  AND SepSales >= 1000
  AND AugNumOfSalesDay >= 20
  AND SepNumOfSalesDay >= 20
ORDER BY SalesChange ASC;

--Answer:
--Deptdesc : Clinique, Store : 9103, State : KY, City : Louisville,
--Augsales : 306968.50, SepSales 73625.00, Sales Change : -7448.04
