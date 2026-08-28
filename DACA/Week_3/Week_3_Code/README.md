# 💻 Week 3 – SQL JOINs & Advanced Analytics

[![SQL](https://img.shields.io/badge/SQL-JOINs-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_3-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **SQL JOIN and advanced analytics code** I wrote during Week 3 of the DACA programme. The focus of this week was to **combine data across multiple tables** using different types of JOINs and to perform more sophisticated analyses that require aggregating and grouping data from multiple sources.

The code demonstrates:
- Clean table generation with `DISTINCT ON` for duplicate removal
- `INNER JOIN` to combine sales, customer, and product data
- Advanced aggregations with `GROUP BY`, `ROLLUP`, and window functions
- CTEs (`WITH`) for complex, multi-step analyses
- Data quality checks across joined tables

---

## 📂 Files in This Folder

### Data Cleaning & Table Generation

| File | Description |
| :--- | :--- |
| **`Clean_table_generator_Customers.sql`** | Creates cleaned customer table with `TRIM()`, `INITCAP()`, and filters; adds indexes for performance |
| **`Clean_table_generator_Products.sql`** | Creates cleaned product table with standardised text columns (basic version) |
| **`Clean_table_generator_Products_Removes_duplicates.sql`** | Creates cleaned product table using `DISTINCT ON` to remove duplicate product names |
| **`Clean_table_generator_Sales.sql`** | Creates cleaned sales table with standardised text columns (basic version) |
| **`Clean_table_generator_Sales_Removes_duplicates.sql`** | Creates cleaned sales table using `DISTINCT ON` to remove duplicate `invoice_id` records |
| **`Clean_table_generator_Sales_Removes_duplicates_Merged_Columns.sql`** | Creates cleaned sales table with duplicate removal AND merged `location` column (`store_location` + "Online" for NULLs) |

---

### Data Exploration & Quality Checks

| File | Description |
| :--- | :--- |
| **`Channel_Counter.sql`** | Lists all unique sales channels and store locations |
| **`Quick_missingcustomer_id_tester.sql`** | Compares total sales vs sales with customers vs sales missing customer IDs |
| **`Quick_sales_values_tester.sql`** | Quick count and sum of all sales |

---

### JOIN-Based Analysis

| File | Description |
| :--- | :--- |
| **`Client_and_shoping_data_analyzer.sql`** | Basic `INNER JOIN` analysis – customer city + sales channel + revenue |
| **`Client_and_shoping_data_analyzer_ver2.sql`** | Advanced `INNER JOIN` with multiple tables and window functions – city, channel, category with percentage breakdowns |

---

### Advanced Aggregations

| File | Description |
| :--- | :--- |
| **`Sale_analyzer_1.sql`** | Uses `ROLLUP` to show sales by location with a grand total row |
| **`Sale_analyzer_2.sql`** | Multi-CTE approach with `UNION ALL` – individual location stats + grand total with percentages |

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
