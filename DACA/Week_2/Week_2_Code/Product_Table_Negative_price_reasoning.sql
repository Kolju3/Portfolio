SELECT
    product_id,
    product_name,
    CASE WHEN created_at > CURRENT_DATE THEN 'Future date' END AS issue_1,
    CASE WHEN cost_price < 0 THEN 'Negative cost' END AS issue_2,
    CASE WHEN retail_price < 0 THEN 'Negative retail' END AS issue_3,
    CASE WHEN retail_price < cost_price THEN 'Retail below cost' END AS issue_4,
    created_at,
    cost_price,
    retail_price
FROM "Testing_Products_Cleaned"
WHERE
    created_at > CURRENT_DATE
    OR cost_price < 0
    OR retail_price < 0
    OR retail_price < cost_price;