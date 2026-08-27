# 📽️ Week 4 – Group Presentation: SQL Aggregation & Business Intelligence

[![DACA](https://img.shields.io/badge/DACA-Week_4-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)
[![Presentation](https://img.shields.io/badge/Presentation-Group-FFA500?style=for-the-badge)](https://github.com/Kolju3/DACA-group)
[![Status](https://img.shields.io/badge/Status-Completed-00A86B?style=for-the-badge)]()

---

## 📌 Overview

This folder contains the **group presentation** delivered during Week 4 of the DACA programme. The presentation summarises our team's SQL aggregation analysis, focusing on marketing channel contribution, customer journey analysis, and the methodological limitations that affect interpretation.

The presentation was created collaboratively by the **Operations Intelligence** team and presented during Sessioon 3 (Demo session).

---

## 📄 File Contents

| File | Description |
| :--- | :--- |
| **`W4_GT_Olga_UrbanStyle_lisad.pptx`** | The group presentation slides (PowerPoint format) – covering marketing channels, customer journey funnel, methodological limitations, and strategic recommendations |

---

## 👥 Team Members (Operations Intelligence)

| Team Member | Role | Focus Area |
| :--- | :--- | :--- |
| **Kalju (Me)** | Roll A – Sales Aggregation | Sales trends, seasonal patterns, YoY growth |
| **Natalia** | Roll B – Customer Segmentation | VIP/Regular/New customer analysis |
| **Olga** | Roll C – Product & Inventory | Category performance, inventory statistics |
| **Helen** | Roll D – Marketing Channels | Channel attribution, customer journey, ROI analysis |

---

## 🎯 Presentation Objective

The goal of this presentation was to:

1. **Present aggregated business intelligence** derived from UrbanStyle's sales, customer, and marketing data
2. **Demonstrate marketing channel performance** using customer journey analysis
3. **Highlight methodological limitations** that affect interpretation
4. **Provide strategic recommendations** for Kristi Tamm (CEO) and Anna Mets (Marketing Lead)

---

## 🔍 Key Findings Presented

### 1. Customer Journey Filtered Funnel

| Metric | Value |
| :--- | :--- |
| **Filtered Customers** | 624 clients |
| **Orders** | 1,994 |
| **Revenue** | €582,912.57 |

**Key Insight:** The filtered funnel shows the subset of customers who can be linked to specific marketing channels via `web_logs`. This represents a portion of total business that can be attributed to marketing efforts.

**Methodological Note:** Direct JOIN between `sales` and `web_logs` without filtering multiplies sales rows (one customer → multiple visits). To correct this, **last-click attribution** was applied: each customer was assigned to the channel of their most recent known visit.

---

### 2. Marketing Channel Contribution

The analysis identified the following key channels:

| Channel | Performance |
| :--- | :--- |
| **google_organic** | Largest revenue contributor (€666,444.98, 2,273 orders) |
| **facebook_ads** | Strong performer (€469,933.25, 1,635 orders) |
| **direct** | Significant direct traffic (€420,103.22, 1,505 orders) |
| **email_campaign** | Effective engagement channel (€300,296.85, 1,024 orders) |
| **instagram** | Highest average order value (€298.87) |

**Key Insight:** Organic search is the largest channel, but paid channels (Facebook, Instagram) show strong performance with higher AOV.

---

### 3. Critical Methodological Limitations

The presentation highlighted several important data limitations:

| Limitation | Impact | Mitigation |
| :--- | :--- | :--- |
| **ROI Data Missing** | Cannot calculate true campaign return on investment | Add campaign cost data to future analysis |
| **Visit Multiplicity** | Direct JOIN multiplies sales rows | Used last-click attribution as a simplification |
| **2025 Data Anomaly** | Sudden drop in 2025 requires investigation | Technical audit needed before business conclusions |
| **Last-Click Attribution** | Ignores previous touchpoints | Simpler than multi-touch, but less accurate |
| **Segment Thresholds** | VIP/Regular boundaries (€150/€500) are analytical choices | Management should validate and confirm |
| **Inventory Integration** | Category revenue doesn't equal stock planning | Link to actual `inventory` data for planning |

**Key Insight:** While aggregation provides valuable insights, the limitations must be clearly communicated to stakeholders to avoid over-interpretation.

---

### 4. Strategic Recommendations

#### For Kristi Tamm (CEO)

| Recommendation | Rationale |
| :--- | :--- |
| **VIP-Client Personalisation** | Small segment (18 clients) – they deserve personalised offers, not mass campaigns |
| **Regular-Client Cross-Sell** | Best growth source – implement add-on recommendations and frequency incentives |
| **New-Client Automation** | Large new customer base – automated follow-up emails to prevent one-time purchases |
| **Growth Channel Prioritisation** | Focus on Online and Tartu – they proved strong growth |
| **Seasonality & Inventory Sync** | Increase men's clothing and footwear stock before summer peaks (+20%) and year-end campaigns |

#### For Anna Mets (Marketing)

| Recommendation | Rationale |
| :--- | :--- |
| **Standardise Marketing Channels** | Same channels appear with different spellings in the database – standardisation reduces manual work |
| **Data Audit** | Initiate technical check of 2025 sales data completeness before external disclosure |

---

## 📊 Summary of Insights

| Domain | Key Finding | Data Quality Concern |
| :--- | :--- | :--- |
| **Marketing Channels** | `google_organic` largest by revenue; `instagram` highest AOV | Last-click attribution is a simplification |
| **Customer Journey** | 624 clients, 1,994 orders, €582,912.57 | Direct JOIN multiplies rows |
| **Data Quality** | 2025 data anomaly needs investigation | ROI data missing |
| **Segmentation** | VIP (18 clients) need personalised treatment | Thresholds are analytical choices |

---

## 💡 Key Takeaways

### What We Learned

1. **Aggregation unlocks business value** – transforming raw data into actionable KPIs
2. **Last-click attribution is a simplification** – it ignores prior touchpoints but is practical to implement
3. **Data quality limitations are critical** – ROI data, 2025 completeness, and inventory integration all need attention
4. **Seasonal patterns are consistent** – summer peaks (+20%) and year-end spikes are reliable
5. **Online and Tartu are growth engines** – investment should follow these trends

### What We Accomplished

- ✅ Connected sales, customer, and marketing data using SQL JOINs and aggregation
- ✅ Identified top marketing channels by revenue and AOV
- ✅ Created a filtered customer journey funnel (624 clients, 1,994 orders)
- ✅ Documented methodological limitations for accurate interpretation
- ✅ Provided strategic recommendations for CEO and Marketing Lead

---

## 🔗 Related Files

- [Week 4 Main README](../README.md)
- [Week 4 Code Folder](../Week_4_Code/)
- [Week 4 Conclusions README](../Week_4_Conclusions/README.md)
- [Week 4 Tables README](../Week_4_Tables/README.md)
- [Group Repository – Operations Intelligence](https://github.com/Kolju3/DACA-group)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
