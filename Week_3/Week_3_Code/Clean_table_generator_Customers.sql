-- Drop the table if it already exists (to start fresh)
DROP TABLE IF EXISTS "Testing_Customers_Cleaned";

-- Create the cleaned table
CREATE TABLE "Testing_Customers_Cleaned" AS
SELECT
    customer_id,
    TRIM(INITCAP(first_name)) AS first_name,
    TRIM(INITCAP(last_name)) AS last_name,
    TRIM(email) AS email,
    TRIM(phone) AS phone,
    TRIM(INITCAP(city)) AS city,
    registration_date AS registration_date,
    TRIM(INITCAP(loyalty_tier)) AS loyalty_tier,
    birth_year
FROM "Customers"
WHERE first_name IS NOT NULL AND first_name != ''
  AND last_name IS NOT NULL AND last_name != ''
  AND birth_year IS NOT NULL;

-- Add indexes to speed up the duplicate detection query
CREATE INDEX idx_clean_name_birth ON "Testing_Customers_Cleaned" (first_name, last_name, birth_year);
CREATE INDEX idx_clean_email ON "Testing_Customers_Cleaned" (email);
CREATE INDEX idx_clean_phone ON "Testing_Customers_Cleaned" (phone);
/* This creates a new table called "Testing_Customers_Cleaned" that contains cleaned and standardized customer data. 
It trims whitespace, capitalizes names, and filters out records with missing or empty first names, last names, 
or birth years. Indexes are added to improve the performance of queries that will be run on this cleaned data. */