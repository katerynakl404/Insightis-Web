# Keeping the storybook in sync with the real site

**Single source of truth = the live site's design system**, at
`insightis-site/design-system/` (the code that actually ships on
`insightis-landing.vercel.app`). This storybook never owns styles — it only
*documents* what the site already has. So it must never drift from it.

## How it's wired (why it can't silently drift)

- `design-system/ds/` is an **exact, byte-for-byte mirror** of the site's
  `insightis-site/design-system/` folder (tokens, `global.css`, every component
  CSS, `index.css`). It is the only copy of the DS in this repo.
- Every storybook page links `assets/tokens.css`, `assets/base.css`,
  `assets/components.css`. Those three files are **one-line `@import` shims** that
  re-export the mirror (`../ds/...`). They contain zero styles of their own.
- Result: whatever the mirror says, the pages render. There is no second,
  hand-maintained copy of the CSS to fall out of step. The **only** storybook
  override of canonical CSS is the asset-path block at the top of
  `assets/storybook.css`: the site loads a few assets from absolute paths
  (`/fonts/*`, `/img/noise.svg`, `/connectors/sprite.svg`) that resolve against the
  site's public root, not here, so those rules re-point them at local copies in
  `assets/` (`assets/fonts/`, `assets/img/`, `assets/connectors/`). Nothing else is
  overridden.

  Those binary assets are copied once and change very rarely. If the site ever
  swaps a font or regenerates the connector sprite, recopy them by hand from
  `insightis-site/public/{fonts,img,connectors}/` — the CSS sync script only keeps
  the stylesheets in step.

The one thing that CAN drift is the mirror itself, if the site's DS changes and
the mirror isn't refreshed. That's what the sync script below is for.

## App-level blocks (`assets/app-blocks.css`)

A few recurring marketing blocks — the `.showcase` / `.sc-*` **screens + side-tabs**
showcase and the `.section-label` eyebrow — are styled at the **site app level** in
`insightis-site/src/app.css`, not in the design system. They're mirrored **by hand**
into `assets/app-blocks.css` (loaded only on the pattern pages that use them, e.g.
`patterns/screens-side-tabs.html`) so the storybook matches the site exactly.

Because `app-blocks.css` is a curated subset, it can't be auto-diffed. Instead the sync
script **fingerprints the whole `src/app.css`**: if it changes, `-Check` warns you to
re-verify `app-blocks.css` against it. After you re-check (and update it if needed),
record the new baseline:

```bash
powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1 -AcceptAppCss
```

The baseline hash lives in `assets/.app-css.sha256` (committed, travels with the repo).

## Check for divergence (read-only)

Run this any time — before publishing to GitHub Pages, or on a schedule — to see
whether the site's DS has changed since the mirror was last refreshed:

```bash
powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1 -Check
```

- Prints `IN SYNC` and exits `0` when the mirror matches the site exactly.
- Prints a per-file report (`~ changed`, `+ new on site`, `- stale in mirror`) and
  exits `1` when they diverge. Nothing is modified.

## Pull the site's changes into the mirror

When `-Check` reports divergence, refresh the mirror from the site:

```bash
powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1
```

This mirrors `insightis-site/design-system/` into `design-system/ds/` exactly
(new + changed files copied, files deleted on the site removed here). Then review
and commit the mirror so GitHub Pages serves the updated styles:

```bash
git add design-system/ds && git commit -m "sync DS mirror to live site"
```

## Where the script looks for the site

By default it expects the site checked out as a sibling of this repo:

```
<root>/insightis-site/design-system/                     <- source of truth
<root>/1st itteration/homepage-handoff-2026-05-20/        <- this repo
        design-system/ds/                                <- the mirror
```

If your `insightis-site` lives elsewhere, pass its `design-system` path:

```bash
powershell -ExecutionPolicy Bypass -File assets/sync-ds.ps1 -Check -SiteDs 'C:\path\to\insightis-site\design-system'
```

## When to run it

- **Before every publish** to GitHub Pages / before sharing the storybook.
- **After any design-system change lands on the site** (new component, retuned
  token, renamed class).
- If a page ever looks wrong, run `-Check` first — a stale mirror is the most
  likely cause.

## What sync does NOT cover

The sync script keeps the **CSS** identical to the site. It does **not** author
the per-component demo HTML — those pages (`components/*.html`, `foundations/*`,
`patterns/*`) are hand-written documentation whose examples are drawn from real
site usage. If the site adds a brand-new component, add a page for it (copy an
existing page as the template) and it will automatically render with the real,
already-synced styles.
