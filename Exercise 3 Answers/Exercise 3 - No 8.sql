--No. 8. Examine all the transactions for the sku with the greatest standard
--       deviation in sprice, but only consider skus that are part of more than
--       100 transactions. Do you think the original sale price was set to be too high?

SELECT s.sku, s.brand, t.orgprice,
  AVG(t.sprice) AS AvgSellingPrice,
  STDDEV_SAMP(t.sprice) AS Stdev,
  COUNT(t.saledate) AS NumOfTrans,
  CASE WHEN (EXTRACT(YEAR FROM saledate)=2005 AND EXTRACT(MONTH FROM saledate)=8) THEN 'YES'
    ELSE 'NO'
    END AS Exclusion
FROM skuinfo s JOIN trnsact t ON s.sku=t.sku
WHERE t.stype = 'p' AND Exclusion = 'No'
GROUP BY s.sku, s.brand, t.orgprice, Exclusion
HAVING NumOfTrans > 100
ORDER BY Stdev DESC, NumOfTrans DESC;

SELECT store, register, orgprice, sprice
FROM trnsact
WHERE sku = '5453849';

--Answer:
--STORE	/ REGISTER  /	ORGPRICE  /	SPRICE
--7303	/   530	    /   595	    /  148.75
--6002	/   750     /  	595	    /  297.5
--4804	/   820	    /   595     /  595
--. . . /   . . .	  /   . . .   /  . . .
--3704	/   750	    /   595     /  595
