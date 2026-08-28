# 📊 DATA – Datasets and Backups

[![Supabase](https://img.shields.io/badge/Supabase-Export-047857?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com/)

---

## 🎯 Purpose

This folder stores all the **datasets** used in the DACA project – both the original raw data and the processed versions.

The data comes from the UrbanStyle simulation and was originally hosted on **Supabase** (PostgreSQL). The CSV files here are snapshots taken at various points in the programme, allowing for offline analysis, backups, and reproducibility.

---

## 📂 Folder Structure

```text
DATA/
├── README.md                  # This file
├── Backup/                    # Backup copies
│   └── Bonus/                 # Backup of the Bonus dataset
├── Bonus/                     # Additional / bonus datasets
├── Core/                      # Primary datasets (main tables)
└── Schema/                    # Database schema definitions (DDL)
