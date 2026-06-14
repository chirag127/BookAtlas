#!/usr/bin/env python3
"""
BookAtlas Complete Migration Script
Migrates all books from legacy structure to new normalized hierarchy.
"""

import os
import json
import shutil
from pathlib import Path

KNOWLEDGE_DIR = Path("knowledge")

# Mapping from legacy categories to new structure
CATEGORY_MAPPING = {
    # 25-artificial-intelligence-machine-learning
    "25-artificial-intelligence-machine-learning": "04-computers-ai-and-software",
    # 26-technology-engineering  
    "26-technology-engineering": "04-computers-ai-and-software",
    # 27-biography-memoir
    "27-biography-memoir": "10-fiction-and-literature",
    # 28-fiction
    "28-fiction": "10-fiction-and-literature",
    # 29-poetry-drama-performing-arts
    "29-poetry-drama-performing-arts": "10-fiction-and-literature",
    # 30-music-film-media
    "30-music-film-media": "10-fiction-and-literature",
    # 31-architecture-art-design
    "31-architecture-art-design": "10-fiction-and-literature",
    # 32-literary-criticism-theory
    "32-literary-criticism-theory": "06-philosophy-religion-and-indian-thought",
}

# Leaf category mapping (legacy -> new)
LEAF_MAPPING = {
    # AI/ML -> artificial-intelligence
    "deep-learning-and-neural-architectures": "artificial-intelligence",
    "machine-learning-foundations": "artificial-intelligence",
    "mlops-and-production-ai": "artificial-intelligence",
    "natural-language-processing": "artificial-intelligence",
    "reinforcement-learning": "artificial-intelligence",
    # Engineering -> various
    "biomedical-engineering": "engineering-and-technology",
    "civil-and-infrastructure-engineering": "engineering-and-technology",
    "electrical-and-electronics-engineering": "engineering-and-technology",
    "energy-and-sustainability-engineering": "engineering-and-technology",
    "materials-science-and-nanotechnology": "engineering-and-technology",
    "mechanical-engineering": "engineering-and-technology",
    "robotics-and-automation": "engineering-and-technology",
    # Literature -> various
    "artists-writers-and-musicians": "literary-biography-and-memoir",
    "autobiographies-and-personal-memoirs": "literary-biography-and-memoir",
    "entrepreneurs-and-business-builders": "literary-biography-and-memoir",
    "philosophers-and-intellectuals": "literary-biography-and-memoir",
    "political-and-military-leaders": "historical-biography-and-memoir",
    "scientists-and-mathematicians": "literary-biography-and-memoir",
    "social-activists-and-reformers": "literary-biography-and-memoir",
    # Fiction -> various
    "fantasy": "speculative-fiction",
    "horror-and-gothic-literature": "speculative-fiction",
    "historical-fiction": "literary-fiction",
    "mystery-and-crime-fiction": "speculative-fiction",
    "romance": "speculative-fiction",
    "science-fiction": "speculative-fiction",
    # Poetry/Art -> various
    "drama-and-theatre": "poetry-and-drama",
    "poetry": "poetry-and-drama",
    "performing-arts": "poetry-and-drama",
    # Art -> art-and-design
    "architecture": "art-and-design",
    "design": "art-and-design",
    "fine-arts": "art-and-design",
    "photography": "art-and-design",
    # Literary Criticism
    "author-studies-and-genre-criticism": "literary-criticism",
    "classical-literary-theory": "literary-criticism",
    "modern-literary-theory": "literary-criticism",
}

def is_book_directory(dir_path):
    """Check if directory is a book (has 5 required files)."""
    required_files = ["index.mdx", "01-content.mdx", "02-analysis.mdx", "03-narration.mdx", "meta.json"]
    return all((dir_path / f).exists() for f in required_files)

def migrate_books():
    """Migrate all books from legacy structure."""
    migrated = 0
    skipped = 0
    
    for legacy_cat, new_top in CATEGORY_MAPPING.items():
        cat_path = KNOWLEDGE_DIR / legacy_cat
        if not cat_path.exists():
            continue
        
        for leaf_dir in cat_path.iterdir():
            if not leaf_dir.is_dir():
                continue
            
            new_leaf = LEAF_MAPPING.get(leaf_dir.name, leaf_dir.name)
            target_leaf = KNOWLEDGE_DIR / new_top / new_leaf
            target_leaf.mkdir(parents=True, exist_ok=True)
            
            for book_dir in leaf_dir.iterdir():
                if not book_dir.is_dir():
                    continue
                
                if not is_book_directory(book_dir):
                    continue
                
                target_book = target_leaf / book_dir.name
                if target_book.exists():
                    skipped += 1
                    continue
                
                shutil.move(str(book_dir), str(target_book))
                migrated += 1
                print(f"Migrated: {book_dir.name}")
    
    print(f"\nMigrated: {migrated}, Skipped: {skipped}")

if __name__ == "__main__":
    migrate_books()