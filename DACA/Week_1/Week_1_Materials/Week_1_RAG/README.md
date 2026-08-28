# 🧠 Week_1_RAG – SQL Basics & UrbanStyle Application

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
| `1_0_R1_sql_basics_concepts-rag.md` | SQL fundamentals – SELECT, WHERE, ORDER BY, LIMIT, DISTINCT, COUNT, NULL handling, and SQL thinking |
| `1_0_R2_sql_basics_urbanstyle_application-rag.md` | Practical SQL application – Toomas Kask's challenge, exploring UrbanStyle's sales, customer, and product data |

---

## 📚 File Details

### 1_0_R1_sql_basics_concepts-rag.md – SQL Fundamentals

This document covers the **core SQL concepts** needed for Week 1 of the DACA programme.

#### Key Topics Covered

| Topic | Description |
| :--- | :--- |
| **What is SQL?** | Why SQL is the #1 skill for data analysts and how it differs from programming languages |
| **SELECT** | Choosing which columns to view from a table |
| **WHERE** | Filtering rows based on conditions |
| **ORDER BY** | Sorting results in ascending or descending order |
| **LIMIT** | Controlling the number of rows returned |
| **DISTINCT** | Finding unique values and removing duplicates |
| **COUNT** | Counting rows and handling NULL values |
| **NULL** | Understanding missing values and how to check them |
| **SQL vs Excel** | How SQL thinking differs from Excel thinking |
| **Common Mistakes** | Frequent beginner errors and how to avoid them |
| **Query Structure** | The correct order of SQL clauses |

#### Example Queries Included

```sql
-- Basic SELECT with filtering
SELECT * FROM sales WHERE channel = 'online';

-- Sorted results with limit
SELECT * FROM sales ORDER BY total_price DESC LIMIT 10;

-- Finding unique values
SELECT DISTINCT city FROM customers;

-- Counting with NULL handling
SELECT COUNT(*) - COUNT(email) AS puuduvad_emailid FROM customers;
