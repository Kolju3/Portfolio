# ✅ Week 8 – Conclusions & Audit Summary

[![DACA](https://img.shields.io/badge/DACA-Week_8-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document summarises the **conclusions and outcomes** of Week 8's analysis for UrbanStyle.ltd. The goal was to **transform raw data into actionable business insights** that would support Kristi Tamm's upcoming investor pitch.

---

## 🎯 Project Objective (Business Question)

The objective of this analysis was to answer the investors' key questions:
1. **Who** are UrbanStyle's most valuable customers?
2. **What** products drive the most revenue and profit?
3. **How** do different marketing channels perform?
4. **Where** should the business focus for growth?

---

## 👥 Team Contributions

| Team Member | Role | Key Contribution |
| :--- | :--- | :--- |
| **Helen** | Roll A – Database Connection & Data Import | Successfully connected Python to Supabase, imported all tables |
| **Kalju (Me)** | Roll B – Data Cleaning & Transformation | Cleaned data, handled NULLs, duplicates, negative values, standardised city names |
| **Natalia** | Roll C – Customer Analytics & CLV | Calculated CLV, segmented customers, analysed segment performance |
| **Olga** | Roll D – Dashboard Creation | Built the final dashboard in Power BI |

---

## 🔍 My Specific Contribution (Roll B)

**My task was to clean and transform the data so it could be used for analysis.**

### What I Did

| Task | Action | Result |
| :--- | :--- | :--- |
| **City name standardisation** | Used `str.strip()` and `str.title()` | All city names are now consistent |
| **Duplicate removal** | Dropped 47 duplicate invoices | Clean, unique transactions |
| **Negative price handling** | Investigated and removed 305 negative transactions | Valid pricing data |
| **NULL handling** | Dropped 1,487 transactions without customer ID | Customer analysis now possible |
| **Date conversion** | Converted to datetime format | Time-based analysis now possible |
| **Calculated columns** | Added margin, margin percentage, month | Rich dataset for analysis |

---

## 📊 Team Summary Findings

### 1. Customer Analysis

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Customer Concentration** | 10% of customers generate 60% of revenue | Focus retention on high-value customers |
| **High-Value Customer AOV** | €571 (vs. €95 for medium-value) | High-value customers buy more, not just more often |
| **Repeat Purchase Rate** | 45% of customers make repeat purchases | Loyalty programs would be effective |

### 2. Product Analysis

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Top Category** | Women's Dresses (€450k revenue, 58% margin) | Expand this category |
| **Highest Margin** | Accessories (62% margin) | Promote accessories with other products |
| **Slow-Moving Products** | 15 products with <5 sales in 2024 | Consider clearance or removal |

### 3. Channel Analysis

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Online Revenue** | 60% of total, growing 15% faster than in-store | Invest in online experience |
| **Store AOV** | €165 vs. €112 online | Store customers buy more per transaction |
| **Missing Location Data** | 5,204 transactions (now resolved) | All transactions now have location info |

### 4. Marketing Analysis

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Highest ROI** | Email marketing (400% ROI) | Invest more in email |
| **Highest Revenue** | Instagram (€30k revenue from €10k spend) | Continue Instagram focus |
| **Lowest ROI** | Facebook (100% ROI) | Consider reallocating budget |

---

## 💡 Overall Conclusion

**UrbanStyle's data is now clean, transformed, and ready for the investor pitch.**

### Key Takeaways

1. **Data quality has been resolved** – all known issues have been fixed
2. **Customer insights are clear** – 10% of customers generate 60% of revenue
3. **Product strategy is defined** – women's dresses and accessories are the focus
4. **Marketing ROI is measurable** – email and Instagram are the best channels

### Recommended Investor Pitch Focus

| Priority | Message | Supporting Data |
| :--- | :--- | :--- |
| 1 | **Customer concentration** | 10% of customers generate 60% of revenue |
| 2 | **Growth opportunity** | Online sales growing 15% faster than in-store |
| 3 | **Marketing efficiency** | Email marketing ROI = 400% |
| 4 | **Product strategy** | Women's dresses = highest revenue and margin |

---

## 📋 Next Steps (Week 9 Focus)

| Priority | Task | Owner |
| :--- | :--- | :--- |
| 1 | **Refine dashboard** based on team feedback | Olga |
| 2 | **Prepare investor presentation** with key insights | All |
| 3 | **Practice the pitch** – answer "why" behind each insight | Kalju |
| 4 | **Finalise documentation** – ensure all READMEs are complete | All |
'
---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
