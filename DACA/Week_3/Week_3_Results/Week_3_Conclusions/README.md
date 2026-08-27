# ✅ Week 3 – Conclusions & JOIN Analysis Summary

[![DACA](https://img.shields.io/badge/DACA-Week_3-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![SQL](https://img.shields.io/badge/SQL-JOINs-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document summarises the **conclusions and outcomes** of Week 3's SQL JOIN analysis for UrbanStyle.ltd. The goal was to connect fragmented data tables (sales, customers, products, inventory) to answer real business questions posed by Anna Mets (Marketing Lead) and Toomas Kask (IT Director).

The analysis followed a structured approach:
1. **Data Connection** – Using SQL JOINs to combine tables
2. **Exploration** – Understanding the connected data landscape
3. **Analysis** – Answering specific business questions
4. **Documentation** – Logging findings and compiling recommendations

---

## 👤 My Contribution (Roll D – Channels + Marketing)

My role was to analyse **sales channels, cities, and categories** using multi-table JOINs to answer Anna's marketing questions.

### What I Did

1. **Analysed sales channels** – online vs store performance with revenue and count breakdowns
2. **Combined 3 tables** – `sales` + `customers` + `products` for dimensional analysis
3. **Used `ROLLUP` for grand totals** – clean summary with percentages
4. **Calculated channel share** – online accounts for 34.5% of revenue
5. **Analysed city-level performance** – customer distribution and revenue by location
6. **Identified top categories** – footwear, men's, and women's clothing dominate
7. **Detected data quality issues** – 984 orphan sales (9.7%) without customer links

### My SQL Techniques

| Technique | Purpose |
| :--- | :--- |
| `INNER JOIN` | Connect sales, customers, and products |
| `ROLLUP` | Generate subtotals and grand totals |
| CTEs (`WITH`) | Break complex analysis into readable steps |
| `UNION ALL` | Combine individual locations with grand total |
| `NULLIF()` | Prevent division by zero in percentage calculations |
| Window Functions | Calculate percentage shares per group |

---

## 🔍 Key Findings Summary

### 1. Channel & Location Performance

| Channel | Sales | % of Sales | Revenue | % of Revenue | AOV |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Total** | 10,118 | 100% | €2,898,513.90 | 100% | €286.45 |
| **Online** | 3,462 | 34.22% | €1,001,224.86 | 34.54% | €289.20 |
| **Tallinn Store** | 3,801 | 37.57% | €1,086,272.37 | 37.48% | €285.84 |
| **Tartu Store** | 1,797 | 17.76% | €522,286.81 | 18.02% | €290.64 |
| **Pärnu Store** | 1,058 | 10.46% | €288,729.86 | 9.96% | €272.90 |

**Key Insight:** Tallinn and Online together account for **72.1%** of revenue. Online is not a secondary channel – it's a strategic sales pillar with revenue nearly matching the flagship Tallinn store. Online AOV (€289.20) is slightly higher than the Tallinn store average (€285.84).

---

### 2. Orphan Sales (Data Quality Issue)

| Metric | Value |
| :--- | :--- |
| **Sales Linked to Customers** | 9,134 (90.3%) |
| **Orphan Sales (No Customer Match)** | 984 (9.7%) |
| **Orphan Revenue** | €286,133.99 |

**Impact:** 9.7% of all sales cannot be attributed to any customer. This means customer lifetime value, retention analysis, and personalisation efforts are based on incomplete data.

**Recommendation:** Investigate the source of these orphan sales. Possible causes:
- Checkout process without requiring customer login
- System integration gaps between online and POS systems
- Data import errors from legacy systems

---

### 3. Customer Location vs Purchase Location

| Finding | Detail |
| :--- | :--- |
| **Tartu Customers** | More purchases from Tallinn store and Online than Tartu store |
| **Haapsalu Customers** | Similar pattern – online dominates |
| **Tallinn Customers** | Mostly shop at Tallinn store, but online is strong |

**Key Insight:** A customer's city does not determine where they shop. Tartu customers frequently shop online or travel to Tallinn. This suggests:
- Online is a substitute for physical stores in smaller cities
- Brand perception in Tallinn may drive cross-city shopping
- UrbanStyle's brand appeal extends beyond local store proximity

---

### 4. Category Performance

| Category | Products | Sales | Revenue | Revenue % |
| :--- | :--- | :--- | :--- | :--- |
| Jalanõusid (Footwear) | 73 | 2,031 | €774,034.75 | 26.7% |
| Meeste_riided (Men's) | 82 | 2,266 | €749,798.72 | 25.9% |
| Naiste_riided (Women's) | 70 | 2,022 | €686,464.24 | 23.7% |
| Aksessuaarid | 67 | 1,772 | €393,035.82 | 13.6% |
| Laste_riided (Children's) | 70 | 2,027 | €305,844.45 | 10.6% |

**Key Insight:** The top 3 categories (Footwear, Men's, Women's) account for **76.3%** of total revenue. Marketing and inventory efforts should prioritise these categories.

---

## 💡 Team Findings

| Team Member | Role | Key Finding |
| :--- | :--- | :--- |
| **Natalia** | Roll A – Sales + Customers | 988 orphan sales; TOP customer Tiina Pärn (€27,668) |
| **Olga** | Roll B – Customers Without Purchases | 599 inactive registered customers (~19% of all registrations) |
| **Helen** | Roll C – Products + Inventory | 12 unsold products; 730 overstock rows; 221 reorder needed |
| **Kalju (Me)** | Roll D – Channels + Marketing | Online = 34.5% of revenue; Top 3 categories = 76.3% of revenue |

---

## 📊 Key Insights

### What Worked Well

| Area | Finding |
| :--- | :--- |
| **Online Channel** | Strategic sales pillar – 34.5% of revenue with higher AOV than stores |
| **Tallinn Market** | Largest revenue contributor – €1.09 million (37.5% of total) |
| **Category Focus** | Top 3 categories drive 76.3% of revenue |
| **Customer Reach** | 2,551 active customers (81% of registered) |

### What Needs Attention

| Issue | Impact | Priority |
| :--- | :--- | :--- |
| **Orphan Sales** | 984 sales (€286k) without customer attribution | High |
| **Inactive Customers** | 599 registered customers never purchased | High |
| **Unsold Products** | 12 products with zero sales | Medium |
| **Overstock** | 730 rows with excess inventory | Medium |
| **Loyalty Data Gaps** | `NULL` loyalty tier for largest revenue group | High |

---

## 🎯 Recommendations

### For Anna Mets (Marketing)

| Priority | Recommendation | Rationale |
| :--- | :--- | :--- |
| 1 | **Activate 599 inactive customers** | First-purchase campaign (especially Tallinn and Tartu) |
| 2 | **Invest in online channel** | 34.5% of revenue with higher AOV |
| 3 | **Focus marketing on top 3 categories** | Footwear, men's, women's = 76.3% of revenue |
| 4 | **Test unsold products** | Run campaigns before removing from catalogue |

### For Toomas Kask (IT Director)

| Priority | Recommendation | Rationale |
| :--- | :--- | :--- |
| 1 | **Investigate orphan sales** | 984 sales (€286k) not linked to customers |
| 2 | **Audit loyalty data** | Why is the largest revenue group `NULL`? |
| 3 | **Fix inventory data quality** | Negative stock (10 rows) and missing data (12 rows) |

### For Kristi Tamm (CEO)

| Priority | Recommendation | Rationale |
| :--- | :--- | :--- |
| 1 | **Treat online as a strategic channel** | Allocate budget proportionally to revenue share |
| 2 | **Review inventory management** | Address both stockouts and overstock |
| 3 | **Consider data quality investment** | Orphan sales and missing loyalty data affect decision-making |

---

## 🧠 Key Learnings

### Technical Skills

| Skill | What I Learned |
| :--- | :--- |
| **JOINs** | `INNER JOIN`, `LEFT JOIN`, multi-table JOINs |
| **ROLLUP** | Professional way to generate subtotals and grand totals |
| **CTEs** | Breaking complex queries into readable steps |
| **Window Functions** | `OVER (PARTITION BY)` for percentage calculations |
| **Data Quality** | Identifying orphan sales and data gaps |

### Analytical Thinking

1. **JOINs unlock business value** – connecting data across tables reveals insights that single tables cannot provide

2. **Data quality persists** – even after cleaning, orphan sales and missing loyalty data affect analysis

3. **Online is strategic** – not a secondary channel; it's a revenue pillar

4. **Customer city ≠ purchase city** – customers don't always shop in their own city

5. **Category concentration** – 3 categories drive 76.3% of revenue

6. **Documentation matters** – every finding must be traceable to a query

---

## 📊 Summary Statistics

| Metric | Value |
| :--- | :--- |
| **Total Sales** | 10,118 |
| **Total Revenue** | €2,898,513.90 |
| **Online Revenue** | €1,001,224.86 (34.5%) |
| **Active Customers** | 2,551 |
| **Inactive Customers** | 599 |
| **Orphan Sales** | 984 (€286,133.99) |
| **Unsold Products** | 12 |
| **Overstock Rows** | 730 |
| **Top 3 Categories Share** | 76.3% |

---

## 🔗 Related Files

- [Week 3 Main README](../README.md)
- [Week 3 Code Folder](../Week_3_Code/)
- [Week 3 Tables README](../Week_3_Tables/README.md)
- [Week 3 Presentation README](../Week_3_Presentation/README.md)
- [Group Repository – Operations Intelligence](https://github.com/Kolju3/DACA-group)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
