--No. 9. What was the average daily revenue Dillard's brought in during each month of the year?

SELECT A.YearMonth,
  A.TotalRevenue/A.NumOfSalesDay AS AvgDailyRevenues

  FROM (SELECT TRIM(EXTRACT(YEAR FROM saledate))||' '||TRIM(EXTRACT(MONTH FROM saledate)) AS YearMonth,
        SUM(amt) AS TotalRevenue,
        COUNT(DISTINCT saledate) AS NumOfSalesDay,
        CASE WHEN (EXTRACT(YEAR FROM saledate)=2005 AND EXTRACT(MONTH FROM saledate)=8) THEN 'YES'
          ELSE 'NO'
          END AS Exclusion
        FROM trnsact
        WHERE stype = 'p' AND Exclusion = 'NO'
        GROUP BY YearMonth, Exclusion
        HAVING NumOfSalesDay >= 20) AS A

GROUP BY A.YearMonth, AvgDailyRevenues
ORDER BY A.YearMonth ASC;

--Answer:
-- YearMonth      /       AvgDailyRevenues
-- 2004 10        /       6106357.90
-- 2004 11        /       6296913.50
-- 2004 12        /      11333356.01
-- 2004  8        /       5616841.37
-- 2004  9        /       5596588.02
--  . . .         /         . . .
-- 2005  7        /       7271088.69
