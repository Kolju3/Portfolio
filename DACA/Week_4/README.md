# 📊 Week 4 – SQL Aggregation & Business Intelligence

[![SQL](https://img.shields.io/badge/SQL-Aggregation-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_4-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Week Overview

**Week 4** marks the shift from **data connection** to **data summarisation and business intelligence**. The focus of this week was to use SQL aggregation (`GROUP BY`, `HAVING`, CTEs, and window functions) to transform raw transaction data into actionable business insights for UrbanStyle's CEO Kristi Tamm.

The task was framed as a **business-critical problem**: Kristi needed a concise set of key performance indicators for an upcoming board meeting, covering sales trends, customer segments, product performance, and marketing channel effectiveness.

---

## 🎯 Weekly Objectives

| Objective | Description | Status |
| :--- | :--- | :--- |
| **GROUP BY** | Aggregate sales by month, category, city, and channel | ✅ |
| **HAVING** | Filter aggregated results (e.g., categories with >€10k revenue) | ✅ |
| **CTEs** | Structure complex queries into readable, logical steps | ✅ |
| **Window Functions** | Calculate running totals, rankings, and period-over-period changes | ✅ |
| **Data Quality Validation** | Identify anomalies using aggregation (e.g., inventory discrepancies) | ✅ |
| **Business Reporting** | Produce concise CEO-level KPIs | ✅ |

---

## 👥 Team Roles & Contributions

As part of the **Operations Intelligence** team, each member took on a specific aggregation domain.

| Role | Team Member | Focus Area | Key Technique |
| :--- | :--- | :--- | :--- |
| **Roll A** | **Kalju (Me)** | Sales Aggregation & Trends | `GROUP BY`, CTEs, `LAG()` |
| **Roll B** | Natalia | Customer Segmentation | CTEs, `CASE WHEN`, window functions |
| **Roll C** | Olga | Product & Inventory Statistics | `GROUP BY`, `HAVING`, `ROW_NUMBER()` |
| **Roll D** | Helen | Marketing Channel ROI | Multi-table JOINs, CTEs, `LAG()` |

---

## 🔍 Key Findings Summary

### 1. Sales Aggregation (Kalju – Roll A)
- **Total Sales:** 10,118 transactions
- **Total Revenue:** €2,909,177.98
- **2024 Revenue:** €1,470,358.02
- **Year-over-Year Growth:** 19.08% (2024 vs 2023)
- **Best Month:** December 2024 (€170,623.28)
- **Top Category by Volume:** `meeste_riided` (4,121 units sold)

### 2. Customer Segmentation (Natalia – Roll B)
- **VIP Customers:** 18 (avg. spend €745.20)
- **Regular Customers:** 54 (avg. spend €312.50)
- **New Customers:** 142 (avg. spend €64.80)
- **Key Insight:** A small group of VIP customers drives a disproportionate share of revenue

### 3. Product & Inventory (Olga – Roll C)
- **Top Category by Revenue:** `jalanõusid` (€774,034.75)
- **Top Category by Units Sold:** `meeste_riided` (4,121 units)
- **Highest Average Price:** `jalanõusid` (€214.10)
- **Key Insight:** 10 products sold at a loss (retail_price < cost_price)

### 4. Marketing Channels (Helen – Roll D)
- **Top Channel by Revenue:** `google_organic` (€666,444.98, 2,273 orders)
- **Top Channel by AOV:** `instagram` (€298.87)
- **Top Channel by Revenue per Customer:** `facebook_ads`
- **Key Insight:** Online channels drive 34.5% of total revenue

---

## 👤 My Individual Contribution (Roll A – Sales Aggregation)

My role was to aggregate **sales data** to answer Kristi's questions about revenue trends, category performance, and period-over-period growth.

### What I Did

1. **Aggregated sales by month** – calculated monthly revenue, order count, and average order value
2. **Analysed category performance** – identified top categories by revenue and units sold
3. **Calculated year-over-year growth** – 2024 vs 2023 (19.08% growth)
4. **Built CTE-based trend analysis** – month-to-month changes with `LAG()` window function
5. **Validated data quality** – cross-checked aggregated totals against raw data

### My SQL Code

The queries I wrote for this week are available in the **[Week_4_Code/](./Week_4_Code/)** folder.

---

## 💡 Key Learnings

1. **Aggregation unlocks business value** – turning 10,118 transactions into 12 monthly summary rows makes data digestible for leadership
2. **CTEs improve readability** – complex queries become maintainable when broken into logical steps
3. **Window functions enable trend analysis** – `LAG()` and `LEAD()` are essential for period-over-period comparisons
4. **Data validation is critical** – always cross-check aggregated totals against raw data
5. **Documentation matters** – every query and finding must be traceable

---

## 📁 Folder Structure

```text
Week_4/
├── README.md                  # This file
├── Week_4_Code/               # SQL aggregation queries
├── Week_4_Feedback/           # Personal reflections
├── Week_4_Materials/          # Course materials and RAG files
└── Week_4_Results/            # Analysis results and conclusions
    ├── Week_4_Conclusions/
    ├── Week_4_Pictures/
    ├── Week_4_Presentation/
    └── Week_4_Tables/
