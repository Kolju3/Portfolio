CREATE TABLE "Testing_Products_Cleaned" AS
SELECT DISTINCT ON (product_name)
    product_id,
    TRIM(INITCAP(product_name)) AS product_name,
    TRIM(INITCAP(category)) AS category,
    TRIM(INITCAP(subcategory)) AS subcategory,
    TRIM(INITCAP(supplier)) AS supplier,
    cost_price,
    retail_price,
    eco_certified,
    created_at
FROM
    "Products"
ORDER BY
    product_name,          -- Required for DISTINCT ON
    product_id;            -- Picks the row with the smallest ID per name
