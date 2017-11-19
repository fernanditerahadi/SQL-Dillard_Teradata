--No. 2.Which sku had the greatest total sales during the combined summer months
--      of June, July, and August

SELECT sku, SUM(CASE WHEN EXTRACT(MONTH FROM saledate)=6 THEN amt
                      WHEN EXTRACT(MONTH FROM saledate)=7 THEN amt
                      WHEN EXTRACT(MONTH FROM saledate)=8 THEN amt
                      END) AS TotalSales

FROM trnsact
WHERE EXTRACT(MONTH FROM saledate) IN ('6','7','8') AND stype = 'p'
GROUP BY sku
ORDER BY TotalSales DESC;

--Answer:
-- SKU : 4108011 , TotalSales : 1646017.38
