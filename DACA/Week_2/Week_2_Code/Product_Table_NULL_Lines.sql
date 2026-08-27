-- Show all rows that have any NULL in any column
SELECT *
FROM "Testing_Products_Cleaned"
WHERE
    product_id IS NULL
    OR product_name IS NULL
    OR category IS NULL
    OR subcategory IS NULL
    OR supplier IS NULL
    OR cost_price IS NULL
    OR retail_price IS NULL
    OR eco_certified IS NULL
    OR created_at IS NULL;