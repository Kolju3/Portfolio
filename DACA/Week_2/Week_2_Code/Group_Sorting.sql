-- OVER example (Window Function)
SELECT 
    customer_id,
    first_name_clean, 
    last_name_clean,
    birth_year,
    COUNT(*) OVER (PARTITION BY first_name_clean, last_name_clean, birth_year) AS name_count
FROM "Testing_Customers_Cleaned"
ORDER BY name_count DESC;
/* Output: Every single row remains. 
If there are 3 Johns, you see all 3 rows, and every John row shows "3" in the name_count column. */