-- Create a new table with cleaned text columns
CREATE TABLE "Testing_Products_Cleaned" AS
SELECT
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
    "Products";   -- Table name with capital P, must be quoted