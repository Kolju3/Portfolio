# ✅ Week 7 – RFM Segmentation Conclusions

[![Python](https://img.shields.io/badge/Python-3.10-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![DACA](https://img.shields.io/badge/DACA-Week_7-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)

---

## 📌 Overview

This document summarises the conclusions and recommendations from our RFM customer segmentation analysis for UrbanStyle.ltd.

---

## 🎯 Business Objective

Marko Saar, UrbanStyle's Product Manager, wanted to understand the customer base better to tailor marketing campaigns. RFM segmentation provides a simple yet powerful way to prioritise customers based on their purchasing behaviour.

---

## 👥 Team Contributions

| Team Member | Role | Key Contribution |
| :--- | :--- | :--- |
| **Natalia** | Roll A – Data Loading | Loaded and merged sales + customer data |
| **Olga** | Roll B – Data Cleaning | Handled NULLs, duplicates, date parsing |
| **Helen** | Roll C – RFM Analysis | Computed RFM scores and segments |
| **Kalju (Me)** | Roll D – Visualisation & Findings | Created Plotly graphs and business interpretation |

---

## 🔍 My Specific Contribution (Roll D)

I focused on **translating RFM results into a clear business story** for Marko.

### Segment Analysis

| Segment | Customers | % of Customers | % of Monetary Value | Business Action |
| :--- | :---: | :---: | :---: | :--- |
| **VIP Champions** | 455 | 17.91% | 42.82% | Exclusive offers, early access, VIP events |
| **Loyal** | 679 | 26.73% | 29.75% | Loyalty programme, rewards |
| **Potential** | 759 | 29.88% | 19.49% | Loyalty-building campaigns |
| **At Risk** | 529 | 20.83% | 7.18% | Win-back campaigns (focus on high monetary value) |
| **Lost** | 118 | 4.65% | 0.76% | Minimal investment, general brand awareness |

### Key Insight

**VIP + Loyal = 44.65% of customers but 72.57% of total monetary value.** A small group drives most of the revenue.

**Top 10 VIP Champions** account for **8.64%** of total RFM-analysed revenue (€2.677M total).

### Visualisation Highlights

- **Bar chart:** Segment sizes clearly show the concentration of Potential customers (largest group) and Lost (smallest)
- **Scatter plot (log scale):** Recency vs Monetary – clusters of VIP Champions (low recency, high monetary) and Lost (high recency, low monetary) are visually distinct
- **Donut chart:** Top 10 VIP Champions' revenue share is immediately visible

---

## 💡 Recommendations for Marko

1. **VIP Champions:** Reward with exclusivity (early access, VIP events) – not price discounts. These customers already spend; discounts would only reduce margin.
2. **Loyal:** Nurture toward VIP status with loyalty programmes and cross-sell recommendations.
3. **Potential:** Largest customer group (29.88%). Test loyalty-building campaigns to convert to Loyal.
4. **At Risk:** Prioritise high-monetary-value customers for win-back campaigns. Test targeted offers before rolling out expensive campaigns to the whole segment.
5. **Lost:** Low monetary share – minimal investment. General brand advertising is sufficient.

---

## ⚠️ Limitations

- **Monetary = revenue,** not profit or margin
- **RFM doesn't show price sensitivity directly** – that would require campaign response data
- **Reference date mismatch:** RFM reference date (2025-02-28) is earlier than the dataset (extends to 2026-06-28), creating 25 customers with negative Recency. This is a data range issue, not a calculation error.

---

## 📋 Next Steps

| Priority | Task | Owner |
| :--- | :--- | :--- |
| 1 | **Integrate RFM scoring** into the data pipeline (automate weekly updates) | Data Engineering |
| 2 | **Design a loyalty programme** for Champions and Loyal segments | Marketing |
| 3 | **Run a win-back campaign** for At‑Risk customers and measure response | Marketing |
| 4 | **Validate segmentation** with A/B testing of targeted offers | Analytics |

---

## 🔗 Related Files

- [Week 7 Main README](../README.md)
- [Week 7 Code Folder](../../Week_7_Code/)
- [Week 7 Pictures Folder](../Week_7_Pictures/)

---

*Part of the DACA Portfolio – maintained by Kalju Tamme*
