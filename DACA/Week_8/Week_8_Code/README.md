# 💻 Week 8 – Python Code & Analysis

[![Python](https://img.shields.io/badge/Python-pandas-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_8-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **Python code** I wrote during Week 8 of the DACA programme. The focus of this week was to **connect Python to the UrbanStyle database**, perform **advanced data cleaning**, and prepare the data for **dashboard creation**.

The code demonstrates:
- Database connection (SQLAlchemy + Supabase)
- Data loading and merging
- Data quality checks and cleaning
- Customer Lifetime Value (CLV) calculation
- Marketing ROI calculation
- Exporting data for dashboard use

---

## 📂 Files in This Folder

| File | Description |
| :--- | :--- |
| `Week-8_analysis.ipynb` | Main Jupyter notebook with all analysis and visualisations |
| `dashboard_app.py` | Streamlit dashboard application (Track B) |
| `utils.py` | Helper functions for database connection and data processing |
| `config.py` | Configuration file (database credentials, paths) |

---

## 🔍 Code Highlights

### 1. Database Connection

```python
# config.py
DATABASE_URL = "postgresql://postgres:password@db.xxxxx.supabase.co:5432/postgres"

# utils.py
from sqlalchemy import create_engine
import pandas as pd

def get_connection():
    return create_engine(DATABASE_URL)

def load_table(table_name):
    engine = get_connection()
    return pd.read_sql(f"SELECT * FROM {table_name}", engine)

# Load all tables
sales = load_table("sales")
customers = load_table("customers")
products = load_table("products")
inventory = load_table("inventory")
```
---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
