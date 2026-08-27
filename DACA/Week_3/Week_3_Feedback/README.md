# 💬 Week 3 – Feedback & Reflections: From Cleaning to Connection

[![DACA](https://img.shields.io/badge/DACA-Week_3-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![SQL](https://img.shields.io/badge/SQL-JOINs-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document captures my personal reflections on Week 3 of the DACA programme. It describes how my SQL skills evolved from **data cleaning and quality auditing** (Week 2) to **joining multiple tables and performing advanced analytics** (Week 3).

---

## 🔄 Evolution from Week 2 to Week 3

### Week 2: Data Cleaning & Quality Auditing

| Aspect | Week 2 Approach |
| :--- | :--- |
| **Focus** | Identifying and documenting data quality issues |
| **Key Techniques** | `ROW_NUMBER()`, `PARTITION BY`, `COALESCE`, `TRIM`, `INITCAP` |
| **Table Scope** | Single-table analysis (sales, customers, products separately) |
| **Goal** | Understand what's wrong with the data |
| **Output** | Quality audit reports and cleaning scripts |

### Week 3: Connecting & Analysing

| Aspect | Week 3 Approach |
| :--- | :--- |
| **Focus** | Combining data across tables to answer business questions |
| **Key Techniques** | `INNER JOIN`, `LEFT JOIN`, `DISTINCT ON`, `ROLLUP`, CTEs with `UNION ALL`, window functions (`OVER`) |
| **Table Scope** | Multi-table analysis (joining sales, customers, products) |
| **Goal** | Extract business insights from connected data |
| **Output** | Revenue reports, channel analysis, product category performance |

---

## 🧠 What Changed

### 1. Deduplication: From `ROW_NUMBER()` to `DISTINCT ON`

In Week 2, I used `ROW_NUMBER()` with `PARTITION BY` to identify duplicates – a reliable but somewhat verbose approach. In Week 3, I discovered `DISTINCT ON`, which achieves the same result in a much cleaner and more concise way.

**Key learning:** `DISTINCT ON` is the more elegant choice for deduplication when you want to keep one specific row per group.

---

### 2. From Cleaning to Connecting: The Power of JOINs

Week 2 was about **cleaning data within individual tables** – identifying NULLs, duplicates, and inconsistencies. Week 3 was about **connecting data across tables** to answer real business questions.

**Key learning:** The true value of data is unlocked when you combine it. A single table has limited value – connecting sales, customer, and product data reveals patterns that would otherwise remain hidden.

---

### 3. From Simple Aggregations to Professional Reporting

| Dimension | Week 2 | Week 3 |
| :--- | :--- | :--- |
| **Tables** | Single table | Multiple tables (3+) |
| **JOIN Types** | None | `INNER JOIN`, `LEFT JOIN` |
| **Aggregation** | Simple `GROUP BY` | `ROLLUP`, window functions |
| **Percentages** | Manual calculation | Window functions with `OVER` |
| **Report Structure** | Single query | Multi-CTE with `UNION ALL` |

**Key learning:** Reporting becomes more professional when you use tools like `ROLLUP` for subtotals and `OVER` for percentage calculations – they reduce manual work and improve accuracy.

---

### 4. Merging Data for Simpler Analysis

A small but significant change in Week 3 was using `COALESCE` to merge columns – for example, replacing `store_location` with `'Online'` for online sales, creating a single unified `location` column.

**Key learning:** A well-designed data model makes analysis easier. Merging related columns before analysis simplifies every subsequent query.

---

### 5. The Complexity Leap

| Skill | Week 2 | Week 3 |
| :--- | :--- | :--- |
| **JOINs** | None | `INNER JOIN`, `LEFT JOIN` |
| **Deduplication** | `ROW_NUMBER()` | `DISTINCT ON` |
| **Subtotals** | Manual `UNION ALL` | `ROLLUP` |
| **Percentages** | Manual calculation | Window functions (`OVER`) |
| **Multi-CTE** | Simple | Complex with `UNION ALL` |

**Key learning:** The complexity increase was significant, but with practice, multi-CTE queries become natural. The key is to build step by step.

---

## 💡 What I Learned

### Technical Skills

| Skill | Before (Week 2) | After (Week 3) |
| :--- | :--- | :--- |
| **JOINs** | None | Confident with `INNER JOIN`, `LEFT JOIN` |
| **Deduplication** | `ROW_NUMBER()` | Cleaner `DISTINCT ON` |
| **Subtotals** | Manual `UNION ALL` | Professional `ROLLUP` |
| **Percentages** | Manual | Window functions (`OVER`) |
| **Multi-CTE** | Simple | Complex with `UNION ALL` |

### Analytical Thinking

1. **Data cleaning is preparation, not analysis** – Week 2 was about getting the data ready; Week 3 was about using it to answer business questions.

2. **JOINs unlock business value** – Real answers require combining data from multiple tables. Questions like "which cities and channels generate the most revenue?" can only be answered with JOINs.

3. **`DISTINCT ON` is more elegant** – For simple deduplication, it's cleaner and more readable than `ROW_NUMBER()`.

4. **`ROLLUP` is essential for reporting** – It's the professional way to get subtotals and totals without manual `UNION ALL`.

5. **Window functions enable percentages** – `OVER (PARTITION BY)` shows relative contributions, essential for understanding performance.

6. **CTEs make complex queries readable** – Breaking down logic into steps helps debugging and maintenance.

---

## 🎯 Key Takeaway

> *"In Week 2, I learned to clean data and diagnose problems. In Week 3, I learned to connect data and extract business value. The evolution from `ROW_NUMBER()` to `DISTINCT ON`, from single tables to multiple JOINs, and from simple aggregations to `ROLLUP` and window functions represents a significant step forward in my ability to answer real business questions with SQL."*

---

## 🔗 Related Files

- [Week 3 Code Folder](../Week_3_Code/) – See the actual queries
- [Week 3 Results Folder](../Week_3_Results/)
- [Week 3 Main README](../README.md)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
