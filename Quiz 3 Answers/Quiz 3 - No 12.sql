-- No. 12. Identify which department, in which city and state of what store, had the greatest
--         decrease in number of item sold from August to September. How many fewer
--         items did that department sell in September compared to August

SELECT d.deptdesc, str.store, str.city, str.state,

  SUM(CASE WHEN(EXTRACT MONTH FROM t.saledate)=8 THEN t.amt END) AS AugQuantity,
  SUM(CASE WHEN(EXTRACT MONTH FROM t.saledate)=9 THEN t.amt END) AS SepQuantity,

  COUNT(DISTINCT CASE WHEN EXTRACT(MONTH FROM t.saledate)=8 THEN t.saledate END) AS AugNumOfSalesDay,
  COUNT(DISTINCT CASE WHEN EXTRACT(MONTH FROM t.saledate)=9 THEN t.saledate END) AS SepNumOfSalesDay,

  (SepQuantity - AugQuantity) AS QuantityChange,

  CASE WHEN EXTRACT(YEAR FROM t.saledate)=2005 AND EXTRACT(MONTH FROM t.saledate)=8 THEN 'YES'
    ELSE 'NO'
    END AS Exclusion

  FROM trnsact t

  JOIN strinfo str ON t.store=str.store
  JOIN skuinfo ski ON t.sku=ski.sku
  JOIN deptinfo d ON ski.dept=d.dept

WHERE t.stype='p' AND Exclusion='NO'
GROUP BY d.deptdesc, str.store, str.city, str.state, Exclusion
HAVING AugNumOfSalesDay>=20 AND SepNumOfSalesDay>=20
ORDER BY QuantityChange ASC;

--Answer:
--Deptdesc : Clinique, Store : 9103, State : KY, City : Louisville, AugQuantity : 17644
--SepQuantity : 4153, QuantityChange : -13491
