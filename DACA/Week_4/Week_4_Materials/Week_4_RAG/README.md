# 🧠 Week_4_RAG – SQL Aggregation & UrbanStyle Application

[![RAG](https://img.shields.io/badge/RAG-NotebookLM-4B8BBE?style=for-the-badge)](https://notebooklm.google.com/)

---

## 📄 Files in This Folder

| File | Description |
| :--- | :--- |
| `4_0_R1_sql_aggregation_concepts-rag.md` | SQL aggregation fundamentals – `GROUP BY`, `HAVING`, CTEs, window functions (`ROW_NUMBER`, `RANK`, `LAG`, `LEAD`), and the "Test, Verify, Log" process |
| `4_0_R2_sql_aggregation_urbanstyle_application-rag.md` | Practical application – CEO reporting, customer segmentation, product analysis, marketing ROI, and inventory discrepancy detection |

---

## 📚 File Details

### 4_0_R1_sql_aggregation_concepts-rag.md – SQL Aggregation Fundamentals

This document covers the **core SQL aggregation concepts** needed for Week 4 of the DACA programme.

#### Key Topics Covered

| Topic | Description |
| :--- | :--- |
| **What is Aggregation?** | Turning raw numbers into business answers |
| **GROUP BY** | Grouping data by categories (month, city, category) |
| **Aggregate Functions** | `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` – with `COUNT(*)` vs `COUNT(column)` distinction |
| **HAVING vs WHERE** | Filtering rows (`WHERE`) vs filtering groups (`HAVING`) |
| **CTEs (Common Table Expressions)** | Breaking complex queries into readable steps |
| **Window Functions** | `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `LAG()`, `LEAD()`, `SUM() OVER` |
| **GROUP BY vs PARTITION BY** | Collapsing rows vs adding calculated columns |
| **Data Validation** | Using aggregation to find anomalies |
| **SQL Execution Order** | `FROM` → `WHERE` → `GROUP BY` → `HAVING` → `SELECT` → `ORDER BY` |

#### Example Queries Included

```sql
-- Monthly sales aggregation
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    COUNT(*) AS tellimusi,
    SUM(total_price) AS kogukäive,
    ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;

-- HAVING: only categories with >10 products
SELECT category, COUNT(*) AS tooteid
FROM products
GROUP BY category
HAVING COUNT(*) > 10;

-- CTE with LAG for month-over-month growth
WITH kuu_myyk AS (
    SELECT DATE_TRUNC('month', sale_date) AS kuu,
           SUM(total_price) AS käive
    FROM sales
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT kuu, käive,
       LAG(käive) OVER (ORDER BY kuu) AS eelmine_kuu,
       käive - LAG(käive) OVER (ORDER BY kuu) AS kasv
FROM kuu_myyk;
