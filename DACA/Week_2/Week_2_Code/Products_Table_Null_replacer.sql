UPDATE "Testing_Products_Cleaned"
SET
    product_name = COALESCE(product_name, 'Unknown'),
    category = COALESCE(category, 'Uncategorized'),
    subcategory = COALESCE(subcategory, 'Unspecified'),
    supplier = COALESCE(supplier, 'Unknown supplier'),
    cost_price = COALESCE(cost_price, 0),
    retail_price = COALESCE(retail_price, 0),
    eco_certified = COALESCE(eco_certified, false)
-- optionally add a WHERE clause to update only rows that have at least one NULL
WHERE
    product_name IS NULL OR category IS NULL OR subcategory IS NULL OR
    supplier IS NULL OR cost_price IS NULL OR retail_price IS NULL OR
    eco_certified IS NULL OR created_at IS NULL;