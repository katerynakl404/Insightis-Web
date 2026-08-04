# Insightis — Global Audit v1 · Findings

> **Source of truth** for v1. The deliverables in [`deliverables/`](deliverables/) are generated
> from this file — never the other way round.
>
> Framework (taxonomy/severity/schema): [`../../review-framework.md`](../../review-framework.md).
> Decision machinery: [`../../review-iteration-protocol.md`](../../review-iteration-protocol.md).

- **Object:** insightis-landing.vercel.app · **Theme:** dark (bg `#0A0E13`)
- **Method:** live DOM/CSS inspection + source review (`insightis-site/`) + attention heatmaps + heuristic (Nielsen) pass
- **Pages in scope (full site):** Home, Pricing, AI Chat, Integrations, Semantic Layer, Solutions (revenue / executive / marketing / product / analytics / finance teams), Docs, Blog, Connectors, Roadmap, Prompt Library, Contact Support
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
| Accepted       | 3 | 11 | 27 | 33 | 74 |
| Declined       | 0 | 0 | 0 | 0 | 0 |
| Deferred       | 0 | 0 | 0 | 0 | 0 |
| **Total**      | 3 | 11 | 27 | 33 | 74 |

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

**Notes** — The 404 must **reuse the site design system**, not hand-rolled styles: `<link>` the DS CSS (as the Storybook `*.html` pages do), use the reusable `.ins-section--tint` background gradient and `.ins-btn--primary`/`.ins-btn--secondary` — no copied hex. Design reference: [`deliverables/404-design.html`](deliverables/404-design.html); deploy steps in `deliverables/dev-handoff.md`.

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

### AUD-24 — Contact Support: all 30 help-topic links are dead `#` anchors (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🔴 Critical | Section | Contact Support — self-service grid | Category | Navigation |
| Page(s) | Contact Support | Verify | https://insightis-landing.vercel.app/resources/contact-support |

**Current** — All 30 links across the six topic cards ("Reset my password", "Supported data sources", "Request a new connector", "Delete my account", …) are `<a href="#">` — clicking jumps to top, goes nowhere. The self-service grid is the page's primary content and is non-functional.
**Expected** — Each item points to a real help-article/doc URL (or is removed until docs exist).
**Status history** | 2026-08-04 | Accepted | Filed in v1 (full-site pass). |

---

### AUD-25 — Contact Support: "AI Assistant" is a hardcoded mock that fabricates results (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | 🟠 High | Section | Contact Support — Ask-AI | Category | Content |
| Page(s) | Contact Support | Verify | https://insightis-landing.vercel.app/resources/contact-support |

