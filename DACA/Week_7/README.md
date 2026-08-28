# 🐍 Week 7 – RFM Customer Segmentation with Python

[![Python](https://img.shields.io/badge/Python-3.10-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![pandas](https://img.shields.io/badge/pandas-2.0-150458?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Plotly](https://img.shields.io/badge/Plotly-3F4F75?style=for-the-badge&logo=plotly&logoColor=white)](https://plotly.com/)
[![DACA](https://img.shields.io/badge/DACA-Week_7-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Week Overview

**Week 7** introduced **Python and pandas** for data analysis, with a focus on **RFM (Recency, Frequency, Monetary) customer segmentation**. The goal was to analyse UrbanStyle's customer transaction data to identify high-value segments and inform marketing strategies.

This was the first week where the team moved from SQL to Python for deeper analytical modelling. My role was **Roll D – Visualization & Findings** – turning the RFM results into clear, actionable insights through visualisations and a written summary for Marko Saar (Product Manager).

---

## 🎯 Weekly Objectives

| Objective | Description | Status |
| :--- | :--- | :--- |
| **Python & pandas** | Learn data manipulation with pandas (DataFrames, filtering, aggregation) | ✅ |
| **RFM Analysis** | Compute Recency, Frequency, and Monetary scores for each customer | ✅ |
| **Segmentation** | Group customers into segments (VIP Champions, Loyal, Potential, At Risk, Lost) | ✅ |
| **Visualisation** | Create interactive Plotly plots showing segment distribution and relationships | ✅ |
| **Business Insights** | Derive actionable recommendations for Marko | ✅ |

---

## 👥 Team Roles & Contributions

| Role | Team Member | Focus Area |
| :--- | :--- | :--- |
| **Roll A – Data Loading** | Natalia | Loading sales and customer data from Supabase with pagination |
| **Roll B – Data Cleaning** | Olga | Handling NULL values, duplicates, date parsing, outlier removal |
| **Roll C – RFM Analysis** | Helen | Computing RFM scores, defining segments, exporting CSV |
| **Roll D – Visualization & Findings** | **Kalju (Me)** | Creating interactive Plotly graphs and business interpretation |

---

## 🔍 Key Findings Summary

### 1. Data Loading (Natalia)
- Loaded 10,118 sales rows and 3,150 customer rows from Supabase
- Used pagination to handle Supabase's 1,000-row limit
- Merged tables using `LEFT JOIN` on `customer_id`

### 2. Data Cleaning (Olga)
- Removed duplicates using `invoice_id`
- Handled NULL values in critical columns (`customer_id`, `sale_date`, `total_price`)
- Parsed dates and removed negative `total_price` values
- Final dataset: **8,950 rows**, **2,540 unique customers**

### 3. RFM Analysis (Helen)
- **Recency:** Days since last purchase (reference date: 2025-02-28)
- **Frequency:** Number of orders per customer
- **Monetary:** Total spend per customer
- Scored each metric on a 1–5 scale using quantiles
- Created 5 customer segments

### 4. Visualisations & Insights (Kalju – My Role)

**Segment Distribution:**
| Segment | Customers | Customer Share | Monetary Share |
| :--- | :---: | :---: | :---: |
| **VIP Champions** | 455 | 17.91% | 42.82% |
| **Loyal** | 679 | 26.73% | 29.75% |
| **Potential** | 759 | 29.88% | 19.49% |
| **At Risk** | 529 | 20.83% | 7.18% |
| **Lost** | 118 | 4.65% | 0.76% |

**Key Insight:** VIP + Loyal = 44.65% of customers but **72.57% of total monetary value**. A small group drives most of the revenue.

**Top 10 VIP Champions** account for **8.64%** of total RFM-analysed revenue (€2.677M total).

---

## 👤 My Individual Contribution (Roll D)

My role was to **turn RFM data into a compelling business story** through visualisations.

### What I Did

1. **Three Interactive Plotly Graphs:**
   - **Bar chart:** Customer distribution across segments (with count and percentage labels)
   - **Scatter plot (log scale):** Recency vs Monetary value, coloured by segment, size = Frequency
   - **Donut chart:** Top 10 VIP Champions' share of total revenue

2. **Business Interpretation for Marko:**
   - **VIP Champions:** Reward with exclusivity (early access, VIP events) – not price discounts
   - **Loyal:** Nurture toward VIP status with loyalty programmes
   - **Potential:** Largest group – test loyalty-building campaigns
   - **At Risk:** Prioritise high-monetary value customers for win-back campaigns
   - **Lost:** Low-value segment – minimal investment

3. **Documentation:**
   - Integrated all work into the group Jupyter Notebook
   - Ensured the notebook runs end-to-end without errors

---

## ⚠️ Limitations & Quality Control

- **Reference date mismatch:** The RFM reference date (2025-02-28) is earlier than the dataset (which extends to 2026-06-28), creating 25 customers with negative Recency. This is a data range issue, not a calculation error.
- **Monetary = revenue,** not profit or margin
- **Frequency = count of `sale_id` rows** – if one order has multiple rows, this definition should be reviewed
- **Duplicates check** used `invoice_id` (recommended over full row comparison)

---

## 📁 Folder Structure

```text
Week_7/
├── README.md                  # This file
├── Week_7_Code/               # Jupyter Notebook and Python scripts
├── Week_7_Feedback/           # Personal reflections on the week
├── Week_7_Materials/          # Course materials and RAG files
└── Week_7_Results/            # Visualisations, conclusions
    ├── Week_7_Conclusions/
    ├── Week_7_Pictures/
    ├── Week_7_Presentation/   # (empty – no separate presentation)
    └── Week_7_Tables/         # (empty – no table exports)
```
---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
