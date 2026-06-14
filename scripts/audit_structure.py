"""Audit script: find all book directories and their file counts."""
import os
from pathlib import Path
from collections import defaultdict

knowledge = Path("knowledge")
books = {}
leaf_cats = defaultdict(list)
top_cats = set()

for root, dirs, files in os.walk(knowledge):
    root_path = Path(root)
    rel = root_path.relative_to(knowledge)
    parts = rel.parts
    
    if len(parts) == 1:
        top_cats.add(parts[0])
    
    if len(parts) == 2:
        leaf_cats[parts[0]].append(parts[1])
    
    # A book dir has meta.json
    if (root_path / "meta.json").exists():
        book_files = {
            "index.mdx": (root_path / "index.mdx").exists(),
            "01-content.mdx": (root_path / "01-content.mdx").exists(),
            "02-analysis.mdx": (root_path / "02-analysis.mdx").exists(),
            "03-narration.mdx": (root_path / "03-narration.mdx").exists(),
            "meta.json": True,
        }
        extra = [f for f in files if f not in book_files and not f.startswith(".")]
        books[str(rel)] = {
            "files": book_files,
            "extra": extra,
            "file_count": len(files),
        }

print("=" * 60)
print("TOP CATEGORIES")
print("=" * 60)
for tc in sorted(top_cats):
    print(f"  {tc}")
    for lc in sorted(leaf_cats[tc]):
        book_count = sum(1 for b in books if b.startswith(f"{tc}/{lc}/"))
        print(f"    {lc}/ ({book_count} books)")

print()
print("=" * 60)
print(f"TOTAL BOOKS: {len(books)}")
print("=" * 60)

# Find books with missing files
missing = {k: v for k, v in books.items() if not all(v["files"].values())}
print(f"\nBOOKS WITH MISSING FILES: {len(missing)}")
for path, info in sorted(missing.items()):
    missing_files = [f for f, exists in info["files"].items() if not exists]
    print(f"  {path}: missing {missing_files}")

# Find books with extra files
extra_files = {k: v for k, v in books.items() if v["extra"]}
print(f"\nBOOKS WITH EXTRA FILES: {len(extra_files)}")
for path, info in sorted(extra_files.items()):
    print(f"  {path}: extra={info['extra']}")

# Find duplicate/nested books (book dir inside book dir)
print("\n" + "=" * 60)
print("POTENTIAL NESTED/DUPLICATE BOOK DIRS")
print("=" * 60)
for path in sorted(books.keys()):
    parts = path.split("/")
    if len(parts) > 3:
        print(f"  DEEP: {path}")
    elif len(parts) == 3:
        book_name = parts[2]
        # Check if there's a nested dir with same name
        nested = knowledge / parts[0] / parts[1] / book_name / book_name
        if nested.exists():
            print(f"  NESTED: {path} -> {nested}")
