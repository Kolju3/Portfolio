# 🧠 Week_7_RAG – pandas & RFM Concepts

[![RAG](https://img.shields.io/badge/RAG-NotebookLM-4B8BBE?style=for-the-badge)](https://notebooklm.google.com/)

---

## 📄 Files in This Folder

| File | Description |
| :--- | :--- |
| `7_0_R1_python_pandas_concepts-rag.md` | Core pandas concepts: Series, DataFrame, indexing, groupby, merge, filtering |
| `7_0_R2_python_pandas_urbanstyle_application-rag.md` | RFM segmentation theory applied to UrbanStyle: recency, frequency, monetary, scoring, segment definitions |

---

## 📚 File Details

### 7_0_R1_python_pandas_concepts-rag.md – pandas Fundamentals

Key topics:
- **DataFrame** – creation, reading CSV, viewing data (`head()`, `info()`, `describe()`)
- **Filtering** – boolean indexing (`df[df['column'] == value]`)
- **Aggregation** – `groupby()`, `agg()`, `pivot_table()`
- **Merging** – `merge()` for joining tables (SQL JOIN equivalent)
- **Handling missing data** – `dropna()`, `fillna()`
- **Apply functions** – `apply()` and `map()` for custom logic

---

### 7_0_R2_python_pandas_urbanstyle_application-rag.md – RFM Segmentation

Key topics:
- **Recency** – days since last purchase (lower is better)
- **Frequency** – number of transactions (higher is better)
- **Monetary** – total spend (higher is better)
- **Scoring methods** – quantile-based (1–5) scoring
- **Segment definitions:**
  - 13–15: VIP Champions
  - 10–12: Loyal Customers
  - 7–9: Potential Loyalists
  - 4–6: At Risk
  - 3: Lost
- **Actionable insights** – how to use RFM for marketing campaigns

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
