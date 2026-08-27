# 🧹 Week 2 – Data Quality Audit & SQL Cleaning

[![SQL](https://img.shields.io/badge/SQL-Data%20Cleaning-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_2-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Week Overview

**Week 2** marks the shift from data exploration to **data cleaning and quality assurance** in the DACA programme. The focus of this week was to conduct a comprehensive data quality audit of the UrbanStyle.ltd database, identifying duplicates, NULL values, inconsistencies, and logical errors across all core tables.

The task was framed as a **business-critical problem**: Toomas Kask needed a complete data quality assessment to understand the scope of issues before any reliable business analysis could be performed.

---

## 🎯 Weekly Objectives

| Objective | Description | Status |
| :--- | :--- | :--- |
| **Data Quality Audit** | Identify duplicates, NULL values, and inconsistencies across all tables | ✅ |
| **Duplicate Detection** | Use `ROW_NUMBER()` and `PARTITION BY` to find exact duplicates | ✅ |
| **Data Standardisation** | Clean city names using `TRIM()` and `INITCAP()` | ✅ |
| **Logical Error Detection** | Find products sold below cost and price mismatches | ✅ |
| **Team Collaboration** | Each team member cleaned a different data domain | ✅ |
| **Portfolio Submission** | Document findings and submit SQL scripts to GitHub | ✅ |

---

## 👥 Team Roles & Contributions

As part of the **Operations Intelligence** team, each member took on a specific cleaning domain.

| Role | Team Member | Focus Area |
| :--- | :--- | :--- |
| **Roll A – Sales Data Cleaner** | Olga | Duplicate detection and NULL value identification in the sales table |
| **Roll B – Customer Data Cleaner** | Helen | Email uniqueness analysis and city name normalisation |
| **Roll C – Product Data Cleaner** | **Kalju (Me)** | Product duplicate detection and price logic validation |
| **Roll D – Quality Control** | Natalia | Cross-table validation and financial impact analysis |

---

## 🔍 Key Findings Summary

### 1. Sales Data (Olga)
- **Total Issues Found:** 6,603
- **Duplicate Transactions:** 5,116 duplicate invoice records artificially inflating revenue
- **Missing Customer IDs:** 1,487 transactions without customer reference

### 2. Customer Data (Helen)
- **Total Issues Found:** 762
- **Duplicate Emails:** 130 duplicate emails (128 distinct addresses)
- **City Name Inconsistencies:** 252 rows with inconsistent city names (54 variations vs. 12 actual cities)

### 3. Product Data (Kalju)
- **Total Issues Found:** 22
- **Negative Margin Products:** 10 products sold at a loss (cost price > retail price)
- **Product Duplicates:** 12 duplicate product names

### 4. Cross-Validation (Natalia)
- **Total Issues Found:** 1,268
- **Price Mismatches:** 664 records where sales price doesn't match product price list
- **Dormant Customers:** 592 "ghost customers" with no purchase history

---

## 👤 My Individual Contribution (Roll C – Product Data Cleaner)

My role was to audit the **product data** for duplicates, NULL values, and logical errors that could affect UrbanStyle's profitability.

### What I Did

1. **Created a test copy** of the products table for safe experimentation

2. **Identified product duplicates** based on name, category, subcategory, and supplier:
   - Found **12 duplicate products** out of 362 total
   - Actual unique product count: **350**

3. **Analysed NULL values** across all product columns:
   - Only **18 rows** with NULL values (all in sales-related fields)
   - No NULLs in critical columns like `product_name` or `category`

4. **Detected logical price errors**:
   - Found **10 products** where `retail_price < cost_price` (sold at a loss)
   - No products with negative prices or prices exceeding €1,000

5. **Standardised text fields** using `TRIM()`, `INITCAP()`, and `REGEXP_REPLACE()`

### My SQL Code

The queries I wrote for this week are available in the **[Week_2_Code/](./Week_2_Code/)** folder.

---

## 💡 Conclusions & Recommendations

**Conclusion:** The dataset has significant quality issues that require systematic cleaning. The most critical issues are:

1. **Financial leakage** – 10 products sold at a loss and 664 price mismatches
2. **Revenue distortion** – 5,116 duplicate transactions inflating revenue
3. **Customer data fragmentation** – 130 duplicate emails and inconsistent city names

### Strategic Action Plan

| Priority | Action | Owner |
| :--- | :--- | :--- |
| **1** | **Stop financial leakage** – fix 664 price mismatches and 10 loss-making products | Kalju / Natalia |
| **2** | **De-duplicate sales data** – remove 5,116 duplicate transactions | Olga |
| **3** | **Activate dormant customers** – target 592 ghost customers with campaigns | Helen |
| **4** | **Optimise product catalogue** – audit 12 never-sold products | Kalju |

---

## 📁 Folder Structure

```text
Week_2/
├── README.md                  # This file
├── Week_2_Code/               # SQL cleaning scripts
│   ├── Clean_table_generator_*.sql
│   ├── Duplicate_email_finder.sql
│   ├── Complete_customer_analyze_code_with_comments.sql
│   └── ...
├── Week_2_Feedback/           # Personal reflections on the week
├── Week_2_Materials/          # Course materials and RAG files
└── Week_2_Results/            # Analysis results and conclusions
    ├── Week_2_Conclusions/
    ├── Week_2_Pictures/
    ├── Week_2_Presentation/
    └── Week_2_Tables/
