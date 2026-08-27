WITH numbered_customers AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY email 
            ORDER BY customer_id
        ) AS email_occurrence
    FROM "Testing_Customers"
)
SELECT *
FROM numbered_customers
WHERE email_occurrence > 1
ORDER BY email, customer_id;