# 💬 Week 5 – Feedback & Reflections

[![Linux](https://img.shields.io/badge/Linux-Mint-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://linuxmint.com/)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This document captures my personal reflections on Week 5 of the DACA programme. This was my first week working with **visualisation and dashboard design**, using **Python, Plotly, and Streamlit** on **Linux Mint**.

The week represented a significant shift from SQL-based data analysis to creating interactive, business-facing dashboards.

---

## 🧠 Tool Choice: Why I Chose Track B

Unlike most team members who used Power BI (Track A), I chose **Track B – Python with Plotly and Streamlit**.

### The Reason: Linux Mint

I use **Linux Mint** as my primary operating system. Power BI Desktop is **Windows-only**, which meant I had two options:

| Option | Considerations |
| :--- | :--- |
| **Track A – Power BI via VMware** | Required installing Windows in a virtual machine (~60-90 min setup), limited RAM/CPU, potential performance issues |
| **Track B – Python/Plotly/Streamlit** | Already had Python installed, cross-platform, code-based, full control |

**Decision:** I chose Track B. It was the more practical, efficient, and portfolio-friendly choice.

### Why This Was the Right Decision

1. **No virtual machine overhead** – my system resources were fully available for development
2. **Code is portable** – the dashboard can run on any platform (Linux, macOS, Windows)
3. **Version control** – Git tracks every change to the code
4. **Deployment ready** – Streamlit Cloud deployment is straightforward
5. **Python skills** – aligns with Weeks 7-8 (Python/pandas) and future data science work

---

## 🛠️ Technical Challenges & Solutions

### Challenge 1: Supabase 1,000-Row Limit (Pagination)

**The Problem:** Supabase restricts API calls to 1,000 rows by default. My dashboard only loaded the first 1,000 rows, meaning the timeline graph showed a massive data gap (missing all of 2024 and most of 2025).

**The Discovery:** I noticed this **directly from the timeseries chart** – the line dropped to near-zero in mid-2023 and didn't recover. At first, I thought it was a data issue, but then I realised the problem was the API limit.

**The Solution:** I implemented **looped pagination** – requesting 1,000 rows at a time in a loop until all data was fetched. This ensured the full dataset of 10,118 rows was loaded.

**Key Lesson:** Always check your data completeness. A visual gap in a chart is often a sign of an underlying data loading issue.

---

### Challenge 2: Adapting Code to My Schema

**The Problem:** The tutorial assumed separate columns for `channel` (online/store) and `store_location`. However, I had previously merged these into a single `location` column in my database (see Week 3-4 work).

**The Solution:** I modified the data loader and filter logic to work with my `location` column, ensuring all filters and aggregations referenced the correct field.

**Key Lesson:** Always adapt tutorials to your actual data schema. Copy-paste without understanding leads to bugs.

---

### Challenge 3: Pie Chart Grouping

**The Problem:** The initial pie chart showed too many small cities, making it cluttered and hard to read.

**The Solution:** I changed the grouping threshold from **3% to 5%**. At 3%, too many tiny towns cluttered the chart. Setting it to 5% grouped all small outliers into a single "Muud linnad" (Other Cities) slice.

**Key Lesson:** Pie charts work best with 4-5 categories. Group smaller categories to maintain readability.

---

## 💡 What I Learned

### Technical Skills

| Skill | Before | After |
| :--- | :--- | :--- |
| **Streamlit** | None | Built a complete interactive dashboard |
| **Plotly** | None | Created three chart types with custom formatting |
| **Supabase Pagination** | None | Implemented looped pagination for large datasets |
| **Dashboard Design** | Basic | Applied KPI cards, filters, and layout principles |
| **Data Merging** | SQL JOINs | Python pandas merge for data integration |

### Visualisation Principles

| Principle | Application |
| :--- | :--- |
| **Data-Ink Ratio** | Removed chart junk, kept only essential elements |
| **Z-Muster** | KPI cards at top, main chart in centre, supporting charts below |
| **Colour** | Used Teal/Viridis palettes for professional, colourblind-friendly visuals |
| **Interactivity** | Filters allow users to explore data without creating new dashboards |

### Professional Skills

| Skill | Lesson |
| :--- | :--- |
| **Tool Selection** | Choose the right tool for your platform and goals |
| **Problem Solving** | Visual clues (data gaps) lead to technical insights (pagination) |
| **Adaptability** | Tutorials need adjustment to fit your specific schema |
| **Design Thinking** | A dashboard is not just charts – it's a communication tool |

---

## 🔍 Comparison: Track A vs Track B

| Aspect | Power BI (Track A) | Python/Plotly (Track B) |
| :--- | :--- | :--- |
| **Platform** | Windows-only | Cross-platform (Linux ✅) |
| **Approach** | Drag-and-drop | Code-based |
| **Version Control** | Limited (.pbix files) | Full Git support |
| **Customisation** | Pre-defined options | Complete control |
| **Learning Curve** | Lower initially | Higher initially |
| **Portfolio Value** | BI-focused | Data science + engineering |
| **Performance** | Good for moderate data | Scales with code optimisation |

**My Verdict:** Track B was the right choice for my situation. The initial learning curve was steeper, but the flexibility, version control, and cross-platform compatibility made it worth it.

---

## 🎯 Key Takeaways

1. **Choose the right tool for your platform** – Linux users should embrace Python/Streamlit rather than fighting with virtual machines

2. **Visual clues reveal data issues** – the chart gap led me to the pagination problem

3. **Pagination is essential** – Supabase's 1,000-row limit requires explicit handling

4. **Adapt tutorials to your schema** – don't copy-paste; understand and modify

5. **Code-based visualisation is powerful** – full control, version control, and reproducibility

6. **Design matters** – a clean, well-structured dashboard communicates insights faster

---

## 📝 Final Reflection

> *"This week was a major shift from data analysis to data communication. I learned that a dashboard is not just about making pretty charts – it's about answering business questions quickly and clearly. The technical challenges (pagination, schema adaptation) taught me that visualisation requires solid data engineering behind the scenes. And choosing Track B on Linux Mint proved that Python-based visualisation is a viable, powerful alternative to traditional BI tools."*

---

## 🔗 Related Files

- [Week 5 Code Folder](../Week_5_Code/)
- [Week 5 Results Folder](../Week_5_Results/)
- [Week 5 Main README](../README.md)
- [Week 5 Pictures README](../Week_5_Results/Week_5_Pictures/README.md)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
