/*
SELECT
    COUNT(*) AS total_sales_rows,
    SUM(total_price) AS total_sales_value
FROM "Testing_Sales_Cleaned";
*/

/*
SELECT
    COUNT(*) AS sales_with_customers,
    SUM(s.total_price) AS sales_value_with_customers
FROM "Testing_Sales_Cleaned" AS s
INNER JOIN "Testing_Customers_Cleaned" AS c
    ON s.customer_id = c.customer_id;
*/

SELECT
    COUNT(*) AS sales_missing_customer,
    SUM(total_price) AS missing_customer_value
FROM "Testing_Sales_Cleaned" AS s
LEFT JOIN "Testing_Customers_Cleaned" AS c
    ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;