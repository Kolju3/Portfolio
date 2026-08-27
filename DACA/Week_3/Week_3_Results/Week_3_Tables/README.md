# 📊 Week 3 – Data Tables & JOIN Analysis Results

[![DACA](https://img.shields.io/badge/DACA-Week_3-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![SQL](https://img.shields.io/badge/SQL-JOINs-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![CSV](https://img.shields.io/badge/CSV-Data%20Tables-FF6B6B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains **CSV exports** of the JOIN analysis results generated during Week 3 of the DACA programme. These tables document my multi-table analysis of UrbanStyle's sales, customer, product, and inventory data.

The tables demonstrate:
- Multi-table JOINs (`sales` + `customers` + `products`)
- Channel analysis (online vs store)
- City and category performance
- Sales summary with percentages
- Data quality checks (orphan sales)

---

## 📂 Table Files

### 1. Channel & Location Analysis

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Channels.csv`** | Unique sales channels and store locations | 4 combinations: Online, Pärnu, Tartu, Tallinn |
| **`Sales_Table_analyze_per_location.csv`** | Sales by location with percentages | Online (34.22%), Tallinn (37.57%), Tartu (17.76%), Pärnu (10.46%) |

**Key Finding:** Online represents **34.22%** of all sales transactions and **34.54%** of total revenue.

| Sale Location | Number of Sales | % of Sales | Total Revenue | % of Revenue |
| :--- | :--- | :--- | :--- | :--- |
| **Total** | 10,118 | 100% | €2,898,513.90 | 100% |
| **Online** | 3,462 | 34.22% | €1,001,224.86 | 34.54% |
| **Tallinn** | 3,801 | 37.57% | €1,086,272.37 | 37.48% |
| **Tartu** | 1,797 | 17.76% | €522,286.81 | 18.02% |
| **Pärnu** | 1,058 | 10.46% | €288,729.86 | 9.96% |

---

### 2. Customer + Sales Analysis

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`How_clients_bought_from_different_places.csv`** | Customer count and revenue by city + channel | 48 city-channel combinations |
| **`No_unidentified_customers_check.csv`** | Sales linked to customers | 9,134 sales linked to customers (€2,612,379.91) |
| **`Unknown_sales.csv`** | Sales missing customer ID | 984 orphan sales (€286,133.99) |

**Key Finding:** 984 sales (9.7% of total) cannot be linked to any customer – representing €286,133.99 in "orphan" revenue.

| Metric | Value |
| :--- | :--- |
| **Sales Linked to Customers** | 9,134 |
| **Value Linked to Customers** | €2,612,379.91 |
| **Orphan Sales** | 984 |
| **Orphan Revenue** | €286,133.99 |

---

### 3. Customer Shopping Habits by Location

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Client_shopping_habits_by_location.csv`** | Full shopping analysis by city, channel, category | Quantity and revenue with percentage breakdowns |
| **`Client_shopping_habits_by_location_last_year.csv`** | Shopping analysis for the last year only | Filtered view of recent activity |

**Sample Data (Tallinn - Online):**

| City | Channel | Category | Total Quantity | Quantity % | Total Revenue | Revenue % |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Tallinn | Online | Meeste_riided | 512 | 36.11% | €88,324.79 | 34.45% |
| Tallinn | Online | Jalanõusid | 479 | 35.48% | €98,036.21 | 34.88% |
| Tallinn | Online | Laste_riided | 435 | 32.88% | €35,566.95 | 32.77% |
| Tallinn | Online | Naiste_riided | 385 | 30.29% | €71,730.21 | 31.37% |
| Tallinn | Online | Aksessuaarid | 345 | 31.05% | €42,269.80 | 31.77% |

**Sample Data (Tallinn - Tallinn Store):**

| City | Channel | Category | Total Quantity | Quantity % | Total Revenue | Revenue % |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Tallinn | Tallinn | Jalanõusid | 502 | 37.19% | €104,435.96 | 37.16% |
| Tallinn | Tallinn | Meeste_riided | 527 | 37.17% | €98,284.46 | 38.34% |
| Tallinn | Tallinn | Naiste_riided | 521 | 40.99% | €91,690.30 | 40.11% |
| Tallinn | Tallinn | Aksessuaarid | 458 | 41.22% | €55,769.67 | 41.92% |
| Tallinn | Tallinn | Laste_riided | 525 | 39.68% | €43,540.35 | 40.12% |

---

### 4. Simplified Shopping Analysis

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Clients_shopping_analyze_by_type.csv`** | Simplified city + channel + category analysis | Clean version of shopping habits data |

---

### 5. Quick Checks

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Quick_Sales_value_check.csv`** | Total sales count and value | 10,118 sales, €2,898,513.90 |

---

## 🔍 Key Insights

### Channel Performance

| Channel | Sales % | Revenue % | AOV |
| :--- | :--- | :--- | :--- |
| **Online** | 34.22% | 34.54% | €289.20 |
| **Tallinn Store** | 37.57% | 37.48% | €285.84 |
| **Tartu Store** | 17.76% | 18.02% | €290.64 |
| **Pärnu Store** | 10.46% | 9.96% | €272.90 |

**Key Insight:** Online AOV (€289.20) is higher than the Tallinn store average (€285.84), suggesting online customers spend more per transaction.

### Category Performance

The top 3 categories by revenue are:

| Category | Revenue Share |
| :--- | :--- |
| **Jalanõusid (Footwear)** | ~26.7% |
| **Meeste_riided (Men's)** | ~25.9% |
| **Naiste_riided (Women's)** | ~23.7% |

**Combined top 3 categories:** ~75.9% of total revenue.

### Data Quality Issues

| Issue | Count | Impact |
| :--- | :--- | :--- |
| **Orphan Sales** | 984 | €286,133.99 cannot be attributed to customers |
| **Inactive Customers** | 599 | Registered but never purchased |
| **Unsold Products** | 12 | Products with zero sales |

---

## 🧠 SQL Logic Used

### Multi-Table JOIN for Channel Analysis

```sql
-- Analyse sales by channel, city, and category
SELECT
    c.city,
    s.location AS channel,
    p.category,
    SUM(s.total_price) AS total_revenue,
    SUM(s.quantity) AS total_quantity
FROM
    "Testing_Sales_Cleaned" AS s
INNER JOIN "Testing_Customers_Cleaned" AS c
    ON s.customer_id = c.customer_id
INNER JOIN "Testing_Products_Cleaned" AS p
    ON s.product_id = p.product_id
GROUP BY
    c.city,
    s.location,
    p.category
ORDER BY
    c.city,
    s.location,
    p.category;
