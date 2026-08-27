# 📊 Week 1 – Data Tables & Query Results

[![DACA](https://img.shields.io/badge/DACA-Week_1-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![CSV](https://img.shields.io/badge/CSV-Data%20Tables-FF6B6B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains **CSV exports** of the query results I generated during Week 1 of the DACA programme. These tables document my exploration of the UrbanStyle database and the data quality issues I identified.

The tables demonstrate:
- Basic data exploration (counts, date ranges, sample data)
- Data quality checks (duplicates, missing values)
- City name standardisation (before and after `TRIM()` and `INITCAP()`)

---

## 📂 Table Files

### 1. Basic Data Exploration

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Klientide_Koguarv.csv`** | Total number of customers in the database | 3,150 customers |
| **`Registratsiooni_ajad.csv`** | Earliest and latest registration dates | 2020-01-02 to 2025-02-27 |
| **`Tabeli_formaat_10_rida.csv`** | First 10 rows of the customers table | Sample of customer data with all columns |

---

### 2. Data Quality Checks

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Korduvad_emailid.csv`** | Number of duplicate email addresses | 130 duplicate emails (≈4.1% of customers) |

**Business Impact:** 130 duplicate emails mean that customer communication (e.g., marketing emails) may be sent to the same person multiple times, or different people may share email addresses.

---

### 3. City Standardisation Comparison

This is the **core finding** of my Week 1 investigation.

| File | Description | What It Shows |
| :--- | :--- | :--- |
| **`Loobiga_puhastamat_groupeering.csv`** | Unstandardised city names with customer counts | **Problem:** Same city appears multiple times due to case and whitespace variations |
| **`Loobiga_puhastatud_groupeering.csv`** | Standardised city names with customer counts | **Solution:** Clean, standardised city names with accurate counts |
| **`Tabel_kolm_tulpa_Tallinnat.csv`** | Tallinn customers filtered without standardisation | Only one variation of "Tallinn" is captured |

---

## 🔍 Key Insight: City Standardisation Matters

### Before Standardisation (Unstandardised)

**File:** `Loobiga_puhastamat_groupeering.csv`

| City Name | Count |
| :--- | :--- |
| **Tallinn** | 1,135 |
| **tallinn** | 26 |
| **TALLINN** | 23 |
| **Tallinn (space)** | 31 |
| **Total: 1,215** (but appears as 4 separate entries) |

**Problem:** Same city (Tallinn) appears 4 times with different formatting. `GROUP BY` treats them as separate cities!

### After Standardisation

**File:** `Loobiga_puhastatud_groupeering.csv`

| Clean City Name | Customers |
| :--- | :--- |
| **Tallinn** | **1,238** |
| Tartu | 658 |
| Pärnu | 346 |
| Narva | 177 |
| Viljandi | 112 |
| Rakvere | 107 |
| Valga | 94 |
| Kuressaare | 98 |
| Haapsalu | 90 |
| Jõhvi | 83 |
| Võru | 81 |
| Paide | 66 |

**Solution:** Using `TRIM()` and `INITCAP()` standardises all city names, giving **accurate** customer counts.

---

## 📊 Complete Data Overview

### Customer Data Summary

| Metric | Value |
| :--- | :--- |
| **Total Customers** | 3,150 |
| **Duplicate Emails** | 130 (≈4.1%) |
| **Registration Range** | 2020-01-02 to 2025-02-27 |
| **Unique Cities (Cleaned)** | 12 |

### City Distribution (Cleaned Data)

| City | Customers | Percentage |
| :--- | :--- | :--- |
| Tallinn | 1,238 | 39.3% |
| Tartu | 658 | 20.9% |
| Pärnu | 346 | 11.0% |
| Narva | 177 | 5.6% |
| Viljandi | 112 | 3.6% |
| Rakvere | 107 | 3.4% |
| Valga | 94 | 3.0% |
| Kuressaare | 98 | 3.1% |
| Haapsalu | 90 | 2.9% |
| Jõhvi | 83 | 2.6% |
| Võru | 81 | 2.6% |
| Paide | 66 | 2.1% |

---

## 🧠 What These Tables Tell Us

### 1. Data Quality Issues Exist

- **130 duplicate emails** – needs investigation
- **Inconsistent city names** – must be standardised before analysis

### 2. Standardisation is Essential

Without `TRIM()` and `INITCAP()`:
- "Tallinn" appears as 4 different entries
- Customer counts are **incorrect**
- Business decisions based on this data would be **misinformed**

With standardisation:
- All city names are **clean and consistent**
- Customer counts are **accurate**
- Analysis is **reliable**

### 3. Customer Distribution

- **39.3%** of customers are in Tallinn
- **20.9%** in Tartu
- **39.8%** across the remaining 10 cities

This suggests a **strong concentration** of customers in Tallinn and Tartu – important for marketing and store location decisions.

---

## 🔗 Related Files

- [Week 1 Main README](../README.md)
- [Week 1 Code Folder](../Week_1_Code/)
- [Week 1 Conclusions README](../Week_1_Conclusions/README.md)
- [Week 1 Pictures README](../Week_1_Pictures/README.md)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
