-- No. 3. Which sku number had the greatest increase in total sales revenue
--        from November to December?

SELECT A.sku, A.RevIncrease

  FROM

  (SELECT DISTINCT sku,
  SUM(CASE WHEN EXTRACT(MONTH FROM saledate) = 11 THEN amt) AS NovSales,
  SUM(CASE WHEN EXTRACT(MONTH FROM saledate) = 12 THEN amt) AS DecSales,
  DecSales/NovSales AS RevIncrease
  CASE WHEN EXTRACT(YEAR FROM saledate) = 2005 AND EXTRACT(MONTH FROM saledate) = 8 THEN 'YES'
    ELSE 'NO'
    END AS Exclusion
  FROM trnsact
  WHERE stype = 'p' AND Exclusion = 'No'
  HAVING COUNT(DISTINCT saledate) >= 20
  GROUP BY sku, Exclusion) AS A

  ORDER BY A.RevIncrease DESC;

-- Answer:
-- SKU : 3949538 , RevIncrease : 815080.21
