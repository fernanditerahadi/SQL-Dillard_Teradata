-- No. 6. What is the city and state of the store that had the greatest increase in average
--        daily revenue from November to December?

SELECT SM.city, SM.state, SM.store, A.AvgDailyRevChange

  FROM

    (SELECT DISTINCT store,

    SUM(CASE WHEN EXTRACT(MONTH FROM saledate)= 11 THEN amt END) AS NovSales,
    SUM(CASE WHEN EXTRACT(MONTH FROM saledate)= 12 THEN amt END) AS DecSales,

    COUNT(DISTINCT CASE WHEN EXTRACT(MONTH FROM saledate)= 11 THEN saledate END) AS NovNumOfSalesDay,
    COUNT(DISTINCT CASE WHEN EXTRACT(MONTH FROM saledate)= 12 THEN saledate END) AS DecNumOfSalesDay,

    NovSales/NovNumOfSalesDay AS NovAvgDailyRev,
    DecSales/DecNumOfSalesDay AS DecAvgDailyRev,
    DecAvgDailyRev - NovAvgDailyRev AS AvgDailyRevChange,

    CASE WHEN (EXTRACT(YEAR FROM saledate) = 2005 AND EXTRACT(MONTH FROM saledate) = 8) THEN 'YES'
      ELSE 'NO'
      END AS Exclusion

    FROM trnsact
    WHERE stype = 'p' AND Exclusion = 'NO'
    Having NovNumOfSalesDay >= 20 AND DecNumOfSalesDay >= 20
    GROUP BY store, Exclusion) AS A

  JOIN store_msa SM
  ON A.store = SM.store

GROUP BY SM.city, SM.state, SM.store, A.AvgDailyRevChange
ORDER BY A.AvgDailyRevChange DESC;

-- Answer:
-- City : Metairie , State : LA, Store : 8402, AvgDailyRevChange : 41423.30
