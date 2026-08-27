/*WITH numbered_customers AS (
    SELECT 
        customer_id,
        first_name,
        last_name,
        email,
        phone,
        city,
        registration_date,
        loyalty_tier,
        birth_year,
        ROW_NUMBER() OVER (
            PARTITION BY email 
            ORDER BY customer_id
        ) AS email_occurrence
    FROM "Testing_Customers"
)
SELECT 
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    city,
    registration_date,
    loyalty_tier,
    birth_year,
    email_occurrence,
    CASE 
        WHEN COUNT(*) OVER (PARTITION BY email) > 1 
        THEN 'Shared with others' 
        ELSE 'Unique' 
    END AS email_status
FROM numbered_customers
ORDER BY email, email_occurrence;
*/

WITH numbered_customers AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY email 
            ORDER BY customer_id
        ) AS email_occurrence
    FROM "Testing_Customers"
)
SELECT *,
    CASE 
        WHEN COUNT(*) OVER (PARTITION BY email) > 1 
        THEN 'Shared with others' 
        ELSE 'Unique' 
    END AS email_status
FROM numbered_customers
ORDER BY email, email_occurrence;

/* This SQL queries are designed to analyze customer data from the "Testing_Customers" table. 
They are identical only difference is that first one asks specific columns while other asks for all.
It identifies whether each customer's email address is unique or shared with others.*/