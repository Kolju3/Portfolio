# 💻 Week 4 – SQL Aggregation Code

[![SQL](https://img.shields.io/badge/SQL-Aggregation-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_4-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **SQL aggregation code** I wrote during Week 4 of the DACA programme. The focus of this week was to use `GROUP BY`, `HAVING`, CTEs, and window functions to transform raw sales data into business insights for UrbanStyle's CEO Kristi Tamm.

The code demonstrates:
- Monthly sales aggregation with `DATE_TRUNC()`
- Category-level performance analysis
- Year-over-year growth calculations
- CTE-based trend analysis with `LAG()` window functions
- Inventory movement cleaning and deduplication
- Promotions and suppliers data standardisation
- Advanced reporting with parameterised queries

---

## 📂 Files in This Folder

### Data Cleaning & Table Generation

| File | Description |
| :--- | :--- |
| **`Generating_Cleaned_Inventory_table.sql`** | Creates cleaned inventory table with standardised locations (`INITCAP` + `TRIM`) |
| **`Generating_Cleaned_Inventory_movment_table.sql`** | Creates cleaned inventory movements table with duplicate removal using `ROW_NUMBER()` |
| **`Generating_Cleaned_Promotions_table.sql`** | Creates cleaned promotions table with duplicate removal and text standardisation |
| **`Generating_Cleaned_Suppliers_table.sql`** | Creates cleaned suppliers table with duplicate removal based on standardised names |

---

### Inventory Movement Analysis

| File | Description |
| :--- | :--- |
| **`Inventory_Movment_duplicate_row_Finder.sql`** | Audit table showing which duplicate rows were kept vs removed |

---

### Sales Aggregation & Reporting

| File | Description |
| :--- | :--- |
| **`Periodic_sales_analyzer.sql`** | Basic sales report by interval with counts, values, averages, and percentages |
| **`Periodic_category_sales_analyzer.sql`** | Sales totals per category per interval with grand total percentages |
| **`Periodic_location_sales_analyzer.sql`** | Sales breakdown by interval, location, and category with within-location and grand-total percentages |
| **`Monthly_Sales_Table_Generator.sql`** | Comprehensive monthly sales table generator with full parameterisation (start/end date, interval unit, location/category filters, HAVING thresholds) |
| **`Generating_Cleaned_Inventory_movment_table.sql`** | Cleans inventory movements with location standardisation and duplicate removal |

---

## 🔍 Detailed Query Analysis

### 1. Basic Sales Aggregation

**File:** `Periodic_sales_analyzer.sql`

```sql
WITH params AS (
    SELECT '2026-01-01'::date    AS start_date,
           '2026-12-31'::date    AS end_date,
           'month'::text         AS interval_unit
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
       ROUND(100.0 * a.sales_count / t.total_sales_count, 2) AS sales_count_percent,
       a.total_sales_value,
       ROUND(100.0 * a.total_sales_value / t.total_sales_value, 2) AS total_sales_percent,
       ROUND(a.avg_sale_value, 2) AS avg_sale_value
FROM aggregated a
CROSS JOIN totals t
ORDER BY a.interval_start;
