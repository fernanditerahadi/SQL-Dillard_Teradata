-- No. 4. What vendor has the greatest number of distinct skus in the transaction
--        table that do not exists in the skstinfo table?

SELECT COUNT(DISTINCT trnsact.sku) AS NumOfSku, skuinfo.vendor
FROM trnsact LEFT JOIN skstinfo
ON trnsact.sku = skstinfo.sku AND trnsact.store = skstinfo.store
LEFT JOIN skuinfo
ON skuinfo.sku = trnsact.sku
WHERE skstinfo.sku IS NULL
GROUP BY skuinfo.vendor
ORDER BY NumOfSku DESC;

-- Answer:
-- NumOfSku : 28088 , Vendor : 5715232
