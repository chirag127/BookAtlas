$ErrorActionPreference = "SilentlyContinue"
$knowledgeRoot = "C:\AM\GitHub\BookAtlas\knowledge"

# Step 1: Remove all 04-problems.mdx files (deprecated)
$problemsFiles = Get-ChildItem -Path $knowledgeRoot -Recurse -Filter "04-problems.mdx" -File
foreach ($f in $problemsFiles) {
    Remove-Item $f.FullName -Force
}
Write-Host "Removed $($problemsFiles.Count) 04-problems.mdx files"

# Step 2: Remove all README.md files inside knowledge (deprecated)
$readmeFiles = Get-ChildItem -Path $knowledgeRoot -Recurse -Filter "README.md" -File
foreach ($f in $readmeFiles) {
    Remove-Item $f.FullName -Force
}
Write-Host "Removed $($readmeFiles.Count) README.md files"

# Step 3: Remove old category-level index.mdx files (not book-level)
$oldCats = @(
    "01-health-fitness-longevity",
    "02-medicine-health-sciences",
    "03-biology-life-sciences",
    "04-self-help-personal-development",
    "05-productivity-performance",
    "06-productivity",
    "07-decision-making-systems-thinking",
    "08-psychology",
    "09-philosophy",
    "10-religion-spirituality",
    "11-finance-investing",
    "12-business-management-entrepreneurship",
    "13-economics-economic-theory",
    "14-communication-language-linguistics",
    "15-education-pedagogy",
    "16-social-sciences-sociology",
    "17-law-legal-systems",
    "18-history",
    "19-political-science-geopolitics",
    "20-pure-sciences",
    "21-nature-environment-ecology",
    "22-mathematics-statistics",
    "23-computer-science",
    "24-software-engineering",
    "25-artificial-intelligence-machine-learning",
    "26-technology-engineering",
    "27-biography-memoir",
    "28-fiction",
    "29-poetry-drama-performing-arts",
    "30-music-film-media",
    "31-architecture-art-design",
    "32-literary-criticism-theory"
)

$indexRemoved = 0
foreach ($cat in $oldCats) {
    $catPath = Join-Path $knowledgeRoot $cat
    if (Test-Path $catPath) {
        # Remove index.mdx at category level and subcategory level
        Get-ChildItem -Path $catPath -Filter "index.mdx" -Recurse -File | ForEach-Object {
            # Only remove if it's NOT inside a book folder (book folders have meta.json)
            $parentDir = $_.Directory
            $hasMeta = Test-Path (Join-Path $parentDir.FullName "meta.json")
            if (-not $hasMeta) {
                Remove-Item $_.FullName -Force
                $indexRemoved++
            }
        }
    }
}
Write-Host "Removed $indexRemoved old category index.mdx files"

# Step 4: Now remove empty old category directories
$removed = 0
foreach ($cat in $oldCats) {
    $catPath = Join-Path $knowledgeRoot $cat
    if (Test-Path $catPath) {
        $remaining = Get-ChildItem -Path $catPath -Recurse -File -ErrorAction SilentlyContinue
        if ($remaining.Count -eq 0) {
            Remove-Item -Path $catPath -Recurse -Force
            $removed++
        } else {
            Write-Host "Still has files: $cat ($($remaining.Count) files)"
            # List what's left
            $remaining | ForEach-Object { Write-Host "  $($_.FullName)" }
        }
    }
}
Write-Host "Removed $removed empty old categories"
