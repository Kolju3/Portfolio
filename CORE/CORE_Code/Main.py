#!/usr/bin/env python3
"""
Main.py
Builds the full folder/file structure for the Data Analysis course portfolio.
Uses utilities from Structure_Utils and week logic from WeekBuilder.
"""

from pathlib import Path
from Structure_Utils import create_folder, create_readme, create_empty_file
from Week_Builder import build_week

# ----------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------

WEEKS = list(range(11))                          # 0 … 10
TOP_LEVEL = ["CORE", "WORKSHOP"] + [f"Week_{i}" for i in WEEKS]

CORE_SUBFOLDERS = ["CORE_Code", "CORE_RAG", "DATA", "INTRODUCTION"]
WORKSHOP_FILES = ["README.md", ".env", ".gitignore", "requirements.txt"]

# ----------------------------------------------------------------------
# Builder functions for CORE and WORKSHOP
# ----------------------------------------------------------------------

def build_core(root: Path) -> None:
    """Create the CORE folder and its subfolders."""
    core_path = root / "CORE"
    create_folder(core_path)

    # README for CORE itself
    create_readme(core_path / "README.md", "# CORE\n\nCore materials for the Data Analysis course.\n")

    # Subfolders with their own READMEs
    for sub in CORE_SUBFOLDERS:
        sub_path = core_path / sub
        create_folder(sub_path)
        create_readme(
            sub_path / "README.md",
            f"# {sub}\n\nPlaceholder for {sub} materials.\n"
        )

def build_workshop(root: Path) -> None:
    """Create the WORKSHOP folder, its subfolders, and required files."""
    ws_path = root / "WORKSHOP"
    create_folder(ws_path)

    # Subfolders
    for sub in ["output", "__pycache__", ".venv"]:
        create_folder(ws_path / sub)

    # Files
    for fname in WORKSHOP_FILES:
        file_path = ws_path / fname
        if fname == "README.md":
            create_readme(file_path, "# WORKSHOP\n\nWorkspace for development and experiments.\n")
        else:
            create_empty_file(file_path)

# ----------------------------------------------------------------------
# Root README update
# ----------------------------------------------------------------------

def build_root_readme(root: Path) -> None:
    """Create or update the root README.md with a project structure listing."""
    root_readme = root / "README.md"
    structure_lines = ["## Project Structure\n"]
    for folder in TOP_LEVEL:
        structure_lines.append(f"- `{folder}/` – see `{folder}/README.md`")

    if root_readme.exists():
        with open(root_readme, "r", encoding="utf-8") as f:
            current = f.read()
        if "## Project Structure" in current:
            print("⏩ Root README already contains '## Project Structure' – skipping append.")
            return
        # Append the structure
        with open(root_readme, "a", encoding="utf-8") as f:
            f.write("\n" + "\n".join(structure_lines))
        print("✅ Updated root README with structure listing.")
    else:
        # Create new README
        content = "# DACA Portfolio\n\nData Analysis Course portfolio.\n\n"
        content += "\n".join(structure_lines)
        create_readme(root_readme, content)

# ----------------------------------------------------------------------
# Main execution
# ----------------------------------------------------------------------

def main() -> None:
    root = Path.cwd()

    # Safety check: are we inside a Git repo?
    if not (root / ".git").exists():
        print("❌ Error: No .git folder found. Please run this script from the root of your Git repository.")
        return

    # 1. Build CORE and WORKSHOP
    build_core(root)
    build_workshop(root)

    # 2. Build each week (0 … 10) using the dedicated module
    for week in WEEKS:
        build_week(week, root)

    # 3. Root README
    build_root_readme(root)

    print("\n🎉 Folder structure created successfully!")
    print("Now stage, commit, and push with:")
    print("  git add .")
    print('  git commit -m "Add folder structure for course weeks"')
    print("  git push origin main")

if __name__ == "__main__":
    main()