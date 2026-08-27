-- 3) Fix formatting issues in all text columns
UPDATE "Testing_Products_Cleaned"
SET
    product_name = TRIM(
        REGEXP_REPLACE(
            INITCAP(product_name),
            '\s+', ' ', 'g'   -- collapse multiple spaces into one
        )
    ),
    category = TRIM(
        REGEXP_REPLACE(
            INITCAP(category),
            '\s+', ' ', 'g'
        )
    ),
    subcategory = TRIM(
        REGEXP_REPLACE(
            INITCAP(subcategory),
            '\s+', ' ', 'g'
        )
    ),
    supplier = TRIM(
        REGEXP_REPLACE(
            INITCAP(supplier),
            '\s+', ' ', 'g'
        )
    )
    -- Optional: if you want to turn underscores into spaces before capitalising,
    -- replace INITCAP(column) with INITCAP(REPLACE(column, '_', ' '))
    -- Example for product_name:
    -- product_name = TRIM(REGEXP_REPLACE(INITCAP(REPLACE(product_name, '_', ' ')), '\s+', ' ', 'g'))
WHERE
    product_name IS NOT NULL OR
    category IS NOT NULL OR
    subcategory IS NOT NULL OR
    supplier IS NOT NULL;