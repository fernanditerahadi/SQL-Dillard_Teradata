-- No. 13. For each store, determine the month with the minimum average daily revenue.
--         For each of the twelve months of the year, count how many stores' minimum avreage
--         daily revenue was in that month. During which month(s) did over 100 stores have their
--         minimum average daily revenue

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
        SUM(amt) AS TotalRevenue,
        COUNT(DISTINCT saledate) AS NumOfSalesDay,
        TotalRevenue / NumOfSalesDay AS AvgDailyRevenue,
        ROW_NUMBER() OVER (PARTITION BY store ORDER BY AvgDailyRevenue DESC) AS MonthRank

      FROM trnsact

      WHERE stype = 'p' AND Exclusion = 'NO'
      GROUP BY store, Y3ar, M0nth
      HAVING NumOfSalesDay>=20 QUALIFY MonthRank=12) AS A

GROUP BY _MONTH_
ORDER BY _COUNT_ DESC;

-- Answer:
-- _MONTH_    / _COUNT_
-- August     /  120
-- January    /   73
-- September  /   72
-- October    /   21
-- November   /   14
-- March      /   10
-- April      /    4
-- May        /    3
-- February   /    1
-- June       /    1
