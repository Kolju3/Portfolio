# 🖼️ Week 1 – SQL Screenshots: Standardisation & Data Quality

[![DACA](https://img.shields.io/badge/DACA-Week_1-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Screenshots](https://img.shields.io/badge/Screenshots-10-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains **10 screenshots** taken during Week 1 of the DACA programme. These images document my investigation into **data quality issues** in the UrbanStyle database, specifically focusing on **city name standardisation**.

The screenshots demonstrate how using **unstandardised** data leads to incorrect interpretations, and how SQL functions like `INITCAP()` and `TRIM()` can be used to **normalise** the data for accurate analysis.

---

## 🎯 The Core Problem

UrbanStyle's `customers` table contains city names in **multiple inconsistent formats**:

| Issue | Example |
| :--- | :--- |
| **Case sensitivity** | "Tallinn", "tallinn", "TALLINN" |
| **Whitespace** | "Tallinn " (trailing space) |
| **Mixed formats** | Different capitalisation within the same city |

**The Impact:** Without standardisation, `GROUP BY` queries treat these as **separate cities**, producing **incorrect** counts and misleading results.

---

## 📸 Screenshot Gallery

### Part 1: The Problem – Unstandardised Data

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| **`Puhastamata_Linnad.png`** | Unstandardised city names as they appear in the database | Mixed case, trailing spaces, inconsistent formatting |
| **`Loobiga_puhastamata_grupeerimime_.png`** | GROUP BY on unstandardised city names | "Tallinn" appears as multiple separate entries |
| **`Parandamata_klientide_koguarv.png`** | Total customer count before any standardisation | Baseline count for comparison |
| **`Kolme_tulba_valik_puhastamata_Tallinna_alusel.png`** | Selecting three columns based on unstandardised "Tallinn" | Only captures one variation of the city name |
| **`Top_15_puhastamata_Tallinn.png`** | Top 15 results filtered by unstandardised "Tallinn" | Missing customers from other variations |

---

### Part 2: The Solution – Standardised Data

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| **`Loobiga_groupeering_puhastatud.png`** | GROUP BY on standardised city names | All variations of "Tallinn" are now grouped correctly |
| **`Loobiga_groupeering_tulba_pealkiri_puudu.png`** | GROUP BY with column heading missing | Demonstrates the importance of `AS` for readable output |
| **`GROUP_BY_puhastatud_groupeering.png`** | Cleaned GROUP BY with proper formatting | Correctly grouped data with clear column headings |
| **`Tabeli_formaat_10rida.png`** | Table format showing first 10 rows | Standardised data displayed clearly |

---

### Part 3: Technical Achievement – VS Code Connection

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| **`Run on active connection.png`** | Successful VS Code connection to Supabase | SQLTools working correctly with PostgreSQL connection |

---

### Part 4: Final Presentation

| Screenshot | Description | What It Shows |
| :--- | :--- | :--- |
| **`UrbanStyle_week1_operatsioonid.pdf`** | Week 1 group presentation results | Team summary – Operations Intelligence |

---

## 🔍 Key Insights from This Investigation

### Before Standardisation (Unstandardised Data)

```sql
-- This query would return INCORRECT results
SELECT city, COUNT(*) AS klientide_arv
FROM customers
GROUP BY city;
