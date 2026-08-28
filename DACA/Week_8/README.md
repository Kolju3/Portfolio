# 📊 Week 8 – Advanced Python & Dashboard Creation

[![Python](https://img.shields.io/badge/Python-pandas-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_8-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Week Overview

**Week 8** marks a significant milestone in the DACA programme – we transition from SQL-focused analysis to **Python-based analytics and dashboard creation**. This is the week where data becomes **visual and interactive**.

The focus is on:
- Connecting Python to the UrbanStyle PostgreSQL database
- Performing advanced data cleaning and transformation
- Creating **interactive dashboards** for the investor pitch
- Preparing **Customer Lifetime Value (CLV)** and **Marketing ROI** analyses

---

## 🎯 Business Context

### The Investor Pitch Problem

UrbanStyle's CEO Kristi Tamm is preparing for a **€500,000 investor pitch** in just 2 weeks. Investors need to see:
1. **Who** are UrbanStyle's most valuable customers?
2. **What** products drive the most revenue and profit?
3. **How** do different marketing channels perform?
4. **Where** should the business focus for growth?

**Without data-driven answers, the pitch will fail.**

### My Role

As part of the analytics team, my task is to:
- Connect Python to the database
- Clean and prepare the data
- Build an **interactive dashboard** that answers the investors' key questions
- Present **actionable insights** to Kristi and the team

---

## 🎯 Weekly Objectives

| Objective | Description | Status |
| :--- | :--- | :--- |
| **Python Database Connection** | Connect to Supabase PostgreSQL using `pandas` and `sqlalchemy` | ✅ |
| **Data Cleaning** | Handle NULLs, duplicates, negative values, and inconsistencies | ✅ |
| **Customer Analytics** | Calculate CLV (Customer Lifetime Value), segment customers | ✅ |
| **Product Analytics** | Identify top products, margins, slow-moving items | ✅ |
| **Marketing Analytics** | Calculate Marketing ROI and Customer Acquisition Cost (CAC) | ✅ |
| **Dashboard Creation** | Build an interactive dashboard (Power BI or Streamlit) | ✅ |
| **Insights Presentation** | Present findings with actionable recommendations | ✅ |

---

## 👥 Team Roles & Contributions

As part of the **Operations Intelligence** team, each member focused on a different aspect of the Week 8 analysis.

| Role | Team Member | Focus Area |
| :--- | :--- | :--- |
| **Roll A – Database Connection & Data Import** | Helen | Set up Python connection to Supabase, imported all tables |
| **Roll B – Data Cleaning & Transformation** | **Kalju (Me)** | Cleaned the data – handled NULLs, duplicates, negative values, and standardised city names |
| **Roll C – Customer Analytics & CLV** | Natalia Krassilnikova | Calculated Customer Lifetime Value, customer segmentation |
| **Roll D – Dashboard Creation** | Olga | Built the final dashboard (Power BI) |

---

## 🔍 My Specific Contribution (Roll B)

### What I Did

1. **Connected Python to Supabase**
   ```python
   from sqlalchemy import create_engine
   import pandas as pd

   engine = create_engine(DATABASE_URL)
   sales = pd.read_sql("SELECT * FROM sales", engine)
   customers = pd.read_sql("SELECT * FROM customers", engine)
   products = pd.read_sql("SELECT * FROM products", engine)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
