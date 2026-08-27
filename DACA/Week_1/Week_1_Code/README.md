# 💻 Week 1 – SQL Code & Queries

[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_1-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **SQL queries** I wrote during Week 1 of the DACA programme. The focus of this week was to **explore and understand** the UrbanStyle `Customers` table using basic SQL operations.

The queries demonstrate:
- Data exploration (counting, limiting, sorting)
- Data quality checks (missing values, duplicates)
- Data cleaning (trimming, formatting)
- Aggregation and grouping
- Subqueries and Common Table Expressions (CTEs)

---

## 📂 Files in This Folder

| File | Description |
| :--- | :--- |
| `Week-1.sql` | Main SQL file containing all queries with comments and explanations |
| `Korduvad_emailid.sql` | Query to count duplicate email addresses |
| `Puuduvad_andmed.sql` | Query to count missing values across multiple columns |
| `REgistratsiooni_ajad.sql` | Query to find min and max registration dates |
| `Tallinna_15_perekonna_nime_klienti.sql` | Query result for Tallinn customers (15 rows) |
| `Linna_nime_pikkus_test.sql` | Query result showing duplicate last names |
| `Loobiga_puhastus.sql` | Query result showing customer list by last name |

---

## 🔍 Detailed Query Analysis

### 1. Basic Data Exploration

**File:** `Week-1.sql` (commented sections)

#### Count Total Customers

```sql
SELECT COUNT(customer_id) AS "Klientide_koguarv"
FROM "Customers";
