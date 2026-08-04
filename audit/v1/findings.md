# Insightis — Global Audit v1 · Findings

> **Source of truth** for v1. The deliverables in [`deliverables/`](deliverables/) are generated
> from this file — never the other way round.
>
> Framework (taxonomy/severity/schema): [`../../review-framework.md`](../../review-framework.md).
> Decision machinery: [`../../review-iteration-protocol.md`](../../review-iteration-protocol.md).

- **Object:** insightis-landing.vercel.app · **Theme:** dark (bg `#0A0E13`)
- **Method:** live DOM/CSS inspection + source review (`insightis-site/`) + heuristics
- **Pages in scope:** Home, Pricing, AI Chat, Integrations, Semantic Layer
- **Date:** 2026-08-04

Severity: 🔴 Critical · 🟠 High · 🟡 Medium · ⚪ Low

> **On contrast.** The site is dark. Contrast was re-measured compositing the semi-transparent
> backgrounds over the real page background — **body text passes WCAG AA everywhere** (Home 0 /
> Pricing 0 violations). Thresholds: text (SC 1.4.3) 4.5:1 / large 3:1; UI + meaningful graphics
> (SC 1.4.11) 3:1; purely decorative — no requirement.

---

## Status summary (live)

|                | 🔴 Critical | 🟠 High | 🟡 Medium | ⚪ Low | Total |
|---|---|---|---|---|---|
| Pending Review | 0 | 0 | 0 | 0 | 0 |
| Accepted       | 2 | 3 | 4 | 3 | 12 |
| Declined       | 0 | 0 | 0 | 0 | 0 |
| Deferred       | 0 | 0 | 0 | 0 | 0 |
| **Total**      | 2 | 3 | 4 | 3 | 12 |

---

## Findings

### AUD-01 — Contradictory discount: cards say 50% OFF, FAQ says save 20% (Accepted)

| | |
|---|---|
| Domain | Code + Design |
| Severity | 🔴 Critical |
| Section | Pricing plans / FAQ |
| Category | Content |
| Page(s) | Pricing |
| File | Pricing page markup + FAQ block |

**Current** — Plan cards advertise `50% OFF` ($7.99 vs $15.99), while the FAQ states users "save 20% per seat." 50% ≠ 20%.

**Expected** — A single discount figure across the page. The card math and the FAQ copy must agree (SC-level trust / content accuracy).

**Visual (before → after)**
- Current: card badge "50% OFF" next to FAQ text "save 20% per seat".
- Recommended: one agreed number in both places (e.g. both read 50%).

**Notes** — Pricing contradictions are the single fastest trust-killer on a paid product; a visitor doing the math sees a mistake in the first screen.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1 (migrated from initial audit). |

---

### AUD-02 — FAQ references pricing tiers that don't exist (Accepted)

| | |
|---|---|
| Domain | Code + Design |
| Severity | 🔴 Critical |
| Section | Pricing plans / FAQ |
| Category | Content |
| Page(s) | Pricing |
| File | FAQ block |

**Current** — Pricing shows only Free / Starter / Pro, but the FAQ describes **Team** and **Enterprise** ("14-day free trial", "available on Team and Enterprise").

**Expected** — FAQ copy names only tiers that exist on the page. Either add the tiers or remove the references.

**Visual (before → after)**
- Current: FAQ mentions Team/Enterprise; plan grid has no such cards.
- Recommended: FAQ references only Free / Starter / Pro.

**Notes** — Phantom tiers read as a stale copy-paste from another product and undermine the whole pricing table.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-03 — Broken internal link in static fallback (Accepted)

| | |
|---|---|
| Domain | Code |
| Severity | 🟠 High |
| Section | AI Chat — inline CTA |
| Category | Navigation |
| Page(s) | AI Chat |
| File | `platform/ai-chat.html:193` |

**Current** — `platform/ai-chat.html:193` has `<a href="/integrations">` → **404** (correct path is `/platform/integrations`). The adjacent "Start for free" label links to `/pricing` instead of `/auth/sign-up/`. The only genuinely broken internal link found.

**Expected** — `/integrations` → `/platform/integrations`; "Start for free" → `/auth/sign-up/`. No 404 from any internal link.

**Visual (before → after)**
- Current: "See all integrations" → 404 page.
- Recommended: link resolves to the Integrations page.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-04 — No custom 404 page + dead route mappings (Accepted)

