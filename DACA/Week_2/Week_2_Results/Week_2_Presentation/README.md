# 📽️ Week 2 – Group Presentation: UrbanStyle Data Quality Audit

[![DACA](https://img.shields.io/badge/DACA-Week_2-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Presentation](https://img.shields.io/badge/Presentation-Group-FFA500?style=for-the-badge)](https://github.com/Kolju3/DACA-group)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **group presentation** delivered during Week 2 of the DACA programme. The presentation summarises our team's comprehensive data quality audit of the UrbanStyle.ltd database.

The presentation was created collaboratively by the **Operations Intelligence** team and presented during Sessioon 3 (Demo session).

---

## 📄 File Contents

| File | Description |
| :--- | :--- |
| **`UrbanStyle_Data_Surgery_v5.pdf`** | The final group presentation slides (PDF format) – titled "UrbanStyle Andmekvaliteedi Audit: Diagnostika, finantsmõju ja strateegiline raviplaan" |

---

## 👥 Team Members (Operations Intelligence)

| Team Member | Role | Focus Area |
| :--- | :--- | :--- |
| **Olga** | Roll A – Sales Data Cleaner | Duplicate detection and NULL value identification in the sales table |
| **Helen** | Roll B – Customer Data Cleaner | Email uniqueness analysis and city name normalisation |
| **Kalju (Me)** | Roll C – Product Data Cleaner | Product duplicate detection and price logic validation |
| **Natalia** | Roll D – Quality Control | Cross-table validation and financial impact analysis |

---

## 🎯 Presentation Objective

The goal of this presentation was to:

1. **Present a complete data quality audit** of UrbanStyle's sales, customer, and product data
2. **Quantify the financial impact** of data quality issues
3. **Provide a strategic action plan** for prioritised data cleaning
4. **Recommend next steps** for Week 3 (JOIN analysis)

---

## 🔍 Key Findings Presented

### 1. Sales Data Audit (Olga)

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Duplicate Transactions** | 5,116 duplicate records (33.6% of total) | Revenue artificially inflated |
| **Missing Customer IDs** | 1,487 transactions without customer reference | JOIN analysis impossible |
| **Total Issues** | 6,603 | Critical |

---

### 2. Customer Data Audit (Helen)

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Missing Emails** | 380 customers without email | Campaigns cannot reach target groups |
| **Duplicate Emails** | 130 duplicate rows (128 distinct addresses) | Customer statistics distorted |
| **Inconsistent City Names** | 252 rows affected (54 variations vs. 12 actual cities) | Geospatial targeting errors |
| **Total Issues** | 762 | Significant |

**Key Insight:** "Human logic vs SQL logic" – what looks like one city to a human (Tallinn) appears as 4+ different values to SQL due to capitalisation and trailing spaces.

---

### 3. Product Data Audit (Kalju)

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Loss-Making Products** | 10 products where cost_price > retail_price | Direct financial leakage |
| **Product Duplicates** | 12 duplicate product names (362 → 350 unique) | Product portfolio analysis distorted |
| **NULL Values** | 18 rows with NULL values (4.97% of total) | Low risk, localised issue |
| **Total Issues** | 22 | Moderate |

**Key Insight:** Only 4.97% of rows have NULL values. Most issues are logical errors (negative margin) rather than missing data.

---

### 4. Cross-Validation Audit (Natalia)

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Price Mismatches** | 664 records where sales price ≠ product price list | Inaccurate financial reporting |
| **Dormant Customers** | 592 "ghost customers" with no purchase history | Untapped revenue potential |
| **Total Issues** | 1,268 | Significant |

---

## 💡 Key Insights

### "Human Logic vs SQL Logic"

| Human Perception | SQL Reality |
| :--- | :--- |
| "Tallinn" is one city | "Tallinn", "tallinn", "TALLINN", "Tallinn " are **4 different values** |
| 12 actual cities | 54 "ghost cities" created by formatting inconsistencies |

**Lesson:** What looks like a small issue to a human (capitalisation, trailing spaces) breaks SQL grouping and aggregation entirely.

### Financial Leakage

> *"10 products are being sold at a loss. This is more dangerous than NULL values because it silently erodes profit margins."*

---

## 📊 Summary: Technical Issues vs Business Impact

| Technical Issue | Business Impact |
| :--- | :--- |
| 5,116 sales duplicates + 664 price errors | Revenue inflated; financial reports distorted |
| 54 city name variations + 1,487 missing IDs | Incorrect geographic targeting; resource misallocation |
| 380 missing emails | Campaign failures; dormant potential |

**Conclusion:** Uncleaned data makes all future sales and product analysis (JOINs) unreliable.

---

## 📋 Strategic Action Plan

### Priority 1: STOP THE LEAK (Immediate)

| Problem | Action |
| :--- | :--- |
| 664 price mismatches | Verify sales price vs product price list |
| 5,116 sales duplicates | De-duplicate transactions |
| **Focus:** Start with top 10 products with largest price differences |

### Priority 2: ACTIVATE REVENUE (Next)

| Problem | Action |
| :--- | :--- |
| 592 ghost customers | Deep analysis of purchase barriers |
| 380 missing emails | Targeted marketing campaigns |

### Priority 3: OPTIMISE COSTS (Later)

| Problem | Action |
| :--- | :--- |
| 12 ghost products (0 sales) | Portfolio audit and lifecycle decisions |
| 10 loss-making products | Pricing review |

---

## 🚨 Critical Gaps Identified

| Gap | Impact | Solution |
| :--- | :--- | :--- |
| **No data source info** (online vs POS) | Cannot determine which duplicate is most recent | Add source tracking |
| **No timestamps (`created_at`)** | Dangerous to blindly delete duplicates | Add created_at fields |
| **No Master Customer ID** | Customer identity crises across tables | Implement unique Master-ID system |

**Warning:** Without these, deleting duplicates or merging customer records is risky.

---

## 📊 Presentation Structure

The presentation followed this structure:

1. **Methodology** – Clinical Data Surgery approach
2. **Sales Data Findings** – Olga's analysis
3. **Customer Data Findings** – Helen's analysis
4. **Product Data Findings** – Kalju's analysis
5. **Cross-Validation Findings** – Natalia's analysis
6. **Synthesis** – Technical issues → Business impact
7. **Summary Report** – Consolidated findings
8. **Strategic Action Plan** – Prioritised recommendations
9. **Critical Gaps** – Missing data elements
10. **Next Steps** – Preparation for Week 3 JOIN analysis

---

## 🧠 Key Takeaways

1. **Data quality issues are not just technical** – they have direct financial impact
2. **Inconsistent formatting** (capitalisation, spaces) breaks SQL logic
3. **Logical errors** (products sold at a loss) are more dangerous than NULL values
4. **Always work on test copies** – never modify production data directly
5. **Document everything** – each finding must be validated and logged
6. **Prioritise by business impact** – stop financial leakage first

---

## 🔗 Related Files

- [Week 2 Main README](../README.md)
- [Week 2 Code Folder](../Week_2_Code/)
- [Week 2 Conclusions README](../Week_2_Conclusions/README.md)
- [Week 2 Tables README](../Week_2_Tables/README.md)
- [Group Repository – Operations Intelligence](https://github.com/Kolju3/DACA-group)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
