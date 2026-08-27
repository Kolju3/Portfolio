-- Case‑sensitive table names must be double‑quoted in PostgreSQL.
-- This script cleans the Inventory_Movements table:
-- 1) Standardizes the 'location' column with INITCAP and TRIM.
-- 2) Removes duplicate orders, keeping only the row with the smallest movement_id
--    for each combination of (product_id, location, movement_type, quantity, timestamp).
-- 3) Creates a new table named "Testing_Inventory_Movments_Cleaned" (spelling as requested).

CREATE TABLE "Testing_Inventory_Movments_Cleaned" AS
WITH
-- Step 1: Apply INITCAP and TRIM to location
standardized AS (
    SELECT
        movement_id,
        product_id,
        INITCAP(TRIM(location)) AS location,   -- e.g. 'tartu' → 'Tartu', 'ladu' → 'Ladu'
        movement_type,
        quantity,
        "timestamp",                           -- timestamp is a reserved word, so quote it
        reference
    FROM "Inventory_Movements"
),

-- Step 2: Identify duplicates and keep the smallest movement_id per group
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY
                product_id,
                location,
                movement_type,
                quantity,
                "timestamp"
            ORDER BY movement_id ASC           -- keep the smallest movement_id
        ) AS rn
    FROM standardized
)

-- Step 3: Select only the first occurrence of each duplicate group
SELECT
    movement_id,
    product_id,
    location,
    movement_type,
    quantity,
    "timestamp",
    reference
FROM ranked
WHERE rn = 1;

-- Optional: Add a primary key or additional constraints if needed
-- ALTER TABLE "Testing_Inventory_Movments_Cleaned" ADD PRIMARY KEY (movement_id);