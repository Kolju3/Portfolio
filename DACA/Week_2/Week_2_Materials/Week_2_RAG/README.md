# 🧠 Week_2_RAG – SQL Data Cleaning & UrbanStyle Application

[![RAG](https://img.shields.io/badge/RAG-NotebookLM-4B8BBE?style=for-the-badge)](https://notebooklm.google.com/)

---

## 📌 What is RAG?

**RAG** stands for **Retrieval-Augmented Generation**. It is an AI technique where the AI model first **retrieves** relevant information from provided documents and only then **generates** a response based on that information.

### Simple Analogy

| Without RAG | With RAG |
| :--- | :--- |
| A person answering from memory – might forget or make things up | A person with a reference library – looks up the answer and cites the source |

### Why This Matters

- **More accurate** – the AI answers based on your specific materials
- **Source‑attributed** – every answer can be traced back to a document
- **Reduced hallucinations** – the AI doesn't "invent" answers
- **Programme‑specific** – the AI knows about UrbanStyle and DACA, not just general knowledge

---

## 📄 Files in This Folder

| File | Description |
| :--- | :--- |
| `2_0_R1_sql_cleaning_concepts-rag.md` | SQL data cleaning fundamentals – duplicates (`GROUP BY`, `HAVING`, `ROW_NUMBER()`), NULL handling (`IS NULL`, `COALESCE`, `NULLIF`), formatting (`TRIM`, `INITCAP`, `CAST`), and the "Test, Verify, Log, Commit" process |
| `2_0_R2_sql_cleaning_urbanstyle_application-rag.md` | Practical application – step-by-step cleaning of UrbanStyle's sales, customer, and product data, including duplicate removal, NULL replacement, date validation, and city name standardisation |

---

## 📚 File Details

### 2_0_R1_sql_cleaning_concepts-rag.md – SQL Cleaning Fundamentals

This document covers the **core SQL cleaning concepts** needed for Week 2 of the DACA programme.

#### Key Topics Covered

| Topic | Description |
| :--- | :--- |
| **Why Data Cleaning Matters** | The "Garbage In, Garbage Out" principle and its impact on business decisions |
| **Duplicate Detection** | `GROUP BY` + `HAVING COUNT(*) > 1` to find duplicate values |
| **Duplicate Removal** | `DELETE` with subqueries, `ROW_NUMBER()` window function, and `DISTINCT ON` |
| **NULL Handling** | `IS NULL`, `IS NOT NULL`, `COALESCE()`, and `NULLIF()` |
| **Date Validation** | `CASE WHEN` with `CURRENT_DATE`, identifying future/past dates |
| **String Cleaning** | `TRIM()`, `UPPER()`, `LOWER()`, `INITCAP()`, and `REPLACE()` |
| **Data Type Conversion** | `CAST` and `::` for converting between data types |
| **Transactions** | `BEGIN`, `COMMIT`, and `ROLLBACK` for safe data modification |
| **Audit Logging** | Documenting every cleaning step for accountability |
| **The Cleaning Process** | Test → Verify → Log → Commit (the professional workflow) |

#### Example Queries Included

```sql
-- Find duplicates using GROUP BY + HAVING
SELECT invoice_id, COUNT(*) AS koopiate_arv
FROM sales
GROUP BY invoice_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;

-- Remove duplicates using ROW_NUMBER()
DELETE FROM sales_test
WHERE id IN (
    SELECT id FROM (
        SELECT id, ROW_NUMBER() OVER (PARTITION BY invoice_id ORDER BY id) AS rn
        FROM sales_test
    ) numbered
    WHERE rn > 1
);

-- Handle NULL values with COALESCE
SELECT
    customer_id,
    COALESCE(first_name, 'Tundmatu') AS eesnimi,
    COALESCE(email, 'puudub@urbanstyle.ee') AS email
FROM customers;

-- Standardise city names
UPDATE customers_test
SET city = INITCAP(TRIM(city))
WHERE city != INITCAP(TRIM(city));
