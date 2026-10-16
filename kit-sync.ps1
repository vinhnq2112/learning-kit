<#
.SYNOPSIS
  Sync kit-owned files between a subject folder and the learning-kit template.

.DESCRIPTION
  Kit-owned files: VERSION, CLAUDE.md, GUIDE.md, kit-sync.ps1, every skill/agent of the template's .claude/,
  and the pack skills/agents installed in this subject. Subject-owned files (subject/, learning/,
  practice/project folders, subject agents, README.md) are never touched.

  The hash of each file at the last sync is stored in .kit/sync-state.json, so the script knows which
  side changed. A file changed on both sides is reported as a conflict and never overwritten.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File kit-sync.ps1 status
  powershell -ExecutionPolicy Bypass -File kit-sync.ps1 push          # dry run
  powershell -ExecutionPolicy Bypass -File kit-sync.ps1 push -Apply   # subject -> kit
  powershell -ExecutionPolicy Bypass -File kit-sync.ps1 pull -Apply   # kit -> subject
#>
param(
    [Parameter(Position = 0)][ValidateSet('status', 'push', 'pull')][string]$Action = 'status',
    [string]$KitPath = '',
    [switch]$Apply
)
$ErrorActionPreference = 'Stop'

$Subject = $PSScriptRoot
if (-not $KitPath) { $KitPath = Join-Path (Split-Path $Subject -Parent) 'learning-kit' }
if (-not (Test-Path $KitPath)) { throw "Kit not found at '$KitPath'. Pass -KitPath <path>." }
$Kit = (Resolve-Path $KitPath).Path
if ($Kit -eq $Subject) { Write-Host 'This is the kit template itself. Run kit-sync from a subject folder.'; exit 1 }

$StateFile = Join-Path $Subject '.kit\sync-state.json'
$state = @{}
if (Test-Path $StateFile) {
    (Get-Content $StateFile -Raw | ConvertFrom-Json).PSObject.Properties | ForEach-Object { $state[$_.Name] = $_.Value }
}

# Hash with line endings normalized, so CRLF/LF conversions by git don't look like changes
$sha = [System.Security.Cryptography.SHA256]::Create()
function Get-Hash($path) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { return $null }
    $bytes = [System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $path).Path)
    $text = [System.Text.Encoding]::UTF8.GetString($bytes) -replace "`r`n", "`n"
    [System.BitConverter]::ToString($sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($text))) -replace '-', ''
}

