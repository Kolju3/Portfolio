# 🖼️ Week 5 – Dashboard Screenshots (Python / Plotly)

[![DACA](https://img.shields.io/badge/DACA-Week_5-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Plotly](https://img.shields.io/badge/Plotly-3F4F75?style=for-the-badge&logo=plotly&logoColor=white)](https://plotly.com/)
[![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)](https://streamlit.io/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains **3 screenshots** of the marketing dashboard I built during Week 5 of the DACA programme using **Python, Plotly, and Streamlit** (Track B).

The dashboard was created for Anna Mets (Marketing Lead) and answers her key questions about UrbanStyle's sales performance.

---

## 📸 Image Gallery

| Image | Description | What It Shows |
| :--- | :--- | :--- |
| **`Revenue_Trend.png`** | Monthly revenue trend line chart | Sales performance from 2023 to 2026; shows seasonal patterns and year-over-year growth |
| **`Top_Products.png`** | Top 10 products by revenue (horizontal bar chart) | Highest-grossing products; helps Anna identify bestsellers for marketing campaigns |
| **`Sales_by_City.png`** | Revenue distribution by city (pie chart) | Shows which cities generate the most revenue; Tallinn dominates with 38.6% |

---

## 🔍 What These Screenshots Show

### Revenue_Trend.png

**Chart Type:** Line chart (`px.line`)

**Data Source:** `Testing_Sales_Cleaned` table with pagination

**Key Features:**
- Monthly revenue aggregation
- Dashed average revenue line
- Interactive hover with exact values
- Professional formatting (EUR prefix, thousand separators)

**Key Insight:** The chart shows a clear upward trend from 2023 to 2024, with seasonal peaks in summer and December. The data gap in early 2025 was identified and resolved through pagination.

---

### Top_Products.png

**Chart Type:** Horizontal bar chart (`px.bar` with `orientation="h"`)

**Data Source:** `Testing_Sales_Cleaned` + `Testing_Products_Cleaned` JOIN

**Key Features:**
- Horizontal orientation for long product names
- Colour gradient from light to dark teal
- Sorted from highest to lowest revenue
- Interactive hover with exact revenue values

**Key Insight:** Footwear (`jalanõusid`) dominates, with men's and women's clothing following closely. Accessories and children's clothing have lower revenue.

---

### Sales_by_City.png

**Chart Type:** Pie chart (`px.pie`)

**Data Source:** `Testing_Sales_Cleaned` + `Testing_Customers_Cleaned` JOIN

**Key Features:**
- Cities with <5% revenue share grouped as "Muud linnad" (Other Cities)
- Percentage labels on each segment
- Interactive hover with exact revenue values
- Professional colour palette (Set2)

**Key Insight:** Tallinn is the largest market (38.6%), followed by Tartu (20.9%), Pärnu (11.0%), and Online (34.5%). The online channel is nearly as large as the Tallinn store.

---

## 🧠 Why These Charts?

| Chart | Why This Type? |
| :--- | :--- |
| **Revenue Trend** | Line chart is the best choice for showing trends over time |
| **Top Products** | Horizontal bar chart allows long product names to be readable |
| **Sales by City** | Pie chart shows share of total clearly (max 5 categories) |

---

## 🛠️ Tools Used

| Tool | Purpose |
| :--- | :--- |
| **Python** | Programming language |
| **Plotly Express** | Interactive chart creation |
| **Streamlit** | Web application framework |
| **Supabase SDK** | Database connection with pagination |
| **pandas** | Data manipulation |
| **Linux Mint** | Operating system |

---

## 🔗 Related Files

- [Week 5 Main README](../README.md)
- [Week 5 Code Folder](../Week_5_Code/)
- [Week 5 Conclusions README](../Week_5_Conclusions/README.md)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
