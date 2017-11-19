--No. 6. Compare the average daiily revenues of the stores with the highest median
--       msa_income and the lowest median msa_income. In what city and state were these stores,
--       and which store had a higher average daily revenue?

SELECT B.city, B.state, B.store, B.msa_income,
  SUM(A.TotalRevenue)/SUM(A.NumOfSalesDay) AS AvgDailyRevenues

  FROM (SELECT s.city, s.state, s.store, s.msa_income
        FROM store_msa s
        WHERE s.msa_income IN (SELECT MAX(s2.msa_income) FROM store_msa s2)
        OR s.msa_income IN (SELECT MIN(s3.msa_income) FROM store_msa s3)) AS B

  JOIN  (SELECT store,
          TRIM(EXTRACT(YEAR FROM saledate))||' '||TRIM(EXTRACT(MONTH FROM saledate)) AS YearMonth,
          SUM(amt) AS TotalRevenue,
          COUNT(DISTINCT saledate) AS NumOfSalesDay,
          CASE WHEN (EXTRACT(YEAR FROM saledate)=2005 AND EXTRACT(MONTH FROM saledate)=8) THEN 'YES'
            ELSE 'NO'
            END AS Exclusion
        FROM trnsact
        WHERE stype = 'p' AND Exclusion ='NO'
        GROUP BY YearMonth, store, Exclusion
        HAVING NumOfSalesDay >= 20) AS A

  ON B.store=A.store
GROUP BY B.city, B.state, B.store, B.msa_income;

--Answer:
--City          / State   / Store   / msa_income
--Spanish Fort  / AL      / 3902    / 17884.08
--McAllen       / TX      / 2707    / 56601.99
