WITH numbered_customers AS ( -- This greats a temporary table from the "Testing_Customers" table, adding a row number for each email occurrence
    SELECT 
        *,
        ROW_NUMBER() OVER ( --This creates a new column that will hold the row number for each email occurrence
            PARTITION BY email -- This tells the database to reset the row number for each unique email
            ORDER BY customer_id -- This orders the values in created column by customer_id
        ) AS email_occurrence -- This names the new column that will hold the row number for each email occurrence
    FROM "Testing_Customers" --This is the table that we are querying from
    WHERE email IS NOT NULL AND email != ''   -- <-- THIS EXCLUDES THE PROBLEM off NULL values and empty strings
) -- All that happens before this line is creating a temporary table called "numbered_customers" 
SELECT *
FROM numbered_customers -- This selects the new temporary table we created above
WHERE email_occurrence > 1 -- This filters the results to duplicates
ORDER BY email, customer_id; -- This order the fianl output by email and then customer_id

