#!/usr/bin/env python3
"""
Week_Builder.py
Contains the logic to build a single week folder (Week_0 … Week_10).
"""

from pathlib import Path
from Structure_Utils import create_folder, create_readme

# ----------------------------------------------------------------------
# Configuration for week sub‑structures
# ----------------------------------------------------------------------

WEEK_SUBFOLDERS = ["Code", "Feedback", "Materials", "Results"]
MATERIALS_SUB = ["RAG"]
RESULTS_SUB = ["Conclusions", "Pictures", "Presentation", "Tables"]

# ----------------------------------------------------------------------
# Builder function
# ----------------------------------------------------------------------

def build_week(week_num: int, root: Path) -> None:
    """
    Create a single week folder (Week_0 … Week_10).
    Week_0 gets only a README; weeks 1–10 get the full nested structure.
    """
    week_name = f"Week_{week_num}"
    week_path = root / week_name
    create_folder(week_path)

    # Top‑level README for this week
    if week_num == 0:
        content = f"# {week_name}\n\nPlaceholder for Week 0 materials.\n"
    else:
        content = f"# {week_name}\n\nContent for Week {week_num} of the Data Analysis course.\n"
    create_readme(week_path / "README.md", content)

    # For weeks 1–10, create subfolders
    if week_num >= 1:
        for sub in WEEK_SUBFOLDERS:
            sub_path = week_path / f"{week_name}_{sub}"
            create_folder(sub_path)

            # Handle special cases: Materials and Results
            if sub == "Materials":
                # RAG subfolder
                rag_path = sub_path / f"{week_name}_RAG"
                create_folder(rag_path)
                create_readme(
                    rag_path / "README.md",
                    f"# {week_name}_RAG\n\nRAG materials for Week {week_num}.\n"
                )
                # README for Materials itself
                create_readme(
                    sub_path / "README.md",
                    f"# {week_name}_Materials\n\nMaterials for Week {week_num}.\n"
                )

            elif sub == "Results":
                # Four subfolders inside Results
                for rsub in RESULTS_SUB:
                    rsub_path = sub_path / f"{week_name}_{rsub}"
                    create_folder(rsub_path)
                    create_readme(
                        rsub_path / "README.md",
                        f"# {week_name}_{rsub}\n\nPlaceholder for {rsub}.\n"
                    )
                # README for Results itself
                create_readme(
                    sub_path / "README.md",
                    f"# {week_name}_Results\n\nResults from Week {week_num}.\n"
                )

            else:  # Code, Feedback
                create_readme(
                    sub_path / "README.md",
                    f"# {week_name}_{sub}\n\nPlaceholder for {sub}.\n"
                )