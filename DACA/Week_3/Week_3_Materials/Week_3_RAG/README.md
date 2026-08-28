# 🧠 Week_3_RAG – SQL JOINs & UrbanStyle Application

[![RAG](https://img.shields.io/badge/RAG-NotebookLM-4B8BBE?style=for-the-badge)](https://notebooklm.google.com/)

---

## 📄 Files in This Folder

| File | Description |
| :--- | :--- |
| `3_0_R1_sql_joins_concepts-rag.md` | SQL JOIN fundamentals – `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`, Primary Keys, Foreign Keys, and the "LEFT JOIN + WHERE IS NULL" pattern |
| `3_0_R2_sql_joins_urbanstyle_application-rag.md` | Practical application – Anna Mets' marketing questions, TOP customers, missing customers, unsold products, channel analysis, and multi-table JOINs |

---

## 📚 File Details

### 3_0_R1_sql_joins_concepts-rag.md – SQL JOIN Fundamentals

This document covers the **core SQL JOIN concepts** needed for Week 3 of the DACA programme.

#### Key Topics Covered

| Topic | Description |
| :--- | :--- |
| **Why Data is in Multiple Tables** | Normalisation, Primary Keys, and Foreign Keys explained |
| **INNER JOIN** | Only matching rows from both tables – the most common JOIN type |
| **Table Aliases** | Shortening table names for readability (`sales s`, `customers c`) |
| **LEFT JOIN** | All rows from the left table + matching rows from the right (NULL if no match) |
| **The "Missing Data" Pattern** | `LEFT JOIN + WHERE IS NULL` to find rows that exist only in the left table |
| **RIGHT JOIN and FULL OUTER JOIN** | Less common but useful JOIN types |
| **Multi-Table JOINs** | Combining 3+ tables in a single query |
| **Self-JOIN** | Joining a table to itself for hierarchical data |
| **Common JOIN Mistakes** | Missing `ON` clauses, wrong join columns, JOIN type selection errors |
| **JOIN vs Excel VLOOKUP** | How SQL JOINs compare to spreadsheet lookups |

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
