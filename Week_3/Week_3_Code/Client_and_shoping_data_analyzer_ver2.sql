WITH aggregated AS (
    SELECT
        c.city,
        s.location AS channel,
        p.category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.total_price) AS total_revenue
    FROM
        "Testing_Sales_Cleaned" AS s
    INNER JOIN "Testing_Customers_Cleaned" AS c
        ON s.customer_id = c.customer_id
    INNER JOIN "Testing_Products_Cleaned" AS p
        ON s.product_id = p.product_id
    GROUP BY
        c.city,
        s.location,
        p.category
)
SELECT
    city,
    channel,
    category,
    total_quantity,
    COALESCE(
        ROUND(
            (total_quantity::numeric / NULLIF(SUM(total_quantity) OVER (PARTITION BY city, category), 0)) * 100,
            2
        ),
        0
    ) AS quantity_percentage,
    total_revenue,
    COALESCE(
        ROUND(
            (total_revenue::numeric / NULLIF(SUM(total_revenue) OVER (PARTITION BY city, category), 0)) * 100,
            2
        ),
        0
    ) AS revenue_percentage
FROM aggregated
ORDER BY city, channel, category;