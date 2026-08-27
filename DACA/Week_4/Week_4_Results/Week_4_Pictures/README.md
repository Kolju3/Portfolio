# 🖼️ Week 4 – Pictures & Visualisations (MATLAB)

[![DACA](https://img.shields.io/badge/DACA-Week_4-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![MATLAB](https://img.shields.io/badge/MATLAB-Visualisation-0076A8?style=for-the-badge&logo=mathworks&logoColor=white)](https://www.mathworks.com/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains **12 visualisations** created during Week 4 of the DACA programme using **MATLAB**. These images document my analysis of UrbanStyle's sales trends across different locations and time periods, helping to identify seasonal patterns, growth trends, and a critical data gap in 2025.

---

## 🎯 Why MATLAB?

At the time of this analysis, I had not yet learned Python's data visualisation libraries (such as `matplotlib`, `plotly`, or `seaborn`). Rather than waiting, I chose to use **MATLAB** – a tool I was already familiar with – to create the visualisations.

This decision reflects a practical approach to data analysis: **use the tools you have available** to answer the questions at hand, rather than waiting until you've learned the "perfect" tool.

---

## 📸 Image Gallery

### Location-Specific Sales Analysis

| Image | Description | Key Insight |
| :--- | :--- | :--- |
| **`Online - sales_count (log y).png`** | Online channel order count (logarithmic Y-axis) | Shows trends in online sales volume |
| **`Online - total_sales_value (log y).png`** | Online channel total revenue (logarithmic Y-axis) | Revenue trends for the online channel |
| **`Pärnu - sales_count (log y).png`** | Pärnu store order count (logarithmic Y-axis) | Pärnu store performance over time |
| **`Pärnu - total_sales_value (log y).png`** | Pärnu store total revenue (logarithmic Y-axis) | Revenue trends for Pärnu store |
| **`Tallinn - sales_count (log y).png`** | Tallinn store order count (logarithmic Y-axis) | Tallinn store performance over time |
| **`Tallinn - total_sales_value (log y).png`** | Tallinn store total revenue (logarithmic Y-axis) | Revenue trends for Tallinn store |
| **`Tartu - sales_count (log y).png`** | Tartu store order count (logarithmic Y-axis) | Tartu store performance over time |
| **`Tartu - total_sales_value (log y).png`** | Tartu store total revenue (logarithmic Y-axis) | Revenue trends for Tartu store |

---

### Overall Sales Summary

| Image | Description | Key Insight |
| :--- | :--- | :--- |
| **`Total - sales_count (log y).png`** | Total order count across all channels (log Y-axis) | Overall volume trends |
| **`Total - sales_count_2 (log y).png`** | Total order count (alternative view) | Confirms the same pattern |
| **`Total - total_sales_value (log y).png`** | Total revenue across all channels (log Y-axis) | Overall revenue trends |
| **`Total - total_sales_value_2 (log y).png`** | Total revenue (alternative view) | Confirms the same pattern |

---

## 🔍 Key Insights from Visualisations

### 1. The 2025 Data Drop

The MATLAB visualisations revealed a **critical data quality issue**: sales appear to drop to near-zero levels at the start of 2025 and remain there for approximately 9 months.

**What the graphs show:**
- 2023 and 2024 show consistent monthly sales (hundreds of transactions, tens of thousands in revenue)
- January 2025 shows a sudden, sharp drop
- February–November 2025 show near-zero activity (only a handful of transactions)
- December 2025 shows a small recovery
- 2026 shows very limited activity

**Important Note:** This is **not an actual business collapse** – it is almost certainly a **data coverage issue**. The most likely explanation is that the data import for 2025–2026 was incomplete, or that the Week 2 data cleaning rules (`sale_date > CURRENT_DATE` being set to NULL or removed) affected these records.

**Recommendation:** Before presenting this as a business trend, verify the completeness of 2025–2026 data. The correct phrasing is:
> *"2025–2026 data in the database is partial – reliable trend conclusions cannot be drawn at this time."*

---

### 2. The Linear vs Logarithmic Y-Axis Problem

The visualisations clearly demonstrated why **logarithmic Y-axis scaling** is often superior for time-series analysis:

| Y-Axis Type | Issue |
| :--- | :--- |
| **Linear** | The 2023–2024 data (high values) compresses the 2025–2026 data (low values) into an unreadable line at the bottom |
| **Logarithmic** | Both the high and low values are visible, clearly showing the pattern across the entire period |

**Key Learning:** When data spans multiple orders of magnitude, logarithmic scaling reveals patterns that linear scaling hides. This is a valuable lesson in data visualisation best practices.

---

### 3. Seasonal Patterns Confirmed

The visualisations also confirmed the seasonal patterns identified in the aggregation analysis:

- **Summer peaks** (June–August) consistently show higher sales
- **Year-end spikes** (December) show strong performance
- **Spring/Autumn dips** show lower activity

These patterns are visible across all four locations (Online, Tallinn, Tartu, Pärnu), suggesting they are genuine seasonal trends rather than location-specific anomalies.

---

## 📊 Visualisation Summary

| Channel | Sales Count | Revenue | Key Observation |
| :--- | :--- | :--- | :--- |
| **Online** | 3,462 | €1,001,224.86 | Fastest-growing channel; clear seasonal pattern |
| **Tallinn** | 3,801 | €1,086,272.37 | Largest channel; mature, slower growth |
| **Tartu** | 1,797 | €522,286.81 | Strong growth; second-largest channel |
| **Pärnu** | 1,058 | €288,729.86 | Smallest; stable performance |
| **Total** | 10,118 | €2,898,513.90 | Full picture; shows all patterns combined |

---

## 🧠 What I Learned

### Visualisation Skills

| Lesson | Why It Matters |
| :--- | :--- |
| **Logarithmic scaling is essential** | Reveals patterns across large data ranges |
| **MATLAB is a viable alternative** | Use available tools; don't wait for the "perfect" one |
| **Visualisation reveals data gaps** | The 2025 drop was visible immediately in the graphs |
| **Always question unusual patterns** | A "collapse" is more likely a data issue than a business crisis |

### Analytical Thinking

1. **Visualisations are diagnostic tools** – the 2025 drop was visible immediately in the graphs, prompting investigation

2. **Don't confuse data gaps with business trends** – the "collapse" is almost certainly incomplete data, not a real business decline

3. **Logarithmic scaling is not cheating** – it's a legitimate way to visualise data across orders of magnitude

4. **Use what you know** – MATLAB was the right choice for this analysis given my skills at the time

---

## 🔗 Related Files

- [Week 4 Main README](../README.md)
- [Week 4 Code Folder](../Week_4_Code/)
- [Week 4 Tables README](../Week_4_Tables/README.md)
- [Week 4 Conclusions README](../Week_4_Conclusions/README.md)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
