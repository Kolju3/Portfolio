# ✅ Week 2 – Conclusions & Data Quality Audit Report

[![SQL](https://img.shields.io/badge/SQL-Data%20Cleaning-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_2-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document summarises the **conclusions and outcomes** of Week 2's data quality audit for UrbanStyle.ltd. The goal was to conduct a systematic review of the sales, customer, and product data to identify and document all quality issues before proceeding with business analysis.

The audit followed the **"Clinical Data Surgery"** methodology:

1. **Test Copy Creation** (`CREATE TABLE ... AS SELECT`) – never modify production data directly
2. **Cleaning** – apply SQL scripts to identify anomalies
3. **Validation** – cross-check results across domains
4. **Documentation** – log findings and compile a comprehensive report

---

## 👥 Team Contributions

| Team Member | Role | Key Finding |
| :--- | :--- | :--- |
| **Olga** | Roll A – Sales Data Cleaner | 6,603 issues: 5,116 duplicate transactions; 1,487 missing customer IDs |
| **Helen** | Roll B – Customer Data Cleaner | 762 issues: 130 duplicate emails; 252 inconsistent city names |
| **Kalju (Me)** | Roll C – Product Data Cleaner | 22 issues: 10 loss-making products; 12 product duplicates |
| **Natalia** | Roll D – Quality Control | 1,268 issues: 664 price mismatches; 592 dormant ghost customers |

---

## 🔍 My Specific Contribution (Roll C – Product Data Cleaner)

**My task was to audit the product data for duplicates, NULL values, and logical errors that could affect UrbanStyle's profitability.**

### What I Found

| Problem Type | Detail | Impact |
| :--- | :--- | :--- |
| **Product Duplicates** | 12 duplicate products out of 362 | Unique product count is actually 350 |
| **NULL Values** | Only 18 rows with NULLs | Good data quality in critical columns |
| **Loss-Making Products** | 10 products where `retail_price < cost_price` | Direct financial leakage |
| **Negative Prices** | 0 products with negative prices | No issues found |
| **Extreme Prices** | 0 products > €1,000 | No outliers found |

### My Recommendations

1. **Fix loss-making products** – review pricing for 10 products where cost exceeds retail price
2. **De-duplicate products** – merge or remove 12 duplicate product entries
3. **Audit never-sold products** – consider removing 12 products with zero sales history

---

## 📊 Comprehensive Findings Summary

### Sales Data (Olga)

| Metric | Value |
| :--- | :--- |
| **Total Transactions** | 15,234 |
| **Duplicate Transactions** | 5,116 (33.6% of total) |
| **Missing Customer IDs** | 1,487 (9.8% of total) |
| **Issues Found** | 6,603 |

**Business Impact:** Duplicate transactions artificially inflate revenue figures by approximately 33.6%. This means every sales report based on raw data is significantly overstating revenue.

---

### Customer Data (Helen)

| Metric | Value |
| :--- | :--- |
| **Total Customers** | 3,150 |
| **Missing Emails** | 380 (12.1%) |
| **Duplicate Emails** | 130 duplicates (128 distinct addresses) |
| **Inconsistent City Names** | 252 rows affected |
| **Ghost Cities Created** | 54 variations vs. 12 actual cities |
| **Issues Found** | 762 |

**Business Impact:** City name inconsistencies mean that `GROUP BY` queries show 54 "cities" instead of 12. This distorts any location-based analysis. Duplicate emails prevent accurate customer communication.

---

### Product Data (Kalju)

| Metric | Value |
| :--- | :--- |
| **Total Products** | 362 |
| **Unique Products** | 350 |
| **Product Duplicates** | 12 |
| **Loss-Making Products** | 10 |
| **NULL Values** | 18 rows |
| **Issues Found** | 22 |

**Business Impact:** 10 products are being sold at a loss, causing direct financial leakage. This is more dangerous than NULL values because it silently erodes profit margins.

---

### Cross-Validation (Natalia)

| Metric | Value |
| :--- | :--- |
| **Price Mismatches** | 664 (sales price ≠ product price list) |
| **Dormant "Ghost" Customers** | 592 (registered but never purchased) |
| **Issues Found** | 1,268 |

**Business Impact:** Price mismatches indicate either discounts not properly recorded or data entry errors. Ghost customers represent untapped revenue potential.

---

## 💡 Key Insight: SQL Logic vs Human Logic

The audit revealed that **seemingly minor formatting errors** can create significant data quality issues:

| Human Perception | SQL Reality |
| :--- | :--- |
| "Tallinn" is one city | "Tallinn", "tallinn", "TALLINN", "Tallinn " are **4 different values** |
| 12 actual cities | 54 "ghost cities" created by formatting inconsistencies |

**Lesson:** What looks like a small issue to a human (capitalisation, trailing spaces) breaks SQL grouping and aggregation entirely.

---

## 🎯 Overall Conclusion

The dataset has **significant quality issues** that require systematic cleaning before any reliable business analysis can be performed.

### Priority Issues by Business Impact

| Priority | Issue | Business Impact |
| :--- | :--- | :--- |
| **1** | **Loss-making products** (10) | Direct financial leakage |
| **2** | **Price mismatches** (664) | Inaccurate financial reporting |
| **3** | **Duplicate transactions** (5,116) | Inflated revenue by ~33.6% |
| **4** | **Customer duplicates** (130 emails) | Ineffective communication |
| **5** | **Ghost cities** (54 → 12) | Incorrect location analysis |

---

## 📋 Recommendations & Next Steps

### Phase 1: Stop Financial Leakage (Immediate)

| Action | Owner |
| :--- | :--- |
| Fix 10 loss-making product prices | Kalju |
| Correct 664 price mismatches | Natalia |
| Remove 5,116 duplicate transactions | Olga |

### Phase 2: Activate Revenue (Next)

| Action | Owner |
| :--- | :--- |
| Target 592 ghost customers with campaigns | Helen |
| Normalise 252 inconsistent city names | Helen |

### Phase 3: Optimise Costs (Later)

| Action | Owner |
| :--- | :--- |
| Audit 12 never-sold products | Kalju |
| Merge or remove 12 duplicate products | Kalju |

---

## 🔗 Related Files

- [Week 2 Main README](../README.md)
- [Week 2 Code Folder](../Week_2_Code/)
- [Week 2 Group Repository](https://github.com/Kolju3/DACA-group)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
