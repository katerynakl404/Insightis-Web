# Changelog

All notable changes to the Insightis Design System.

## v1.1.0 — 2026-08-04

Re-synced the storybook to the **live site** design system
(`insightis-site/design-system/`) and made that link permanent.

### Single source of truth (no more divergence)
- Added `ds/` — an **exact, byte-for-byte mirror** of the live site's
  `design-system/` (tokens, `global.css`, all component CSS, `index.css`).
- `assets/tokens.css`, `assets/base.css`, `assets/components.css` are now **one-line
  `@import` shims** into that mirror. The old hand-maintained flat copies (which had
  drifted from the site) are gone — every page now renders the real site styles.
- Only storybook override left is the asset-path block in `assets/storybook.css`
  (re-points the site's absolute `/fonts`, `/img/noise.svg`, `/connectors/sprite.svg`
  at local copies). Added `assets/connectors/sprite.svg` for connector logos.
- Added `assets/sync-ds.ps1` + `SYNC.md`: check divergence (`-Check`) and pull the
  site's changes into the mirror. **Run before every publish.**

### Components (32 → 47 documented)
New pages for components that shipped on the site after v1.0.0:
- **Data display**: Icon badge, Code chip, Metrics catalog, Solutions accordion,
  Comparison cards, Testimonial card
- **Feedback**: Cookie notice
- **Navigation**: Back to top
- **Marketing**: Bottom CTA, FAQ accordion, Pain-point grid, Steps / process,
  Connector gallery (+ connector sprite)
- **Content**: Eyebrow · **Layout**: Capsule

### Storybook chrome
- Fixed the mobile nav: the hamburger now actually opens the sidebar as an overlay
  drawer below 1024px (previously it toggled an attribute with no matching CSS).

## v1.0.0 — 2026-04-19

Initial handoff release.

### Foundations (16 pages)
- Colors (primitives + semantic + WCAG AA matrix)
- Typography (Geist + Geist Mono, 13 role classes)
- Spacing (4px grid + 2px half-step)
- Radius (8-step scale)
- Elevation (4 shadow levels, no glow)
- Opacity primitives (04/08/12/24/48/72/92)
- Borders (4 widths + 7 semantic colors)
- Blur (4/8/16/24 backdrop-filter)
- Breakpoints (480/768/1024/1280, mobile-first)
- Grid (responsive 4/8/12/24 columns)
- Layout blocks (hero, feature grid, stats strip, promo, newsletter, etc.)
- Motion (decorative vs state-communicating rule)
- Atmosphere (soft-heading, noise, aurora — scoped utilities)
- Performance & SEO (CWV targets + mitigations)
- Icons (size scale + inline SVG pattern)
- Logo (mark + wordmark + clear-space)

### Components (32)
- **Inputs**: Button, Input, Textarea, Select, Checkbox/Radio/Toggle, Segmented control, Form group
- **Data display**: Card (10 variants), Stat/KPI, Divider, Table, Tabs (horizontal + vertical), Accordion, Comparison grid
- **Feedback**: Modal (sm/md/lg + drawer), Alert/Toast, Banner (top/promo/newsletter), Badge, Avatar, Tooltip, Loader, Empty state
- **Navigation**: Navbar, Sidebar (non-collapsable docs-style), Footer, Pagination, Breadcrumbs, Scroll-spy TOC
- **Marketing**: Chat bubble, Marquee
- **Content**: Code (inline + fenced), Kbd

### Token system
- Two-tier: primitives → semantics
- No raw hex/rgba in semantic or component CSS
- 10 explicit alpha-blended color primitives (white-a-06/12/45, teal-a-08/12/20/25/50, red-a-30, overlay)
- 3 derived teal state primitives (650/850/950) for button hover/active/disabled
- Legacy aliases preserved for backward compatibility — see [DEPRECATED.md](DEPRECATED.md)

### Infrastructure
- Single-file static kit; no build step required
- PowerShell dev server at `.claude/serve.ps1` (Windows) for local preview
- Storybook-style docs site with live previews, state toggles, copy-to-clipboard, scroll-spy, contrast widget
- Font assets: Geist-Variable.ttf + GeistMono-Variable.ttf (variable-axis, local)

### Accessibility
- WCAG AA contrast matrix live-computed per text/surface pair
- Global `:focus-visible` ring (3px teal-50%)
- Skip-to-content utility
- Touch targets ≥44×44 below 768px
- `prefers-reduced-motion` respected globally

### Known changes from source HTML pages
See [UX_IMPROVEMENTS.md](UX_IMPROVEMENTS.md) for the complete list. Biggest shifts:
- Heading font: Clash Display → Geist
- Mono font: Space Mono → Geist Mono
- Primary button: gradient + glow → flat teal-600
- Breakpoints: ad-hoc 600/900 → standard 480/768/1024/1280
- Mobile animations: full → decorative off, state-communicating always on
