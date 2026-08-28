# 💻 Week 2 – SQL Data Cleaning & Duplicate Analysis

[![DACA](https://img.shields.io/badge/DACA-Week_2-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **SQL data cleaning and duplicate analysis code** I wrote during Week 2 of the DACA programme. The focus of this week was to **clean and standardise** the UrbanStyle database, identify duplicate records, and implement data quality improvements.

The code demonstrates:
- Creating safe "testing" copies of tables
- Standardising text data using `TRIM()`, `INITCAP()`, and `REGEXP_REPLACE()`
- Identifying duplicates using `ROW_NUMBER()`, `PARTITION BY`, and window functions
- Analysing duplicate patterns in customer, product, and sales data
- Handling NULL values with `COALESCE()` and `UPDATE` statements

---

## 📂 Files in This Folder

### Data Duplication (Creating Testing Copies)

| File | Description |
| :--- | :--- |
| **`Duplicate_the_data_tables.sql`** | Creates safe "Testing" copies of Products, Customers, and Sales tables for experimentation without affecting production data |

---

### Data Cleaning & Standardisation

| File | Description |
| :--- | :--- |
| **`Clean_table_generator_Customers.sql`** | Creates cleaned customer table with `TRIM()` and `INITCAP()`; filters out records with missing names or birth years; adds indexes |
| **`Clean_table_generator_Products.sql`** | Creates cleaned product table with standardised text columns |
| **`Clean_table_generator_Sales.sql`** | Creates cleaned sales table with standardised channel, store location, and payment method |
| **`NULL_cleaner.sql`** | Replaces NULL values in customer table with meaningful defaults using `COALESCE()` |
| **`Product_Table_Null_replacer.sql`** | Updates product table to replace NULL values with sensible defaults |
| **`Product_Table_formater.sql`** | Fixes formatting issues in product text columns using `INITCAP()`, `TRIM()`, and `REGEXP_REPLACE()` |

---

### Duplicate Detection & Analysis

| File | Description |
| :--- | :--- |
| **`Duplicate_email_finder.sql`** | Identifies duplicate email addresses using `ROW_NUMBER()` with `PARTITION BY email` |
| **`Problematic_email_finder.sql`** | Alternative duplicate email finder with cleaner output |
| **`Customer_data_analyzer_by_email.sql`** | Analyzes customer data by email, marking emails as "Unique" or "Shared with others" |
| **`Customer_data_analyzer_by_email_2.sql`** | Comprehensive email quality analysis using `CASE` statements |
| **`Customer_data_analyzer_by_email_3.sql`** | Email quality analysis using `FILTER` clause (cleaner syntax) |
| **`Complete_customer_analyze_code_with_comments.sql`** | Advanced duplicate analysis with multiple CTEs, email frequency distribution, and detailed commentary |
| **`Group_counter.sql`** | Counts duplicate groups based on first name, last name, and birth year |
| **`Group_Sorting.sql`** | Demonstrates window functions with `OVER()` to count name occurrences |
| **`Name_based_analyzer.sql`** | Advanced duplicate detection based on name, email, and phone combinations |
| **`Product_Table_Duplicate_finder.sql`** | Identifies duplicate products based on name, category, subcategory, and supplier |

---

### NULL & Data Quality Checks

| File | Description |
| :--- | :--- |
| **`Null_Value_Test.sql`** | Simple test to check NULL values for a specific customer |
| **`Products_Table_NULL_finder.sql`** | Comprehensive NULL analysis across all product columns with percentages |
| **`Products_Table_NULL_Lines.sql`** | Shows all product rows that contain any NULL values |
| **`Product_Table_Negative_price_finder.sql`** | Identifies products with illogical prices (negative costs or retail prices) |
| **`Product_Table_Negative_price_reasoning.sql`** | Detailed analysis of price issues with explanations for each issue type |


