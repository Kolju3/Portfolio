# 📊 Week 5 – Data Visualisation & Dashboard Design

[![DACA](https://img.shields.io/badge/DACA-Week_5-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Week Overview

**Week 5** marks the transition from **data analysis** to **data visualisation and storytelling**. The focus of this week was to create interactive, professional dashboards that answer the critical business questions of UrbanStyle's key stakeholders: Kristi Tamm (CEO), Anna Mets (Marketing Lead), and Liis Koppel (Operations Manager).

Unlike other team members who used Power BI (Track A), I chose **Track B** – using **Python with Plotly and Streamlit** – because I use **Linux Mint** as my operating system, which does not support Power BI Desktop.

---

## 🎯 Weekly Objectives

| Objective | Description | Status |
| :--- | :--- | :--- |
| **Dashboard Design** | Create interactive dashboards for key stakeholders | ✅ |
| **Diagram Selection** | Choose appropriate chart types for each business question | ✅ |
| **Data Integration** | Connect to Supabase via Python SDK with pagination | ✅ |
| **Interactivity** | Implement filters (city, date range, location) | ✅ |
| **KPI Cards** | Display key metrics (revenue, orders, customers, AOV) | ✅ |
| **Portfolio Submission** | Deploy working dashboard and document findings | ✅ |

---

## 👥 Team Roles & Contributions

As part of the **Operations Intelligence** team, each member created a dashboard for a specific stakeholder.

| Role | Team Member | Stakeholder | Focus Area | Tool |
| :--- | :--- | :--- | :--- | :--- |
| **Roll A** | Helen | Kristi (CEO) | Revenue trends, YoY growth, city comparison | Power BI |
| **Roll B** | **Kalju (Me)** | Anna (Marketing) | Sales trends, top products, city distribution | **Plotly + Streamlit** |
| **Roll C** | Natalia | Liis (Operations) | Inventory, stock value, overstock analysis | Power BI |
| **Roll D** | Olga | Investor | Consolidated KPIs, AOV, overall trends | Power BI |

---

## 👤 My Individual Contribution (Roll B – Marketing Dashboard)

My role was to create an **interactive marketing dashboard** for Anna Mets, answering her questions about sales trends, top products, and city distribution.

### What I Did

1. **Built a fully functional Streamlit application** – interactive dashboard with live Supabase data
2. **Implemented pagination** – overcame Supabase's 1,000-row API limit using looped pagination
3. **Created three Plotly charts** – revenue trend (line chart), top products (horizontal bar chart), sales by city (pie chart)
4. **Designed KPI cards** – total revenue, order count, unique customers, average order value
5. **Added interactive filters** – city, date range, and sales channel/location
6. **Adapted code to my schema** – merged `channel` and `store_location` into a single `location` column

### My Tools

| Tool | Purpose |
| :--- | :--- |
| **Python** | Programming language |
| **Plotly Express** | Interactive chart creation |
| **Streamlit** | Web application framework |
| **Supabase Python SDK** | Database connection with pagination |
| **pandas** | Data manipulation |
| **python-dotenv** | Environment variable management |

### Why Track B?

I chose Track B (Python/Plotly/Streamlit) because:

- **Linux Mint compatibility** – Power BI Desktop is Windows-only
- **Code-based approach** – allows version control (Git) and reproducibility
- **Full control** – complete customisation of every visual element
- **Portfolio value** – demonstrates Python skills valued in data science roles

### My SQL Code

The queries I wrote for this week are available in the **[Week_5_Code/](./Week_5_Code/)** folder.

---

## 🔍 Key Findings Summary

### Marketing Dashboard Insights

| Metric | Value |
| :--- | :--- |
| **Total Revenue** | €2,898,513.90 |
| **Total Orders** | 10,118 |
| **Unique Customers** | ~2,500 |
| **Average Order Value** | €286.38 |
| **Top City by Revenue** | Tallinn (38.6%) |
| **Top Category** | Footwear (`jalanõusid`) |
| **Online Revenue Share** | 34.5% |

### Key Technical Achievement: Supabase Pagination

The most significant challenge overcome was Supabase's **1,000-row API limit**. Initially, my dashboard only loaded the first 1,000 rows, which meant the revenue trend graph showed a massive data gap (missing all of 2024). I solved this by implementing **looped pagination**:

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*

