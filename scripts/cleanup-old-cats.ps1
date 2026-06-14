$ErrorActionPreference = "SilentlyContinue"
$knowledgeRoot = "C:\AM\GitHub\BookAtlas\knowledge"

$oldCategories = @(
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

$removed = 0
$kept = 0
foreach ($cat in $oldCategories) {
    $catPath = Join-Path $knowledgeRoot $cat
    if (Test-Path $catPath) {
        $remaining = Get-ChildItem -Path $catPath -Recurse -File -ErrorAction SilentlyContinue
        if ($remaining.Count -eq 0) {
            Remove-Item -Path $catPath -Recurse -Force
            $removed++
        } else {
            Write-Host "Still has files: $cat ($($remaining.Count) files)"
            $kept++
        }
    }
}
Write-Host "Removed $removed empty categories, $kept still have files"
