# 📊 Week 3 – SQL JOINs & Business Intelligence

[![SQL](https://img.shields.io/badge/SQL-JOINs-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_3-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Week Overview

**Week 3** marks the transition from **data cleaning** to **data connection and analysis**. The focus of this week was to use SQL JOINs to combine UrbanStyle's fragmented data tables (sales, customers, products, inventory) to answer real business questions posed by Anna Mets (Marketing Lead) and Toomas Kask (IT Director).

The task was framed as a **business-critical problem**: Anna needed insights for her marketing campaign planning, and Toomas needed to understand data quality issues affecting business decisions.

---

## 🎯 Weekly Objectives

| Objective | Description | Status |
| :--- | :--- | :--- |
| **INNER JOIN** | Combine sales and customers to find TOP customers | ✅ |
| **LEFT JOIN + IS NULL** | Identify customers who registered but never purchased | ✅ |
| **LEFT JOIN** | Find unsold products and analyse inventory | ✅ |
| **Multi-Table JOIN** | Analyse sales channels, cities, and categories | ✅ |
| **Data Quality Checks** | Identify orphan sales and missing customer links | ✅ |
| **Business Recommendations** | Provide actionable insights for Anna and Toomas | ✅ |

---

## 👥 Team Roles & Contributions

As part of the **Operations Intelligence** team, each member took on a specific analytical role.

| Role | Team Member | Focus Area | JOIN Type |
| :--- | :--- | :--- | :--- |
| **Roll A** | Natalia | Sales + Customers – TOP customers analysis | `INNER JOIN` |
| **Roll B** | Olga | Customers without purchases – missing customers | `LEFT JOIN + IS NULL` |
| **Roll C** | Helen | Products + Inventory – unsold products and stock | `LEFT JOIN` |
| **Roll D** | **Kalju (Me)** | Channels + Marketing – multi-dimensional analysis | Multi-table `INNER JOIN` |

---

## 🔍 Key Findings Summary

### 1. Sales + Customers (Roll A)
- **Total Sales Rows:** 10,118
- **Sales Linked to Customers:** 9,130
- **Orphan Sales (No Customer Match):** 988
- **TOP Customer:** Tiina Pärn (€27,668.02)
- **TOP City by Revenue:** Tallinn (€1,006,252.88)
- **Largest Loyalty Group by Revenue:** `NULL` (€1,071,805.32)

**Key Insight:** 988 sales records cannot be linked to any customer – a data quality risk affecting customer-based analysis. The largest revenue group by loyalty tier is `NULL`, suggesting missing loyalty data.

---

### 2. Customers Without Purchases (Roll B)
- **Inactive Registered Customers:** 599
- **Active Customers:** 2,551
- **Inactive Share:** ~19% of all registered customers
- **TOP City for Inactive Customers:** Tallinn (231), Tartu (133), Pärnu (78)

**Key Insight:** 599 registered customers have never made a purchase – a significant untapped marketing opportunity. These customers are already in the system and cheaper to activate than acquiring new ones.

---

### 3. Products + Inventory (Roll C)
- **Unsold Products:** 12
- **Inventory Rows:** 1,412
- **Reorder Required:** 221 rows
- **Negative Stock:** 10 rows
- **Missing Inventory Data:** 12 rows
- **Potential Overstock:** 730 rows
- **Extreme Overstock (>100x reorder point):** 31 rows
- **Worst Overstock Multiplier:** 628.6x

**Key Insight:** UrbanStyle has both **stockout** and **overstock** problems simultaneously. 730 rows indicate potential excess inventory tying up capital, while 221 rows need reordering.

---

### 4. Channels + Marketing (Kalju)
- **Online Share of Revenue:** 34.5%
- **Online Revenue:** ~€1.0 million
- **Tallinn Store Revenue:** ~€1.08 million
- **Online Average Order Value:** €289.20
- **Store Average Order Value:** €285.05
- **Top 3 Categories Share of Revenue:** 75.9%

**Key Insight:** Online is not a secondary channel – it's a strategic sales pillar with revenue nearly matching the flagship Tallinn store. Online AOV is slightly higher than in-store.

---

## 👤 My Individual Contribution (Roll D – Channels + Marketing)

My role was to analyse **sales channels, cities, and categories** using multi-table JOINs to answer Anna's marketing questions.

### What I Did

1. **Analysed sales channels** – identified online vs store performance
2. **Combined 3 tables** – `sales` + `customers` + `products` for dimensional analysis
3. **Calculated channel share** – online accounts for 34.5% of revenue
4. **Analysed city-level performance** – Tallinn dominates, but Tartu and Pärnu are significant
5. **Compared average order values** – online (€289.20) vs store (€285.05)
6. **Identified top categories** – footwear, men's, and women's clothing account for 75.9% of revenue

### My SQL Code

The queries I wrote for this week are available in the **[Week_3_Code/](./Week_3_Code/)** folder.

---

## 💡 Key Learnings

1. **JOINs unlock business value** – combining data across tables answers questions that single tables cannot
2. **Data quality issues persist** – 988 orphan sales and `NULL` loyalty tiers indicate ongoing data quality challenges
3. **Online is a strategic channel** – not a secondary sales channel; it's nearly equal to the flagship store
4. **Inventory has dual problems** – both stockouts and overstock exist simultaneously
5. **599 inactive customers** represent a clear marketing opportunity
6. **Documentation matters** – every query and finding must be traceable

---

## 📁 Folder Structure

```text
Week_3/
├── README.md                  # This file
├── Week_3_Code/               # SQL JOIN queries
├── Week_3_Feedback/           # Personal reflections on the week
├── Week_3_Materials/          # Course materials and RAG files
└── Week_3_Results/            # Analysis results and conclusions
    ├── Week_3_Conclusions/
    ├── Week_3_Pictures/
    ├── Week_3_Presentation/
    └── Week_3_Tables/
```
---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
