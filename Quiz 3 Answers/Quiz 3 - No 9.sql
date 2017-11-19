-- No. 9.Divide stores up so that stores with msa population between 1 and 100,000 are labeled
--       ‘very small’, stores with msa populations between 100,001 and 200,000 are labeled ‘small’,
--        stores with msa populations between 200,001 and 500,000 are labeled ‘med_small’, stores with
--        msa populations between 500,001 and 1,000,000 are labeled ‘med_large’, stores with msa
--        populations between 1,000,001, and 5,000,000 are labeled ‘large’, and stores with msa
--        populations greater than 5,000,000 are labeled ‘very large’. What is the average daily
--        revenue for a store in a ‘very large’ population msa?

SELECT
  CASE WHEN msa_pop >= 1 AND msa_pop <= 100000 THEN 'very small'
    WHEN msa_pop >= 100001 AND msa_pop <= 200000 THEN 'small'
    WHEN msa_pop >= 200001 AND msa_pop <= 500000 THEN 'med small'
    WHEN msa_pop >= 500001 AND msa_pop <= 1000000 THEN 'med large'
    WHEN msa_pop >= 1000001 AND msa_pop <= 5000000 THEN 'large'
    WHEN msa_pop >= 5000001 THEN 'very large'
    END AS MsaPopulationClass,
  SUM(A.TotalRevenue)/SUM(A.NumOfSalesDay) AS AvgDailyRevenue

  FROM store_msa JOIN (SELECT DISTINCT store,
                      EXTRACT(YEAR FROM saledate) AS Y3ar,
                      EXTRACT(MONTH FROM saledate) AS M0nth,
                      SUM(amt) AS TotalRevenue,
                      COUNT(DISTINCT saledate) AS NumOfSalesDay,
                      CASE WHEN EXTRACT(YEAR FROM saledate)=2005 AND EXTRACT(MONTH FROM saledate)=8 THEN 'YES'
                        ELSE 'NO'
                        END AS Exclusion

                      FROM trnsact

                      WHERE stype = 'p' AND Exclusion = 'No'
                      GROUP BY store, Y3ar, M0nth, Exclusion
                      HAVING NumOfSalesDay >= 20) AS A

  ON store_msa.store = A.store

GROUP BY MsaPopulationClass
ORDER BY AvgDailyRevenue DESC;

-- Answer:
-- MsaPopulationClass : Very Large, AvgDailyRevenue : 25451.53
