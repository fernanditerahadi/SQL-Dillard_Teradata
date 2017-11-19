-- No. 8.Divide the msa_income groups up so that msa_incomes between 1 and 20,000 are
--      labeled 'low', msa_incomes between 20,001 and 30,000 are labeled 'med-low'
--      msa_incomes between 30,001 and 40,000 are 'med-high', and msa_incomes between
--      40,001 and 60,000 are labeled 'high'. Which of these groups has the highest
--      average daily revenue per store?

SELECT

  CASE WHEN SM.msa_incomes >= 1 AND SM.msa_incomes <= 20000 THEN 'low'
    WHEN SM.msa_incomes >= 20001 AND SM.msa_incomes <= 30000 THEN 'med-low'
    WHEN SM.msa_incomes >= 30001 AND SM.msa_incomes <= 40000 THEN 'med-high'
    WHEN SM.msa_incomes >= 40001 AND SM.msa_incomes <= 60000 THEN 'high'
    END AS MsaIncomeGroup
    SUM(A.Revenue)/SUM(A.NumOfSalesDay) AS AvgDailyRevenue

    FROM store_msa SM

    JOIN

      (SELECT DISTINCT store,
        SUM(amt) AS Revenue,
        COUNT (DISTINCT saledate) AS NumOfSalesDay,
        CASE WHEN EXTRACT(YEAR FROM saledate)= 2005 AND EXTRACT(MONTH FROM saledate)= 8 THEN 'YES'
          ELSE 'NO'
          END AS Exclusion

      FROM trnsact

      WHERE stype = 'p' AND Exclusion 'NO'
      GROUP BY store, Exclusion
      HAVING NumOfSalesDay >= 20) AS A

    ON SM.store = A.store

GROUP BY MsaIncomeGroup
ORDER BY AvgDailyRevenue DESC;

-- Answer :
-- MsaIncomeGroup : Low, AvgDailyRevenue : 34159.76
