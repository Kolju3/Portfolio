WITH 
-- This CTE calculates all the counts using window functions (very fast)
calculated_counts AS (
    SELECT
        customer_id,
        first_name_clean,
        last_name_clean,
        birth_year,
        email_clean,
        phone_clean,
        -- Total group size (same standardized name + birth year)
        COUNT(*) OVER (PARTITION BY first_name_clean, last_name_clean, birth_year) AS group_size,
        
        -- How many times does THIS EXACT EMAIL appear in this group?
        -- The FILTER ensures NULL/empty emails are ignored and NOT counted.
        COUNT(*) FILTER (WHERE email_clean IS NOT NULL AND email_clean != '') 
            OVER (PARTITION BY first_name_clean, last_name_clean, birth_year, email_clean) AS email_occurrences,
            
        -- How many times does THIS EXACT PHONE appear in this group?
        -- The FILTER ensures NULL/empty phones are ignored and NOT counted.
        COUNT(*) FILTER (WHERE phone_clean IS NOT NULL AND phone_clean != '') 
            OVER (PARTITION BY first_name_clean, last_name_clean, birth_year, phone_clean) AS phone_occurrences
    FROM "Testing_Customers_Cleaned"
),

-- This CTE adds the logical flags based on the counts
flagged_data AS (
    SELECT
        customer_id,
        first_name_clean,
        last_name_clean,
        birth_year,
        email_clean,
        phone_clean,
        group_size,
        -- Flag: This customer shares their email with at least ONE other person in the group?
        (email_occurrences > 1) AS matches_by_email,
        -- Flag: This customer shares their phone with at least ONE other person in the group?
        (phone_occurrences > 1) AS matches_by_phone,
        -- The three match-type columns combined into one descriptive column
        CASE 
            WHEN (email_occurrences > 1) AND (phone_occurrences > 1) THEN 'BOTH'
            WHEN (email_occurrences > 1) THEN 'EMAIL'
            WHEN (phone_occurrences > 1) THEN 'PHONE'
            ELSE 'NEITHER'
        END AS match_type
    FROM calculated_counts
    -- Only include customers that belong to a group of size 2 or more
    WHERE group_size >= 2
)

-- ONE SINGLE SELECT combining both lists using UNION ALL
SELECT 
    'CONFIRMED DUPLICATES' AS list_type,
    customer_id,
    first_name_clean,
    last_name_clean,
    birth_year,
    email_clean,
    phone_clean,
    group_size,
    match_type
FROM flagged_data
WHERE matches_by_email OR matches_by_phone

UNION ALL

SELECT 
    'POSSIBLE DUPLICATES' AS list_type,
    customer_id,
    first_name_clean,
    last_name_clean,
    birth_year,
    email_clean,
    phone_clean,
    group_size,
    match_type
FROM flagged_data
WHERE NOT (matches_by_email OR matches_by_phone)

ORDER BY group_size DESC, first_name_clean, last_name_clean, birth_year;
--ORDER BY list_type DESC, first_name_clean, last_name_clean, birth_year;