-- ============================================================
-- SALES TOTALS PER CATEGORY PER INTERVAL (ALL LOCATIONS COMBINED)
-- WITH CATEGORY FILTER (LIST) AND MIN CATEGORY VALUE FILTER
--
-- PERCENTAGES ARE CALCULATED AGAINST THE GRAND TOTAL
-- (ALL CATEGORIES, ALL LOCATIONS) FOR THAT INTERVAL.
--
-- Modify the parameters below:
--   start_date          : first day of the period
--   end_date            : last day of the period
--   interval_unit       : 'day', 'week', 'month', 'quarter', 'year'
--   selected_categories : array of category names – use ARRAY[]::text[] for all
--   min_category_value  : exclude categories with total sales < this (over the whole period)
-- ============================================================

WITH params AS (
    SELECT
        '2023-01-01'::date            AS start_date,
        '2023-12-31'::date            AS end_date,
        'month'::text                 AS interval_unit,
        ARRAY['Aksessuaarid']::text[]  AS selected_categories, -- change or use ARRAY[]::text[] for all
        1000::numeric                 AS min_category_value
),

-- 1. All sales (no category filter) – used for grand totals
sales_all AS (
    SELECT
        s.sale_id,
        s.sale_date,
        s.total_price,
        p.category
    FROM "Testing_Sales_Cleaned" s
    JOIN "Testing_Products_Cleaned" p ON s.product_id = p.product_id
    CROSS JOIN params prm
    WHERE s.sale_date BETWEEN prm.start_date AND prm.end_date
),

-- 2. Filtered sales (only selected categories) – for the actual rows we display
sales_filtered AS (
    SELECT *
    FROM sales_all
    CROSS JOIN params prm
    WHERE (array_length(prm.selected_categories, 1) IS NULL
           OR category = ANY(prm.selected_categories))
),

-- 3. Grand totals per interval (ALL categories, ALL locations)
grand_interval_totals AS (
    SELECT
        date_trunc((SELECT interval_unit FROM params), sale_date) AS interval_start,
        COUNT(*)      AS grand_total_sales_count,
        SUM(total_price) AS grand_total_sales_value
    FROM sales_all
    GROUP BY interval_start
),

-- 4. Aggregated data for the filtered categories (by interval, category) – summing over all locations
aggregated_filtered AS (
    SELECT
        date_trunc((SELECT interval_unit FROM params), sale_date) AS interval_start,
        category,
        COUNT(*)                    AS sales_count,
        SUM(total_price)            AS total_sales_value
    FROM sales_filtered
    GROUP BY interval_start, category
),

-- 5. Category totals over the whole period – for the min value filter
category_period_totals AS (
    SELECT
        category,
        SUM(total_sales_value) AS total_category_value
    FROM aggregated_filtered
    GROUP BY category
),

-- 6. Final join – compute grand‑total percentages
final_data AS (
    SELECT
        af.interval_start,
        af.category,
        af.sales_count,
        af.total_sales_value,
        -- Percentage of grand total sales count (all categories, all locations) in this interval
        ROUND(100.0 * af.sales_count / NULLIF(git.grand_total_sales_count, 0), 2) AS sales_count_pct_of_grand_total,
        -- Percentage of grand total sales value (all categories, all locations) in this interval
        ROUND(100.0 * af.total_sales_value / NULLIF(git.grand_total_sales_value, 0), 2) AS sales_value_pct_of_grand_total
    FROM aggregated_filtered af
    JOIN grand_interval_totals git ON af.interval_start = git.interval_start
    JOIN category_period_totals cpt ON af.category = cpt.category
    CROSS JOIN params p
    WHERE cpt.total_category_value >= p.min_category_value   -- exclude low‑total categories
)

-- Final output – 5 columns
SELECT
    interval_start,
    category,
    sales_count,
    total_sales_value,
    sales_count_pct_of_grand_total,
    sales_value_pct_of_grand_total
FROM final_data
ORDER BY interval_start, category;