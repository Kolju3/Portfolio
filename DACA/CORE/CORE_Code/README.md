
---

### 2. CORE/CORE_code/README.md

Place this file inside `/home/kolp/Desktop/Kursus/Repositary/Portfolio/DACA/CORE/CORE_code/`.

```markdown
# ⚙️ CORE_code – Folder Structure Generator

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![DACA](https://img.shields.io/badge/DACA-Project-0A66C2?style=for-the-badge)](https://github.com/Kolju3/Portfolio)

---

## 🎯 Purpose

This folder contains the **Python script** that automatically creates the entire folder hierarchy for the DACA project.

The script generates:
- The `Week_0` through `Week_10` folders
- Their subfolders (`Code`, `Feedback`, `Materials`, `Results`)
- The nested subfolders under `Results` (`Conclusions`, `Pictures`, `Presentation`, `Tables`)
- The `CORE` subfolders (`CORE_code`, `CORE_RAG`, `DATA`, `INTRODUCTION`) and their internal structure

This script is useful if you ever need to **reset** the project structure or **replicate** it for a new project.

---

## ⚠️ Important: Execution Location

The script **must be run from the repository root** – i.e., from `/home/kolp/Desktop/Kursus/Repositary/Portfolio/` – **not** from inside the `CORE_code` folder.

If you run it from within `CORE_code`, it will create the folders in the wrong place.

### Correct way to run:

```bash
cd /home/kolp/Desktop/Kursus/Repositary/Portfolio
python CORE/CORE_code/create_structure.py
