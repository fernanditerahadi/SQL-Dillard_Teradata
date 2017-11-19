--No. 12.a Determine the month of maximum total revenue for each store. Count the
--        number of stores which month of maximum total revenue was in each of the twelve months.

SELECT CASE WHEN A.M0nth = 1 Then 'January'
  WHEN A.M0nth = 2 Then 'February'
  WHEN A.M0nth = 3 Then 'March'
  WHEN A.M0nth = 4 Then 'April'
  WHEN A.M0nth = 5 Then 'May'
  WHEN A.M0nth = 6 Then 'June'
  WHEN A.M0nth = 7 Then 'July'
  WHEN A.M0nth = 8 Then 'August'
  WHEN A.M0nth = 9 Then 'September'
  WHEN A.M0nth = 10 Then 'October'
  WHEN A.M0nth = 11 Then 'November'
  WHEN A.M0nth = 12 Then 'December'
  END AS _Month_,
  COUNT(*) AS _Count_

  FROM (SELECT DISTINCT t.store,
        EXTRACT(YEAR FROM t.saledate) AS Y3ar,
        EXTRACT(MONTH FROM t.saledate) AS M0nth,
        CASE WHEN EXTRACT(YEAR FROM t.saledate)=2005 AND EXTRACT(MONTH FROM t.saledate)=8 THEN 'YES'
          ELSE 'NO'
          END AS Exclusion,
        SUM(t.amt) AS TotalRevenue,
        ROW_NUMBER() OVER (PARTITION BY t.store ORDER BY TotalRevenue DESC) AS MonthRank
        FROM trnsact t
        WHERE t.stype = 'p' AND Exclusion = 'NO'
        GROUP BY t.store, Y3ar, M0nth
        HAVING COUNT(DISTINCT t.saledate)>=20 QUALIFY MonthRank = 1) AS A

GROUP BY _Month_
ORDER BY _Month_;


--Answer:
-- _MONTH_      /     _Count_
--  December    /       321
--   July       /       3
--   March      /       3
--   September  /       1

--Exercise 12b. Determine the month of maximum average daily revenue for each store.
--              Count the number of stores which month of average daily revenue was in
--              each of the twelve months.

SELECT CASE WHEN A.M0nth = 1 Then 'January'
  WHEN A.M0nth = 2 Then 'February'
  WHEN A.M0nth = 3 Then 'March'
  WHEN A.M0nth = 4 Then 'April'
  WHEN A.M0nth = 5 Then 'May'
  WHEN A.M0nth = 6 Then 'June'
  WHEN A.M0nth = 7 Then 'July'
  WHEN A.M0nth = 8 Then 'August'
  WHEN A.M0nth = 9 Then 'September'
  WHEN A.M0nth = 10 Then 'October'
  WHEN A.M0nth = 11 Then 'November'
  WHEN A.M0nth = 12 Then 'December'
  END AS _Month_,
  COUNT(*) AS _Count_

  FROM (SELECT DISTINCT t.store,
        EXTRACT(YEAR FROM t.saledate) AS Y3ar,
        EXTRACT(MONTH FROM t.saledate) AS M0nth,
        CASE WHEN EXTRACT(YEAR FROM t.saledate)=2005 AND EXTRACT(MONTH FROM t.saledate)=8 THEN 'YES'
          ELSE 'NO'
          END AS Exclusion,
        SUM(t.amt) AS TotalRevenue,
        COUNT(DISTINCT t.saledate) AS NumOfSalesDay,
        TotalRevenue / NumOfSalesDay AS AvgDailyRevenue,
        ROW_NUMBER() OVER (PARTITION BY t.store ORDER BY AvgDailyRevenue DESC) AS MonthRank
        FROM trnsact t
        WHERE t.stype = 'p' AND Exclusion = 'NO'
        GROUP BY t.store, Y3ar, M0nth
        HAVING COUNT(DISTINCT t.saledate)>=20 QUALIFY MonthRank = 1) AS A

GROUP BY _Month_
ORDER BY _Month_;

--Answer:
-- _MONTH_      /     _Count_
--  December    /       321
--  February    /       2
--  July        /       3
--  March       /       4
--  May         /       1
--  September   /       1
