# 📊 Week 2 – Data Tables & Quality Audit Results

[![DACA](https://img.shields.io/badge/DACA-Week_2-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![CSV](https://img.shields.io/badge/CSV-Data%20Tables-FF6B6B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains **CSV exports** of the query results I generated during Week 2 of the DACA programme. These tables document my product data quality audit, including duplicate detection, NULL value analysis, and pricing error identification.

The tables demonstrate:
- Systematic duplicate detection using `ROW_NUMBER()` and `PARTITION BY`
- NULL value analysis across product columns
- Logical error detection (products sold at a loss)
- Comprehensive data quality reporting

---

## 📂 Table Files

### 1. Product Duplicate Analysis

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Product_Table_Duplicates.csv`** | Products with duplicate entries | 12 duplicate products across various categories |

**Sample Data:**

| Product Name | Category | Subcategory | Supplier | Duplicate Count |
| :--- | :--- | :--- | :--- | :--- |
| Vintage Nahkne Tossud | Jalanõusid | Tossud | Riia Stils Sia | 2 |
| Minimalistlik Kashmiir Bleiser | Naiste_riided | Jakid | Tallinna Rõivatehas Oü | 2 |
| Stiilne Orgaaniline Pidžaama | Laste_riided | Komplektid | Eesti Nahk As | 2 |

**Key Finding:** 12 duplicate products out of 362 total means the actual unique product count is **350** (not 362). This distorts product portfolio analysis and inventory management.

---

### 2. NULL Value Analysis

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Products_Table_NULL_finder.csv`** | NULL value distribution across all product columns | Only `eco_certified` has NULL values (18 rows, 4.97%) |
| **`Products_Table_NULL_lines.csv`** | All rows containing NULL values | 18 specific product rows with missing `eco_certified` data |

**Key Findings:**

| Column | NULL Count | NULL Percentage | Status |
| :--- | :--- | :--- | :--- |
| `eco_certified` | 18 | 4.97% | Needs review |
| `product_name` | 0 | 0.00% | Clean |
| `category` | 0 | 0.00% | Clean |
| `subcategory` | 0 | 0.00% | Clean |
| `supplier` | 0 | 0.00% | Clean |
| `cost_price` | 0 | 0.00% | Clean |
| `retail_price` | 0 | 0.00% | Clean |
| `product_id` | 0 | 0.00% | Clean |
| `created_at` | 0 | 0.00% | Clean |

**Conclusion:** NULL values are **localised to `eco_certified` only** and affect only 18 products. This is a **low-risk issue** that does not block JOIN analysis but should be reviewed by the product team.

---

### 3. Price Error Analysis

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Products_Table_Negative_prices.csv`** | Products with illogical pricing | 10 products where `retail_price < cost_price` |
| **`Products_Table_Negative_prices_reasoning.csv`** | Detailed reasoning for each price error | All issues classified as "Retail below cost" |

**Key Finding:**

| Product | Category | Cost Price | Retail Price | Loss per Unit |
| :--- | :--- | :--- | :--- | :--- |
| Vintage Nahkne Tossud | Jalanõusid | €305.72 | €179.95 | **€125.77 loss** |
| Minimalistlik Kashmiir Bleiser | Naiste_riided | €276.20 | €185.46 | **€90.74 loss** |
| Praktiline Viskoosne Jakk | Naiste_riided | €346.70 | €213.35 | **€133.35 loss** |
| Klassikaline Puust Nahkvöö | Aksessuaarid | €186.77 | €111.74 | **€75.03 loss** |

**Total of 10 products are being sold at a loss** – this represents **direct financial leakage** for UrbanStyle.

**No negative prices** (retail_price < 0) or **extreme prices** (> €1,000) were found.

---

### 4. Customer Email Analysis

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Complete_analyze.csv`** | Full email duplicate analysis with frequency distribution | Shows how many emails appear 1, 2, or 3+ times |

**Summary Data:**

| Metric | Value |
| :--- | :--- |
| **Total Customers** | 3,150 |
| **Total Missing Emails** | 380 (12.1%) |
| **Distinct Valid Emails** | 2,640 |
| **Emails Exactly Once** | 2,512 |
| **Emails Multiple Times** | 128 distinct emails appear 2+ times |
| **Rows for Multiple Emails** | 258 customer records share 128 emails |
| **Extra Duplicate Copies** | 130 extra rows beyond the first occurrence |

**Frequency Distribution:**

| Occurrence Count | Distinct Emails | Customer Rows Affected |
| :--- | :--- | :--- |
| 1 | 2,512 | 2,512 |
| 2 | 126 | 252 |
| 3 | 2 | 6 |
| **Total** | **2,640** | **2,770** |

**Business Impact:** 128 distinct emails appear multiple times. This means 258 customer records are tied to just 128 unique email addresses – a clear sign of duplicate customer profiles.

---

## 🔍 Key Insights

### Product Data Quality

| Category | Finding | Business Impact |
| :--- | :--- | :--- |
| **Product Duplicates** | 12 duplicate products (362 → 350 unique) | Distorts product portfolio analysis |
| **NULL Values** | 18 rows (4.97%) with missing `eco_certified` | Low risk; product team should review |
| **Loss-Making Products** | 10 products sold below cost | Direct financial leakage – **PRIORITY FIX** |
| **Negative Prices** | 0 products with negative prices | No issues found |
| **Extreme Prices** | 0 products over €1,000 | No outliers found |

### Customer Email Quality

| Category | Finding | Business Impact |
| :--- | :--- | :--- |
| **Missing Emails** | 380 customers (12.1%) | Marketing campaigns cannot reach these customers |
| **Duplicate Emails** | 128 emails appear 2+ times | Customer statistics distorted; risk of duplicate communications |
| **Extra Copies** | 130 extra rows beyond first occurrence | Database bloat and inaccurate metrics |

---

## 🧠 SQL Logic Used

### Duplicate Detection

```sql
-- Identify duplicate products using GROUP BY + HAVING
SELECT
    product_name,
    category,
    subcategory,
    supplier,
    COUNT(*) AS duplicate_count,
    ARRAY_AGG(product_id) AS duplicate_ids
FROM "Testing_Products_Cleaned"
GROUP BY product_name, category, subcategory, supplier
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;
