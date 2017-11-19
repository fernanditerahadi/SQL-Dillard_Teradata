--No. 1. How many distinct dates are there in the saledate column of the
--       transaction table for each month/year combination in the database?

SELECT EXTRACT(YEAR FROM saledate) AS Y3ar,
  EXTRACT(MONTH FROM saledate) AS M0nth,
  COUNT(DISTINCT saledate) AS NumOfDays

FROM trnsact

GROUP BY M0nth, Y3ar
ORDER BY Y3ar DESC, M0nth DESC;

--Answer: 13
-- Y3ar / M0nth / NumOfDays
-- 2005 / 8     / 27
-- 2005 / 7     / 31
-- 2005 / 6     / 30
-- 2005 / 5     / 31
-- 2005 / 4     / 30
-- 2005 / 3     / 30
-- 2005 / 2     / 28
-- 2005 / 1     / 31
-- 2004 / 12    / 30
-- 2004 / 11    / 29
-- 2004 / 10    / 31
-- 2004 / 9     / 30
-- 2004 / 8     / 31
