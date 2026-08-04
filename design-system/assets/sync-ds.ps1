<#
  sync-ds.ps1 -- keep the storybook's design-system mirror (../ds) byte-identical
  to the LIVE site design system (insightis-site/design-system), and flag when the
  site's app-level block CSS (src/app.css) has changed.

  WHY THIS EXISTS
  ---------------
  Every storybook page renders through ../ds (via the assets/*.css shims), so the
  storybook only shows the *real* site styles as long as ../ds is an exact copy of
  the site's design-system folder. A few recurring marketing blocks (the .showcase /
  .sc-* screens+side-tabs, .section-label) are styled at the SITE app level in
  src/app.css, mirrored by hand into assets/app-blocks.css. This script:
    (a) tells you whether ../ds has DIVERGED from the site DS and pulls the changes;
    (b) fingerprints src/app.css and warns when it changes so you can re-verify
        assets/app-blocks.css against it.

  USAGE
  -----
    # Report divergence only (no changes). Exit 1 if the DS mirror or app.css drifted.
    powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1 -Check

    # Pull the site DS into ../ds (refresh the mirror).
    powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1

    # After you re-verify assets/app-blocks.css against a changed app.css, record the
    # new app.css baseline so -Check stops warning:
    powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1 -AcceptAppCss

    # Non-default site checkout location:
    powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1 -Check -SiteDs 'D:\path\to\insightis-site\design-system'

  NOTE: pure ASCII on purpose (Windows PowerShell 5.1 reads a BOM-less .ps1 as the
  system ANSI codepage; a stray non-ASCII byte can be mis-parsed). Keep it ASCII-only.
#>
[CmdletBinding()]
param(
  [switch]$Check,
  [switch]$AcceptAppCss,
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

# --- app.css provenance for assets/app-blocks.css -----------------------------
# app-blocks.css is a hand-curated mirror of a few section rules in the site's
# src/app.css. We can't auto-diff a curated subset, so we fingerprint the whole
# app.css: if it changed since app-blocks.css was last verified, warn.
$appCss     = (Join-Path $SiteDs '..\src\app.css')
$appHashRef = (Join-Path $assets '.app-css.sha256')
$appNow = $null
if (Test-Path $appCss) { $appNow = (Get-FileHash -Algorithm SHA256 -LiteralPath $appCss).Hash }

if ($AcceptAppCss) {
  if (-not $appNow) { Write-Host "ERROR: app.css not found at $appCss" -ForegroundColor Red; exit 2 }
  Set-Content -LiteralPath $appHashRef -Value $appNow -NoNewline
  Write-Host "Recorded app.css baseline ($($appNow.Substring(0,12))...)." -ForegroundColor Green
  Write-Host "assets/app-blocks.css is now marked in sync with src/app.css."
  exit 0
}

$appBaseline = $null
if (Test-Path $appHashRef) { $appBaseline = (Get-Content -LiteralPath $appHashRef -Raw).Trim() }
$appDiverged = $false
if ($appNow -and ($appBaseline -ne $appNow)) { $appDiverged = $true }

# --- DS mirror diff -----------------------------------------------------------
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

$dsDiverged = ($onlySite.Count + $onlyMir.Count + $changed.Count) -gt 0

Write-Host "Site DS : $SiteDs"
Write-Host "Mirror  : $mirror"
Write-Host "app.css : $appCss"
Write-Host ""

if (-not $dsDiverged -and -not $appDiverged) {
  Write-Host "IN SYNC -- the storybook mirror matches the live site design system," -ForegroundColor Green
  Write-Host "          and src/app.css is unchanged since app-blocks.css was verified." -ForegroundColor Green
  exit 0
}

if ($dsDiverged) {
  Write-Host "DS MIRROR DIVERGED -- ../ds is out of date:" -ForegroundColor Yellow
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
}

if ($appDiverged) {
  Write-Host ""
  Write-Host "APP.CSS CHANGED -- src/app.css differs from the baseline that" -ForegroundColor Yellow
  Write-Host "assets/app-blocks.css was mirrored from." -ForegroundColor Yellow
  Write-Host "  Re-check the .showcase / .sc-* / .section-label rules in"
  Write-Host "  assets/app-blocks.css against src/app.css, update if needed, then run:"
  Write-Host "    assets/sync-ds.ps1 -AcceptAppCss"
}
if (-not $appNow) {
  Write-Host ""
  Write-Host "NOTE: could not read src/app.css at $appCss to check app-block provenance." -ForegroundColor DarkYellow
}

if ($Check) {
  Write-Host ""
  if ($dsDiverged) { Write-Host "Run without -Check to pull the DS changes into ../ds." -ForegroundColor Cyan }
  exit 1
}

# --- Pull: refresh the DS mirror (robocopy /MIR removes stale files too) -------
if ($dsDiverged) {
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
}

# app.css is a curated subset -- never auto-pulled; leave a non-zero exit so the
# app-blocks re-verify does not get silently skipped.
if ($appDiverged) { exit 1 }
exit 0