| | |
|---|---|
| Domain | Code |
| Severity | 🟠 High |
| Section | Global — routing |
| Category | Navigation |
| Page(s) | All |
| File | `public/404.html` (missing); `src/components/Header.jsx:66`, `src/components/Footer.jsx:21` |

**Current** — Non-existent URLs render the raw Vercel `404: NOT_FOUND` page (no header, nav, or branding). `Memory & Storage → /platform/memory-storage` is mapped in `Header.jsx:66` and `Footer.jsx:21`, but the page does not exist.

**Expected** — A branded 404 in the site's style, and no route mappings to non-existent pages.

**Visual (before → after)**
- Current: raw Vercel 404, no branding.
- Recommended: dark, branded 404 with logo + nav (already prepared in `insightis-site/public/404.html`).

**Notes** — Branded 404 already drafted; see `deliverables/dev-handoff.md`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-05 — Numbers disagree across pages (Accepted)

| | |
|---|---|
| Domain | Code + Design |
| Severity | 🟠 High |
| Section | Global — content |
| Category | Content |
| Page(s) | Home, Integrations, Semantic Layer |
| File | Page copy (multiple) |

**Current** — Home says "500+ pre-built definitions" while Semantic Layer says "498 built-in metrics"; Home says "200+ connectors" while Integrations says "20 sources."

**Expected** — One source of truth per metric, used consistently across pages.

**Visual (before → after)**
- Current: 500+ vs 498; 200+ vs 20 across pages.
- Recommended: identical figures everywhere they appear.

**Notes** — 200+ vs 20 is a 10× gap — not rounding; it reads as one of the two being wrong.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-06 — Menu buttons lack ARIA state (Accepted)

| | |
|---|---|
| Domain | Code |
| Severity | 🟡 Medium |
| Section | Header / Nav |
| Category | Accessibility |
| Page(s) | All |
| File | `src/components/Header.jsx` |

**Current** — `Platform` / `Solutions` / `Resources` menu buttons have no `aria-expanded` or `aria-haspopup` (WCAG 4.1.2).

**Expected** — Add `aria-haspopup="menu"`, toggle `aria-expanded`, and verify keyboard access + Esc to close.

**Visual (before → after)** — Not applicable (non-visual Code fix).

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-07 — Sub-44px tap targets on tabs and submenus (Accepted)

| | |
|---|---|
| Domain | Code |
| Severity | 🟡 Medium |
| Section | Home — "Made for every team"; Platform submenu |
| Category | Accessibility |
| Page(s) | Home, all (submenu) |
| File | Tab / submenu components |

**Current** — Team tabs and the Platform submenu are ≈18–19px tall (< 24px WCAG 2.5.8; far below 44px).

**Expected** — Increase the clickable padding to ≥44px on mobile (SC 2.5.8 / 2.5.5).

**Visual (before → after)**
- Current: cramped 18–19px targets.
- Recommended: ≥44px touch targets with padding.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-08 — Low-contrast functional captions in demo widgets (Accepted)

| | |
|---|---|
| Domain | Code + Design |
| Severity | 🟡 Medium |
| Section | Demo widgets |
| Category | Color |
| Page(s) | AI Chat, Integrations, Semantic Layer, Home |
| File | Demo widget markup/styles |

**Current** — 11 small captions measure 2.5–3.8:1. Those that are part of a graphic pass the 3:1 bar; a few **functional** labels (the `Thinking` state ≈2.8, the "before" side of comparisons ≈2.5) fall short of 4.5:1 — though "before" is dimmed on purpose.

**Expected** — Functional labels ≥4.5:1 and ≥12px. For the "bad"/"before" side, add a non-color cue (SC 1.4.1) so meaning isn't carried by color alone.

**Visual (before → after)**
- Current: dim "before" label, low-contrast "Thinking" state.
- Recommended: functional labels at AA + a non-color marker on the "before" side.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-09 — Body paragraphs default to 14px (Accepted)

| | |
|---|---|
| Domain | Code + Design |
| Severity | 🟡 Medium |
| Section | Global — typography |
| Category | Typography |
| Page(s) | All |
| File | Type styles |

**Current** — 14px dominates description paragraphs; 16px is rare. Small 11–13px (labels/badges/nav/eyebrow) is fine.

