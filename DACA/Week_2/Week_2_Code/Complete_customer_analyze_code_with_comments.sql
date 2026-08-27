WITH 
email_frequency AS (
    -- Count occurrences for every valid email
    SELECT
        email,
        COUNT(*) AS occurrence_count
    FROM "Testing_Customers"
    WHERE email IS NOT NULL AND email != ''
    GROUP BY email
),
/* this created first CTE from Testing_Customers, this CTE has only 2 columns, email and occurence_count.
email is just cleaned email from orginal table, and occurence_count is how many times this email appears in the orginal table,
and it is allready filtered by WHERE condition that removes NULL and empty emails. */

frequency_distribution AS (
    -- "Loop" over every distinct occurrence count (1, 2, 3, ...)
    SELECT
        occurrence_count,
        COUNT(*) AS number_of_distinct_emails,   -- e.g., 126 for freq=2, 2 for freq=3
        SUM(occurrence_count) AS total_customer_rows_in_group
    FROM email_frequency
    GROUP BY occurrence_count
),
/* this created second CTE from first CTE, this CTE has 3 columns, occurrence_count, number_of_distinct_emails and total_customer_rows_in_group
occurance_count is just the same as in first CTE, 
number_of_distinct_emails is how many distinct emails have this occurrence_count, 
and total_customer_rows_in_group is how many rows in Testing_Customers table are there for this occurrence_count. */

summary AS (
    -- Single‑row summary with all the totals you asked for
    SELECT
        (SELECT COUNT(*) FROM "Testing_Customers") AS total_customers,
        (SELECT COUNT(*) FROM "Testing_Customers" WHERE email IS NULL OR email = '') AS total_missing_emails,
        (SELECT COUNT(*) FROM email_frequency) AS number_of_distinct_emails, --This is distinct because group by removes duplicate rows.
        (SELECT SUM(number_of_distinct_emails) FROM frequency_distribution WHERE occurrence_count = 1) AS emails_once,
        (SELECT SUM(number_of_distinct_emails) FROM frequency_distribution WHERE occurrence_count >= 2) AS emails_multiple_times, -- ★ YOUR NEW 128 LINE
        (SELECT SUM(total_customer_rows_in_group) FROM frequency_distribution WHERE occurrence_count >= 2) AS rows_for_multiple_emails,
        (SELECT SUM(total_customer_rows_in_group - number_of_distinct_emails) FROM frequency_distribution WHERE occurrence_count >= 2) AS extra_duplicate_copies
)
/* this created third CTE from orginal table and and both previous CTEs. It has 7 columns, total_customers, total_missing_emails, distinct_valid_emails, emails_exactly_once, emails_multiple_times_total, rows_for_multiple_emails and extra_duplicate_copies
total_customers is how many rows are in Testing_Customers table, this is data from orginal table.
total_missing_emails is how many rows have NULL or empty email, this is data from orginal table.
number_of_distinct_emails is how many distinct emails are there in Testing_Customers table, because it is counted from first CTE, which is filtered by WHERE condition that removes NULL and empty emails.
emails_once is how many distinct emails appear exactly once in Testing_Customers table, because it filters it with where condition that occurrence_count = 1, and counts the number_of_distinct_emails from second CTE.
emails_multiple_times is how many distinct emails appear 2 or more times in Testing_Customers. IT is filtered with where condition that occurrence_count >= 2, and counts the number_of_distinct_emails from second CTE
rows_for_multiple_emails is how many rows in Testing_Customers table have emails that appear 2 or more times. It is filtered with where condition that occurrence_count >= 2, and sums the total_customer_rows_in_group from second CTE.
COMMENTED OUT extra_duplicate_copies is how many extra rows are there in Testing_Customers table for emails that appear 2 or more times. 
It is filtered with where condition that occurrence_count >= 2, and sums the total_customer_rows_in_group - number_of_distinct_emails from second CTE.
*/

-- Combine the full distribution with the summary (repeated on every row)
SELECT
    fd.occurrence_count,
    fd.number_of_distinct_emails,
    fd.total_customer_rows_in_group,
    s.total_customers,
    s.total_missing_emails,
    s.number_of_distinct_emails,
    s.emails_once,
    s.emails_multiple_times,   -- this is your 126 + 2 = 128
    s.rows_for_multiple_emails,
    s.extra_duplicate_copies
    --s.rows_for_multiple_emails - s.emails_multiple_times AS extra_duplicate_copies --inserted here because cleaner logic.
FROM frequency_distribution AS fd
CROSS JOIN summary AS s
ORDER BY fd.occurrence_count;

/* this is the final SELECT statement that combines the second CTE and third CTE. 
It selects all columns from both CTEs and orders the result by occurrence_count. 
The CROSS JOIN ensures that the summary data is repeated for each row in the frequency_distribution result set. */