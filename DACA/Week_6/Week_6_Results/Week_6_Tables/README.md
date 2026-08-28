# 📊 Week 6 – Data Tables & Exports

[![DACA](https://img.shields.io/badge/DACA-Week_6-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Empty-FFB347?style=for-the-badge)]()

---

## 📌 Overview

This folder is intentionally **empty**. No CSV tables or data exports were generated during Week 6 of the DACA programme.

---

## 📂 Why No Tables?

| Reason | Explanation |
| :--- | :--- |
| **Live Data Connection** | All data is loaded **live from Supabase** via the Python API – no exports needed |
| **Dashboard Focus** | The task was to create a **live, interactive dashboard**, not to export static data |
| **Streamlit Integration** | The dashboard reads data directly from the database on each load |

---

## 📊 Where Are the Data?

All data used in the Week 6 dashboard is loaded **live from Supabase** via the `Data_Loader.py` module.

**Data Source:**
- Supabase PostgreSQL database
- Tables: `Testing_Sales_Cleaned`, `Testing_Customers_Cleaned`, `Testing_Products_Cleaned`

**Data Loading:**
- Pagination handles Supabase's 1,000-row limit
- All 10,118 sales rows are loaded on demand

---

## 🗓️ What's Coming

If future work requires static exports, tables will be added here. For now, the data is fully accessible via the live dashboard.

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
