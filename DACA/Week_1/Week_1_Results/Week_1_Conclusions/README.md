# ✅ Week 1 – Conclusions & Audit Summary

[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_1-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document summarises the **conclusions and outcomes** of Week 1's data audit for UrbanStyle.ltd. The goal was to assess the quality and reliability of the sales, customer, and product data before it could be used for strategic business analysis.

---

## 🎯 Project Objective (Business Question)

The objective of this analysis was to audit the reliability of UrbanStyle.ltd's sales and product data. Toomas Kask, the IT Director, had identified potential data quality problems that needed thorough investigation before the data could be used in strategic business analysis and decision-making processes.

---

## 👥 Team Contributions

| Team Member | Role | Key Contribution |
| :--- | :--- | :--- |
| **Helen** | Roll A – Sales Data Explorer | Found 15,234 transactions, 1,487 missing customer IDs, and 305 negative-amount transactions |
| **Kalju (Me)** | Roll B – Data Quality Expert | Identified spelling, case sensitivity, and whitespace inconsistencies in city names |
| **Natalia** | Roll C – Product Data Analyst | Found 362 products across five categories with no missing prices or categories |
| **Olga** | Roll D – Sales Channels & Locations | Found 5,204 transactions missing location data |

---

## 🔍 My Specific Contribution (Roll B)

**My task was to identify "data dirtiness" – systemic errors that would cause problems for analysis.**

### What I Found

| Problem Type | Example | Impact |
| :--- | :--- | :--- |
| **Spelling inconsistencies** | "Tallinn", "tallinn", "TALLINN", "Tallinn " | All treated as separate locations |
| **Whitespace issues** | Trailing spaces in city names | Creates duplicate entries in the system |
| **Case sensitivity** | Different capitalisation of the same city name | Makes accurate GROUP BY queries impossible |

### Why This Matters

Without fixing these issues, any aggregate analysis (e.g., sales by city) would be **inaccurate**. Different spellings of the same city would be counted separately, distorting the actual distribution of customers and sales.

### My Recommendations

1. **Normalise city names** – use `TRIM()` and `INITCAP()` to standardise spelling
2. **Use CTEs** – to avoid repeating cleaning functions in multiple queries
3. **Create a lookup table** – for consistent city name mapping across the database

---

## 📊 Team Summary Findings

| Area | Finding |
| :--- | :--- |
| **Transaction Volume** | 15,234 total transactions |
| **Missing Customer IDs** | 1,487 transactions (~9.8%) have no customer ID |
| **Negative Transactions** | 305 transactions with negative amounts (total -€88,632.61) |
| **Future Dates** | 2 transactions with future dates |
| **Product Data Quality** | High – no missing prices or categories |
| **Product Count** | 362 products across five categories |
| **Price Range** | €13.53 (belt) – €434.00 (sports shoes) |
| **Missing Location Data** | 5,204 transactions missing location information |

---

## 💡 Overall Conclusion

**The dataset is largely usable but requires cleaning before analysis can begin.**

The data contains:
- ✅ Good volume of transactions and products
- ✅ High-quality product data
- ❌ Significant data quality issues in customer information
- ❌ Inconsistencies in city names and formatting
- ❌ Some suspicious entries (negative amounts, future dates)

---

## 📋 Next Steps (Week 2 Focus)

| Priority | Task | Owner |
| :--- | :--- | :--- |
| 1 | **Data normalisation** – standardise city name spelling and remove trailing spaces | Kalju |
| 2 | **Negative transactions investigation** – determine if these are returns or system errors | Helen |
| 3 | **Customer ID impact analysis** – assess the effect of missing customer IDs | Olga |
| 4 | **Product data deeper dive** – analyse pricing trends and category performance | Natalia |

---

## 🔗 Related Files

- [Week 1 Main README](../README.md)
- [Week 1 Code Folder](../Week_1_Code/)
- [Group Repository – Operations Intelligence](https://github.com/Kolju3/DACA-group)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
