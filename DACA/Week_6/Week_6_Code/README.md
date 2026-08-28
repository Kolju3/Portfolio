# 💻 Week 6 – Dashboard Code (Python / Plotly / Streamlit)

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Plotly](https://img.shields.io/badge/Plotly-3F4F75?style=for-the-badge&logo=plotly&logoColor=white)](https://plotly.com/)
[![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)](https://streamlit.io/)
[![DACA](https://img.shields.io/badge/DACA-Week_6-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **modular Python code** for the Week 6 marketing dashboard built with **Plotly and Streamlit** (Track B). Unlike Week 5 (which was a single monolithic file), this version has been **refactored into separate modules** for maintainability, readability, and scalability.

The dashboard connects to the UrbanStyle Supabase database, loads sales data with pagination, and presents interactive visualisations with **KPI percentage changes**, **annotated charts**, and **a clean user interface**.

All code was written and tested on **Linux Mint**.

---

## 📂 Files in This Folder

| File | Description |
| :--- | :--- |
| **`App.py`** | Main Streamlit application – orchestrates all modules |
| **`Data_Loader.py`** | Supabase data loading with pagination |
| **`Filters.py`** | Data filtering logic (city, date range, location) |
| **`KPI.py`** | KPI calculation with percentage change vs previous period |
| **`Charts.py`** | Plotly chart definitions – revenue trend, top products, sales by city |

---

## 📄 File Details

### 1. `Data_Loader.py` – Supabase Connection with Pagination

**Purpose:** Loads sales, customer, and product data from Supabase, handling the 1,000-row API limit with looped pagination.

**Key Functions:**

| Function | Description |
| :--- | :--- |
| `load_sales()` | Loads all sales data with pagination |
| `load_customers()` | Loads all customer data with pagination |
| `load_products()` | Loads all product data with pagination |
| `load_sales_with_details()` | Joins sales, products, and customers into a single DataFrame |

---

### 2. `Filters.py` – Filtering Logic

**Purpose:** Applies selected filters to the dataset.

**Key Function:**

| Function | Description |
| :--- | :--- |
| `filter_data(df, selected_cities, date_range, selected_locations)` | Filters the DataFrame by city, date range, and location/channel |

---

### 3. `KPI.py` – KPI Calculation with Deltas

**Purpose:** Calculates KPIs and their percentage change compared to the previous period of the same length.

**Key Function:**

| Function | Description |
| :--- | :--- |
| `compute_kpis(df_full, df_filtered, selected_cities, selected_locations, date_range)` | Returns current and previous values for revenue, orders, customers, and average order value, plus deltas |

**Key Feature – Period Comparison:**

The function identifies the period before the current filter period that is exactly the same length. If that period doesn't exist (e.g., at the beginning of the dataset), it uses the longest available previous period. This gives investors a true sense of growth.

---

### 4. `Charts.py` – Plotly Chart Definitions

**Purpose:** Defines the three main charts used in the dashboard.

#### `create_revenue_trend(df)`

**Type:** Line chart

**Purpose:** Shows monthly revenue trend over time.

**Enhancements:**
- Dashed horizontal line showing the average revenue
- **Red star markers** on the top 3 revenue months
- Value labels on top months (e.g., "€3.1k")

---

#### `create_top_products(df, top_n=10)`

**Type:** Horizontal bar chart

**Purpose:** Shows the top N products by revenue.

**Enhancements:**
- **Continuous value labels** on each bar (no hover needed)
- Rounded values (e.g., "€3.1k" instead of "€3,123.45")
- Teal colour scale

---

#### `create_sales_by_city(df)`

**Type:** Pie chart

**Purpose:** Shows customer origin distribution by city.

**Enhancements:**
- Cities with <5% revenue share grouped as "Muud linnad" (Other Cities)
- Renamed to "Kliendid asukoha järgi" (Customers by location) to clarify it shows customer origin

---

### 5. `App.py` – Main Streamlit Application

**Purpose:** The main dashboard application that orchestrates all modules.

**Structure:**

```text
App.py
│
├── 1. Page Configuration
│   └── st.set_page_config()
│
├── 2. Data Loading (cached)
│   └── @st.cache_data(ttl=300) – loads data once, caches for 5 minutes
│
├── 3. Sidebar (Filters)
│   ├── st.sidebar.multiselect() – city selection
│   ├── st.sidebar.date_input() – date range
│   └── st.sidebar.multiselect() – channel/location selection
│
├── 4. Data Filtering
│   └── filter_data() from Filters.py
│
├── 5. KPI Cards
│   ├── st.columns(4) with st.metric()
│   └── compute_kpis() from KPI.py – includes deltas
│
├── 6. Charts
│   ├── Revenue Trend (full width)
│   └── Top Products + Sales by City (two columns)
│
└── 7. Footer
    └── st.caption() – data source and row count