**Expected** — Raise **only real description paragraphs** to 15–16px (the "how it works" steps, Solutions descriptions, the Devart trust line, plan features on Pricing). Leave labels/badges alone.

**Visual (before → after)**
- Current: 14px description paragraphs.
- Recommended: 15–16px for body descriptions.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-10 — Repeated CTA blocks (Accepted)

| | |
|---|---|
| Domain | Design |
| Severity | ⚪ Low |
| Section | Final CTA (multiple) |
| Category | Content |
| Page(s) | Home, AI Chat |
| File | Page copy |

**Current** — "Get answers… not days" is duplicated; the `Start for free / Explore Pricing` pair repeats in nearly every section.

**Expected** — Vary the CTA pattern; avoid repeating the same headline + button pair per section.

**Visual (before → after)**
- Current: identical CTA pair repeated down the page.
- Recommended: one primary CTA per intent, varied supporting copy.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-11 — Minor copywriting defects (Accepted)

| | |
|---|---|
| Domain | Code |
| Severity | ⚪ Low |
| Section | Headings |
| Category | Content |
| Page(s) | Home, Semantic Layer |
| File | Heading markup |

**Current** — Words glued together in H1 by line breaks ("Get answers in / seconds"); a double space in "Stop arguing about  which number."

**Expected** — Clean copy: no glued words from `<br>`, no double spaces.

**Visual (before → after)**
- Current: "Get answers inseconds"; "about  which".
- Recommended: correct spacing.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

### AUD-12 — Inline `<style>` blocks inside `<main>` (Accepted)

| | |
|---|---|
| Domain | Code |
| Severity | ⚪ Low |
| Section | Global — code hygiene |
| Category | Tokens |
| Page(s) | All |
| File | Page templates |

**Current** — Every page carries inline CSS with media queries inside `<main>` — a sign of hand-patched styling.

**Expected** — Move these into stylesheets / design-system tokens rather than per-page inline blocks.

**Visual (before → after)** — Not applicable (non-visual Code fix).

**Notes** — Site styling is intentionally not being redesigned in v1 (per decision); this is hygiene only, no visual change.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-08-04 | Accepted | Filed and accepted in v1. |

---

## Prioritized action plan

| Priority | Action | Findings |
|---|---|---|
| **P0** | Remove the 50% vs 20% discount contradiction | AUD-01 |
| **P0** | Align pricing tiers — FAQ names non-existent Team/Enterprise | AUD-02 |
| **P0** | Fix broken link `/integrations` → `/platform/integrations` | AUD-03 |
| **P1** | Custom 404 + remove dead Memory & Storage mappings | AUD-04 |
| **P1** | Sync numbers across pages | AUD-05 |
| **P1** | ARIA states for menus (haspopup / expanded) | AUD-06 |
| **P2** | Tap targets ≥44px; small-caption contrast; 15–16px body | AUD-07, AUD-08, AUD-09 |
| **P3** | Remove CTA repetition; clean copy; extract inline CSS | AUD-10, AUD-11, AUD-12 |

---

## End-of-pass report (protocol §5)

1. **Critical blockers** — AUD-01 (discount contradiction), AUD-02 (phantom tiers). Both misinform on the paid page.
2. **Quick wins** — AUD-03 (one-line link fix), AUD-11 (copy spacing), AUD-05 (number sync once source agreed).
3. **Newly introduced** — All 12 (this is v1, the baseline).
4. **Resolved (proposed)** — None (baseline).
5. **Regressions** — None (baseline).
6. **Impacted accepted decisions** — None (baseline).
7. **Systemic UX risks** — Content drift is the dominant theme: three findings (AUD-01, AUD-02, AUD-05) are the same class of defect — figures/tiers that disagree with themselves across the site. A single source-of-truth for pricing + metrics would close all three.
8. **DS maturity gaps** — Per-page inline `<style>` (AUD-12) and 14px default body (AUD-09) suggest the type scale and spacing aren't fully driven from tokens; the DS should publish a body-text size rule pages inherit.
9. **Scalability concerns** — The repeated CTA pattern (AUD-10) will worsen as pages are added; a single CTA component with varied copy scales better than copy-pasted blocks.
10. **Recommended next priorities** — AUD-01, AUD-02, AUD-03 (P0), then AUD-04, AUD-05, AUD-06 (P1).
