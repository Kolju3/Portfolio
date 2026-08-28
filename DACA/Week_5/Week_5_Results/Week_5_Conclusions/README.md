
---

### 7. Week_5/Week_5_Results/Week_5_Conclusions/README.md

Copy this into `/home/kolp/Desktop/Kursus/Repositary/Portfolio/DACA/Week_5/Week_5_Results/Week_5_Conclusions/README.md`:

```plaintext
# ✅ Week 5 – Conclusions & Dashboard Design Summary

[![DACA](https://img.shields.io/badge/DACA-Week_5-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Plotly](https://img.shields.io/badge/Plotly-3F4F75?style=for-the-badge&logo=plotly&logoColor=white)](https://plotly.com/)
[![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)](https://streamlit.io/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document summarises the **conclusions and outcomes** of Week 5's visualisation design work for UrbanStyle.ltd. The goal was to create interactive, professional dashboards that answer the critical business questions of key stakeholders: Kristi Tamm (CEO), Anna Mets (Marketing Lead), and Liis Koppel (Operations Manager).

My contribution was the **Marketing Dashboard (Roll B)** for Anna Mets, built using **Python, Plotly, and Streamlit** (Track B) on **Linux Mint**.

---

## 👤 My Contribution (Roll B – Marketing Dashboard)

### Dashboard Overview

I created an interactive dashboard for Anna Mets that answers her key marketing questions:

| Question | Visualisation |
| :--- | :--- |
| "How are sales trending?" | Revenue trend line chart |
| "What products sell best?" | Top 10 products bar chart |
| "Where do customers come from?" | Sales by city pie chart |
| "What are the key numbers?" | KPI cards (revenue, orders, customers, AOV) |

### Design Decisions

| Element | Decision | Rationale |
| :--- | :--- | :--- |
| **Revenue Trend** | Line chart | Best for showing trends over time |
| **Top Products** | Horizontal bar chart | Long product names need horizontal space |
| **City Distribution** | Pie chart (4-5 categories) | Shows share of total clearly |
| **Pie Grouping** | 5% threshold | Cleaner than showing tiny cities |
| **Colour Scheme** | Teal / Viridis | Professional, colourblind-friendly |
| **Filters** | City, date range, location | Enables interactive exploration |

### Technical Achievements

| Achievement | Description |
| :--- | :--- |
| **Supabase Pagination** | Overcame 1,000-row API limit with looped pagination |
| **Full Data Loading** | Successfully loaded all 10,118 sales records |
| **Schema Adaptation** | Adapted tutorial code to my merged `location` column |
| **Interactive Filters** | City, date range, and location/channel filters |
| **Professional Design** | KPI cards, clean layout, consistent colours |

---

## 🔍 Key Findings

### Marketing Dashboard Insights

| Metric | Value | Business Implication |
| :--- | :--- | :--- |
| **Total Revenue** | €2,898,513.90 | Baseline for all analysis |
| **Total Orders** | 10,118 | Healthy transaction volume |
| **Unique Customers** | ~2,500 | Solid customer base |
| **Average Order Value** | €286.38 | Strong AOV; stable across periods |
| **Top City** | Tallinn (38.6%) | Flagship market |
| **Online Share** | 34.5% | Online is a strategic channel |
| **Top Category** | Footwear (`jalanõusid`) | Strongest product category |

### Technical Insights

| Insight | Discovery |
| :--- | :--- |
| **Data Gap Discovery** | The revenue trend chart revealed the missing data issue visually |
| **Pagination Solution** | Looped pagination solved the 1,000-row API limit |
| **Schema Adaptation** | Modified code from `channel` to `location` column |
| **Pie Chart Clarity** | Grouping cities <5% improved readability |

---

## 💡 Recommendations

### For Anna Mets (Marketing)

| Recommendation | Rationale |
| :--- | :--- |
| **Invest in online channel** | 34.5% of revenue with higher AOV |
| **Focus on top cities** | Tallinn dominates; investigate Tartu potential |
| **Highlight top products** | Use bestsellers in marketing campaigns |
| **Monitor seasonal patterns** | Summer peaks and year-end spikes are consistent |

### For Technical Team

| Recommendation | Rationale |
| :--- | :--- |
| **Use pagination consistently** | Supabase 1,000-row limit affects all API calls |
| **Merge columns early** | Unified `location` column simplifies analysis |
| **Cache data efficiently** | `@st.cache_data` reduces API calls |

---

## 🧠 Key Learnings

### Technical

1. **Supabase pagination is essential** – the 1,000-row API limit requires explicit handling
2. **Visual clues reveal data issues** – the chart gap led me to the pagination problem
3. **Adapt tutorials to your schema** – don't copy-paste; understand and modify
4. **Python on Linux is viable** – Track B provides a powerful alternative to Power BI

### Design

1. **Chart type matters** – line for trends, bar for categories, pie for shares
2. **Data-Ink Ratio** – remove chart junk; every element must carry information
3. **KPI cards first** – stakeholders need numbers before details
4. **Filters add value** – one dashboard becomes many views

---

## 🔗 Related Files

- [Week 5 Main README](../README.md)
- [Week 5 Code Folder](../Week_5_Code/)
- [Week 5 Pictures README](../Week_5_Pictures/README.md)
- [Week 5 Presentation README](../Week_5_Presentation/README.md)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
