# 📽️ Week 1 – Group Presentation: UrbanStyle Data Landscape

[![DACA](https://img.shields.io/badge/DACA-Week_1-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Presentation](https://img.shields.io/badge/Presentation-Group-FFA500?style=for-the-badge)](https://github.com/Kolju3/DACA-group)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **group presentation** delivered during Week 1 of the DACA programme. The presentation summarises our team's investigation into the UrbanStyle.ltd sales, customer, and product data.

The presentation was created collaboratively by the **Operations Intelligence** team and presented during Sessioon 3 (Demo session).

---

## 📄 File Contents

| File | Description |
| :--- | :--- |
| **`UrbanStyle_week1_operatsioonid.pdf`** | The final group presentation slides (PDF format) |

---

## 👥 Team Members (Operations Intelligence)

| Team Member | Role | Focus Area |
| :--- | :--- | :--- |
| **Helen** | Roll A – Sales Data Explorer | Transaction volume, structure, errors in amounts and dates |
| **Kalju (Me)** | Roll B – Data Quality Expert | Data inconsistencies, spelling, case sensitivity, whitespace issues |
| **Natalia Krassilnikova** | Roll C – Product Data Analyst | Product database content, categories, pricing statistics |
| **Olga** | Roll D – Sales Channels & Locations | Sales channels, store locations, payment methods |

---

## 🎯 Presentation Objective

The goal of this presentation was to:

1. **Provide a complete overview** of UrbanStyle's sales, customer, and product data
2. **Identify data quality issues** that could affect business reporting
3. **Make recommendations** for data cleaning and improvement
4. **Answer Toomas Kask's questions** about the reliability of the data

---

## 🔍 Key Findings Presented

### 1. Sales Data Quality (Helen)

| Finding | Detail |
| :--- | :--- |
| **Total Transactions** | 15,234 transactions |
| **Missing Customer IDs** | 1,487 transactions (~9.8%) |
| **Negative Amounts** | 305 transactions (total -€88,632.61) |
| **Future Dates** | 2 transactions with future dates |

### 2. Data Inconsistencies & "Dirtiness" (Kalju)

| Finding | Detail |
| :--- | :--- |
| **Spelling inconsistencies** | "Tallinn", "tallinn", "TALLINN", "Tallinn " |
| **Whitespace issues** | Trailing spaces in city names |
| **Impact** | Prevents accurate aggregate statistics without prior cleaning |
| **Solution proposed** | Use `TRIM()` and `INITCAP()` to standardise city names |

### 3. Product Data (Natalia)

| Finding | Detail |
| :--- | :--- |
| **Total Products** | 362 products |
| **Categories** | 5 main categories |
| **Data Quality** | High – no missing prices or categories found |
| **Price Range** | €13.53 (belt) – €434.00 (sports shoes) |

### 4. Sales Channels & Locations (Olga)

| Finding | Detail |
| :--- | :--- |
| **Sales Channels** | Online and In-store |
| **Payment Methods** | Card, cash, instalment |
| **Missing Location Data** | 5,204 transactions without location info (indicating large share of online sales) |

---

## 💡 Recommendations Made

Based on our findings, we made the following recommendations to Toomas Kask:

| Priority | Recommendation |
| :--- | :--- |
| 1 | **Normalise city names** – use `TRIM()` and `INITCAP()` to standardise spelling |
| 2 | **Investigate negative transactions** – determine if these are returns or system errors |
| 3 | **Analyse missing customer IDs** – assess the impact on customer analytics |
| 4 | **Review future date entries** – correct 2 transactions with invalid dates |

---

## 📊 Presentation Structure

The presentation followed this structure:

1. **Introduction** – Team introduction and project objective
2. **Sales Data Findings** – Helen's analysis
3. **Data Quality Findings** – Kalju's analysis (city name standardisation)
4. **Product Data Findings** – Natalia's analysis
5. **Channels & Locations Findings** – Olga's analysis
6. **Key Insights** – Combined team findings
7. **Recommendations** – Next steps for data improvement
8. **Q&A** – Questions from the audience and mentor

---

## 🧠 Key Takeaways

### What We Learned

1. **Data is rarely clean** – even in a professional database, issues like duplicates, NULL values, and inconsistencies are common
2. **Standardisation is essential** – without `TRIM()` and `INITCAP()`, city names would have been counted incorrectly
3. **Different perspectives reveal different issues** – each team member's focus area uncovered unique insights
4. **Documentation matters** – clear presentation of findings helps stakeholders understand the data

### What We Accomplished

- ✅ Created a **complete data landscape** of UrbanStyle's core tables
- ✅ Identified **critical data quality issues** affecting reporting
- ✅ Demonstrated the **importance of data cleaning** before analysis
- ✅ Built a **foundation for Week 2** (data cleaning and standardisation)

---

## 🔗 Related Files

- [Week 1 Main README](../README.md)
- [Week 1 Code Folder](../Week_1_Code/)
- [Week 1 Conclusions README](../Week_1_Conclusions/README.md)
- [Week 1 Pictures README](../Week_1_Pictures/README.md)
- [Group Repository – Operations Intelligence](https://github.com/Kolju3/DACA-group)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
