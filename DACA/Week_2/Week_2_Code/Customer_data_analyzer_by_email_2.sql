SELECT
    COUNT(*) AS total_customers, -- Value of total number of customers in table
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS null_email_count, -- Value of total number of customers with null email
    SUM(CASE WHEN email = '' THEN 1 ELSE 0 END) AS empty_string_count, -- Value of total number of customers with empty string email
    SUM(CASE WHEN email IS NULL OR email = '' THEN 1 ELSE 0 END) AS total_missing_emails, -- Value of total number of customers with missing emails
    SUM(CASE WHEN email IS NOT NULL AND email != '' THEN 1 ELSE 0 END) AS total_valid_customers, -- Value of total number of customers with valid emails
    COUNT(DISTINCT CASE WHEN email IS NOT NULL AND email != '' THEN email END) AS distinct_valid_emails, -- Value of total number of unique valid emails
    SUM(CASE WHEN email IS NOT NULL AND email != '' THEN 1 ELSE 0 END) --Total number of customers with valid emails
    - COUNT(DISTINCT CASE WHEN email IS NOT NULL AND email != '' THEN email END) AS valid_duplicate_extra_copies, -- Value of all valid emails minus distinct valid emails = the number of duplicate EXTRA COPIES (the 2nd, 3rd, 4th... occurrences).
    (SUM(CASE WHEN email IS NULL OR email = '' THEN 1 ELSE 0 END)) --Value of total number of customers with missing emails
    + (SUM(CASE WHEN email IS NOT NULL AND email != '' THEN 1 ELSE 0 END) -- Total number of customers with valid emails
    - COUNT(DISTINCT CASE WHEN email IS NOT NULL AND email != '' THEN email END)) AS total_problematic_rows -- Value of total number of customers with missing emails plus total number of customers with valid emails minus distinct valid emails is value of all problematic rows.

FROM "Testing_Customers";