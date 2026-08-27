SELECT
    c.city AS linn,
    s.location AS müügikanal,
    COUNT(DISTINCT c.customer_id) AS kliente,
    SUM(s.total_price) AS kogumüük
FROM
    "Testing_Sales_Cleaned" AS s
INNER JOIN
    "Testing_Customers_Cleaned" AS c
    ON s.customer_id = c.customer_id
GROUP BY
    c.city,
    s.location
ORDER BY
    c.city,
    s.location;