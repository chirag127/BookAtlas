$ErrorActionPreference = "SilentlyContinue"
$knowledgeRoot = "C:\AM\GitHub\BookAtlas\knowledge"
$fixed = 0

# Find all nested duplicate folders
$nested = Get-ChildItem -Path $knowledgeRoot -Recurse -Directory -ErrorAction SilentlyContinue | Where-Object {
    $_.Name -eq $_.Parent.Name
}

foreach ($dup in $nested) {
    $outerDir = $dup.Parent.FullName
    $innerDir = $dup.FullName

    # Move files from inner to outer (don't overwrite existing)
    $innerFiles = Get-ChildItem -Path $innerDir -File
    foreach ($f in $innerFiles) {
        $destFile = Join-Path $outerDir $f.Name
        if (!(Test-Path $destFile)) {
            Copy-Item $f.FullName $destFile -Force
        }
    }

    # Remove the nested duplicate directory
    Remove-Item $innerDir -Recurse -Force
    $fixed++
    Write-Host "Fixed: $innerDir"
}

Write-Host "Fixed $fixed nested duplicate folders"