**Current** — The "Ask a question / Ask AI" panel shows, for ANY query, "Found results for <query>", "Read 1 file", and one canned `SAMPLE_RESPONSE`. No real search happens; it fabricates activity.
**Expected** — Wire to a real knowledge base or remove the Ask-AI experience before release. Presenting fake "results / read 1 file" on production is misleading.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-26 — Contact Support: form labels not associated with inputs (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟠 High | Section | Contact Support — ticket modal | Category | Accessibility |
| Page(s) | Contact Support | Verify | https://insightis-landing.vercel.app/resources/contact-support |

**Current** — In SupportTicketModal each `<label>` ("SUBJECT *", "YOUR EMAIL", details) is a styled sibling with no `htmlFor`/`id`, and inputs have no `aria-label` → fields have no accessible name (WCAG 1.3.1 / 4.1.2).
**Expected** — Matching `id` + `htmlFor` (or wrap input in label / add `aria-label`) on each field.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-27 — Shared ConnectorCard: "Sign in to connect" is hover-only, unreachable on touch (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟠 High | Section | Global component (Connectors + all Solutions pages) | Category | Accessibility |
| Page(s) | Connectors, Solutions ×6 | Verify | https://insightis-landing.vercel.app/resources/connectors |

**Current** — `.connector-overlay { opacity:0; pointer-events:none }` revealed only on `.connector-tile:hover` (no `:focus-within`). The only per-connector action ("Sign in to connect" → /auth/sign-in/) lives inside it → touch users get no visible affordance.
**Expected** — Reveal on `:focus-within` and make tap-accessible on `@media (hover:none)`.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-28 — Contact Support: support email uses the wrong domain (.io) (Accepted)

| | |
|---|---|
| Domain | Content | Severity | 🟡 Medium | Section | Contact Support — Ask-AI answer | Category | Content |
| Page(s) | Contact Support | Verify | https://insightis-landing.vercel.app/resources/contact-support |

**Current** — Answer text says "reach us at support@insightis.io" while the site's canonical domain is **insightis.ai** (canonical / og:url = https://insightis.ai/…).
**Expected** — Correct support address on the canonical domain.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-29 — Contact Support: hardcoded "All systems operational · 2 minutes ago" (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟡 Medium | Section | Contact Support — status badge | Category | Content |
| Page(s) | Contact Support | Verify | https://insightis-landing.vercel.app/resources/contact-support |

**Current** — The header badge always reads "All systems operational" + "· Last checked: 2 minutes ago" — not tied to any status source, so it always claims operational.
**Expected** — Bind to a real status endpoint or drop the "Last checked" claim.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-30 — Contact Support: AI-assistant controls are non-functional (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟡 Medium | Section | Contact Support — Ask-AI | Category | Completeness |
| Page(s) | Contact Support | Verify | https://insightis-landing.vercel.app/resources/contact-support |

**Current** — "Copy" runs `clipboard.writeText('')` (copies nothing); "Helpful / Not helpful / Regenerate" do nothing; the three suggested resource links and the empty-state "contact support" link are `href="#"` / target a missing `#contact` anchor.
**Expected** — Implement or remove these controls; add the `#contact` target or trigger the modal directly.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-31 — Roadmap contradicts itself (Now vs Recently-shipped; timeline vs kanban; past date as present) (Accepted)

| | |
|---|---|
| Domain | Content | Severity | 🟡 Medium | Section | Roadmap | Category | Content |
| Page(s) | Roadmap | Verify | https://insightis-landing.vercel.app/resources/roadmap |

**Current** — "Now" (building) lists "Connectors" and "Semantic Layer" while "Recently shipped" (done) lists "200+ Data Connectors" and "Semantic Layer v2". The SVG timeline (V1–V4: DWH & MCP / Team Support & Dashboard / Signals / Custom Agents) doesn't reconcile with the Now/Next/Later kanban. The only date, "Q2 2026" (marked as the live/present milestone), has already passed (today 2026-08-04).
**Expected** — A feature isn't both in-progress and shipped; the two views agree; the present-marker date is current.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-32 — Blog: 2026 post title vs 2024 description/body (Accepted)

| | |
|---|---|
| Domain | Content | Severity | 🟡 Medium | Section | Blog | Category | Content |
| Page(s) | Blog | Verify | https://insightis-landing.vercel.app/blog/ |

**Current** — "78 Best Marketing Analytics Tools **for 2026**" but the card/meta description reads "…for **2024**…"; another article ("…for 2026") has body copy "But in 2024, the stack has shifted." All 4 posts also share one date, "May 20, 2026".
**Expected** — Years consistent with the post title (2026).
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-33 — "See all 200+ integrations" pill is a sub-44px tap target (Accepted)

| | |
|---|---|
| Domain | Code | Severity | ⚪ Low | Section | Solutions pages — integrations section | Category | Accessibility |
| Page(s) | Solutions ×6 | Verify | https://insightis-landing.vercel.app/solutions/analytics-teams |

**Current** — Link styled `padding:8px 20px` at `13px` → ~33px tall, below the 44px minimum (WCAG 2.5.8/2.5.5).
**Expected** — ≥44px hit area.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-34 — Prompt Library: placeholder promises "data source" filtering that doesn't exist (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Prompt Library — search | Category | Content |
| Page(s) | Prompt Library | Verify | https://insightis-landing.vercel.app/resources/prompt-library |

**Current** — Search placeholder: "Search prompts by title, team, or data source…" but only a "Teams" filter exists; no data-source facet is rendered.
**Expected** — Drop "or data source", or add a real data-source facet.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-35 — Docs: inline "Start for free" link omits the canonical trailing slash (Accepted)

| | |
|---|---|
| Domain | Code | Severity | ⚪ Low | Section | Docs — welcome | Category | Navigation |
| Page(s) | Docs | Verify | https://insightis-landing.vercel.app/docs/ |

**Current** — welcome.md links `/auth/sign-up` while the rest of the site uses canonical `/auth/sign-up/` → an extra redirect.
**Expected** — Use `/auth/sign-up/`.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-36 — Blog: thumbnail images have empty alt text (Accepted)

| | |
|---|---|
| Domain | Code | Severity | ⚪ Low | Section | Blog — listing | Category | Accessibility |
| Page(s) | Blog | Verify | https://insightis-landing.vercel.app/blog/ |

**Current** — `blog.jsx:96` renders `<img src={article.image} alt="" />` for all post thumbnails.
**Expected** — If informative, give descriptive alt (e.g. the post title); if decorative, confirm empty alt is intentional.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-37 — Tiny mockup / timeline text below legible size (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Roadmap timeline; Executive mockups | Category | Accessibility |
| Page(s) | Roadmap, Executive Teams | Verify | https://insightis-landing.vercel.app/resources/roadmap |

**Current** — Roadmap SVG milestone labels at `fontSize 10–11`; Executive mockup labels ("Board-ready", "NRR / quarter") at 9–9.5px muted on dark — legibility/contrast risk.
**Expected** — ≥12px or an accessible text alternative for meaningful labels.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-38 — Finance page: mockup micro-typography inconsistencies (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Finance Teams — hero mockup | Category | Typography |
| Page(s) | Finance Teams | Verify | https://insightis-landing.vercel.app/solutions/finance-teams |

**Current** — Interpunct spacing differs ("AP · HR · Billing" vs "AP·HR·Billing"); mixed casing "finance"/"Finance" in adjacent copy.
**Expected** — One interpunct spacing style; consistent casing per house style.
**Status history** | 2026-08-04 | Accepted | Filed in v1. |

---

### AUD-39 — Secondary button: default border too faint, blends into surface (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | 🟡 Medium | Section | Global — buttons (DS) | Category | Accessibility |
| Page(s) | All | Verify | https://insightis-landing.vercel.app/ |

**Current** — `.ins-btn--secondary` border = `--ins-button-secondary-border` = `--ins-border-default` = `rgba(255,255,255,0.06)` (6% white) on card `#131820`. Fails 3:1 UI-boundary contrast (WCAG 1.4.11); the button visually blends until hover. *Source:* `design-system/tokens/colors.css:211`, `components/button.css:84`.
**Expected** — A dedicated secondary-border token with a visible resting border ≥3:1 (e.g. `rgba(255,255,255,0.24)` or a mid-gray), intensifying on hover. See `deliverables/fix-examples.html`.
**Status history** | 2026-08-04 | Accepted | User-reported; verified in source. |

---

### AUD-40 — Footer reflows badly at tablet widths (orphaned columns) (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟡 Medium | Section | Footer | Category | Responsive |
| Page(s) | All | Verify | https://insightis-landing.vercel.app/ |

**Current** — 5 link groups but `.ins-footer__cols` is `repeat(3, 1fr)` at 768–1023px → Company/Legal orphan onto a 2nd row with an empty cell + large blank area; at ≥1024 `justify-content:flex-end` pushes columns right. *Source:* `design-system/components/footer.css:47,52,53`.
**Expected** — Columns flow evenly (`repeat(auto-fit, minmax(130px,1fr))`), left-aligned, clean mobile stack. See `deliverables/fix-examples.html`.
**Status history** | 2026-08-04 | Accepted | User-reported; verified in source. |

---

### AUD-41 — Buttons carry glow / drop-shadow (should be flat) (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | ⚪ Low | Section | Global — buttons | Category | Consistency |
| Page(s) | Home, AI Chat, integrations demos | Verify | https://insightis-landing.vercel.app/ |

**Current** — Primary CTA / "Done" button has a teal glow `box-shadow: …, 0 0 28px var(--ins-color-teal-a-50)` (`src/app.css:167`); the chat send button glows `0 0 16px rgba(7,128,126,0.35)` (`src/main.jsx:372`). Per house style, buttons should be flat (no shadow).
**Expected** — Remove button box-shadows/glows.
**Status history** | 2026-08-04 | Accepted | User-reported (no shadows on buttons). |

---

### AUD-42 — Duplicated label: small eyebrow repeats the heading verbatim (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Integrations connect-flow demo | Category | Content |
| Page(s) | Integrations / connect demo | Verify | https://insightis-landing.vercel.app/platform/integrations |

**Current** — A small eyebrow label "Data Sources" sits directly above a bold "Data Sources" heading (same words twice); the small line adds nothing. (Same redundant small-text pattern also appears in the connect "Connected!" panel.)
**Expected** — Remove the redundant small label; keep one heading.
**Status history** | 2026-08-04 | Accepted | User-reported (screenshots). |

---

### AUD-43 — Sales/Support modals bypass the DS `.ins-modal` (hardcoded, no focus trap) (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟠 High | Section | Modals (Sales, Support) | Category | Accessibility |
| Page(s) | Sales enquiry, Contact Support | Verify | https://insightis-landing.vercel.app/resources/contact-support |

**Current** — `SalesEnquiryModal` and `SupportTicketModal` don't use `.ins-modal` — they hand-roll overlay `rgba(5,8,12,0.75)` / `blur(4px)` (DS = 8) / `z-sticky` (DS = `z-modal`), dialog on `surface-container` (DS = `surface-card`), radius `18px`, `maxWidth 520px`, **no shadow**, and (per their own docblocks) **lack the focus trap + Escape handler** that `RequestConnectorModal` (the DS-conformant one) has. `RequestConnectorModal` itself inline-overrides `--sm` to `maxWidth:480px`. *Source:* `SalesEnquiryModal.jsx:137-159`, `SupportTicketModal.jsx:177-199`, `RequestConnectorModal.jsx:166-176`.
**Expected** — All modals use `.ins-modal` / `.ins-modal__dialog` (+ header/body/footer) with the DS overlay/blur/z/shadow and focus trap + Esc.
**Status history** | 2026-08-04 | Accepted | Source-audit (DS consistency pass). |

---

### AUD-44 — Chat demo widgets: DS bubble classes overridden; rich cards hand-styled (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | 🟡 Medium | Section | AI Chat / Home chat demos | Category | Consistency |
| Page(s) | AI Chat, Home | Verify | https://insightis-landing.vercel.app/platform/ai-chat |

**Current** — `.ins-chat__bubble--ai` is used but its radius/padding/maxWidth/font are inline-overridden with raw px; two chat surfaces on the same page use different paddings (`24px 32px` vs `20px 18px 16px`); action chips, MRR chart cards, and "suggested actions" cards are inline-styled divs (hardcoded rgba, `10px` radius) instead of any DS class. *Source:* `src/pages/ai-chat.jsx:736,744-751,780,1051,1116,1122-1162`.
**Expected** — Consume DS `.ins-chat`/`.ins-chat__bubble` without px overrides; promote the recurring rich cards to a DS component/tokens.
**Status history** | 2026-08-04 | Accepted | Source-audit (DS consistency pass). |

---

### AUD-45 — Heading letter-spacing (tracking) looks off; normalize site-wide (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | ⚪ Low | Section | Global — typography | Category | Typography |
| Page(s) | All (e.g. "how it works" step titles) | Verify | https://insightis-landing.vercel.app/platform/integrations |

**Current** — Step/section headings (e.g. "Connect in minutes" / "Semantic layer maps it" / "Ask in plain English") show inconsistent/too-wide tracking. Heading letter-spacing isn't applied from one DS rule.
**Expected** — Drive heading letter-spacing from DS type tokens (headings typically slightly negative, e.g. `-0.02em`); apply consistently everywhere.
**Status history** | 2026-08-04 | Accepted | User-reported (screenshot). |

---

### AUD-46 — Success Stories: content cards reimplement the DS card inline (Accepted)

| | |
|---|---|
| Domain | Code | Severity | ⚪ Low | Section | Success Stories | Category | Consistency |
| Page(s) | Success Stories | Verify | https://insightis-landing.vercel.app/ |

**Current** — Case-study grids hand-roll the `.ins-article-card` role with inline styles: radius `16px` (vs DS card `12px`), surface `--ins-color-white-a-03` (vs `--ins-surface-card`), border `--ins-color-white-a-07` (vs `--ins-border-default`), JS `onMouseEnter/Leave` hover (vs DS CSS `:hover`). *Source:* `src/pages/success-stories.jsx:52,100` (+ CTA banner :283). Every other page uses the DS card correctly.
**Expected** — Use `.ins-article-card` / `.ins-card`.
**Status history** | 2026-08-04 | Accepted | Source-audit (DS consistency pass). |

---

### AUD-47 — Eyebrows: hand-rolled / overridden to 10px Geist Mono, nullifying `.ins-eyebrow` (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | 🟡 Medium | Section | Global — eyebrows | Category | Typography |
| Page(s) | Press/Media + ~14 pages | Verify | https://insightis-landing.vercel.app/platform/semantic-layer |

**Current** — `press-media.jsx` builds 6 eyebrows with **no `.ins-eyebrow` class** (no `✦`, 10px, weight 600, Geist Mono, wrong color). Across ~14 files a nested `<span>` re-hardcodes eyebrow text to **10px + Geist Mono** (DS `.ins-eyebrow` = 11px + sans), nullifying the class: `analytics/executive/finance/marketing/product/revenue-teams` (hero + FAQ), `integrations.jsx:251`, `semantic-layer.jsx:340`, `ai-chat.jsx:1207`, `success-stories.jsx:264` (weight 600). Correct usage exists at `about-insightis.jsx`, `connectors.jsx:25` — proving the overrides are gratuitous.
**Expected** — Put text directly in `.ins-eyebrow` (11px sans + star); remove the mono/10px overrides.
**Status history** | 2026-08-04 | Accepted | Source-audit (DS consistency pass). |

---

### AUD-48 — Success Stories: a parallel stat system instead of `.ins-stat-kpi` (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | 🟡 Medium | Section | Success Stories; Pricing | Category | Typography |
| Page(s) | Success Stories, Pricing | Verify | https://insightis-landing.vercel.app/pricing |

**Current** — `AnimatedStat` / `TextStat` / result tiles (`success-stories.jsx:113,160-200,267-272`) render big numbers as **Geist Mono, weight 500, teal `--ins-text-highlight`, clamp sizes, no tabular-nums** — vs DS `.ins-stat-kpi__value` (sans, 700, `--ins-text-heading`, 36/48px, tabular). Pricing big price is a raw `40px` inline (`pricing.jsx:81`).
**Expected** — Use `.ins-stat-kpi` / `StatStrip`; drive big-number size from a token.
**Status history** | 2026-08-04 | Accepted | Source-audit (DS consistency pass). |

---

### AUD-49 — Link loses its underline on hover; needs a body-colored link class that keeps it (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | ⚪ Low | Section | Global — links | Category | Accessibility |
| Page(s) | e.g. "see full list →" | Verify | https://insightis-landing.vercel.app/platform/integrations |

**Current** — An inline link (e.g. "see full list →") is underlined by default but **drops the underline on hover** — the opposite of best practice and inconsistent with the DS inline-link (which keeps a 30%-opacity underline, `button.css:111`).
**Expected** — A reusable link class in the text color that **keeps** the underline on hover (same principle as the default inline link); underline should intensify, not vanish.
**Status history** | 2026-08-04 | Accepted | User-reported (screenshot). |

---

### AUD-50 — Primary CTA button implemented multiple ways (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | 🟠 High | Section | Global — buttons | Category | Consistency |
| Page(s) | Success Stories, Waitlist, app.css | Verify | https://insightis-landing.vercel.app/ |

**Current** — DS `.ins-btn--primary` is a solid-token pill (used by Header/CTA), but three other "primary" buttons hand-roll it with **different gradients, radii, weights**: `success-stories.jsx:290` (2-stop gradient, radius-8, 12/600), `WaitlistForm.jsx` (hardcoded-hex 180° gradient, 10px, 14/600), `app.css:160 .btn-primary` (3-stop gradient, pill, 13/500 + glow). One role, four looks.
**Expected** — `<Button variant="primary">` everywhere; if a gradient fill is wanted, make it a DS variant, not per-page.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-51 — "Before/after" comparison built four ways + two competing DS classes (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟠 High | Section | Comparison sections | Category | Consistency |
| Page(s) | Home, AI Chat, Semantic Layer, Integrations | Verify | https://insightis-landing.vercel.app/platform/semantic-layer |

**Current** — One "without/with" role, four implementations: `<ComparisonCards>`/`.ins-compare` (Home only), `.ins-comparison` (ai-chat.jsx:884 — a *second* DS grid class for the same role, different gap), and raw inline `gridTemplateColumns:'1fr 1fr'` (semantic-layer.jsx:442, integrations.jsx:558 — not responsive). `ComparisonCards` is imported but never rendered in `analytics-teams.jsx:10` / `product-teams.jsx:10`.
**Expected** — One comparison component; deprecate the duplicate DS class; remove dead imports.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-52 — Bottom CTA hand-rolled instead of `<BottomCTA>` (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | 🟡 Medium | Section | Final CTA | Category | Consistency |
| Page(s) | Success Stories, Security | Verify | https://insightis-landing.vercel.app/ |

**Current** — `success-stories.jsx:279` reimplements the final CTA inline (grayscale gradient, **no teal**, radius-16, hardcoded padding, rebuilt input group); `security.jsx:232` hand-rolls a text-variant CTA (radius 24px, padding 64/32). Both bypass the DS `.ins-bottom-cta`.
**Expected** — Use `<BottomCTA>` (+ `variant="text"`). The CTA background should **reuse the site's gradient utility `.ins-section--tint`** (the same reusable teal radial-gradient used elsewhere) instead of a hand-rolled grayscale gradient.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-53 — Raw brand-teal literals + hardcoded radii instead of tokens (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟡 Medium | Section | Global — color/radii tokens | Category | Tokens |
| Page(s) | Multiple | Verify | https://insightis-landing.vercel.app/platform/integrations |

**Current** — A third teal literal `rgba(9,160,157,…)` recurs (security.jsx, connectors.jsx, ai-chat cards, brand pills) where the DS uses `rgba(7,128,126,…)` / teal tokens — so even the brand teal is inconsistent. Hardcoded `borderRadius:'999px'` recurs where `--ins-radius-pill` exists, and raw surfaces like `#0D0D1A` / `rgba(46,46,64,1)` appear instead of surface tokens.
**Expected** — All colors/radii from tokens (`--ins-color-teal-*`, `--ins-surface-*`, `--ins-radius-*`); no raw hex/rgba in components.
**Status history** | 2026-08-04 | Accepted | Source-audit (answers "raw colors" mandate). |

---

### AUD-54 — DS control primitives bypassed with inline rebuilds (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟡 Medium | Section | Global — controls | Category | Consistency |
| Page(s) | Multiple | Verify | https://insightis-landing.vercel.app/pricing |

**Current** — DS ships `.ins-badge--tab`, `.ins-segmented`, `.ins-input-group` but they're bypassed: filter pills override the DS badge inline (`7px/18px/13px` vs `3px 8px/11`) on integrations/ai-chat, and blog swaps brand/neutral variants instead; `BillingToggle.jsx` rebuilds `.ins-segmented` fully inline (hardcoded 999px, 180ms); email input+button groups (`success-stories`, `WaitlistForm`) hand-rolled instead of `.ins-input-group`; the "copy/request/clear" utility button exists in 4 different inline styles.
**Expected** — Consume the DS primitives (`.ins-badge--tab`, `.ins-segmented`, `.ins-input-group`, `<Button size="sm">`).
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-55 — Duplicated component JSX + unused/undefined classes (Accepted)

| | |
|---|---|
| Domain | Code | Severity | ⚪ Low | Section | Global — code hygiene | Category | Tokens |
| Page(s) | Docs, connectors, prompt-library | Verify | https://insightis-landing.vercel.app/docs/ |

**Current** — `docs.jsx:251` hand-copies the `<SearchInput>` markup instead of the component (silent drift risk). The DS `.ins-badge--tab` / `.ins-tabs` / `.ins-segmented` are never referenced in `src/`. Classes `.cat-item` / `.team-pill` / `.view-btn` / `.filter-item` (connectors, prompt-library) aren't defined in any CSS — likely dead/unstyled; confirm.
**Expected** — Use `<SearchInput>`; adopt or remove the unused DS classes; define or delete the undefined ones.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-56 — Comparison "before" card uses red/error styling; use a neutral treatment (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Comparison sections | Category | Color |
| Page(s) | Home, AI Chat, Semantic Layer, Integrations | Verify | https://insightis-landing.vercel.app/ |

**Current** — The "Traditional Approach" / "Without" card is styled **red** (error glow, red border, red ✗). Red signals *error/danger*, but this is just the "before" state — overusing red cheapens real error states and leans on color to carry meaning (SC 1.4.1).
**Expected** — Neutral (gray) treatment for the "before" card; keep meaning on the ✗ vs ✓ icons, reserve teal for the positive side and red for genuine errors. Alternative shown in `deliverables/fix-examples.html`.
**Status history** | 2026-08-04 | Accepted | User-requested alternative. |

---

### AUD-57 — Inline stat numbers use a different color + typeface than their line (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Semantic Layer — catalog footer | Category | Typography |
| Page(s) | Semantic Layer (+ similar stat lines) | Verify | https://insightis-landing.vercel.app/platform/semantic-layer |

**Current** — In "**498** built-in metrics · across **20** sources · plus your own…" the numbers are teal + mono while the rest is muted sans — inconsistent emphasis within one sentence. **The correct state already exists elsewhere:** the integrations page renders "+ 180 more connectors available" in one uniform text color/typeface.
**Expected** — Match that existing plain treatment: one color + one typeface for the whole line (emphasise with weight only, no second color/font); use the canonical count (see AUD-05). This is a direct fix to an existing pattern — **not** a redesign proposal.
**Status history** | 2026-08-04 | Accepted | User-reported; correct pattern already on site ("+ 180 more connectors available"). |

---

### AUD-58 — Low-contrast body text (Accepted)

| | |
|---|---|
| Domain | Design | Severity | 🟡 Medium | Section | Semantic Layer — subheads | Category | Color |
| Page(s) | Semantic Layer | Verify | https://insightis-landing.vercel.app/platform/semantic-layer |

**Current** — Italic teal-tinted line "One certified definition. Queried through the Semantic Layer. Always your numbers." is low-contrast against the dark background (below WCAG AA for body text).
**Expected** — Raise to ≥4.5:1 (use `--ins-text-body`/`--ins-text-heading`, not a dim teal tint).
**Status history** | 2026-08-04 | Accepted | User-reported (low contrast). |

---

### AUD-59 — Button label casing inconsistent (Title vs sentence case) (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Global — buttons | Category | Content |
| Page(s) | All | Verify | https://insightis-landing.vercel.app/ |

**Current** — "Start for free" (sentence case) sits next to "Explore Pricing" (Title case). House style should be sentence case everywhere → "Explore pricing".
**Expected** — Sentence case for all button/CTA labels site-wide.
**Status history** | 2026-08-04 | Accepted | User-reported. |

---

### AUD-60 — Highlighted word color inconsistent across CTA banners (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | CTA banners | Category | Color |
| Page(s) | Multiple (e.g. "See it on your own pipeline") | Verify | https://insightis-landing.vercel.app/solutions/revenue-teams |

**Current** — The teal used for the highlighted word ("your own pipeline") differs from the teal on other banners — the same teal-literal drift as AUD-53 (`rgba(9,160,157)` vs the DS teal token). Highlight color isn't driven from one token.
**Expected** — One highlight token (`--ins-text-highlight` / `--ins-color-teal-*`) for every banner. Related: [[AUD-53]].
**Status history** | 2026-08-04 | Accepted | User-reported (inconsistent highlight). |

---

### AUD-61 — "See all 200+ integrations" uses a custom teal-outline instead of the secondary button (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | ⚪ Low | Section | Solutions — integrations link | Category | Consistency |
| Page(s) | Solutions ×6, Integrations | Verify | https://insightis-landing.vercel.app/solutions/revenue-teams |

**Current** — The "See all 200+ integrations →" control is a bespoke teal-outline pill (teal border + teal text), not the DS secondary button. Inconsistent with the rest of the button system. Related: [[AUD-33]] (it's also sub-44px), [[AUD-54]].
**Expected** — Use `<Button variant="secondary">` (with the ≥44px hit area).
**Status history** | 2026-08-04 | Accepted | User-reported (should be secondary). |

---

### AUD-62 — FAQ question hover feedback too weak (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | ⚪ Low | Section | FAQ accordion | Category | Accessibility |
| Page(s) | All with FAQ | Verify | https://insightis-landing.vercel.app/platform/semantic-layer |

**Current** — Hovering an FAQ question gives almost no visual change — the interactive affordance is too subtle for a full-width clickable row.
**Expected** — A clearer hover state (background/border shift) so the row reads as clickable; apply in the DS `<FAQAccordion>` so it's consistent everywhere.
**Status history** | 2026-08-04 | Accepted | User-reported. |

---

### AUD-63 — Connector-tile hover: abrupt animation + custom-looking reveal button (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | ⚪ Low | Section | Connector grid (shared) | Category | Consistency |
| Page(s) | Connectors, Solutions ×6, Integrations | Verify | https://insightis-landing.vercel.app/platform/integrations |

**Current** — The connector tile's hover reveal is abrupt (transition not smooth), and the revealed "Sign in to connect" CTA is a bespoke button, not the DS secondary/ghost. Related: [[AUD-27]] (hover-only access), [[AUD-54]] (custom controls).
**Expected** — Smooth eased transition (opacity/transform), and the reveal CTA uses the DS button variant.
**Status history** | 2026-08-04 | Accepted | User-reported. |

---

### AUD-64 — Heading hierarchy skips levels (h1 → h3, no h2) (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟡 Medium | Section | Global — headings | Category | Accessibility |
| Page(s) | Blog, Connectors, Prompt Library, Contact Support, all Solutions | Verify | https://insightis-landing.vercel.app/blog/ |

**Current** — Blog/Connectors/Prompt-Library/Contact-Support jump h1 → h3 with no h2 (main content sits two levels below h1). On all 6 Solutions pages a decorative hero-mockup `<h3>` and the UseCases promo `<h3>` appear before the first `<h2>` (h1→h3 skip). One h1 per page (good), no block-in-heading.
**Expected** — No skipped levels: section titles are h2; demote decorative headlines to styled divs.
**Status history** | 2026-08-04 | Accepted | Source-audit (IA pass). |

---

### AUD-65 — FAQ structured data (JSON-LD) with no matching on-page FAQ (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟡 Medium | Section | AI Chat, Integrations | Category | Content |
| Page(s) | AI Chat, Integrations (+ Semantic Layer) | Verify | https://insightis-landing.vercel.app/platform/ai-chat |

**Current** — AI Chat and Integrations emit `FAQPage` JSON-LD in `<head>` but render **no visible FAQ** (TODOs confirm it). Structured data without matching DOM is an SEO risk and breaks the expected arc. Semantic Layer has no FAQ at all (only Pricing ships a real one).
**Expected** — Render a visible `<FAQAccordion>` matching the JSON-LD word-for-word (or remove the JSON-LD).
**Status history** | 2026-08-04 | Accepted | Source-audit (IA pass). |

---

### AUD-66 — Security page: broken "View privacy policy" link (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟠 High | Section | Security — hero | Category | Navigation |
| Page(s) | Security | Verify | https://insightis-landing.vercel.app/security |

**Current** — `security.jsx:140` `<Button as="a" href="Privacy">` — a relative, capitalized href resolving to `/security/Privacy` (404) instead of the real `/privacy`. The hero's primary next step is dead.
**Expected** — `href="/privacy"`.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-67 — Contact-email domain inconsistent across the site (.ai vs .io) (Accepted)

| | |
|---|---|
| Domain | Content | Severity | 🟡 Medium | Section | Global — contact | Category | Content |
| Page(s) | Contact Support, Security, Press/Media, About | Verify | https://insightis-landing.vercel.app/security |

**Current** — `support@insightis.io` (AUD-28), `security@insightis.ai` (security), `press@insightis.io` (press), and boilerplate stating the site is `insightis.io` — the brand domain itself is used inconsistently. Extends [[AUD-28]].
**Expected** — One canonical domain for all addresses and boilerplate.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-68 — Dead imports + empty section stubs (template drift) (Accepted)

| | |
|---|---|
| Domain | Code | Severity | ⚪ Low | Section | Product/Analytics Teams | Category | Tokens |
| Page(s) | product-teams, analytics-teams (+CheckIcon on 4) | Verify | https://insightis-landing.vercel.app/solutions/product-teams |

**Current** — `product-teams.jsx` / `analytics-teams.jsx` import `PainPointGrid`, `ComparisonCards`, `TestimonialCard` but never render them, and keep orphan comment stubs (`BEFORE/AFTER`, `TESTIMONIALS`) from an older template; `CheckIcon` is imported unused on 4 Solutions pages.
**Expected** — Remove dead imports + orphan stubs.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-69 — Success Stories: bottom-CTA email form does nothing (Accepted)

| | |
|---|---|
| Domain | Code | Severity | 🟡 Medium | Section | Success Stories — final CTA | Category | Completeness |
| Page(s) | Success Stories | Verify | https://insightis-landing.vercel.app/ |

**Current** — The closing CTA email `<input>` + "Start for free" `<button>` (`success-stories.jsx:288`) have no `onSubmit`/`onClick`/action — it captures nothing. Related: [[AUD-52]].
**Expected** — Wire to sign-up, or use `<BottomCTA>`.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-70 — Security: "Industry-standard certifications" heading contradicts its content (Accepted)

| | |
|---|---|
| Domain | Content | Severity | ⚪ Low | Section | Security — compliance | Category | Content |
| Page(s) | Security | Verify | https://insightis-landing.vercel.app/security |

**Current** — Section titled "Industry-standard certifications", but the cards list GDPR-aligned / read-only / no-AI-training (not certifications), and the FAQ says "Formal certifications are on our security roadmap."
**Expected** — Rename (e.g. "Compliance & data-handling commitments") to match the actual claims.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-71 — Home built differently from platform pages (structure/IA) (Accepted)

| | |
|---|---|
| Domain | Code + Design | Severity | ⚪ Low | Section | Home | Category | Consistency |
| Page(s) | Home | Verify | https://insightis-landing.vercel.app/ |

**Current** — Home hand-rolls each section's eyebrow `<span>` + raw `<h2>` instead of the `<SectionHeader>` used elsewhere, and mounts How-It-Works via imperative `showcase.js` while platform pages use `<StepsProcess>`. IA-wise, a Semantic-Layer deep dive ("Every number means the same thing") precedes the product overview (WhatIsInsightis).
**Expected** — Use `<SectionHeader>`/`<StepsProcess>`; consider overview before the single-feature deep dive.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-72 — Solutions: Use Cases restate the Feature Spotlights (Accepted)

| | |
|---|---|
| Domain | Design | Severity | ⚪ Low | Section | Solutions pages | Category | Content |
| Page(s) | Solutions ×6 | Verify | https://insightis-landing.vercel.app/solutions/finance-teams |

**Current** — The 4 spotlights (Self-Serve, Semantic Layer, Risk Alerts, Full Lineage) are re-listed as use-case cards on every page — the two sections largely repeat the same messaging.
**Expected** — Differentiate Use Cases toward concrete tasks/outcomes.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-73 — Roadmap content lives only inside an SVG (not in the DOM outline) (Accepted)

| | |
|---|---|
| Domain | Code | Severity | ⚪ Low | Section | Roadmap | Category | Accessibility |
| Page(s) | Roadmap | Verify | https://insightis-landing.vercel.app/resources/roadmap |

**Current** — Milestones are drawn as SVG `<text>` on an animated spine; the page outline is only h1 → h2 → h3, so the actual roadmap items aren't in the document outline or reliably reflowable. Related: [[AUD-31]], [[AUD-37]].
**Expected** — Provide a semantic list/heading fallback alongside the SVG.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

### AUD-74 — Pricing feature table keeps 4 columns on mobile (Accepted)

| | |
|---|---|
| Domain | Code | Severity | ⚪ Low | Section | Pricing — feature comparison | Category | Responsive |
| Page(s) | Pricing | Verify | https://insightis-landing.vercel.app/pricing |

**Current** — `FeatureComparison` uses fixed `cols='1.6fr 1fr 1fr 1fr'`; the ≤768px query only shrinks font/padding, never reflows the 4 columns → cramped at 320px.
**Expected** — Stack or horizontally scroll the plan columns on mobile.
**Status history** | 2026-08-04 | Accepted | Source-audit. |

---

> **Terminology note (AUD-22, re-evidenced site-wide):** the full-site pass confirmed the connector/integration/source/"data source" drift on **every** page audited (Home, Integrations, Docs, Connectors, Prompt Library, and all six Solutions pages — e.g. CTA "See all 200+ integrations" → the `/resources/connectors` route, footer "Data Connectors"). AUD-22 remains the single canonical finding; scope now = site-wide.

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
