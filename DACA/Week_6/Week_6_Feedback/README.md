# 💬 Week 6 – Feedback & Reflections

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Plotly](https://img.shields.io/badge/Plotly-3F4F75?style=for-the-badge&logo=plotly&logoColor=white)](https://plotly.com/)
[![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)](https://streamlit.io/)
[![Linux](https://img.shields.io/badge/Linux-Mint-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://linuxmint.com/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document captures my personal reflections on Week 6 of the DACA programme. This week focused on **data storytelling and dashboard publishing** – transforming the Week 5 dashboard into a polished, investor-ready tool that tells a clear business story.

The week also involved **further code refinement**, building upon the modular structure I had already established in Week 5 with clearer separation of concerns and enhanced functionality.

---

## 🧠 From Data to Story

### Week 5: "Data is Visible"

| Aspect | Week 5 |
| :--- | :--- |
| **Focus** | Getting the dashboard functional |
| **Code** | Modular (data loader, charts, app) |
| **Charts** | Basic Plotly charts |
| **KPIs** | Simple totals |
| **Story** | None – just numbers |

### Week 6: "Data Tells a Story"

| Aspect | Week 6 |
| :--- | :--- |
| **Focus** | Adding context and narrative |
| **Code** | Further refactored – dedicated filters and KPI modules |
| **Charts** | Annotated, with markers and labels |
| **KPIs** | With percentage changes vs previous periods |
| **Story** | Clear business conclusions |

---

## 🛠️ Key Technical Decisions

### 1. Further Refactoring

In Week 5, I had already established a modular structure with separate files for data loading, charts, and the main application. For Week 6, I took this further by extracting filtering logic and KPI calculations into dedicated modules.

**Week 5 Structure:**
```text
Data_Loader.py → Loading data
Charts.py      → Chart creation
App.py         → Orchestration
