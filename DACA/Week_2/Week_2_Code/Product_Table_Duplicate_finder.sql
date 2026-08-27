-- 1) Find duplicate products (based on name, category, subcategory, supplier)
WITH duplicate_groups AS (
    SELECT
        product_name,
        category,
        subcategory,
        supplier,
        COUNT(*) AS duplicate_count,
        ARRAY_AGG(product_id) AS duplicate_ids
    FROM "Testing_Products_Cleaned"
    GROUP BY product_name, category, subcategory, supplier
    HAVING COUNT(*) > 1
)
SELECT *
FROM duplicate_groups
ORDER BY duplicate_count DESC;