#!/usr/bin/env python3
"""
Complete Book Migration Script
Migrates all books from git history to new normalized structure.
"""

import subprocess
import os
import json
import shutil
from pathlib import Path

KNOWLEDGE_DIR = Path("knowledge")

# Legacy to new category mapping
CATEGORY_MAP = {
    "25-artificial-intelligence-machine-learning": "04-computers-ai-and-software",
    "26-technology-engineering": "04-computers-ai-and-software",
    "27-biography-memoir": "10-fiction-and-literature",
    "28-fiction": "10-fiction-and-literature",
    "29-poetry-drama-performing-arts": "10-fiction-and-literature",
    "30-music-film-media": "10-fiction-and-literature",
    "31-architecture-art-design": "10-fiction-and-literature",
    "32-literary-criticism-theory": "06-philosophy-religion-and-indian-thought",
    "23-computer-science": "04-computers-ai-and-software",
    "24-software-engineering": "04-computers-ai-and-software",
    "22-mathematics-statistics": "07-math-logic-and-science",
    "20-pure-sciences": "07-math-logic-and-science",
    "21-nature-environment-ecology": "02-body-health-and-life-sciences",
    "19-political-science-geopolitics": "08-society-history-and-power",
    "18-history": "08-society-history-and-power",
    "17-law-legal-systems": "01-mind-behavior-and-human-performance",
    "16-social-sciences-sociology": "08-society-history-and-power",
    "15-education-pedagogy": "09-communication-writing-and-creativity",
    "14-communication-language-linguistics": "09-communication-writing-and-creativity",
    "13-economics-economic-theory": "03-money-markets-and-wealth",
    "12-business-management-entrepreneurship": "05-business-strategy-and-organizations",
    "11-finance-investing": "03-money-markets-and-wealth",
    "09-philosophy": "06-philosophy-religion-and-indian-thought",
    "08-psychology": "01-mind-behavior-and-human-performance",
    "02-medicine-health-sciences": "02-body-health-and-life-sciences",
    "01-health-fitness-longevity": "02-body-health-and-life-sciences",
    "06-productivity": "09-communication-writing-and-creativity",
    "05-productivity-performance": "09-communication-writing-and-creativity",
    "07-decision-making-systems-thinking": "08-society-history-and-power",
    "10-religion-spirituality": "06-philosophy-religion-and-indian-thought",
}

# Leaf category mapping
LEAF_MAP = {
    # AI/ML
    "deep-learning-and-neural-architectures": "artificial-intelligence",
    "machine-learning-foundations": "artificial-intelligence",
    "mlops-and-production-ai": "artificial-intelligence",
    "natural-language-processing": "artificial-intelligence",
    "reinforcement-learning": "artificial-intelligence",
    # Engineering
    "biomedical-engineering": "engineering-and-technology",
    "civil-and-infrastructure-engineering": "engineering-and-technology",
    "electrical-and-electronics-engineering": "engineering-and-technology",
    "energy-and-sustainability-engineering": "engineering-and-technology",
    "materials-science-and-nanotechnology": "engineering-and-technology",
    "mechanical-engineering": "engineering-and-technology",
    "robotics-and-automation": "engineering-and-technology",
    # Computer Science
    "algorithms-and-data-structures": "computer-science",
    "compilers-and-language-runtimes": "computer-science",
    "computer-architecture-and-organization": "computer-science",
    "computer-networking": "computer-science",
    "databases-and-storage-theory": "computer-science",
    "operating-systems-internals": "computer-science",
    "programming-languages-and-paradigms": "computer-science",
    "security-and-cryptography": "computer-science",
    "software-engineering-practice": "computer-science",
    "theoretical-computer-science": "computer-science",
    # Software Engineering
    "devops-sre-and-platform-engineering": "software-engineering",
    "distributed-systems-implementation": "software-engineering",
    "engineering-culture-and-team-dynamics": "software-engineering",
    "software-architecture": "software-engineering",
    "software-design-and-architecture": "software-engineering",
    # Math
    "algebra-and-number-theory": "mathematics",
    "analysis-and-calculus": "mathematics",
    "applied-and-computational-mathematics": "mathematics",
    "mathematics-for-a-general-audience": "mathematics",
    "probability-theory": "mathematics",
    "statistics-and-data-analysis": "mathematics",
    # Psychology
    "social-psychology": "psychology",
    "cognitive-psychology": "psychology",
    "developmental-psychology": "psychology",
    # Philosophy
    "aesthetics": "philosophy",
    "eastern-philosophy": "philosophy",
    "epistemology": "philosophy",
    "ethics-and-moral-philosophy": "philosophy",
    "existentialism": "philosophy",
    "logic-and-critical-thinking": "philosophy",
    "metaphysics-and-ontology": "philosophy",
    "non-western-and-comparative-philosophy": "philosophy",
    "philosophy-of-mind-and-language": "philosophy",
    "political-philosophy": "philosophy",
    "western-philosophy-by-era": "philosophy",
    # Finance
    "alternative-investments": "finance",
    "behavioral-finance": "finance",
    "derivatives-and-structured-products": "finance",
    "equity-investing": "finance",
    "personal-finance-and-wealth-building": "finance",
    "quantitative-finance": "finance",
    "real-estate-investing": "finance",
    "risk-management": "finance",
    "venture-capital-and-private-equity": "finance",
    # Business
    "business-strategy": "business",
    "entrepreneurship-and-startups": "business",
    "leadership-and-executive-development": "business",
    "marketing-and-brand-strategy": "business",
    "operations-and-supply-chain": "business",
    "product-management": "business",
    # History
    "big-history-and-civilization": "history",
    "contemporary-history": "history",
    "history-of-ideas-and-intellectual-history": "history",
    "history-of-technology": "history",
    "military-history": "history",
    "modern-world-history": "history",
    "regional-history": "history",
    "world-history-and-civilizations": "history",
    # Literature
    "art-and-design": "art-and-design",
    "historical-biography-and-memoir": "literary-biography",
    "literary-biography-and-memoir": "literary-biography",
    "music": "music",
    "speculative-fiction": "speculative-fiction",
    "poetry-and-drama": "poetry-and-drama",
}

