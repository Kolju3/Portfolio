-- Case‑sensitive table name must be double‑quoted.
-- Standardises text fields (TRIM + INITCAP) and removes duplicates
-- based on (promo_name, start_date, end_date, category, discount_percent).
-- Keeps the row with the smallest promo_id for each duplicate group.
DROP TABLE IF EXISTS "Testing_Promotions_Cleaned";

CREATE TABLE "Testing_Promotions_Cleaned" AS
WITH
standardized AS (
    SELECT
        promo_id,
        INITCAP(TRIM(promo_name)) AS promo_name,
        product_id,
        INITCAP(TRIM(category)) AS category,
        discount_percent,
        start_date,
        end_date,
        INITCAP(TRIM(channel)) AS channel
    FROM "Promotions"
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY
                promo_name,
                start_date,
                end_date,
                category,
                discount_percent
            ORDER BY promo_id ASC   -- keep the smallest promo_id
        ) AS rn
    FROM standardized
)
SELECT
    promo_id,
    promo_name,
    product_id,
    category,
    discount_percent,
    start_date,
    end_date,
    channel
FROM ranked
WHERE rn = 1;