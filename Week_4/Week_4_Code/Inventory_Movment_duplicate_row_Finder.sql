-- Create a table that stores all rows from duplicate groups,
-- marking which one was kept and which were removed.
DROP TABLE IF EXISTS "duplicate_groups_audit";

CREATE TABLE "duplicate_groups_audit" AS
WITH
standardized AS (
    SELECT
        movement_id,
        product_id,
        INITCAP(TRIM(location)) AS location,
        movement_type,
        quantity,
        "timestamp",
        reference
    FROM "Inventory_Movements"
),
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
            ORDER BY movement_id ASC
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY
                product_id,
                location,
                movement_type,
                quantity,
                "timestamp"
        ) AS group_count
    FROM standardized
)
SELECT
    movement_id,
    product_id,
    location,
    movement_type,
    quantity,
    "timestamp",
    reference,
    group_count,
    CASE WHEN rn = 1 THEN 'KEPT' ELSE 'REMOVED' END AS status
FROM ranked
WHERE group_count > 1   -- only duplicate groups
ORDER BY
    product_id,
    location,
    movement_type,
    quantity,
    "timestamp",
    movement_id;