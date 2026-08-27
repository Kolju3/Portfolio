# 💬 Week 2 – Feedback & Reflections: Evolution of My SQL Skills

[![DACA](https://img.shields.io/badge/DACA-Week_2-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![SQL](https://img.shields.io/badge/SQL-Data%20Cleaning-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document captures my personal reflections on Week 2 of the DACA programme. It describes how my SQL skills evolved from Week 1's foundational queries to Week 2's more structured, analytical, and comprehensive data cleaning approach.

---

## 🔄 Evolution from Week 1 to Week 2

### Week 1: Exploration & Discovery

In Week 1, my SQL work was focused on **exploration** – understanding what data existed, identifying basic patterns, and getting familiar with the UrbanStyle database.

| Aspect | Week 1 Approach |
| :--- | :--- |
| **Focus** | Data exploration and basic filtering |
| **Key Techniques** | `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT`, `COUNT` |
| **Complexity** | Simple, single-table queries |
| **Code Style** | Basic, functional, sometimes messy |
| **Data Quality** | Initial identification of issues |

### Week 2: Analysis & Precision

In Week 2, my SQL work evolved into **structured analysis** – creating test copies, cleaning data systematically, and using advanced techniques to identify duplicates and data quality issues.

| Aspect | Week 2 Approach |
| :--- | :--- |
| **Focus** | Data cleaning, duplicate analysis, quality assurance |
| **Key Techniques** | `ROW_NUMBER()`, `PARTITION BY`, CTEs (`WITH`), `COALESCE`, `INITCAP`, `TRIM`, `CASE WHEN` |
| **Complexity** | Multi-level CTEs, window functions, table duplication |
| **Code Style** | Structured, well-commented, documented |
| **Data Quality** | Systematic identification and resolution |

---

## 🧠 What Changed

### 1. From Simple Queries to Structured Analysis

**Week 1:** I wrote straightforward queries to answer immediate questions.

```sql
-- Week 1: Simple exploration
SELECT COUNT(*) AS klientide_koguarv
FROM "Customers";
