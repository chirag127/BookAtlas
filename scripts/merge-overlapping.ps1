$ErrorActionPreference = "SilentlyContinue"
$knowledgeRoot = "C:\AM\GitHub\BookAtlas\knowledge"
$moved = 0

function Move-Books($from, $to) {
    if (!(Test-Path $from)) { return }
    if (!(Test-Path $to)) { New-Item -ItemType Directory -Path $to -Force | Out-Null }
    Get-ChildItem -Path $from -Directory | ForEach-Object {
        $dest = Join-Path $to $_.Name
        if (!(Test-Path $dest)) {
            Move-Item $_.FullName $to
            $script:moved++
        }
    }
}

# Merge overlapping subcategories in 07-math-logic-and-science
Move-Books "07-math-logic-and-science/physics-and-astronomy" "07-math-logic-and-science/physics"
Move-Books "07-math-logic-and-science/popular-science-and-science-communication" "07-math-logic-and-science/popular-science"
Move-Books "07-math-logic-and-science/philosophy-history-of-science" "07-math-logic-and-science/history-and-philosophy-of-science"
Move-Books "07-math-logic-and-science/chemistry-and-biology" "07-math-logic-and-science/chemistry"
Move-Books "07-math-logic-and-science/real-and-complex-analysis" "07-math-logic-and-science/mathematics"
Move-Books "07-math-logic-and-science/evolutionary-biology" "07-math-logic-and-science/biology-and-evolution"

# Merge overlapping in 10-fiction-and-literature
Move-Books "10-fiction-and-literature/design" "10-fiction-and-literature/art-and-design"
Move-Books "10-fiction-and-literature/literary-biography-and-memoir" "10-fiction-and-literature/autobiographies-and-personal-memoirs"
Move-Books "10-fiction-and-literature/historical-biography-and-memoir" "10-fiction-and-literature/autobiographies-and-personal-memoirs"
Move-Books "10-fiction-and-literature/speculative-fiction" "10-fiction-and-literature/science-fiction"

# Merge overlapping in 08-society-history-and-power
Move-Books "08-society-history-and-power/education-and-pedagogy" "08-society-history-and-power/history"
Move-Books "08-society-history-and-power/historical-biography-and-memoir" "08-society-history-and-power/history"
Move-Books "08-society-history-and-power/sociology" "08-society-history-and-power/sociology-and-anthropology"

# Merge overlapping in 09-communication-writing-and-creativity
Move-Books "09-communication-writing-and-creativity/writing-craft-and-nonfiction-writing" "09-communication-writing-and-creativity/writing-craft-and-nonfiction"

# Merge overlapping in 01-mind-behavior-and-human-performance
Move-Books "01-mind-behavior-and-human-performance/common-law-traditions" "01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"
Move-Books "01-mind-behavior-and-human-performance/corporate-and-commercial-law" "01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"
Move-Books "01-mind-behavior-and-human-performance/foundations-of-law" "01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"
Move-Books "01-mind-behavior-and-human-performance/indian-law" "01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"
Move-Books "01-mind-behavior-and-human-performance/international-law" "01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"
Move-Books "01-mind-behavior-and-human-performance/legal-practice-and-career" "01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"

# Merge overlapping in 04-computers-ai-and-software
Move-Books "04-computers-ai-and-software/system-design-and-scalability" "04-computers-ai-and-software/system-design-and-architecture"

Write-Host "Merged $moved books from overlapping subcategories"

# Now remove empty merged dirs
$emptyDirs = @(
    "07-math-logic-and-science/physics-and-astronomy",
    "07-math-logic-and-science/popular-science-and-science-communication",
    "07-math-logic-and-science/philosophy-history-of-science",
    "07-math-logic-and-science/chemistry-and-biology",
    "07-math-logic-and-science/real-and-complex-analysis",
    "07-math-logic-and-science/evolutionary-biology",
    "10-fiction-and-literature/design",
    "10-fiction-and-literature/literary-biography-and-memoir",
    "10-fiction-and-literature/historical-biography-and-memoir",
    "10-fiction-and-literature/speculative-fiction",
    "08-society-history-and-power/education-and-pedagogy",
    "08-society-history-and-power/historical-biography-and-memoir",
    "08-society-history-and-power/sociology",
    "09-communication-writing-and-creativity/writing-craft-and-nonfiction-writing",
    "01-mind-behavior-and-human-performance/common-law-traditions",
    "01-mind-behavior-and-human-performance/corporate-and-commercial-law",
    "01-mind-behavior-and-human-performance/foundations-of-law",
    "01-mind-behavior-and-human-performance/indian-law",
    "01-mind-behavior-and-human-performance/international-law",
    "01-mind-behavior-and-human-performance/legal-practice-and-career",
    "04-computers-ai-and-software/system-design-and-scalability"
)
$removed = 0
foreach ($d in $emptyDirs) {
    $p = Join-Path $knowledgeRoot $d
    if (Test-Path $p) {
        $files = Get-ChildItem $p -Recurse -File -ErrorAction SilentlyContinue
        if ($files.Count -eq 0) {
            Remove-Item $p -Recurse -Force
            $removed++
        }
    }
}
Write-Host "Removed $removed empty merged directories"
