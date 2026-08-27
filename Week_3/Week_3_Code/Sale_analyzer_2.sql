WITH 
location_stats AS (
  SELECT
    location,
    COUNT(*) AS number_of_sales,
    SUM(total_price) AS total_sales_value
  FROM "Testing_Sales_Cleaned"
  GROUP BY location
),

/* 
Code created a CTE called location_stats it has three columns: location, number_of_sales, 
and total_sales_value. It aggregates the number of sales and total sales value for each location. 
*/

grand_totals AS (
  SELECT
    SUM(number_of_sales) AS grand_total_count,
    SUM(total_sales_value) AS grand_total_value
  FROM location_stats
),

/* 
Code created a CTE called grand_totals that calculates the overall total, it has two values, grand_total_count 
and grand_total_value, which represent the number of sales and total sales value across all locations. 
It uses first CTE as input and calculates the values from it. 
This data is later used to fill total row and to calculate percentages but not show in final output.
*/

unioned_data AS (
  -- First part: individual locations
  SELECT
    location AS sale_location,
    number_of_sales,
    ROUND(
      number_of_sales * 100.0 / NULLIF((SELECT grand_total_count FROM grand_totals), 0),
      2
    ) AS percentage_of_number_of_sales,
    total_sales_value,
    ROUND(
      total_sales_value * 100.0 / NULLIF((SELECT grand_total_value FROM grand_totals), 0),
      2
    ) AS percentage_of_total_sales_values
  FROM location_stats

/*
Code created third CTE called unioned_data. Inside calculations we see it uses first CTE as default input 
and calculates percentages of sale and sale values. It can calculate percentages because in 
NULLif statement we have grand totals from second CTE. 
*/

  UNION ALL
/* 
Here all the previous data is combined. It works like vertical join.
*/

  -- Second part: grand total row
  SELECT
    'Total' AS sale_location,
    (SELECT grand_total_count FROM grand_totals) AS number_of_sales,
    100.00 AS percentage_of_number_of_sales,
    (SELECT grand_total_value FROM grand_totals) AS total_sales_value,
    100.00 AS percentage_of_total_sales_values
)

/*
Here we have second part of unioned_data CTE. It creates a single row with the
grand totals for number of sales and total sales value from second CTE, 
and sets their percentages to 100.00, and sale_location as 'Total'.
*/

-- Apply ORDER BY to the outer SELECT, NOT directly to the UNION
SELECT *
FROM unioned_data
ORDER BY
  CASE WHEN sale_location = 'Total' THEN 0 ELSE 1 END,  -- Total row on top
  sale_location;                                        -- Other locations alphabetically

  /*
  Here it just selects the final output as unioned_data CTE and orders it following the logic that total 
  row is first and others come based on sale_location values alphabetically.     
  */