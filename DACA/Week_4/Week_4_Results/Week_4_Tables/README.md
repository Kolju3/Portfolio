# 📊 Week 4 – Data Tables & Aggregation Results

[![DACA](https://img.shields.io/badge/DACA-Week_4-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![SQL](https://img.shields.io/badge/SQL-Aggregation-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![CSV](https://img.shields.io/badge/CSV-Data%20Tables-FF6B6B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains **CSV exports** of the aggregation query results generated during Week 4 of the DACA programme. These tables document my sales trend analysis, year-over-year growth calculations, and inventory movement duplicate audit.

The tables demonstrate:
- Monthly sales aggregation with percentages (`sales_count_percent`, `total_sales_percent`)
- Year-over-year growth analysis (2023 vs 2024 vs 2025/2026)
- Average order value trends
- Inventory movement duplicate detection and audit

---

## 📂 Table Files

### 1. Monthly Sales Analysis (2023–2026)

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`2023_Monthly_sales_analyze.csv`** | Monthly sales for 2023 | 12 months, €1,231,983.55 total revenue |
| **`2024_Monthly_sales_analyze.csv`** | Monthly sales for 2024 | 12 months, €1,470,358.02 total revenue |
| **`2025_Monthly_sales_analyze.csv`** | Monthly sales for 2025 (partial) | Jan–Feb + Dec (data coverage limited) |
| **`2026_Monthly_sales_analyze.csv`** | Monthly sales for 2026 (partial) | Jan–Jun (incomplete year) |

---

### 2. Inventory Movement Duplicates Audit

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Inventory_Movments_duplicates.csv`** | Duplicate inventory movement records | 4 records in duplicate groups with KEPT/REMOVED status |

---

## 📊 Detailed Analysis

### Year-over-Year Growth Comparison

| Year | Total Revenue | Total Orders | Average Monthly Revenue | YoY Growth |
| :--- | :--- | :--- | :--- | :--- |
| **2023** | €1,231,983.55 | 4,271 | €102,665.30 | — |
| **2024** | €1,470,358.02 | 5,134 | €122,529.84 | **+19.35%** |
| **2025 (Partial)** | €198,614.27 | 693 | — | — |
| **2026 (Partial)** | €5,009.58 | 20 | — | — |

**Key Insight:** 2024 revenue grew **19.35%** compared to 2023, with orders growing **20.19%**. This indicates healthy business growth across both revenue and volume.

---

### Monthly Sales Breakdown

#### 2023 Monthly Sales

| Month | Orders | % of Total | Revenue | % of Total | AOV |
| :--- | :--- | :--- | :--- | :--- | :--- |
| January | 261 | 6.11% | €80,197.19 | 6.51% | €307.27 |
| February | 276 | 6.46% | €80,345.68 | 6.52% | €291.11 |
| March | 341 | 7.98% | €90,910.99 | 7.38% | €266.60 |
| April | 341 | 7.98% | €100,785.07 | 8.18% | €295.56 |
| May | 343 | 8.03% | €93,356.11 | 7.58% | €272.18 |
| June | 424 | 9.93% | €125,162.84 | 10.16% | €295.20 |
| July | 423 | 9.90% | €122,213.05 | 9.92% | €288.92 |
| August | 425 | 9.95% | €120,460.64 | 9.78% | €283.44 |
| September | 328 | 7.68% | €96,156.08 | 7.81% | €293.16 |
| October | 325 | 7.61% | €93,883.28 | 7.62% | €288.87 |
| November | 326 | 7.63% | €99,124.88 | 8.05% | €304.06 |
| December | 458 | 10.72% | €129,187.75 | 10.49% | €282.07 |
| **Total** | **4,271** | **100%** | **€1,231,983.55** | **100%** | **€288.46** |

**2023 Key Insights:**
- **Best Month:** December (€129,187.75, 10.49% of revenue)
- **Weakest Month:** January (€80,197.19, 6.51% of revenue)
- **Highest AOV:** January (€307.27)
- **Lowest AOV:** March (€266.60)

---

#### 2024 Monthly Sales

| Month | Orders | % of Total | Revenue | % of Total | AOV |
| :--- | :--- | :--- | :--- | :--- | :--- |
| January | 312 | 6.08% | €84,964.53 | 5.81% | €272.32 |
| February | 333 | 6.49% | €89,182.82 | 6.10% | €267.82 |
| March | 413 | 8.04% | €111,402.68 | 7.61% | €269.74 |
| April | 411 | 8.01% | €112,508.18 | 7.69% | €273.74 |
| May | 412 | 8.02% | €116,940.04 | 7.99% | €283.84 |
| June | 509 | 9.91% | €145,394.38 | 9.94% | €285.65 |
| July | 510 | 9.93% | €145,947.06 | 9.98% | €286.17 |
| August | 511 | 9.95% | €144,263.85 | 9.86% | €282.32 |
| September | 391 | 7.62% | €106,411.80 | 7.27% | €272.15 |
| October | 391 | 7.62% | €127,358.68 | 8.70% | €325.73 |
| November | 391 | 7.62% | €108,194.86 | 7.39% | €276.71 |
| December | 550 | 10.71% | €170,537.76 | 11.66% | €310.07 |
| **Total** | **5,134** | **100%** | **€1,470,358.02** | **100%** | **€286.38** |

**2024 Key Insights:**
- **Best Month:** December (€170,537.76, 11.66% of revenue)
- **Weakest Month:** January (€84,964.53, 5.81% of revenue)
- **Highest AOV:** October (€325.73)
- **Lowest AOV:** February (€267.82)

---

### Year-over-Year Comparison (2023 vs 2024)

| Metric | 2023 | 2024 | Change | % Change |
| :--- | :--- | :--- | :--- | :--- |
| **Total Revenue** | €1,231,983.55 | €1,470,358.02 | +€238,374.47 | **+19.35%** |
| **Total Orders** | 4,271 | 5,134 | +863 | **+20.19%** |
| **Average Monthly Revenue** | €102,665.30 | €122,529.84 | +€19,864.54 | **+19.35%** |
| **Average Monthly Orders** | 356 | 428 | +72 | **+20.19%** |
| **Average AOV** | €288.46 | €286.38 | -€2.08 | **-0.72%** |

**Key Insights:**
- Revenue grew **19.35%** year-over-year
- Orders grew **20.19%** year-over-year
- Average Order Value remained relatively stable (-0.72%)
- **December 2024** was the strongest month (€170,537.76)

---

### Partial Year Data (2025–2026)

#### 2025 Monthly Sales (Partial)

| Month | Orders | % of Total | Revenue | % of Total | AOV |
| :--- | :--- | :--- | :--- | :--- | :--- |
| January | 328 | 47.33% | €99,142.79 | 49.92% | €302.26 |
| February | 347 | 50.07% | €94,534.87 | 47.60% | €272.43 |
| December | 18 | 2.60% | €4,936.61 | 2.49% | €274.26 |
| **Total** | **693** | **100%** | **€198,614.27** | **100%** | **€286.61** |

**Note:** 2025 data appears incomplete – only Jan–Feb and Dec are available. The limited data suggests January and February were the primary months for 2025 activity in this dataset.

#### 2026 Monthly Sales (Partial, Jan–Jun)

| Month | Orders | % of Total | Revenue | % of Total | AOV |
| :--- | :--- | :--- | :--- | :--- | :--- |
| January | 6 | 30% | €2,109.93 | 42.12% | €351.66 |
| February | 1 | 5% | €84.41 | 1.69% | €84.41 |
| March | 6 | 30% | €1,532.44 | 30.59% | €255.41 |
| April | 2 | 10% | €200.80 | 4.01% | €100.40 |
| May | 2 | 10% | €536.70 | 10.71% | €268.35 |
| June | 3 | 15% | €545.15 | 10.88% | €181.72 |
| **Total** | **20** | **100%** | **€5,009.58** | **100%** | **€250.48** |

**Note:** 2026 data is very limited (20 orders total), likely a small sample or test dataset. **January** had the highest AOV (€351.66) but only 6 orders.

---

### 3. Inventory Movement Duplicates Audit

**File:** `Inventory_Movments_duplicates.csv`

| movement_id | product_id | location | movement_type | quantity | timestamp | reference | group_count | status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 285 | 1031 | Tallinn | OUT | -37 | 2024-10-02 | ORD-74930 | 2 | KEPT |
| 1762 | 1140 | Ladu | OUT | -33 | 2024-10-04 | ORD-84063 | 2 | KEPT |
| 4774 | 1031 | Tallinn | OUT | -37 | 2024-10-02 | ORD-95096 | 2 | REMOVED |
| 6404 | 1140 | Ladu | OUT | -33 | 2024-10-04 | ORD-44703 | 2 | REMOVED |

**Key Insight:**
- 2 duplicate groups identified (`group_count = 2`)
- Each group consists of 2 identical records (same product, location, movement_type, quantity, timestamp)
- The smallest `movement_id` in each group was kept (KEPT)
- The larger `movement_id` in each group was removed (REMOVED)

**Duplicate Group 1 (Product 1031, Tallinn, OUT, -37, 2024-10-02):**
- `movement_id 285` → KEPT
- `movement_id 4774` → REMOVED

**Duplicate Group 2 (Product 1140, Ladu, OUT, -33, 2024-10-04):**
- `movement_id 1762` → KEPT
- `movement_id 6404` → REMOVED

---

## 🔍 SQL Logic Used

### Monthly Sales Aggregation

```sql
WITH params AS (
    SELECT '2024-01-01'::date AS start_date,
           '2024-12-31'::date AS end_date,
           'month'::text      AS interval_unit
),
filtered AS (
    SELECT sale_id, total_price, sale_date
    FROM "Testing_Sales_Cleaned"
    WHERE sale_date BETWEEN (SELECT start_date FROM params)
                        AND (SELECT end_date FROM params)
),
aggregated AS (
    SELECT date_trunc((SELECT interval_unit FROM params), sale_date) AS interval_start,
           COUNT(sale_id)          AS sales_count,
           SUM(total_price)        AS total_sales_value,
           AVG(total_price)        AS avg_sale_value
    FROM filtered
    GROUP BY interval_start
),
totals AS (
    SELECT SUM(sales_count)       AS total_sales_count,
           SUM(total_sales_value) AS total_sales_value
    FROM aggregated
)
SELECT a.interval_start,
       a.sales_count,
       ROUND(100.0 * a.sales_count / t.total_sales_count, 2) AS sales_count_percent,
       a.total_sales_value,
       ROUND(100.0 * a.total_sales_value / t.total_sales_value, 2) AS total_sales_percent,
       ROUND(a.avg_sale_value, 2) AS avg_sale_value
FROM aggregated a
CROSS JOIN totals t
ORDER BY a.interval_start;
