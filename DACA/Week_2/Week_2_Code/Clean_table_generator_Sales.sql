-- Create a new table with cleaned text columns
CREATE TABLE "Testing_Sales_Cleaned" AS
SELECT
    sale_id,
    invoice_id,
    sale_date,
    customer_id,
    product_id,
    quantity,
    unit_price,
    total_price,
    TRIM(INITCAP(channel)) AS channel,
    TRIM(INITCAP(store_location)) AS store_location,
    TRIM(INITCAP(payment_method)) AS payment_method
FROM
    "Sales";   -- Table name with capital letter, must be quoted