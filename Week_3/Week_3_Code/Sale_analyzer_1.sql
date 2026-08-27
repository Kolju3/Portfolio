SELECT
    COALESCE(location, 'Total') AS sale_location,
    COUNT(*) AS number_of_sales,
    SUM(total_price) AS total_sales_value
FROM "Testing_Sales_Cleaned"
GROUP BY ROLLUP(location)
ORDER BY
    CASE WHEN GROUPING(location) = 1 THEN 0 ELSE 1 END,  -- Total row first
    location;                                            -- Then shops alphabetically
