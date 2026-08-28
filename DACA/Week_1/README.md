# 📊 Week 1 – SQL Basics & Data Quality Audit

[![DACA](https://img.shields.io/badge/DACA-Week_1-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Week Overview

**Week 1** marks the beginning of actual data work in the DACA programme. The focus of this week was to **explore and audit** the UrbanStyle.ltd sales and customer data to identify potential quality issues.

The task was framed as a **business problem**: Toomas Kask, UrbanStyle's IT Director, had identified potential data quality issues that needed thorough investigation before the data could be used for strategic business analysis and decision-making.

---

## 🎯 Weekly Objectives

| Objective | Description | Status |
| :--- | :--- | :--- |
| **Data Exploration** | Understand the structure and volume of sales, customer, and product data | ✅ |
| **Data Quality Audit** | Identify duplicates, missing values, inconsistencies, and anomalies | ✅ |
| **Data Cleaning** | Normalise inconsistencies (city names, formatting) | ✅ |
| **Team Collaboration** | Each team member explored a different aspect of the data | ✅ |
| **Portfolio Submission** | Document findings and submit SQL queries to GitHub | ✅ |

---

## 👥 Team Roles & Contributions

As part of the **Operations Intelligence** team, each member took on a specific analytical role to investigate different aspects of UrbanStyle's data.

| Role | Team Member | Focus Area |
| :--- | :--- | :--- |
| **Roll A – Sales Data Explorer** | Helen | Investigated transaction volume, structure, and potential errors in amounts and dates |
| **Roll B – Data Quality Expert** | **Kalju (Me)** | Focused on data "dirtiness" – systemic errors in spelling, case sensitivity, and whitespace |
| **Roll C – Product Data Analyst** | Natalia Krassilnikova | Analysed the product database – content, categories, and pricing statistics |
| **Roll D – Sales Channels & Locations** | Olga | Investigated sales channels, store locations, and payment methods |

---

## 🔍 Key Findings Summary

### 1. Sales Data Quality (Helen)
- **Volume:** 15,234 transactions
- **Missing data:** 1,487 transactions (~9.8%) have missing `customer_id`
- **Critical errors:** 305 negative amount transactions (total -€88,632.61) and 2 transactions with future dates

### 2. Data Inconsistencies & "Dirtiness" (Kalju)
- **Spelling inconsistencies:** "Tallinn", "tallinn", "TALLINN", and "Tallinn " are treated as separate entries
- **Whitespace issues:** Trailing spaces in city names create duplicate locations in the system
- **Impact:** Prevents accurate aggregate statistics without prior data cleaning

### 3. Product Data (Natalia)
- **Volume:** 362 products across five main categories
- **Quality:** High – no missing prices or categories identified
- **Price range:** €13.53 (belt) to €434.00 (sports shoes)

### 4. Sales Channels & Locations (Olga)
- **Channels:** Online and In-store
- **Payment methods:** Card, cash, and instalment payments
- **Statistic:** 5,204 transactions have missing location data (indicating a large share of online sales)

---

## 👤 My Individual Contribution (Roll B)

My role was to identify **data quality issues** in the UrbanStyle database, focusing on inconsistencies that would cause problems for analysis.

### What I Did

1. **Examined city name inconsistencies**
   - Found multiple variations of the same city (e.g., "Tallinn", "tallinn", "TALLINN", "Tallinn ")
   - Identified trailing whitespace issues that created duplicate entries

2. **Wrote SQL queries to identify patterns**
   - Used `DISTINCT` to find unique city name variations
   - Applied `TRIM()` and `INITCAP()` functions to clean data
   - Created CTEs to demonstrate best practices for data normalisation

3. **Documented the impact**
   - Explained how these inconsistencies affect aggregate statistics
   - Made recommendations for data normalisation

### My SQL Code

The queries I wrote for this week are available in the **[Week_1_Code/](./Week_1_Code/)** folder.

---

## 💡 Conclusions & Next Steps

**Conclusion:** The dataset is largely usable but requires cleaning before proper analysis can begin.

**Focus for Week 2:**
1. **Data normalisation:** Standardise city name spelling and remove trailing spaces
2. **Investigate negative transactions:** Determine if these are returns or system errors
3. **Customer data analysis:** Assess the impact of missing customer IDs

---

## 📁 Folder Structure

```text
Week_1/
├── README.md                  # This file
├── Week_1_Code/               # SQL queries and analysis scripts
├── Week_1_Feedback/           # Personal reflections on the week
├── Week_1_Materials/          # Course materials and RAG files
└── Week_1_Results/            # Analysis results and conclusions
    ├── Week_1_Conclusions/
    ├── Week_1_Pictures/
    ├── Week_1_Presentation/
    └── Week_1_Tables/
