SELECT
    -- 1. TOTAL ROWS IN THE TABLE
    COUNT(*) AS total_customers,

    -- 2. MISSING EMAILS (Broken down)
    COUNT(*) FILTER (WHERE email IS NULL) AS null_email_count,
    COUNT(*) FILTER (WHERE email = '') AS empty_string_count,
    COUNT(*) FILTER (WHERE email IS NULL OR email = '') AS total_missing_emails,

    -- 3. VALID EMAILS (Non-null and non-empty)
    COUNT(*) FILTER (WHERE email IS NOT NULL AND email != '') AS total_valid_customers,

    -- 4. DISTINCT VALID EMAILS (How many unique real addresses exist)
    COUNT(DISTINCT email) FILTER (WHERE email IS NOT NULL AND email != '') AS distinct_valid_emails,

    -- 5. DUPLICATE EXTRAS (Your 130)
    COUNT(*) FILTER (WHERE email IS NOT NULL AND email != '') 
    - COUNT(DISTINCT email) FILTER (WHERE email IS NOT NULL AND email != '') AS valid_duplicate_extra_copies,

    -- 6. YOUR 511 FORMULA (Missing + Duplicate Extras)
    (COUNT(*) FILTER (WHERE email IS NULL OR email = '')) 
    + 
    (COUNT(*) FILTER (WHERE email IS NOT NULL AND email != '') 
    - COUNT(DISTINCT email) FILTER (WHERE email IS NOT NULL AND email != '')) AS total_problematic_rows

FROM "Testing_Customers";