function Get-RelFiles($root, $dir) {
    $full = Join-Path $root $dir
    if (-not (Test-Path $full)) { return @() }
    $full = (Resolve-Path $full).Path
    Get-ChildItem -LiteralPath $full -Recurse -File | ForEach-Object {
        $_.FullName.Substring($full.Length).TrimStart('\') -replace '\\', '/'
    }
}

# Tracked pairs: subject-relative path <-> kit-relative path
$pairs = [System.Collections.Generic.List[object]]::new()
function Add-Pair($s, $k) { $pairs.Add([pscustomobject]@{ Subject = $s; Kit = $k }) }
function Add-Dir($sDir, $kDir) {
    $files = @(Get-RelFiles $Subject $sDir) + @(Get-RelFiles $Kit $kDir) | Sort-Object -Unique
    foreach ($f in $files) { Add-Pair "$sDir/$f" "$kDir/$f" }
}

foreach ($f in 'VERSION', 'CLAUDE.md', 'GUIDE.md', 'kit-sync.ps1') { Add-Pair $f $f }
Get-ChildItem (Join-Path $Kit '.claude\skills') -Directory | ForEach-Object {
    Add-Dir ".claude/skills/$($_.Name)" ".claude/skills/$($_.Name)"
}
Get-ChildItem (Join-Path $Kit '.claude\agents') -File | ForEach-Object {
    Add-Pair ".claude/agents/$($_.Name)" ".claude/agents/$($_.Name)"
}
# Pack items are tracked only if installed in this subject
$packsDir = Join-Path $Kit 'packs'
if (Test-Path $packsDir) {
    foreach ($pack in Get-ChildItem $packsDir -Directory) {
        $packSkills = Join-Path $pack.FullName 'skills'
        if (Test-Path $packSkills) {
            foreach ($sk in Get-ChildItem $packSkills -Directory) {
                if (Test-Path (Join-Path $Subject ".claude\skills\$($sk.Name)")) {
                    Add-Dir ".claude/skills/$($sk.Name)" "packs/$($pack.Name)/skills/$($sk.Name)"
                }
            }
        }
        $packAgents = Join-Path $pack.FullName 'agents'
        if (Test-Path $packAgents) {
            foreach ($ag in Get-ChildItem $packAgents -File) {
                if (Test-Path (Join-Path $Subject ".claude\agents\$($ag.Name)")) {
                    Add-Pair ".claude/agents/$($ag.Name)" "packs/$($pack.Name)/agents/$($ag.Name)"
                }
            }
        }
    }
}

# Classify each pair against the last-synced hash
$rows = foreach ($p in $pairs) {
    $sp = Join-Path $Subject $p.Subject
    $kp = Join-Path $Kit $p.Kit
    $s = Get-Hash $sp
    $k = Get-Hash $kp
    $b = $state[$p.Subject]
    $status =
        if ($s -eq $k) { 'same' }
        elseif (-not $b) { if (-not $s) { 'kit-only' } elseif (-not $k) { 'subject-only' } else { 'conflict' } }
        elseif (-not $s -or -not $k) { 'deleted' }
        elseif ($s -ne $b -and $k -eq $b) { 'subject-changed' }
        elseif ($k -ne $b -and $s -eq $b) { 'kit-changed' }
        else { 'conflict' }
    [pscustomobject]@{ Status = $status; Subject = $p.Subject; Kit = $p.Kit; SPath = $sp; KPath = $kp; Hash = $s }
}

$changed = @($rows | Where-Object Status -ne 'same')
function Get-Version($root) { $v = Join-Path $root 'VERSION'; if (Test-Path $v) { (Get-Content $v -Raw).Trim() } else { '?' } }
Write-Host "Subject: $Subject (kit version $(Get-Version $Subject))"
Write-Host "Kit:     $Kit (version $(Get-Version $Kit))"
if ($changed.Count -eq 0) { Write-Host 'In sync: all kit-owned files are identical.' }
else { $changed | Sort-Object Status, Subject | Format-Table Status, Subject, Kit -AutoSize | Out-String -Width 220 | Write-Host }

if ($Action -eq 'status') { exit 0 }

$copyStatuses = @{ push = @('subject-changed', 'subject-only'); pull = @('kit-changed', 'kit-only') }
$todo = @($rows | Where-Object { $copyStatuses[$Action] -contains $_.Status })
$conflicts = @($rows | Where-Object { $_.Status -in 'conflict', 'deleted' })

if (-not $Apply) {
    Write-Host "Dry run: $($todo.Count) file(s) would be copied ($Action). Re-run with -Apply to copy."
    if ($conflicts.Count) { Write-Host "$($conflicts.Count) conflict(s) need a manual merge first." }
    exit 0
}

foreach ($r in $todo) {
    if ($Action -eq 'push') { $from = $r.SPath; $to = $r.KPath } else { $from = $r.KPath; $to = $r.SPath }
    New-Item -ItemType Directory -Force (Split-Path $to -Parent) | Out-Null
    Copy-Item -LiteralPath $from -Destination $to -Force
    $state[$r.Subject] = Get-Hash $from
    Write-Host "copied ($Action): $($r.Subject)"
}
foreach ($r in @($rows | Where-Object Status -eq 'same')) { $state[$r.Subject] = $r.Hash }

New-Item -ItemType Directory -Force (Split-Path $StateFile -Parent) | Out-Null
$ordered = [ordered]@{}
foreach ($key in ($state.Keys | Sort-Object)) { $ordered[$key] = $state[$key] }
$ordered | ConvertTo-Json | Set-Content -Encoding utf8 $StateFile

Write-Host "Done: $($todo.Count) file(s) copied."
if ($conflicts.Count) { Write-Host "$($conflicts.Count) conflict(s) not touched - merge them manually, then run again." }
