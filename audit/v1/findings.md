# Insightis — Global Audit v1 · Findings

> **Source of truth** for v1. The deliverables in [`deliverables/`](deliverables/) are generated
> from this file — never the other way round.
>
> Framework (taxonomy/severity/schema): [`../../review-framework.md`](../../review-framework.md).
> Decision machinery: [`../../review-iteration-protocol.md`](../../review-iteration-protocol.md).

- **Object:** insightis-landing.vercel.app · **Theme:** dark (bg `#0A0E13`)
- **Method:** live DOM/CSS inspection + source review (`insightis-site/`) + attention heatmaps + heuristic (Nielsen) pass
- **Pages in scope:** Home, Pricing, AI Chat, Integrations, Semantic Layer
- **Date:** 2026-08-04
- **Verify:** every finding carries a live-site link so the reader can check it in place.

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
| Accepted       | 2 | 4 | 9 | 8 | 23 |
| Declined       | 0 | 0 | 0 | 0 | 0 |
| Deferred       | 0 | 0 | 0 | 0 | 0 |
| **Total**      | 2 | 4 | 9 | 8 | 23 |

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

### AUD-13 — Home labels the same 200+ stat as both "Integrations" and "Connectors" (Accepted)

| | |
|---|---|
| Domain | Design | Severity | 🟡 Medium | Section | Home — trust/stats | Category | Content |
| Page(s) | Home | Verify | https://insightis-landing.vercel.app/ |

**Current** — On Home the same 200+ figure is captioned both "200+ Integrations" and "200+ Connectors".
**Expected** — One noun for the concept, used consistently.
**Status history** | 2026-08-04 | Accepted | Filed in v1 (live-site pass). |

---

### AUD-14 — Four different terms for the "pre-built metrics" concept (Accepted)

| | |
|---|---|
| Domain | Design | Severity | 🟡 Medium | Section | Global — content | Category | Content |
| Page(s) | Home, Semantic Layer, Pricing | Verify | https://insightis-landing.vercel.app/pricing |

