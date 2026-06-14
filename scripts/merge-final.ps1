$ErrorActionPreference = "SilentlyContinue"
$knowledgeRoot = "C:\AM\GitHub\BookAtlas\knowledge"

# Move remaining orphaned law books from 01 to 08
$lawSubs = @("common-law-traditions","corporate-and-commercial-law","foundations-of-law","indian-law","international-law","legal-practice-and-career")
foreach ($sub in $lawSubs) {
    $src = Join-Path $knowledgeRoot "01-mind-behavior-and-human-performance\$sub"
    $dest = Join-Path $knowledgeRoot "08-society-history-and-power\public-policy-and-law"
    if (Test-Path $src) {
        Get-ChildItem $src -Directory -EA SilentlyContinue | ForEach-Object {
            $d = Join-Path $dest $_.Name
            if (!(Test-Path $d)) { Move-Item $_.FullName $dest }
        }
        $remaining = Get-ChildItem $src -Recurse -File -EA SilentlyContinue
        if ($remaining.Count -eq 0) { Remove-Item $src -Recurse -Force }
    }
}

# Move design books from 10/design to 10/art-and-design
$src = Join-Path $knowledgeRoot "10-fiction-and-literature\design"
$dest = Join-Path $knowledgeRoot "10-fiction-and-literature\art-and-design"
if (Test-Path $src) {
    Get-ChildItem $src -Directory -EA SilentlyContinue | ForEach-Object {
        $d = Join-Path $dest $_.Name
        if (!(Test-Path $d)) { Move-Item $_.FullName $dest }
    }
    if ((Get-ChildItem $src -Recurse -File -EA SilentlyContinue).Count -eq 0) { Remove-Item $src -Recurse -Force }
}

# Move speculative-fiction to science-fiction
$src = Join-Path $knowledgeRoot "10-fiction-and-literature\speculative-fiction"
$dest = Join-Path $knowledgeRoot "10-fiction-and-literature\science-fiction"
if (Test-Path $src) {
    Get-ChildItem $src -Directory -EA SilentlyContinue | ForEach-Object {
        $d = Join-Path $dest $_.Name
        if (!(Test-Path $d)) { Move-Item $_.FullName $dest }
    }
    if ((Get-ChildItem $src -Recurse -File -EA SilentlyContinue).Count -eq 0) { Remove-Item $src -Recurse -Force }
}

# Move remaining overlaps
$overlaps = @(
    @("popular-science-and-science-communication", "popular-science", "07-math-logic-and-science"),
    @("philosophy-history-of-science", "history-and-philosophy-of-science", "07-math-logic-and-science"),
    @("sociology", "sociology-and-anthropology", "08-society-history-and-power"),
    @("writing-craft-and-nonfiction-writing", "writing-craft-and-nonfiction", "09-communication-writing-and-creativity"),
    @("system-design-and-scalability", "system-design-and-architecture", "04-computers-ai-and-software")
)

foreach ($o in $overlaps) {
    $srcName = $o[0]; $destName = $o[1]; $topCat = $o[2]
    $src = Join-Path $knowledgeRoot "$topCat\$srcName"
    $dest = Join-Path $knowledgeRoot "$topCat\$destName"
    if (Test-Path $src) {
        if (!(Test-Path $dest)) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }
        Get-ChildItem $src -Directory -EA SilentlyContinue | ForEach-Object {
            $d = Join-Path $dest $_.Name
            if (!(Test-Path $d)) { Move-Item $_.FullName $dest }
        }
        if ((Get-ChildItem $src -Recurse -File -EA SilentlyContinue).Count -eq 0) { Remove-Item $src -Recurse -Force }
    }
}

Write-Host "Done merging remaining overlaps"
