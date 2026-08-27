#!/usr/bin/env python3
"""
Structure_Utils.py
Generic utilities for creating folders and files.
"""

from pathlib import Path

def create_folder(path: Path) -> None:
    """Create a directory (and parents) if it doesn't exist."""
    path.mkdir(parents=True, exist_ok=True)

def create_readme(path: Path, content: str) -> None:
    """Create a README.md file with the given content (skip if exists)."""
    if path.exists():
        print(f"⏩ {path} already exists, skipped.")
        return
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"✅ Created {path}")

def create_empty_file(path: Path) -> None:
    """Create an empty file (skip if exists)."""
    if path.exists():
        print(f"⏩ {path} already exists, skipped.")
        return
    path.touch()
    print(f"✅ Created {path}")