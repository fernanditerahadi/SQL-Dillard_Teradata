--No. 7. What is the brand of the sku with the greatest standard deviation in
--       sprice? Only examine skus that have been part of over 100 transactions

SELECT s.sku, s.brand, A.Stdev
FROM (SELECT sku,
      STDDEV_SAMP(sprice) AS Stdev,
      SUM(quantity) AS NumOfTrans,
      CASE WHEN (EXTRACT(YEAR FROM saledate)=2005 AND EXTRACT(MONTH FROM saledate)=8) THEN 'YES'
        ELSE 'NO'
        END AS Exclusion
      FROM trnsact
      WHERE stype = 'p' AND Exclusion = 'NO'
      GROUP BY sku, Exclusion
      HAVING NumOfTrans > 100) AS A

JOIN skuinfo s ON A.sku=s.sku
GROUP BY s.brand, s.sku, A.Stdev
ORDER BY A.Stdev DESC;

--Answer:
--brand     /   SKU   /   Stdev
--Polo Fas  / 5453849 /   169.5   
--Polo Fas  / 5623849 /   164.4
-- . . .    / . . .   /   . . .
