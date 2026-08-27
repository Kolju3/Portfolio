# 📽️ Week 3 – Group Presentation: UrbanStyle JOIN Analysis

[![DACA](https://img.shields.io/badge/DACA-Week_3-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Presentation](https://img.shields.io/badge/Presentation-Group-FFA500?style=for-the-badge)](https://github.com/Kolju3/DACA-group)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **group presentation** delivered during Week 3 of the DACA programme. The presentation summarises our team's SQL JOIN analysis of the UrbanStyle.ltd database, answering key business questions about customers, products, inventory, and sales channels.

The presentation was created collaboratively by the **Operations Intelligence** team and presented during Sessioon 3 (Demo session).

---

## 📄 File Contents

| File | Description |
| :--- | :--- |
| **`UrbanStyle_Op_JOIN-analüüs.pdf`** | The final group presentation slides (PDF format) – titled "UrbanStyle JOIN-analüüs" |

---

## 👥 Team Members (Operations Intelligence)

| Team Member | Role | Focus Area | JOIN Type |
| :--- | :--- | :--- | :--- |
| **Natalia** | Roll A – Sales + Customers | TOP customers analysis, sales by city and loyalty tier | `INNER JOIN` |
| **Olga** | Roll B – Customers Without Purchases | Registered customers who never purchased | `LEFT JOIN + IS NULL` |
| **Helen** | Roll C – Products + Inventory | Unsold products, stockouts, overstock analysis | `LEFT JOIN` |
| **Kalju (Me)** | Roll D – Channels + Marketing | Sales channels, cities, categories, multi-dimensional analysis | Multi-table `INNER JOIN` |

---

## 🎯 Presentation Objective

The goal of this presentation was to:

1. **Demonstrate SQL JOIN skills** – connecting sales, customer, product, and inventory tables
2. **Answer Anna Mets' marketing questions** – who are the best customers, who hasn't purchased, what sells and what doesn't
3. **Provide actionable business recommendations** – based on JOIN analysis findings
4. **Identify data quality risks** – orphan sales, missing loyalty data, inventory issues

---

## 🔍 Key Findings Presented

### 1. Sales + Customers (Natalia – Roll A)

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Total Sales** | 10,118 rows | Baseline for all analysis |
| **Sales Linked to Customers** | 9,130 rows | 988 orphan sales (9.7%) |
| **Orphan Sales Revenue** | €286,133.99 | Revenue cannot be attributed to customers |
| **TOP Customer** | Tiina Pärn (€27,668.02) | VIP customer potential |
| **TOP City by Revenue** | Tallinn (€1,006,252.88) | Largest market |
| **Largest Loyalty Group** | `NULL` (€1,071,805.32) | Loyalty data missing for top customers |

**Key Insight:** 988 sales cannot be linked to any customer – a data quality risk affecting customer-based analysis. The largest revenue group by loyalty tier is `NULL`, suggesting missing loyalty data.

---

### 2. Customers Without Purchases (Olga – Roll B)

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Inactive Customers** | 599 registered customers | ~19% of all registered customers |
| **Active Customers** | 2,551 | 81% of registered customers |
| **TOP City for Inactive** | Tallinn (231), Tartu (133), Pärnu (78) | Regional activation opportunity |

**Key Insight:** 599 registered customers have never made a purchase – a significant untapped marketing opportunity. These customers are already in the system and cheaper to activate than acquiring new ones.

---

### 3. Products + Inventory (Helen – Roll C)

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Unsold Products** | 12 products | Inventory tying up capital |
| **Inventory Rows** | 1,412 | Full inventory snapshot |
| **Reorder Required** | 221 rows | Potential lost sales |
| **Potential Overstock** | 730 rows | Capital tied up in excess inventory |
| **Negative Stock** | 10 rows | Data quality issue |
| **Missing Inventory Data** | 12 rows | Data quality issue |
| **Extreme Overstock** | 31 rows (>100x reorder point) | Significant capital waste |
| **Worst Overstock Multiplier** | 628.6x | Critical issue |

**Revenue by Category:**

| Category | Products | Sales | Revenue |
| :--- | :--- | :--- | :--- |
| Jalanõusid (Footwear) | 73 | 2,031 | €774,034.75 |
| Meeste_riided (Men's) | 82 | 2,266 | €749,798.72 |
| Naiste_riided (Women's) | 70 | 2,022 | €686,464.24 |
| Aksessuaarid | 67 | 1,772 | €393,035.82 |
| Laste_riided (Children's) | 70 | 2,027 | €305,844.45 |

**Key Insight:** UrbanStyle has both **stockout** and **overstock** problems simultaneously. 730 rows indicate potential excess inventory tying up capital, while 221 rows need reordering.

---

### 4. Channels + Marketing (Kalju – Roll D)

| Finding | Detail | Business Impact |
| :--- | :--- | :--- |
| **Online Revenue Share** | 34.5% of total revenue (~€1.0 million) | Strategic channel |
| **Online vs Store AOV** | Online: €289.20 vs Store: €285.05 | Online customers spend slightly more |
| **TOP City by Revenue** | Tallinn (€1,006,252.88) | Largest market |
| **Top 3 Categories Share** | 75.9% of total revenue | Marketing focus areas |

**Channel Performance Summary:**

| Channel | Sales % | Revenue % | AOV |
| :--- | :--- | :--- | :--- |
| **Online** | 34.22% | 34.54% | €289.20 |
| **Tallinn Store** | 37.57% | 37.48% | €285.84 |
| **Tartu Store** | 17.76% | 18.02% | €290.64 |
| **Pärnu Store** | 10.46% | 9.96% | €272.90 |

**Key Insight:** Online is not a secondary channel – it's a strategic sales pillar with revenue nearly matching the flagship Tallinn store. Online AOV is slightly higher than in-store.

---

## 📊 Presentation Structure

The presentation followed this structure:

1. **Introduction** – Team introduction and project objective
2. **Methodology** – JOIN types used, tables analysed
3. **Roll A – Sales + Customers** – TOP customers, city analysis, loyalty analysis
4. **Roll B – Customers Without Purchases** – Inactive customer count and distribution
5. **Roll C – Products + Inventory** – Unsold products, category performance, overstock
6. **Roll D – Channels + Marketing** – Channel performance, city analysis, category analysis
7. **Key Insights** – Consolidated findings across all roles
8. **Recommendations** – Strategic action plan
9. **Data Quality Risks** – Orphan sales, missing loyalty data
10. **Q&A** – Questions from the audience and mentor

---

## 💡 Key Takeaways

### What We Learned

1. **JOINs unlock business value** – combining data across tables answers questions that single tables cannot
2. **Online is a strategic channel** – not a secondary sales channel; it's nearly equal to the flagship store
3. **Data quality issues persist** – 988 orphan sales and `NULL` loyalty tiers indicate ongoing data quality challenges
4. **599 inactive customers** represent a clear marketing opportunity
5. **Inventory has dual problems** – both stockouts and overstock exist simultaneously
6. **3 categories drive 75.9% of revenue** – focus marketing on footwear, men's, and women's clothing

### What We Accomplished

- ✅ Connected all major UrbanStyle tables using SQL JOINs
- ✅ Identified TOP customers and their purchasing patterns
- ✅ Found 599 inactive customers for marketing activation
- ✅ Discovered 12 unsold products and 730 overstock rows
- ✅ Quantified online channel's strategic importance (34.5% of revenue)
- ✅ Identified data quality risks (988 orphan sales, `NULL` loyalty data)

---

## 📊 Presentation Visuals

The presentation included the following visual elements:

| Visual | Description |
| :--- | :--- |
| **Tables** | Summary tables for each role's findings |
| **Charts** | Channel performance comparison (online vs store) |
| **City Maps** | Customer and revenue distribution by city |
| **Category Charts** | Revenue by product category |
| **Inventory Visuals** | Stockout vs overstock comparison |
| **Data Quality Highlights** | Orphan sales and missing loyalty data |

---

## 🎯 Recommendations

### For Anna Mets (Marketing)

1. **Activate 599 inactive customers** – launch a first-purchase campaign (especially in Tallinn and Tartu)
2. **Invest in online channel** – it accounts for 34.5% of revenue with higher AOV
3. **Focus marketing on top 3 categories** – footwear, men's, and women's clothing (75.9% of revenue)
4. **Test unsold products** – run campaigns before removing from catalogue

### For Toomas Kask (IT Director)

1. **Investigate orphan sales** – why are 984 sales not linked to customers (€286,133.99)?
2. **Audit loyalty data** – why is the largest revenue group `NULL`?
3. **Fix negative stock** – 10 rows with negative inventory
4. **Add missing inventory data** – 12 rows without inventory records

### For Kristi Tamm (CEO)

1. **Treat online as a strategic channel** – allocate budget proportionally
2. **Review inventory management** – address both stockouts and overstock
3. **Consider data quality investment** – orphan sales and missing loyalty data affect decision-making

---

## 🔗 Related Files

- [Week 3 Main README](../README.md)
- [Week 3 Code Folder](../Week_3_Code/)
- [Week 3 Conclusions README](../Week_3_Conclusions/README.md)
- [Week 3 Tables README](../Week_3_Tables/README.md)
- [Group Repository – Operations Intelligence](https://github.com/Kolju3/DACA-group)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
