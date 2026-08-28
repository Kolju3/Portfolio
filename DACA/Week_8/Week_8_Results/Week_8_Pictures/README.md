# 🖼️ Week 8 – Python & Dashboard Screenshots

[![DACA](https://img.shields.io/badge/DACA-Week_8-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Screenshots](https://img.shields.io/badge/Screenshots-12-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains **screenshots** taken during Week 8 of the DACA programme. These images document my Python analysis and dashboard creation work.

The screenshots demonstrate:
- Python code execution (Jupyter notebook)
- Data cleaning in pandas
- Data visualisation (Plotly/Matplotlib)
- Dashboard creation (Streamlit or Power BI)

---

## 🎯 The Core Work

Week 8 focused on:
1. **Connecting Python to Supabase** – loading data into pandas DataFrames
2. **Data cleaning** – handling NULLs, duplicates, negative values
3. **Data analysis** – CLV calculation, customer segmentation, Marketing ROI
4. **Dashboard creation** – interactive visualisations

---

## 📸 Screenshot Gallery

### Part 1: Python Setup & Database Connection

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| `python_connection_success.png` | Successful Supabase connection | Database connected, tables loaded |
| `data_loaded_into_pandas.png` | Data loaded into pandas DataFrames | sales, customers, products DataFrames |

### Part 2: Data Cleaning & Transformation

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| `data_quality_check.png` | Data quality check results | NULLs, duplicates, data types |
| `city_standardisation.png` | City name cleaning | Before/after standardisation |
| `calculated_columns.png` | New columns created | Margin, margin percentage |

### Part 3: Analysis Results

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| `clv_calculation.png` | Customer Lifetime Value calculation | CLV formula and results |
| `customer_segments.png` | Customer segmentation results | High/Medium/Low value segments |
| `marketing_roi_calculation.png` | Marketing ROI by channel | Email, Instagram, Facebook |

### Part 4: Visualisations

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| `revenue_trend.png` | Monthly revenue trend | Line chart |
| `category_revenue.png` | Revenue by category | Bar chart |
| `customer_segments_chart.png` | Revenue by customer segment | Column chart |
| `channel_performance.png` | Online vs. Store revenue | Donut chart |

### Part 5: Dashboard (Track B - Streamlit)

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| `streamlit_dashboard.png` | Full dashboard view | KPIs, charts, filters |
| `streamlit_sidebar.png` | Dashboard sidebar filters | Date, Channel, Category filters |

### Part 6: Final Outputs

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| `dashboard_pdf_export.png` | Dashboard exported to PDF | Ready for investor presentation |
| `week8_insights_summary.png` | Summary of key insights | Top 5 findings |

---

## 🔍 What These Images Show

### Data Quality Improvements

| Before | After |
| :--- | :--- |
| "Tallinn", "tallinn", "TALLINN", "Tallinn " | All standardised to "Tallinn" |
| Duplicate invoices | Unique transactions |
| Negative prices (305 transactions) | Clean pricing data |
| NULL customer_ids (1,487 transactions) | Customer analysis now possible |

### Analysis Results

| Metric | Before Cleaning | After Cleaning |
| :--- | :--- | :--- |
| Total Revenue | Unknown | €353,598 |
| Average Order Value | Unknown | €116.42 |
| Customer Segmentation | Impossible | 3 segments identified |
| Marketing ROI | Unknown | Email = 400% ROI |

### Dashboard Features

| Feature | Purpose |
| :--- | :--- |
| **KPIs** | Quick overview of key metrics |
| **Line Chart** | Revenue trends over time |
| **Bar Charts** | Category and segment comparisons |
| **Donut Chart** | Channel split |
| **Filters** | Interactive data exploration |
| **Insights Section** | Key findings and recommendations |

---

## 🧠 Key Takeaways

### 1. Data Cleaning is Essential

- Raw data is rarely clean
- Without cleaning, analysis is misleading
- Documentation of cleaning steps is important

### 2. Python is Powerful for Analysis

- pandas makes data manipulation easy
- Jupyter notebooks are perfect for exploration
- Visualisations bring data to life

### 3. Dashboards Tell the Story

- A good dashboard communicates insights instantly
- Interactivity helps stakeholders explore
- Keep it simple – focus on the key message

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
