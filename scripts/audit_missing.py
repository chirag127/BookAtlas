"""Check which books from git history are missing files in current structure."""
import os
import subprocess
from pathlib import Path

def run_git(args):
    result = subprocess.run(["git"] + args, capture_output=True, text=True)
    return result.stdout.strip()

# Get all meta.json paths from git history
files = run_git(["ls-tree", "-r", "b793f22", "--name-only"])
git_books = {}
for f in files.split("\n"):
    if f.endswith("meta.json") and "knowledge/" in f:
        parts = Path(f).parts
        if len(parts) >= 4:
            book_slug = parts[-2]
            top_cat = parts[1]
            leaf_cat = parts[2]
            git_books[book_slug] = {
                "git_path": f,
                "top_cat": top_cat,
                "leaf_cat": leaf_cat,
            }

print(f"Books in git history: {len(git_books)}")

# Check current books
knowledge = Path("knowledge")
current_books = {}
for root, dirs, files in os.walk(knowledge):
    root_path = Path(root)
    if (root_path / "meta.json").exists():
        rel = str(root_path.relative_to(knowledge))
        current_books[rel] = list(files)

print(f"Current book dirs: {len(current_books)}")

# Find nested book dirs (book/book pattern)
nested = []
for root, dirs, files in os.walk(knowledge):
    root_path = Path(root)
    rel = root_path.relative_to(knowledge)
    parts = rel.parts
    if len(parts) == 3:
        book_name = parts[2]
        nested_dir = root_path / book_name
        if nested_dir.exists() and (nested_dir / "meta.json").exists():
            nested.append((str(rel), str(nested_dir.relative_to(knowledge))))

print(f"\nNested book dirs: {len(nested)}")
for outer, inner in nested[:30]:
    print(f"  {outer} -> {inner}")

# Check for books with missing content files
print("\nBooks missing content files:")
for rel, files in sorted(current_books.items()):
    missing = []
    for req in ["index.mdx", "01-content.mdx", "02-analysis.mdx", "03-narration.mdx"]:
        if req not in files:
            missing.append(req)
    if missing:
        print(f"  {rel}: {missing}")
