--No. 5. What is the average daily revenue brought in by Dillard’s stores in areas
--       of high, medium, or low levels of high school education?

SELECT CASE WHEN msa_high>= 50 AND msa_high <= 60 THEN 'low'
          WHEN msa_high > 60 AND msa_high <= 70 THEN 'medium'
          WHEN msa_high > 70 THEN 'high'
          END AS HSEducationLevel,
        SUM(A.TotalRevenue)/Sum(A.NumOfSalesDay) AS AverageRevenue
FROM store_msa s JOIN (SELECT store,
                      TRIM(EXTRACT(YEAR FROM saledate))||' '||TRIM(EXTRACT(MONTH FROM saledate)) AS YearMonth,
                      SUM(amt) AS TotalRevenue,
                      COUNT(DISTINCT saledate) AS NumOfSalesDay,
                      CASE WHEN (EXTRACT(YEAR) FROM saledate)=2005 AND EXTRACT(MONTH FROM saledate)=8 THEN 'YES'
                        ELSE 'NO'
                        END AS Exclusion
                      FROM trnsact
                      WHERE stype='p' AND Exclusion ='NO'
                      GROUP BY YearMonth, store, Exclusion
                      HAVING NumOfSalesDay >= 20) AS A

                ON s.store = A.store

GROUP BY HSEducationLevel;

--Answer:
--HSEducationLevel    /     AverageRevenue
--low                 /     34159.76
--Medium              /     25037.89
--High                /     20937.31
