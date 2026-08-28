# 📊 Week 5 – Data Tables & Query Results

[![DACA](https://img.shields.io/badge/DACA-Week_5-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![SQL](https://img.shields.io/badge/SQL-Data%20Aggregation-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![CSV](https://img.shields.io/badge/CSV-Data%20Tables-FF6B6B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains **CSV exports** of the query results used in the Week 5 marketing dashboard. These tables were loaded into the Python/Streamlit dashboard and used to create the three main charts: revenue trend, top products, and sales by city.

The data comes from the **Test Tables** that were cleaned and prepared in Weeks 2-4.

---

## 📂 Table Files

### 1. Sales Data (Aggregated)

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Sales_Table_analyze_per_location.csv`** | Sales by location with percentages | Online (34.22%), Tallinn (37.57%), Tartu (17.76%), Pärnu (10.46%) |

**Key Findings:**

| Location | Sales Count | % of Sales | Revenue | % of Revenue |
| :--- | :--- | :--- | :--- | :--- |
| Online | 3,462 | 34.22% | €1,001,224.86 | 34.54% |
| Tallinn | 3,801 | 37.57% | €1,086,272.37 | 37.48% |
| Tartu | 1,797 | 17.76% | €522,286.81 | 18.02% |
| Pärnu | 1,058 | 10.46% | €288,729.86 | 9.96% |

---

### 2. Customer Shopping Analysis

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Clients_shopping_analyze_by_type.csv`** | Sales by city, channel, and product category | Detailed breakdown of shopping patterns |
| **`Client_shopping_habits_by_location.csv`** | Shopping habits by location with percentages | Full location-based analysis with percentages |
| **`How_clients_bought_from_different_places.csv`** | Customer count and revenue by city + channel | 48 city-channel combinations |

**Key Finding:**

| City | Channel | Customers | Revenue |
| :--- | :--- | :--- | :--- |
| Tallinn | Online | 671 | €335,927.96 |
| Tallinn | Tallinn Store | 709 | €393,720.74 |
| Tartu | Online | 344 | €177,922.31 |
| Tartu | Tartu Store | 234 | €96,984.47 |

---

### 3. Quick Checks

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Quick_Sales_value_check.csv`** | Total sales count and value | 10,118 sales, €2,898,513.90 |
| **`No_unidentified_customers_check.csv`** | Sales linked to customers | 9,134 sales, €2,612,379.91 |

---

## 🔍 SQL Logic Used

### Sales by Location

The query uses `ROLLUP` to generate subtotals and a grand total, with a `CASE` statement to order the "Total" row first.

### Customer Shopping Analysis

The analysis uses `INNER JOIN` between sales and customers, grouping by city and location to calculate customer counts and total revenue.

---

## 💡 Why This Data Matters

### Dashboard Insights

| Data Source | Chart | Business Question |
| :--- | :--- | :--- |
| Sales by Location | Revenue Trend | "Are we growing?" |
| Product Revenue | Top Products | "What sells best?" |
| City Distribution | Sales by City | "Where do customers come from?" |

---

## 🔗 Related Files

- [Week 5 Main README](../README.md)
- [Week 5 Code Folder](../Week_5_Code/)
- [Week 5 Conclusions README](../Week_5_Conclusions/README.md)
- [Week 5 Pictures README](../Week_5_Pictures/README.md)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
