<#
  sync-ds.ps1 -- keep the storybook's design-system mirror (../ds) byte-identical
  to the LIVE site design system (insightis-site/design-system).

  WHY THIS EXISTS
  ---------------
  Every storybook page renders through ../ds (via the assets/*.css shims), so the
  storybook only shows the *real* site styles as long as ../ds is an exact copy of
  the site's design-system folder. This script is the one tool that (a) tells you
  whether they have DIVERGED and (b) pulls the site's changes into the mirror.

  USAGE
  -----
    # Report divergence only (does NOT modify anything). Exit code 1 if diverged.
    powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1 -Check

    # Pull the site's current design system into ../ds (refresh the mirror).
    powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1

    # Point at a site checkout in a non-default location:
    powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1 -SiteDs 'D:\path\to\insightis-site\design-system'

  After a pull, review + commit:  git add design-system/ds && git commit -m "sync DS mirror"

  NOTE: this file is intentionally pure ASCII. Windows PowerShell 5.1 reads a
  BOM-less .ps1 as the system ANSI codepage, and a stray non-ASCII byte there can
  be mis-parsed as a smart-quote and break the script. Keep it ASCII-only.
#>
[CmdletBinding()]
param(
  [switch]$Check,
  [string]$SiteDs
)

$ErrorActionPreference = 'Stop'
$assets = $PSScriptRoot
$mirror = (Join-Path $assets '..\ds')

# Default site DS location = sibling insightis-site repo checked out next to this repo's parent.
# Layout: <root>\insightis-site\design-system  and  <root>\1st itteration\homepage-handoff-*\design-system\assets
if (-not $SiteDs) {
  $SiteDs = (Join-Path $assets '..\..\..\..\insightis-site\design-system')
}

if (-not (Test-Path $SiteDs)) {
  Write-Host "ERROR: could not find the live site design system at:" -ForegroundColor Red
  Write-Host "  $SiteDs"
  Write-Host ""
  Write-Host "The storybook mirror (../ds) can only be checked/refreshed against a local"
  Write-Host "checkout of insightis-site. Clone it and/or pass its design-system path:"
  Write-Host "  assets\sync-ds.ps1 -Check -SiteDs 'C:\path\to\insightis-site\design-system'"
  exit 2
}

$SiteDs = (Resolve-Path $SiteDs).Path
if (-not (Test-Path $mirror)) { New-Item -ItemType Directory -Force -Path $mirror | Out-Null }
$mirror = (Resolve-Path $mirror).Path

# Build relative-path -> hash maps for both trees.
function Get-Tree($root) {
  $map = @{}
  Get-ChildItem -Path $root -Recurse -File | ForEach-Object {
    $rel = $_.FullName.Substring($root.Length).TrimStart('\','/')
    $map[$rel] = (Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName).Hash
  }
  return $map
}

$site = Get-Tree $SiteDs
$mir  = Get-Tree $mirror

$onlySite = $site.Keys | Where-Object { -not $mir.ContainsKey($_) }  | Sort-Object   # new on site (missing from mirror)
$onlyMir  = $mir.Keys  | Where-Object { -not $site.ContainsKey($_) } | Sort-Object   # stale in mirror (removed on site)
$changed  = $site.Keys | Where-Object { $mir.ContainsKey($_) -and $mir[$_] -ne $site[$_] } | Sort-Object

$diverged = ($onlySite.Count + $onlyMir.Count + $changed.Count) -gt 0

Write-Host "Site DS : $SiteDs"
Write-Host "Mirror  : $mirror"
Write-Host ""

if (-not $diverged) {
  Write-Host "IN SYNC -- the storybook mirror matches the live site design system." -ForegroundColor Green
  exit 0
}

Write-Host "DIVERGED -- the storybook mirror is out of date:" -ForegroundColor Yellow
if ($changed.Count) {
  Write-Host ""
  Write-Host ("  Changed on site ({0}):" -f $changed.Count) -ForegroundColor Yellow
  $changed | ForEach-Object { Write-Host "    ~ $_" }
}
if ($onlySite.Count) {
  Write-Host ""
  Write-Host ("  New on site ({0}):" -f $onlySite.Count) -ForegroundColor Yellow
  $onlySite | ForEach-Object { Write-Host "    + $_" }
}
if ($onlyMir.Count) {
  Write-Host ""
  Write-Host ("  Stale in mirror ({0}):" -f $onlyMir.Count) -ForegroundColor Yellow
  $onlyMir | ForEach-Object { Write-Host "    - $_" }
}

if ($Check) {
  Write-Host ""
  Write-Host "Run without -Check to pull these changes into ../ds." -ForegroundColor Cyan
  exit 1
}

# Pull: mirror the site DS exactly (robocopy /MIR removes stale files too).
Write-Host ""
Write-Host "Pulling site design system into the mirror ..." -ForegroundColor Cyan
# robocopy exit codes 0-7 are success; 8+ are failures.
$null = & robocopy $SiteDs $mirror /MIR /NFL /NDL /NJH /NJS /NP
if ($LASTEXITCODE -ge 8) {
  Write-Host "robocopy failed (code $LASTEXITCODE)" -ForegroundColor Red
  exit $LASTEXITCODE
}

Write-Host "Done. Mirror refreshed." -ForegroundColor Green
Write-Host "Review and commit:" -ForegroundColor Cyan
Write-Host '  git add design-system/ds && git commit -m "sync DS mirror to live site"'
exit 0
