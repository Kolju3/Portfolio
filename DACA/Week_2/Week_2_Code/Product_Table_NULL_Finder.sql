-- 2) Count NULL values per column
SELECT
    'product_id' AS column_name,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS null_count,
    ROUND(100.0 * COUNT(*) FILTER (WHERE product_id IS NULL) / COUNT(*), 2) AS null_percent
FROM "Testing_Products_Cleaned"
UNION ALL
SELECT
    'product_name',
    COUNT(*) FILTER (WHERE product_name IS NULL),
    ROUND(100.0 * COUNT(*) FILTER (WHERE product_name IS NULL) / COUNT(*), 2)
FROM "Testing_Products_Cleaned"
UNION ALL
SELECT
    'category',
    COUNT(*) FILTER (WHERE category IS NULL),
    ROUND(100.0 * COUNT(*) FILTER (WHERE category IS NULL) / COUNT(*), 2)
FROM "Testing_Products_Cleaned"
UNION ALL
SELECT
    'subcategory',
    COUNT(*) FILTER (WHERE subcategory IS NULL),
    ROUND(100.0 * COUNT(*) FILTER (WHERE subcategory IS NULL) / COUNT(*), 2)
FROM "Testing_Products_Cleaned"
UNION ALL
SELECT
    'supplier',
    COUNT(*) FILTER (WHERE supplier IS NULL),
    ROUND(100.0 * COUNT(*) FILTER (WHERE supplier IS NULL) / COUNT(*), 2)
FROM "Testing_Products_Cleaned"
UNION ALL
SELECT
    'cost_price',
    COUNT(*) FILTER (WHERE cost_price IS NULL),
    ROUND(100.0 * COUNT(*) FILTER (WHERE cost_price IS NULL) / COUNT(*), 2)
FROM "Testing_Products_Cleaned"
UNION ALL
SELECT
    'retail_price',
    COUNT(*) FILTER (WHERE retail_price IS NULL),
    ROUND(100.0 * COUNT(*) FILTER (WHERE retail_price IS NULL) / COUNT(*), 2)
FROM "Testing_Products_Cleaned"
UNION ALL
SELECT
    'eco_certified',
    COUNT(*) FILTER (WHERE eco_certified IS NULL),
    ROUND(100.0 * COUNT(*) FILTER (WHERE eco_certified IS NULL) / COUNT(*), 2)
FROM "Testing_Products_Cleaned"
UNION ALL
SELECT
    'created_at',
    COUNT(*) FILTER (WHERE created_at IS NULL),
    ROUND(100.0 * COUNT(*) FILTER (WHERE created_at IS NULL) / COUNT(*), 2)
FROM "Testing_Products_Cleaned"
ORDER BY null_count DESC;