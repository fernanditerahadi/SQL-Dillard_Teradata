--No. 4a. What is the average daily revenue for each store/month/year combination
--        in the database? Calculate this by dividing the total revenue for a group
--        by the number of sales day available in the transaction talbe for that group
SELECT store,
  EXTRACT(YEAR FROM saledate) AS Y3ar,
  EXTRACT(MONTH FROM saledate) AS M0nth,
  SUM(amt)/COUNT(DISTINCT saledate) AS AvgDailySales
FROM trnsact
WHERE stype = 'p'
GROUP BY Y3ar, M0nth, store
ORDER BY Y3ar DESC, M0nth DESC, store ASC;

--Answer:
--Y3ar    /   M0nth   /   Store   /   AvgDailySales
--2005    /   8       /   102     /   38702.02
--2005    /   8       /   103     /   34560.69
--2005    /   8       /   107     /   50219.28
--2005    /   8       /   202     /   15801.80
--2005    /   8       /   203     /   29793.10
--. . .   /  . . .    /  . . .    /   . . .
--2005    /   8       /   403     /   7968.73

--No. 4a. What is the average daily revenue for each store/month/year combination
--        in the database? Calculate this by dividing the total revenue for a group
--        by the number of sales day available in the transaction talbe for that group
--        ONLY EXAMINE PURCHASES (NOT RETURNS) . Exclude all stores with less than 20 days
--        of data. Exclude all data from August, 2005

SELECT A.YearMonth, A.store, A.AvgDailySales
FROM
  (SELECT store,
    TRIM(EXTRACT(YEAR FROM saledate))||' '||TRIM(EXTRACT(MONTH FROM saledate)) AS YearMonth,
    SUM(amt)/COUNT(DISTINCT saledate) AS AvgDailySales,
    CASE WHEN (EXTRACT(YEAR) FROM saledate)=2005 AND EXTRACT(MONTH FROM saledate)=8 THEN 'YES'
      ELSE 'NO'
      END AS Exclusion
  FROM trnsact
  WHERE stype='p' AND Exclusion ='NO'
  GROUP BY YearMonth, store, Exclusion
  HAVING NumOfSalesDay >= 20) AS A
GROUP BY A.YearMonth, A.store, A.AvgDailySales
ORDER BY A.YearMonth DESC, A.store ASC;

--Answer:
--YearMonth   /   Store   /   AvgDailySales
--2005 7      /   102     /   41782.52
--2005 7      /   103     /   31884.65
--2005 7      /   107     /   47897.81
--2005 7      /   202     /   18000.33
--2005 7      /   203     /   27579.03
--. . .       /   . . .   /   . . .
--2005 7      /   403     /   7636.45
