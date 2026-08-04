# Insightis Design System — Storybook (v1.1.0)

Dark-mode design system for the Insightis marketing site. Two-tier tokens, WCAG AA, mobile-first, Geist typography.

## Source of truth = the live site

This is the **storybook** (docs site). It does not own any styles — the real design
system lives in the site repo at `insightis-site/design-system/`. Here, `ds/` is an
**exact mirror** of it, and the storybook renders through that mirror, so the
storybook always shows the real site styles. Keep them in step with the sync tool —
**see [SYNC.md](SYNC.md)** (`assets/sync-ds.ps1 -Check` before every publish).

## What you get

```
design-system/
├── index.html                # Storybook home
├── SYNC.md                    # How to check divergence + pull site changes
├── ds/                        # EXACT MIRROR of insightis-site/design-system (the real DS)
│   ├── tokens/  global.css  components/  index.css   # canonical CSS — do not hand-edit
├── assets/
│   ├── tokens.css            # SHIM -> ds/tokens/index.css   (no styles of its own)
│   ├── base.css              # SHIM -> ds/global.css
│   ├── components.css        # SHIM -> ds/components/index.css
│   ├── storybook.css         # Docs-site chrome + local asset-path overrides (NOT for production)
│   ├── storybook.js          # Interactivity + scroll-spy + contrast widget (NOT for production)
│   ├── app-blocks.css        # Mirror of app-level block styles from site src/app.css (.showcase/.sc-*)
│   ├── sync-ds.ps1           # Divergence check + pull from the live site (DS + app.css)
│   ├── fonts/                # Geist + Geist Mono (variable TTF)
│   ├── img/noise.svg         # Atmosphere utility asset
│   └── connectors/sprite.svg # Connector logo sprite (local copy)
├── foundations/              # 16 token-documentation pages
└── components/               # 47 component-documentation pages
```

## Integrating in production

```html
<!-- Required -->
<link rel="stylesheet" href="/design-system/assets/tokens.css">
<link rel="stylesheet" href="/design-system/assets/base.css">
<link rel="stylesheet" href="/design-system/assets/components.css">

<!-- Do NOT include storybook.css or storybook.js in production -->

<!-- Preload font weights you actually use -->
<link rel="preload" href="/design-system/assets/fonts/Geist-Variable.ttf"
      as="font" type="font/ttf" crossorigin>
<link rel="preload" href="/design-system/assets/fonts/GeistMono-Variable.ttf"
      as="font" type="font/ttf" crossorigin>
```

Then use component classes directly:
```html
<button class="ins-btn ins-btn--primary ins-btn--md">Get started</button>
<div class="ins-card">
  <h3 class="ins-card__title">Title</h3>
  <p class="ins-card__body">Body copy.</p>
</div>
```

## Hard rules

1. **Use semantic tokens at call sites.** `var(--ins-text-body)`, not `var(--ins-color-gray-300)`.
2. **No raw hex/rgba in components.** All alpha-blended colors are named primitives (`--ins-color-white-a-06`, `--ins-color-teal-a-20`).
3. **Mobile-first CSS.** Base styles target <480px; escalate via `@media (min-width: N)`.
4. **Animations**: `.ins-motion-decorative` is off below 768px; `.ins-motion-state` (spinners, typing dots, toasts, skeletons) always runs.
5. **WCAG AA**: normal text ≥ 4.5:1 contrast. Exception: `--ins-text-inactive` is for disabled/placeholder only (per WCAG 1.4.3).
6. **One h1 per page.** Sequential heading levels. `alt` on every `<img>`.
7. **Dark-only.** No light theme is planned or supported in v1.

## Breakpoints

| Stop | Min width | Grid columns | Gutter |
|---|---|---|---|
| mobile | 320 (floor) | 4 | 16 |
| mobile-lg | 480 | 4 | 16 |
| tablet | 768 | 8 | 20 |
| laptop | 1024 | 12 | 24 |
| desktop | 1280 | 24 | 24 |

## Naming conventions

| Context | Pattern | Example |
|---|---|---|
| Primitive token | `--ins-<family>-<scale>` | `--ins-color-teal-600`, `--ins-size-4` |
| Semantic token | `--ins-<role>-<modifier>` | `--ins-text-heading`, `--ins-surface-card` |
| Component class | `.ins-<component>` | `.ins-btn`, `.ins-card` |
| Variant | `.ins-<component>--<variant>` | `.ins-btn--primary` |
| Size | `.ins-<component>--<size>` | `.ins-btn--lg` |
| State | `.is-<state>` / `[data-state]` | `.is-loading`, `[data-state="open"]` |
| Utility | `.ins-u-<prop>-<value>` | `.ins-u-sr-only` |

## Performance budget

- LCP ≤ 2.5s on 4G
- CLS ≤ 0.1
- INP ≤ 200ms
- Initial CSS (gzipped) ≤ 60 KB
- Font payload ≤ 100 KB

See [foundations/performance.html](foundations/performance.html) for the full checklist.

## Adding a new component

Component CSS is authored **on the site** (`insightis-site/design-system/components/`),
never here. Once it ships there:

1. Sync the mirror: `assets/sync-ds.ps1` (pulls the new component CSS into `ds/`)
2. Create `components/<new-component>.html` — copy any existing component page as a template; it renders automatically through the shim → mirror
3. Add a sidebar entry in **both** `assets/storybook.js` (the `data-sb-render-sidebar` block) and `index.html` (inline nav)
4. Update [CHANGELOG.md](CHANGELOG.md)

## Adding a new primitive token

Only when a new raw value is genuinely needed by a semantic role. Primitives are never repurposed — add, don't repoint. Document why in CHANGELOG.

## Bug reports / requests

Track in your team's issue system. Reference the component file and describe expected vs. actual behavior. For design changes, include a before/after screenshot.

## Not in this release (v1.0)

- Light theme
- Data-visualization charts (tokens exist, components don't)
- Mobile-specific page-level templates
- CSS-in-JS or React bindings (component classes work with any framework)

See [UX_IMPROVEMENTS.md](UX_IMPROVEMENTS.md) for known gaps and how existing marketing pages map to this kit.
