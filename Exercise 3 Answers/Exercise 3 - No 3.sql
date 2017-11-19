--No. 3. How many distinct dates are there in the saledate column of the transaction
--       table for each month/year/store combination in the database? Sort your
--       results by the number of days per combination in ascending order.

SELECT store,
  EXTRACT(YEAR FROM saledate) AS Y3ar,
  EXTRACT(MONTH FROM saledate) AS M0nth,
  COUNT(DISTINCT saledate) AS NumOfSalesDay
FROM trnsact
GROUP BY M0nth, Y3ar, store
ORDER BY NumOfSalesDay ASC;

--Answer:
--store     /   Y3ar    /   M0nth   /   NumOfSalesDay
--7604      /   2005    /     7     /       1
--8304      /   2005    /     3     /       1
--4402      /   2004    /     9     /       1
--9906      /   2004    /     8     /       1
--8304      /   2004    /     8     /       1
-- . . .    /   . . .   /    . . .  /      . . .
--1704      /   2005    /     4     /       21