**Current** — "Pre-built metrics" (Home) · "built-in metrics" (Semantic Layer) · "Predefined Metrics" (Pricing) · "Metric definitions" (Pricing).
**Expected** — One canonical term + a short glossary.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-15 — Accuracy stat uses two notations: "X3" vs "3×" (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Global — content | Category | Content |
| Page(s) | Home, Semantic Layer | Verify | https://insightis-landing.vercel.app/ |

**Current** — Home "X3 accuracy" vs Semantic Layer "3× more accurate on real data".
**Expected** — One notation everywhere (recommend "3×").
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-16 — Numbers glued to the following word (missing space) (Accepted)

| | |
|---|---|
| Domain | Code | Severity | ⚪ Low | Section | Global — typography | Category | Typography |
| Page(s) | Integrations, Semantic Layer | Verify | https://insightis-landing.vercel.app/platform/integrations |

**Current** — "12×faster time to insight", "90%fewer data requests" (Integrations); "3×more accurate" (Semantic Layer).
**Expected** — Space (or thin space) between value and word.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-17 — Home H1 jams two sentences with no separator (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | 🟡 Medium | Section | Home — Hero | Category | Content |
| Page(s) | Home | Verify | https://insightis-landing.vercel.app/ |

**Current** — H1 reads "Talk to your data It already knows the answer" (two sentences, no punctuation/break).
**Expected** — "Talk to your data. It already knows the answer." (or a line break).
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-18 — Inconsistent terminal punctuation across page H1s (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Global — headings | Category | Typography |
| Page(s) | AI Chat, Integrations, Semantic Layer | Verify | https://insightis-landing.vercel.app/platform/ai-chat |

**Current** — AI Chat "Ask anything. Get answers in seconds." (periods) vs Integrations "Connect it all. Get the why behind numbers" (none) vs Semantic Layer "The same numbers. Every team. Any report" (none).
**Expected** — One heading-punctuation rule across pages.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-19 — Secondary CTA label drifts for the same destination (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Global — CTA | Category | Navigation |
| Page(s) | Home, Integrations, Semantic Layer, AI Chat | Verify | https://insightis-landing.vercel.app/platform/ai-chat |

**Current** — "Explore Pricing" (Home, Integrations, Semantic Layer) vs "Pricing" (AI Chat) — both link to `/pricing`.
**Expected** — One label for the pricing CTA.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-20 — Discounted price relies on visual strikethrough only (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟡 Medium | Section | Pricing — plan cards | Category | Accessibility |
| Page(s) | Pricing | Verify | https://insightis-landing.vercel.app/pricing |

**Current** — Rendered price text reads "$7.99$15.99" — the new and struck-through old price with no accessible relationship; a screen reader reads two bare numbers.
**Expected** — Old price in `<s>` + sr-only "was", new price + sr-only "now" (WCAG 1.3.1).
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-21 — Integrations: "200+ connectors" alongside "+180 more connectors available" (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | 🟠 High | Section | Integrations — hero/stats | Category | Content |
| Page(s) | Integrations | Verify | https://insightis-landing.vercel.app/platform/integrations |

**Current** — "200+ read-only connectors go live instantly" together with "+ 180 more connectors available" — contradictory math against the 200+ headline.
**Expected** — Reconcile the numbers (e.g. "20 live, 180 coming") or drop the second figure.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-22 — Data-connection terminology sprawl (Accepted)

| | |
|---|---|
| Domain | Design | Severity | 🟡 Medium | Section | Global — content | Category | Content |
| Page(s) | All | Verify | https://insightis-landing.vercel.app/platform/integrations |

**Current** — "Integrations", "Connectors", "sources", and "data source" used interchangeably; the Pricing FAQ even asks 'What does "data source" mean?' (Nielsen #4 consistency).
**Expected** — Canonical nouns applied site-wide.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-23 — Capitalization drift within the Home stats (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Home — trust/stats | Category | Typography |
| Page(s) | Home | Verify | https://insightis-landing.vercel.app/ |

**Current** — "28 years of data tooling" vs "28 Years of data tooling"; "40,000+ companies" vs "40,000+ Companies".
**Expected** — One casing rule for stat labels.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

## Prioritized action plan

| Priority | Action | Findings |
|---|---|---|
| **P0** | Remove the 50% vs 20% discount contradiction | AUD-01 |
| **P0** | Align pricing tiers — FAQ names non-existent Team/Enterprise | AUD-02 |
| **P0** | Fix broken link `/integrations` → `/platform/integrations` | AUD-03 |
| **P1** | Custom 404 + remove dead Memory & Storage mappings | AUD-04 |
| **P1** | Reconcile metric + connector numbers across pages | AUD-05, AUD-21 |
| **P1** | Menu ARIA + accessible price semantics | AUD-06, AUD-20 |
| **P2** | Unify terminology (integrations/connectors/metrics) | AUD-13, AUD-14, AUD-22 |
| **P2** | Tap targets ≥44px; caption contrast; 15–16px body | AUD-07, AUD-08, AUD-09 |
| **P3** | CTA repetition; copy/typography; casing; notation | AUD-10, AUD-11, AUD-15, AUD-16, AUD-17, AUD-18, AUD-19, AUD-23 |
| **P3** | Extract inline CSS | AUD-12 |

---

## End-of-pass report (protocol §5)

1. **Critical blockers** — AUD-01 (discount contradiction), AUD-02 (phantom tiers). Both misinform on the paid page.
2. **Quick wins** — AUD-03 (one-line link fix), AUD-11 / AUD-16 / AUD-17 (copy spacing), AUD-15 / AUD-19 (one-token consistency edits).
3. **Newly introduced** — All 23 (this is v1, the baseline); AUD-13…23 came from the live-site + heuristic pass.
4. **Resolved (proposed)** — None (baseline).
5. **Regressions** — None (baseline).
6. **Impacted accepted decisions** — None (baseline).
7. **Systemic UX risks** — Consistency is the dominant theme (Nielsen #4): numbers (AUD-05, 21), terminology (AUD-13, 14, 22), notation/casing/punctuation (AUD-15, 16, 18, 23) and CTA labels (AUD-19) all drift across pages. A single source-of-truth for stats + a copy glossary would close most of them.
8. **DS maturity gaps** — Per-page inline `<style>` (AUD-12) and 14px default body (AUD-09) show the type scale isn't fully token-driven; the DS should publish a body-text size rule and a canonical-terms glossary.
9. **Scalability concerns** — Repeated CTA blocks (AUD-10) and copy drift worsen with each new page; a single CTA component + centralized stats/copy scale better than per-page literals.
10. **Recommended next priorities** — AUD-01, AUD-02, AUD-03 (P0), then AUD-04, AUD-05+21, AUD-06+20 (P1).
