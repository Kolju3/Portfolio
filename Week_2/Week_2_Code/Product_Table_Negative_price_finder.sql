-- Check for illogical values (future dates, negative prices, price inversion)
SELECT *
FROM "Testing_Products_Cleaned"
WHERE
    created_at > CURRENT_DATE                           -- future date
    /*
    OR cost_price <= 0                                   -- negative cost
    OR retail_price <=  0                                 -- negative retail
    OR retail_price < = cost_price;                       -- selling below cost (optional)
*/
    OR cost_price >= 1000                                   -- negative cost
    OR retail_price >=  1000                                 -- negative retail