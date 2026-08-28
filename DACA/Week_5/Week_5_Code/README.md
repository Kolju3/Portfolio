# 💻 Week 5 – Dashboard Code (Python / Plotly / Streamlit)

[![DACA](https://img.shields.io/badge/DACA-Week_5-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **Python code** for the Week 5 marketing dashboard built with **Plotly and Streamlit** (Track B). The dashboard connects to the UrbanStyle Supabase database, loads sales data with pagination, and presents interactive visualisations for Anna Mets (Marketing Lead).

All code was written and tested on **Linux Mint**.

---

## 📂 Files in This Folder

| File | Description |
| :--- | :--- |
| **`app.py`** | Main Streamlit application – dashboard layout, KPI cards, filters, and chart display |
| **`charts.py`** | Plotly chart definitions – revenue trend, top products, sales by city |
| **`data_loader.py`** | Supabase data loading with pagination – handles the 1,000-row API limit |

---

## 📄 File Details

### 1. `data_loader.py` – Supabase Connection with Pagination

**Purpose:** Loads sales, customer, and product data from Supabase, handling the 1,000-row API limit with looped pagination.

**Key Functions:**

| Function | Description |
| :--- | :--- |
| `load_sales()` | Loads all sales data with pagination |
| `load_customers()` | Loads all customer data with pagination |
| `load_products()` | Loads all product data with pagination |
| `load_sales_with_details()` | Joins sales, products, and customers into a single DataFrame |

**Key Feature – Pagination:** The script uses a loop that requests 1,000 rows at a time, continuing until all data is fetched. This ensures the full dataset (10,118 rows) is loaded, overcoming Supabase's default 1,000-row limit.

**Why This Matters:** Without pagination, the dashboard only loads the first 1,000 rows, creating data gaps in charts.

---

### 2. `charts.py` – Plotly Chart Definitions

**Purpose:** Defines the three main charts used in the dashboard.

#### `create_revenue_trend(df)`

**Type:** Line chart

**Purpose:** Shows monthly revenue trend over time.

**Logic:**
- Groups sales by month
- Sums `total_price` for each month
- Creates a line chart with custom formatting (EUR prefix, thousand separators)
- Adds a dashed horizontal line showing the average revenue

**Output:** A line chart with interactive hover, zoom, and pan functionality.

---

#### `create_top_products(df, top_n=10)`

**Type:** Horizontal bar chart

**Purpose:** Shows the top N products by revenue.

**Logic:**
- Groups sales by `product_name`
- Sums `total_price` for each product
- Sorts descending and takes top N
- Creates a horizontal bar chart (for long product names)
- Uses Teal colour scale for visual appeal

**Output:** A horizontal bar chart sorted from highest to lowest revenue.

---

#### `create_sales_by_city(df)`

**Type:** Pie chart

**Purpose:** Shows revenue distribution by city.

**Logic:**
- Groups sales by `city`
- Sums `total_price` for each city
- Groups cities with <5% revenue share into "Muud linnad" (Other Cities)
- Creates a pie chart with clear labels and hover information

**Output:** A pie chart with clear labels and interactive hover details.

---

### 3. `app.py` – Main Streamlit Application

**Purpose:** The main dashboard application that brings everything together.

**Structure:**

- **Page Configuration** – browser tab title and layout
- **Data Loading (cached)** – loads data once, caches for 5 minutes
- **Sidebar (Filters)** – city selection, date range, channel/location selection
- **Data Filtering** – boolean indexing with filters
- **KPI Cards** – four key metrics in a row
- **Charts** – revenue trend (full width), top products + sales by city (two columns)
- **Footer** – data source and row count

**Key Features:**

| Feature | Implementation |
| :--- | :--- |
| **KPI Cards** | Four key metrics displayed prominently |
| **City Filter** | Multi-select with all cities selected by default |
| **Date Range** | Date input with min/max values |
| **Location Filter** | Multi-select for online/store selection |
| **Data Caching** | Prevents reloading on every interaction |
| **Layout** | Professional, responsive design with columns |

**Key Adaptation:** Unlike the tutorial (which used separate `channel` and `store_location` columns), my code uses a **merged `location` column** – this matches my personal database schema where I combined these fields earlier.

---

## 🛠️ Setup & Running

### Requirements

The following Python packages are required: `plotly`, `streamlit`, `supabase`, `pandas`, and `python-dotenv`.

### Environment Variables

A `.env` file is required in the project root containing `SUPABASE_URL` and `SUPABASE_KEY`.

### Running the Dashboard

The dashboard is launched using the `streamlit run` command pointing to `app.py`.

### Stopping the Dashboard

Use `Ctrl+C` in the terminal.

---

## 🔍 Key Technical Achievements

| Challenge | Solution |
| :--- | :--- |
| **Supabase 1,000-row limit** | Looped pagination with `.range()` |
| **Merged location column** | Adapted filter logic from `channel` to `location` |
| **Missing data gap** | Pagination revealed the full timeline (2023–2026) |
| **Long product names** | Horizontal bar chart (`orientation="h"`) |
| **Cluttered pie chart** | Grouped cities with <5% share into "Muud linnad" |

---

## 🧠 My Approach & Reflection

### Why Track B?

I used Python/Plotly/Streamlit because:
- **Linux Mint** – Power BI Desktop is Windows-only
- **Code-based workflow** – Better for version control and reproducibility
- **Full customisation** – Complete control over every visual element
- **Portfolio value** – Demonstrates Python skills for data science roles

### The Pagination Discovery

The missing data problem was discovered **directly from the timeseries chart**. When I saw the gap from April 2023 to December 2025, I realised the data wasn't loading properly. This visual clue was the key to diagnosing the pagination problem.

### Design Decisions

| Element | Decision | Reason |
| :--- | :--- | :--- |
| **Revenue Trend** | Line chart | Best for showing trends over time |
| **Top Products** | Horizontal bar | Long product names need horizontal space |
| **City Distribution** | Pie chart | 4-5 categories, shows share of total |
| **Pie Grouping** | 5% threshold | Cleaner than showing tiny cities |
| **Color Scheme** | Teal / Viridis | Professional, colourblind-friendly |

---

## 🔗 Related Files

- [Week 5 Main README](../README.md)
- [Week 5 Results Folder](../Week_5_Results/)
- [Week 5 Feedback Folder](../Week_5_Feedback/)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
