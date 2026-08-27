    -- Create a new table with cleaned text columns, remove duplicates, and merge location
CREATE TABLE "Testing_Sales_Cleaned" AS
SELECT DISTINCT ON (invoice_id)
    sale_id,
    invoice_id,
    sale_date,
    customer_id,
    product_id,
    quantity,
    unit_price,
    total_price,
    TRIM(INITCAP(COALESCE(store_location, 'Online'))) AS location,  -- Merged column
    TRIM(INITCAP(payment_method)) AS payment_method
FROM
    "Sales"
ORDER BY
    invoice_id,          -- Required for DISTINCT ON
    sale_id;             -- Keeps the row with the smallest sale_id per invoice_id