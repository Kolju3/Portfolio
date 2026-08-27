-- Case‑sensitive table name must be double‑quoted.
-- Standardises supplier_name and country with TRIM + INITCAP.
-- Email is only TRIMmed (no INITCAP, as requested).
-- Duplicates are identified by the standardised supplier_name.
-- Keeps the row with the smallest supplier_id per duplicate group.
DROP TABLE IF EXISTS "Testing_Suppliers_Cleaned";

CREATE TABLE "Testing_Suppliers_Cleaned" AS
WITH
standardized AS (
    SELECT
        supplier_id,
        INITCAP(TRIM(supplier_name)) AS supplier_name,   -- standardise name
        TRIM(contact_email) AS contact_email,            -- trim whitespace only, keep case
        INITCAP(TRIM(country)) AS country,               -- standardise country
        payment_terms_days,
        lead_time_days,
        reliability_score
    FROM "Suppliers"
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY supplier_name   -- duplicates based on standardised name
            ORDER BY supplier_id ASC     -- keep the smallest supplier_id
        ) AS rn
    FROM standardized
)
SELECT
    supplier_id,
    supplier_name,
    contact_email,
    country,
    payment_terms_days,
    lead_time_days,
    reliability_score
FROM ranked
WHERE rn = 1;