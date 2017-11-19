-- No. 13. Write a query that determines the month in which each store had its maximum
--         number of sku units returned. During which month did thee greatest number of stores
--         have their maximum number of sku units returned

SELECT CASE WHEN A.M0nth = '1' THEN 'January'
            WHEN A.M0nth = '2' THEN 'February'
            WHEN A.M0nth = '3' THEN 'March'
            WHEN A.M0nth = '4' THEN 'April'
            WHEN A.M0nth = '5' THEN 'May'
            WHEN A.M0nth = '6' THEN 'June'
            WHEN A.M0nth = '7' THEN 'Jully'
            WHEN A.M0nth = '8' THEN 'August'
            WHEN A.M0nth = '9' THEN 'September'
            WHEN A.M0nth = '10' THEN 'October'
            WHEN A.M0nth = '11' THEN 'November'
            WHEN A.M0nth = '12' THEN 'December'
            END AS _MONTH_,
      COUNT(*) AS _COUNT_

      FROM

      (SELECT DISTINCT store,
        EXTRACT(YEAR FROM saledate) AS Y3ar,
        EXTRACT(MONTH FROM saledate) AS M0nth,
        CASE WHEN EXTRACT(YEAR FROM saledate)=2005 AND EXTRACT(MONTH FROM saledate)=8 THEN 'YES'
          ELSE 'NO'
          END AS Exclusion,
        SUM(quantity) AS TotalQuantity,
        COUNT(DISTINCT saledate) AS NumOfSalesDay,
        ROW_NUMBER() OVER (PARTITION BY store ORDER BY TotalQuantity DESC) AS MonthRank

      FROM trnsact

      WHERE stype = 'p' AND Exclusion = 'NO'
      GROUP BY store, Y3ar, M0nth
      HAVING NumOfSalesDay>=20 QUALIFY MonthRank=1) AS A

GROUP BY _MONTH_
ORDER BY _COUNT_;

-- Answer:
-- _MONTH_    / _COUNT_
-- December   /  295
-- March      /   10
-- July       /    9
-- February   /    9
-- January    /    2
-- August     /    2
-- November   /    1
