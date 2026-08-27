# ✅ Week 4 – Conclusions & Aggregation Summary

[![DACA](https://img.shields.io/badge/DACA-Week_4-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![SQL](https://img.shields.io/badge/SQL-Aggregation-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document summarises the **conclusions and outcomes** of Week 4's SQL aggregation analysis for UrbanStyle.ltd. The goal was to transform raw sales data (10,118 individual transactions) into a concise set of business KPIs for CEO Kristi Tamm's board meeting.

The analysis followed a structured approach:
1. **Data Cleaning** – Standardising and deduplicating supporting tables (inventory, promotions, suppliers)
2. **Aggregation** – Using `GROUP BY`, `HAVING`, CTEs, and window functions to summarise sales
3. **Trend Analysis** – Monthly and year-over-year performance tracking
4. **Validation** – Cross-checking aggregated totals against raw data
5. **Documentation** – Logging findings and compiling recommendations

---

## 👤 My Contribution (Roll A – Sales Aggregation)

My role was to aggregate **sales data** to provide Kristi Tamm with a clear picture of UrbanStyle's revenue trends, seasonal patterns, and year-over-year growth.

### Methodology

I built a **parameterised CTE-based query structure** where all inputs (period, interval unit, locations, categories, thresholds) are defined in a single `params` CTE. This allows the same query structure to generate multiple reports by simply changing the parameters – a more efficient approach than writing separate queries for each question.

**Key SQL Techniques Used:**
- `DATE_TRUNC()` for time-series aggregation
- `GROUP BY` with multiple dimensions (month, location, category)
- `HAVING` for filtering aggregated results
- CTEs for breaking complex logic into readable steps
- Window functions (`LAG()`) for period-over-period comparisons
- `NULLIF()` to prevent division-by-zero errors
- `ROW_NUMBER()` for duplicate detection and removal

---

## 🔍 Key Findings

### 1. Seasonal Patterns (2023–2024)

All five product categories follow a **similar seasonal pattern**:

| Pattern | Observation |
| :--- | :--- |
| **Summer Peak** | June, July, and August consistently show ~20% higher sales than average |
| **Year-End Spike** | December shows a significant one-month sales increase |
| **Spring/Autumn Dip** | Sales decline during spring and autumn months |

**2023 Monthly Pattern:**

| Period | Average Monthly Orders | Average Monthly Revenue |
| :--- | :--- | :--- |
| **Summer (Jun–Aug)** | 424 | €122,612.18 |
| **Rest of Year** | 342 | €99,945.74 |
| **Difference** | **+24%** | **+22.7%** |

**2024 Monthly Pattern:**

| Period | Average Monthly Orders | Average Monthly Revenue |
| :--- | :--- | :--- |
| **Summer (Jun–Aug)** | 510 | €145,201.76 |
| **Rest of Year** | 405 | €115,891.26 |
| **Difference** | **+26%** | **+25.3%** |

**Key Insight:** The summer peak is consistent across both years, suggesting a genuine seasonal pattern rather than a one-off event. December's year-end spike likely reflects successful end-of-year marketing campaigns.

---

### 2. Category Performance

Products fall into **two distinct groups** by revenue contribution:

| Group | Categories | Revenue Share | Characteristics |
| :--- | :--- | :--- | :--- |
| **High Revenue** | `meeste_riided`, `naiste_riided`, `jalanõusid` | ~76.3% | High volume, high value |
| **Low Revenue** | `aksessuaarid`, `laste_riided` | ~23.7% | Lower volume, lower value |

**Key Insight:** The top 3 categories (men's, women's, footwear) dominate revenue. Marketing and inventory efforts should prioritise these categories, while the lower-revenue categories (accessories, children's) may benefit from targeted campaigns to grow their share.

---

### 3. Year-over-Year Growth (2023 vs 2024)

| Metric | 2023 | 2024 | Change | % Change |
| :--- | :--- | :--- | :--- | :--- |
| **Total Orders** | 4,271 | 5,134 | +863 | **+20.2%** |
| **Total Revenue** | €1,231,783.56 | €1,463,106.64 | +€231,323.08 | **+18.8%** |
| **Average Monthly Orders** | 356 | 428 | +72 | **+20.2%** |
| **Average Monthly Revenue** | €102,648.63 | €121,925.55 | +€19,276.92 | **+18.8%** |
| **Average Order Value (AOV)** | €288.46 | €286.38 | -€2.08 | **-0.7%** |

**Key Insight:** UrbanStyle experienced **~19% growth** in both orders and revenue from 2023 to 2024. The average order value remained stable, meaning growth was driven by **more customers/orders** rather than higher prices.

**⚠️ Correction Note:** The initial estimate of "about 50% growth" was incorrect. The validated data shows **~19% growth** – a significant difference that was corrected after cross-checking the aggregated totals against raw data.

---

### 4. Store Growth Rates

| Location | Growth Rate (2023→2024) | Notes |
| :--- | :--- | :--- |
| **Online** | Fastest growth | Digital channel gaining share |
| **Tartu** | Fast growth | Strong regional performance |
| **Tallinn** | Slower growth | Mature market |
| **Pärnu** | Slower growth | Mature market |

**Key Insight:** Online and Tartu are the fastest-growing channels. This suggests:
- The digital strategy is working effectively
- Tartu has untapped potential
- Tallinn and Pärnu may be approaching market saturation

---

### 5. Inventory Movement Duplicates Audit

During the data cleaning phase, **2 duplicate groups** were identified in the `Inventory_Movements` table:

| Duplicate Group | Product | Location | Quantity | Date | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 1031 | Tallinn | -37 | 2024-10-02 | 1 KEPT, 1 REMOVED |
| 2 | 1140 | Ladu | -33 | 2024-10-04 | 1 KEPT, 1 REMOVED |

**Key Insight:** Each duplicate group consisted of 2 identical records with different `reference` values (order numbers). The smallest `movement_id` in each group was kept; the larger one was removed.

**⚠️ Question for Toomas:** Are these truly duplicates, or are they two separate but coincidentally identical movements? The assumption is that the same (product, location, type, quantity, timestamp) combination cannot occur twice by chance.

---

### 6. Data Quality Validation

| Check | Result |
| :--- | :--- |
| **2023→2024 Growth (%)** | ~19% (not 50%) – corrected after validation |
| **2025–2026 Data Coverage** | Incomplete – cannot make reliable trend conclusions |
| **Orphan Sales** | 984 sales (€286,133.99) without customer links |
| **Inventory Duplicates** | 2 duplicate groups identified and resolved |

**⚠️ 2025–2026 Data Limitation:**

The 2025 data contains only 3 months (January, February, December) and the 2026 data contains only 20 transactions across 6 months. **This is not a "collapse" in business** – it's likely incomplete data import or partial data generation.

**Recommendation:** Before making any claims about 2025–2026 performance, verify whether the data coverage is complete. The correct phrasing is:
> *"2025–2026 data in the database is partial – reliable trend conclusions cannot be drawn at this time. Confirmation is needed on whether the data import for these years is complete."*

---

## 📊 Summary Statistics

| Metric | Value |
| :--- | :--- |
| **Total Sales (2023–2024)** | 9,405 transactions |
| **Total Revenue (2023–2024)** | €2,694,890.20 |
| **2023 Revenue** | €1,231,783.56 |
| **2024 Revenue** | €1,463,106.64 |
| **Year-over-Year Growth** | **+18.8%** |
| **Order Growth** | **+20.2%** |
| **Average Order Value** | €286.38 (stable) |
| **Best Month** | December 2024 (€170,537.76) |
| **Top 3 Categories Share** | 76.3% of revenue |
| **Fastest Growth Channels** | Online, Tartu |

---

## 💡 Recommendations

### For Kristi Tamm (CEO)

| Priority | Recommendation | Rationale |
| :--- | :--- | :--- |
| 1 | **Highlight 19% growth to investors** | Corrected, validated number shows healthy growth |
| 2 | **Plan for summer peak** | June–August consistently 20%+ higher than average |
| 3 | **Invest in online and Tartu** | Fastest-growing channels |
| 4 | **Continue year-end campaigns** | December shows consistent success |
| 5 | **Verify 2025–2026 data** | Don't make decisions on incomplete data |

### For Anna Mets (Marketing)

| Priority | Recommendation | Rationale |
| :--- | :--- | :--- |
| 1 | **Focus on top 3 categories** | 76.3% of revenue |
| 2 | **Boost spring/autumn campaigns** | Off-season periods need activation |
| 3 | **Double down on online** | Fastest growth channel |
| 4 | **Target Tartu** | Strong growth potential |

### For Toomas Kask (IT Director)

| Priority | Recommendation | Rationale |
| :--- | :--- | :--- |
| 1 | **Investigate orphan sales** | 984 sales (€286k) without customer links |
| 2 | **Verify 2025–2026 data completeness** | Incomplete data could mislead decision-making |
| 3 | **Continue inventory duplicate audit** | 2 duplicate groups found |

---

## 🧠 Key Learnings

### Technical Skills

| Skill | What I Learned |
| :--- | :--- |
| **CTEs** | Parameterised CTE structure for reusable queries |
| **Window Functions** | `LAG()` for period-over-period analysis |
| **Data Validation** | Always cross-check aggregated totals |
| **Duplicate Detection** | `ROW_NUMBER()` with audit logging |

### Analytical Thinking

1. **Always validate your numbers** – the initial "50% growth" estimate was wrong; validation showed ~19%

2. **Don't over-interpret incomplete data** – 2025–2026 data doesn't show a "collapse" – it shows incomplete coverage

3. **Seasonal patterns are consistent** – summer peaks and year-end spikes are reliable trends

4. **Document your assumptions** – the duplicate inventory removal assumes identical records are duplicates; this should be documented

5. **Separate data quality from business reality** – data limitations should not be presented as business trends

---

## 🎯 Key Takeaway

> *"Aggregation turns raw numbers into business answers. But aggregation without validation is just guesswork. The key lesson this week: always validate your aggregated totals against raw data before drawing conclusions."*

---

## 🔗 Related Files

- [Week 4 Main README](../README.md)
- [Week 4 Code Folder](../Week_4_Code/)
- [Week 4 Tables README](../Week_4_Tables/README.md)
- [Week 4 Results README](../README.md)
- [Group Repository – Operations Intelligence](https://github.com/Kolju3/DACA-group)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