def run_git_cmd(args):
    """Run git command."""
    result = subprocess.run(["git"] + args, capture_output=True, text=True)
    return result.stdout.strip()

def get_all_books_from_git():
    """Get all book directories from git history."""
    files = run_git_cmd(["ls-tree", "-r", "b793f22", "--name-only"])
    books = {}
    
    for f in files.split("\n"):
        if f.endswith("meta.json"):
            parts = Path(f).parts
            if len(parts) >= 4:
                book_slug = parts[-2]
                if book_slug and not book_slug.startswith("."):
                    books[book_slug] = {
                        "path": str(Path(*parts[:-2])),
                        "files": [f]
                    }
    
    return books

def migrate_book(book_path, book_slug):
    """Migrate a single book."""
    parts = book_path.split("/")
    if len(parts) < 4:
        return None
    
    legacy_cat = parts[1]
    leaf_cat = parts[2]
    
    new_top = CATEGORY_MAP.get(legacy_cat)
    new_leaf = LEAF_MAP.get(leaf_cat, leaf_cat)
    
    if not new_top:
        return None
    
    target_path = KNOWLEDGE_DIR / new_top / new_leaf / book_slug
    return target_path

def main():
    # Get all books from git
    files = run_git_cmd(["ls-tree", "-r", "b793f22", "--name-only"])
    
    # Find all book directories
    books = {}
    for f in files.split("\n"):
        if f.endswith("meta.json"):
            book_slug = Path(f).parent.name
            if book_slug and not book_slug.startswith("."):
                books[book_slug] = f
    
    migrated = 0
    skipped = 0
    
    for book_slug, meta_path in books.items():
        parts = meta_path.split("/")
        if len(parts) < 4:
            continue
        
        legacy_cat = parts[1]
        leaf_cat = parts[2]
        
        new_top = CATEGORY_MAP.get(legacy_cat)
        new_leaf = LEAF_MAP.get(leaf_cat, leaf_cat)
        
        if not new_top:
            print(f"SKIP: {book_slug} - unknown category {legacy_cat}")
            continue
        
        target_dir = KNOWLEDGE_DIR / new_top / new_leaf / book_slug
        
        if target_dir.exists():
            skipped += 1
            continue
        
        target_dir.mkdir(parents=True, exist_ok=True)
        
        # Extract and copy all book files
        for file_type in ["index.mdx", "01-content.mdx", "02-analysis.mdx", "03-narration.mdx", "meta.json"]:
            src = f"{legacy_cat}/{leaf_cat}/{book_slug}/{file_type}"
            dst = target_dir / file_type
            
            content = run_git_cmd(["show", f"b793f22:{src}"])
            dst.write_text(content)
        
        print(f"MIGRATED: {book_slug}")
        migrated += 1
    
    print(f"\nTotal: Migrated={migrated}, Skipped={skipped}")

if __name__ == "__main__":
    main()