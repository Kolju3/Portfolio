-- ============================================================
-- CREATE TABLE: Monthly_Sales_Table
-- Stores the sales breakdown by interval, location, category
-- with all percentages (within‑location and grand‑total).
-- 
-- Modify the parameters below to change what data is stored.
-- ============================================================

DROP TABLE IF EXISTS "Monthly_Sales_Table";

CREATE TABLE "Monthly_Sales_Table" AS
WITH params AS (
    SELECT
        '2023-01-01'::date            AS start_date,
        '2026-06-28'::date            AS end_date,
        'month'::text                 AS interval_unit,
        ARRAY['Tallinn','Tartu','Online','Pärnu']::text[] AS selected_locations,
        ARRAY['Aksessuaarid','Jalanõusid','Meeste_riided','Laste_riided','Naiste_riided']::text[] AS selected_categories,
        0::numeric                     AS min_category_value,
        5::integer                     AS min_interval_sales_count,
        100::numeric                   AS min_interval_sales_value
),

-- 1. All sales (no category filter) – used for totals and percentages
sales_all AS (
    SELECT
        s.sale_id,
        s.sale_date,
        s.location,
        s.total_price,
        p.category
    FROM "Testing_Sales_Cleaned" s
    JOIN "Testing_Products_Cleaned" p ON s.product_id = p.product_id
    CROSS JOIN params prm
    WHERE s.sale_date BETWEEN prm.start_date AND prm.end_date
      AND (array_length(prm.selected_locations, 1) IS NULL
           OR s.location = ANY(prm.selected_locations))
),

-- 2. Filtered sales (only selected categories) – for the actual rows we display
sales_filtered AS (
    SELECT *
    FROM sales_all
    CROSS JOIN params prm
    WHERE (array_length(prm.selected_categories, 1) IS NULL
           OR category = ANY(prm.selected_categories))
),

-- 3. Totals per interval + location (ALL categories) – for within‑location percentages
interval_location_totals AS (
    SELECT
        date_trunc((SELECT interval_unit FROM params), sale_date) AS interval_start,
        location,
        COUNT(*)      AS total_interval_location_sales_count,
        SUM(total_price) AS total_interval_location_sales_value
    FROM sales_all
    GROUP BY interval_start, location
),

-- 4. Grand totals per interval (ALL categories, ALL locations) – for grand‑total percentages
grand_interval_totals AS (
    SELECT
        date_trunc((SELECT interval_unit FROM params), sale_date) AS interval_start,
        COUNT(*)      AS grand_total_sales_count,
        SUM(total_price) AS grand_total_sales_value
    FROM sales_all
    GROUP BY interval_start
),

-- 5. Aggregated data for the filtered categories (by interval, location, category)
--    with HAVING to filter out small groups per interval
aggregated_filtered AS (
    SELECT
        date_trunc((SELECT interval_unit FROM params), sale_date) AS interval_start,
        location,
        category,
        COUNT(*)                    AS sales_count,
        SUM(total_price)            AS total_sales_value
    FROM sales_filtered
    GROUP BY interval_start, location, category
    HAVING
        COUNT(*) >= (SELECT min_interval_sales_count FROM params)
        AND SUM(total_price) >= (SELECT min_interval_sales_value FROM params)
),

-- 6. Category totals over the whole period – for the min value filter
category_period_totals AS (
    SELECT
        category,
        SUM(total_sales_value) AS total_category_value
    FROM aggregated_filtered
    GROUP BY category
),

-- 7. Final join – compute all percentages
final_data AS (
    SELECT
        af.interval_start,
        af.location,
        af.category,
        af.sales_count,
        af.total_sales_value,
        ROUND(100.0 * af.sales_count / NULLIF(ilt.total_interval_location_sales_count, 0), 2) AS sales_count_pct_within_location,
        ROUND(100.0 * af.total_sales_value / NULLIF(ilt.total_interval_location_sales_value, 0), 2) AS sales_value_pct_within_location,
        ROUND(100.0 * af.sales_count / NULLIF(git.grand_total_sales_count, 0), 2) AS sales_count_pct_of_grand_total,
        ROUND(100.0 * af.total_sales_value / NULLIF(git.grand_total_sales_value, 0), 2) AS sales_value_pct_of_grand_total
    FROM aggregated_filtered af
    JOIN interval_location_totals ilt ON af.interval_start = ilt.interval_start AND af.location = ilt.location
    JOIN grand_interval_totals git ON af.interval_start = git.interval_start
    JOIN category_period_totals cpt ON af.category = cpt.category
    CROSS JOIN params p
    WHERE cpt.total_category_value >= p.min_category_value
)

-- Create the table
SELECT
    interval_start,
    location,
    category,
    sales_count,
    total_sales_value,
    sales_count_pct_within_location,
    sales_value_pct_within_location,
    sales_count_pct_of_grand_total,
    sales_value_pct_of_grand_total
FROM final_data
ORDER BY interval_start, location, category;