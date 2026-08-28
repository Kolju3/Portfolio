# 🧠 Week_8_RAG – Advanced Python & Dashboard Creation

[![RAG](https://img.shields.io/badge/RAG-NotebookLM-4B8BBE?style=for-the-badge)](https://notebooklm.google.com/)

---

## 📄 Files in This Folder

| File | Description |
| :--- | :--- |
| `8_0_R1_advanced_python_concepts-rag.md` | Advanced Python fundamentals – SQLAlchemy, pandas, data cleaning, visualisation, dashboard design |
| `8_0_R2_advanced_python_urbanstyle_application-rag.md` | Practical application – connecting to UrbanStyle's database, cleaning the data, building the dashboard |

---

## 📚 File Details

### 8_0_R1_advanced_python_concepts-rag.md – Advanced Python Fundamentals

This document covers the **core Python concepts** needed for Week 8 of the DACA programme.

#### Key Topics Covered

| Topic | Description |
| :--- | :--- |
| **SQLAlchemy** | Connecting Python to PostgreSQL databases |
| **pandas** | Loading, cleaning, transforming data |
| **Data Quality** | Handling NULLs, duplicates, inconsistencies |
| **CLV (Customer Lifetime Value)** | What it is, why it matters, how to calculate it |
| **Customer Segmentation** | Grouping customers by value, behaviour, or attributes |
| **Marketing ROI** | Calculating return on marketing investment |
| **Dashboard Design** | Best practices for creating effective dashboards |
| **Data Storytelling** | Presenting insights to stakeholders |

---

### 8_0_R2_advanced_python_urbanstyle_application-rag.md – UrbanStyle Application

This document applies the concepts to the UrbanStyle dataset.

#### Key Topics Covered

| Topic | Description |
| :--- | :--- |
| **The Investor Pitch** | Understanding Kristi's requirements for the investor presentation |
| **Connecting to Supabase** | Step-by-step guide to connecting Python to the database |
| **Data Cleaning Walkthrough** | Step-by-step guide to cleaning the UrbanStyle data |
| **CLV Calculation** | Calculating CLV for UrbanStyle's customers |
| **Customer Segmentation** | Segmenting UrbanStyle's customers into High, Medium, Low value |
| **Marketing ROI Calculation** | Calculating ROI for UrbanStyle's marketing channels |
| **Dashboard Requirements** | What Kristi needs to see in the dashboard |
| **Insights for Investors** | Key insights to present to potential investors |

---

## 📖 Key Sections

### Section 1: Connecting to Supabase

```python
from sqlalchemy import create_engine
import pandas as pd

DATABASE_URL = "postgresql://postgres:password@db.xxxxx.supabase.co:5432/postgres"
engine = create_engine(DATABASE_URL)

sales = pd.read_sql("SELECT * FROM sales", engine)
customers = pd.read_sql("SELECT * FROM customers", engine)
products = pd.read_sql("SELECT * FROM products", engine)
```
---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
