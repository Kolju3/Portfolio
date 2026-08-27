-- ============================================================
-- Sales report – modify the three values below as needed
-- ============================================================
WITH params AS (
    SELECT '2026-01-01'::date    AS start_date,   -- change period start
           '2026-12-31'::date    AS end_date,     -- change period end
           'month'::text         AS interval_unit -- 'day','week','month','quarter','year'
),
filtered AS (
    SELECT sale_id, total_price, sale_date
    FROM "Testing_Sales_Cleaned"
    WHERE sale_date BETWEEN (SELECT start_date FROM params)
                        AND (SELECT end_date   FROM params)
),
aggregated AS (
    SELECT date_trunc((SELECT interval_unit FROM params), sale_date) AS interval_start,
           COUNT(sale_id)          AS sales_count,
           SUM(total_price)        AS total_sales_value,
           AVG(total_price)        AS avg_sale_value
    FROM filtered
    GROUP BY interval_start
),
totals AS (
    SELECT SUM(sales_count)       AS total_sales_count,
           SUM(total_sales_value) AS total_sales_value
    FROM aggregated
)
SELECT a.interval_start,
       a.sales_count,
       ROUND(100.0 * a.sales_count      / t.total_sales_count, 2) AS sales_count_percent,
       a.total_sales_value,
       ROUND(100.0 * a.total_sales_value / t.total_sales_value, 2) AS total_sales_percent,
       ROUND(a.avg_sale_value, 2)                                   AS avg_sale_value
FROM aggregated a
CROSS JOIN totals t
ORDER BY a.interval_start;