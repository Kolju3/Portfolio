WITH duplicate_groups AS (
    -- Step 1: Find every partition (name + birth_year) that has multiple customers
    SELECT
        first_name_clean,
        last_name_clean,
        birth_year,
        COUNT(*) AS group_size
    FROM "Testing_Customers_Cleaned"
    GROUP BY first_name_clean, last_name_clean, birth_year
    HAVING COUNT(*) >= 2  -- Only partitions with 2 or more customers
)
-- Step 2: Count the partitions and sum up all the customers inside them
SELECT
    COUNT(*) AS number_of_duplicate_partitions,          -- e.g., 128
    SUM(group_size) AS total_customers_in_these_partitions  -- e.g., 384 (if 128 groups avg size 3)
FROM duplicate_groups;