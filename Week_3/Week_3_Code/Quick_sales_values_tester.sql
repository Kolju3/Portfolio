SELECT 
    COUNT(*) AS total_number_of_sales,
    COALESCE(SUM(total_price), 0) AS total_sales_value
FROM "Testing_Sales_Cleaned";