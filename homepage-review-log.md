# Homepage — persistent review log

> **Source HTML:** [Homepage-audit-render.html](Homepage-audit-render.html) — 2026-05-20, byte-equal to the May 18 baseline modulo one 71-byte `.fade-up{opacity:1!important;transform:none!important}` CSS rule. No content / markup / a11y change.
> **Evidence:** [audit-screenshots/](audit-screenshots/) (2026-05-20 batch — section captures `s01-nav.png` … `s11-global.png`, `full-desktop-trimmed.png`, `full-mobile.png`, plus per-issue evidence crops)
> **Framework:** [review-framework.md](review-framework.md)
> **Iteration protocol:** [review-iteration-protocol.md](review-iteration-protocol.md)
> **Prior baselines:** [archive/2026-05-19-baseline/](archive/2026-05-19-baseline/) — 76 findings carried forward (47 from `homepage-audit-summary.md`, 29 from `homepage-audit-extension.md`)
> **Migration audit:** All 76 ISS-NN findings imported from `archive/2026-05-19-baseline/` on 2026-05-20. **Domain, Severity, Section, Category, Title, Problem (Current), Recommendation (Expected), and Evidence fields are byte-equal to the archived files** — verifiable by spot-checking ISS-01, ISS-14, ISS-23, ISS-45, ISS-72 against the archive. Added fields: Status, Complexity, Confidence, Linked, Why It Matters, Status history.

---

## Iteration history

| # | Date | What changed | Net new | Resolved | Regressions | Impact Reviews |
|---|---|---|---|---|---|---|
| 1 | 2026-05-19 | First-pass audit (Code + Design lenses, baseline). ISS-05 dropped as out-of-scope (third-party brand assets). | 47 | — | — | — |
| 2 | 2026-05-19 | Visual extension pass (designer's eye — rhythm, hierarchy, state coverage). | 29 | 0 | 0 | 0 |
| 3 | 2026-05-20 | **First iteration under the new Status workflow.** UX / Scalability / DS-maturity / Product-structure lenses applied. All 76 prior findings migrated as `Pending Review`. Net-new ISS-78–ISS-89 filed. ISS-90–ISS-99 added mid-session during status review (user-identified: text hierarchy, nav button, mid-page CTA, button hover, Glow card, list alignment, chip contrast). | 22 | 0 | 0 | 0 |

---

## Status summary (live, post-iteration 3)

|                          | Critical | High | Medium | Low | Total |
|---|---|---|---|---|---|
| Pending Review           | 0 | 4 | 26 | 9 | **39** |
| Accepted                 | 2 | 9 | 31 | 15 | **57** |
| Declined                 | 0 | 0 | 0 | 1 | **1** |
| Discuss                  | 0 | 0 | 0 | 0 | 0 |
| Backlog                  | 0 | 0 | 0 | 0 | 0 |
| Resolved                 | 0 | 0 | 0 | 0 | 0 |
| Impact Review Required   | 0 | 0 | 0 | 0 | 0 |
| **Total**                | **2** | **13** | **57** | **25** | **97** |

Cross-cut by category (new framework lenses):

| Category | Count |
|---|---|
| UI | 23 |
| UX | 18 |
| DS | 36 |
| Accessibility | 14 |
| Scalability | 6 |
| **Total** | **97** |

Cross-cut by domain (existing rubric split):

| Domain | Count |
|---|---|
| Code | 30 |
| Design | 47 |
| Code + Design | 20 |
| **Total** | **97** |

---

## Iteration 3 — end-of-pass report

### 1. Critical blockers

Two Critical findings remain unresolved and continue to block any "ship-ready" perception of the page:

- **[ISS-01](#iss-01)** — `<h1>` contains two block-level `<div>` children. Invalid HTML; SR users hear two separate paragraphs instead of one heading. Five-second visible defect.
- **[ISS-02](#iss-02)** — KPI strip renders `0x / 0% / 0+ / 0.9%` on initial load until a JS counter animates. SEO crawlers, social-card screenshotters, and no-JS visitors see zeros where real KPIs should be.

Both have High confidence, Low complexity. Resolving them is a single PR each.

### 2. Quick wins

Stack-ranked by impact-per-edit:

1. **[ISS-14](#iss-14)** — Footer "© Copyright © Devart 2026" duplicate symbol. One string edit.
2. **[ISS-15](#iss-15)** — Footer URLs contain unencoded spaces (`/Platform/AI Chat`). Lowercase + hyphenate in the route map.
3. **[ISS-43](#iss-43)** — Hero `<h1>` uses `font-family: 'Outfit'` which is never loaded. Drop the inline style; let the heading inherit `var(--ins-font-display)`.
4. **[ISS-69](#iss-69)** — Final CTA H2 contains leading spaces inside `<span>` tags producing double-gaps. Move the spaces outside the spans.
5. **[ISS-65](#iss-65)** — KPI numbers render at `font-weight: 500`; DS prescribes `font-weight: 700`. One CSS-class swap.
6. **[ISS-57](#iss-57)** — Eyebrow `✦` color drifts between two teals (#148F8D ×3, #09A09D ×1). Replace inline hex with `--ins-primary-400`.
7. **[ISS-72](#iss-72)** — Mobile hamburger button is 40×40 (WCAG 2.5.5 minimum is 44×44). `p-2` → `p-2.5`.

### 3. Newly introduced issues

12 new findings filed under the four under-weighted lenses (UX mental model, scalability ceilings, DS maturity gaps, product structure). IDs **ISS-78 through ISS-89**. All `Status: Pending Review`.

| ID | Title | Category | Severity |
|---|---|---|---|
| [ISS-78](#iss-78) | Hero chat widget conflates demo and primary CTA — interactive-vs-illustrative ambiguity | UX | High |
| [ISS-79](#iss-79) | Two competing primary actions in the hero region | UX | Medium |
| [ISS-80](#iss-80) | Nine-section page has no in-page navigation | UX | Medium |
| [ISS-81](#iss-81) | Hero subheadline packs three claims into one ungrammatical fragment | UX | Medium |
| [ISS-82](#iss-82) | Pillar pattern doesn't scale past two pillars | Scalability | Medium |
| [ISS-83](#iss-83) | Testimonial 6-card fixed grid doesn't scale to 12+ entries | Scalability | Low |
| [ISS-84](#iss-84) | No DS pattern for N-column comparison ("us vs Tableau vs PowerBI") | DS | Medium |
| [ISS-85](#iss-85) | Chat-input component has no DS equivalent | DS | High |
| [ISS-86](#iss-86) | Connector marquee has no DS logo-wall variant | DS | Medium |
| [ISS-87](#iss-87) | Section ordering delays social proof to position 6 of 10 | UX | Medium |
| [ISS-88](#iss-88) | Two-pillar framing is non-parallel ("Architecture" vs "Decision Velocity") | UX | Medium |
| [ISS-89](#iss-89) | "Semantic Layer" jargon never explained on-page | UX | Medium |

### 4. Resolved issues

**None.** The May 20 source HTML is byte-equal to the May 18 baseline modulo a one-line `.fade-up` CSS rule. No previously-filed issue has been addressed by code changes; every finding carries forward with the same Status.

### 5. Regressions

**None.** Possible only after the first `Resolved` decision lands.

### 6. Impacted accepted decisions

**None.** Possible only after the first `Accepted` decision lands. The new lens-driven findings (ISS-78 → ISS-89) do not invalidate any prior filing — they sit alongside as new lenses on the same evidence.

### 7. Systemic UX risks

Three patterns surface when reading the 88 findings as a whole:

1. **The page assumes the visitor already knows what an AI semantic layer is.** ISS-89 (jargon), ISS-81 (subheadline packs three claims), ISS-80 (no jump nav for a mid-funnel reader to skip to "Comparison" or "Pricing"). A CFO or RevOps lead — likely target audience — has no fast lane to validation.
2. **The hero region promises interactivity it likely doesn't deliver.** ISS-78 (chat widget ambiguity), ISS-52 (Send button styled as ghost), ISS-76 (no disabled state), ISS-74 (no empty state). Together: the chat widget looks live, types like live, but probably doesn't *do* anything. Mental-model whiplash on the most prominent above-the-fold element.
3. **No primary CTA discipline.** ISS-51 (no standalone hero CTA), ISS-79 (competing nav-CTA + chat widget), ISS-30/ISS-68 ("Get Insight" fragment), ISS-34 (arrow glyph inconsistency), ISS-70 (final CTA horizontal layout). One CTA family, no dominant action — visitor never sees a single hand-raise moment.

### 8. DS maturity gaps

The page exposes specific places where the design system is silent or thin:

- **Chat-input component is custom.** `design-system/components/` does not publish a chat-input pattern. ISS-52 (button tier), ISS-53 (input height), ISS-74 (empty state), ISS-76 (disabled state) are all chat-widget-state issues that would collapse into one fix if the DS owned the component. Filed as **[ISS-85](#iss-85)**.
- **Comparison-grid component is structural only.** Per the DS survey, `design-system/components/comparison-grid.html` documents the layout but not the color-signal pattern (red-tint vs teal-tint) needed for "win vs pain" reading. ISS-40, ISS-66 ride this gap. Filed as **[ISS-84](#iss-84)**.
- **Marquee component has no logo-wall variant.** `design-system/components/marquee.html` covers auto-scroll for text/icons but not the 32×32 monochrome logo cell pattern that vendor strips need (ISS-37). Filed as **[ISS-86](#iss-86)**.
- **Loading / empty / error triad incomplete at component level.** DS publishes `loaders.html` + `empty-states.html` + `alerts.html`, but no per-component state matrix tying them to inputs, cards, KPI strips. ISS-73, ISS-74, ISS-75, ISS-76 are all symptoms.
- **Component state matrices missing for select / modal / accordion / tabs / table.** Per the DS survey. None are used heavily on this Homepage, but every future page that uses them inherits the gap.
- **Motion vocabulary is sparse.** One easing curve + three durations, no spring/bounce. Card hover (ISS-64), testimonial hover, and decorative animations have no motion-design language to draw from.

### 9. Scalability concerns

Patterns that work at the current scale but break as the product grows:

- **Two-pillar layout.** ISS-82. Adding a third pillar (likely as the platform expands beyond Semantic Layer + Decision Velocity) pushes the page over 4000 px desktop. No "compact pillars" pattern in the DS.
- **Six fixed-height testimonial cards.** ISS-83 (extends ISS-63). At 12+ testimonials the page needs pagination, carousel, or "see more" — none exist.
- **Eyebrow rhythm at 4 of 8 sections.** ISS-58. Inconsistent half-coverage. If a new section is added, the rule for "eyebrow yes / eyebrow no" is undocumented.
- **Footer column lengths drift 4/6/6/4/4.** ISS-71. At the program scale (Roadmap, AI Chat, About, Platform, Privacy, Data Analytics Teams) every footer column will accumulate items at different rates — the imbalance compounds.
- **Section ordering as a fixed list.** ISS-87. Currently social proof comes at position 6 of 10. As content grows, the visitor's path to validation lengthens — no jump-nav exists to compensate.
- **CTA ladder is flat.** ISS-79 + ISS-51. With only "Start for Free" at the top and "Get Insight" at the bottom, mid-page CTAs are absent. Every new section deepens the ask without renewing the offer.

### 10. Recommended next priorities

For the user to decide Status on, in this order:

1. **[ISS-01](#iss-01), [ISS-02](#iss-02), [ISS-43](#iss-43)** — the three Critical/High items with one-line fixes. Decide `Accepted` to unlock the stabilize phase.
2. **[ISS-04](#iss-04), [ISS-44](#iss-44)** — the token-vocabulary unification pair. Blocks every per-call-site token migration (ISS-06, ISS-45, ISS-57, ISS-65, ISS-66). Decide once, unlocks ~12 dependent findings.
3. **[ISS-85](#iss-85)** — chat-input DS component. Decide `Accepted → Backlog (DS work)`. Collapses ISS-52, ISS-53, ISS-74, ISS-76 into a single DS roadmap item.
4. **[ISS-78](#iss-78)** — chat widget mental-model. Decide whether the chat widget is genuinely interactive (then upgrade send/states) or illustrative (then add "demo" framing). Hands shape every other hero finding.
5. **[ISS-87](#iss-87), [ISS-88](#iss-88), [ISS-89](#iss-89)** — product-structure trio. Decide `Discuss` to flag for a design crit before implementation work; these need user judgment, not engineering.
6. **[ISS-24](#iss-24), [ISS-77](#iss-77), [ISS-48](#iss-48)** — global accessibility (`:focus-visible`, focus ring, `prefers-reduced-motion`). One sweep PR; affects every page in the program.
7. **[ISS-82](#iss-82), [ISS-83](#iss-83), [ISS-84](#iss-84), [ISS-86](#iss-86)** — the four "DS / scalability gap" findings. Move to `Backlog (DS roadmap)` collectively; they belong in the DS work, not the Homepage PR.

---

## Duplicate detection log — iteration 3

Twelve net-new candidate findings were screened against the existing 76 ISS-NN by Section × Category bucket + 70 % title-overlap heuristic. Decisions:

| Candidate | Closest existing | Decision |
|---|---|---|
| Hero chat widget interactive-vs-demo ambiguity | ISS-38 (truncated placeholder), ISS-52 (Send tier), ISS-74 (empty state) | **Split** — these three are visual-state symptoms; the new finding (ISS-78) names the underlying mental-model mismatch. Different problem. |
| Competing CTAs in hero | ISS-51 (no standalone CTA), ISS-79 (this) | **Split** — ISS-51 says "add a CTA"; ISS-79 says "*if* both the nav CTA and the chat widget remain, they compete". Different concern. |
| No in-page navigation | None | **New** — no existing finding about jump-nav or sticky in-page anchors. |
| Hero subheadline overpacked | ISS-39 (trust line packs too much), ISS-46 (trust line wraps to 4 lines) | **Split** — ISS-39/46 are about the *trust line* below the CTA; ISS-81 is about the *subheadline* between H1 and chat. Different DOM element. |
| Pillars don't scale | ISS-61 (pillar 5 vs 4 features), ISS-35 (architecture list duplicated) | **Split** — ISS-61 is asymmetric *within* the current pillars; ISS-82 is the pattern *not scaling* to a third pillar. Different concern (now vs future). |
| Testimonials don't scale | ISS-63 (fixed 207 px), ISS-64 (no hover), ISS-10 (stock avatars) | **Split** — ISS-63 is the height pattern at N=6; ISS-83 is the *grid pattern* at N=12+. Different concern. |
| No DS comparison pattern | ISS-40 (no color signal), ISS-66 (alpha asymmetry) | **Split** — ISS-40/66 are about the current 2-card render; ISS-84 is about the DS not publishing the *pattern* needed for N>2 column comparisons. Different layer. |
| Chat-input is custom | ISS-52, ISS-53, ISS-74, ISS-76 | **Split** — those four are individual symptoms; ISS-85 names the root cause (no DS component). Filed with `blocks: ISS-52, ISS-53, ISS-74, ISS-76` link so the dependency surfaces. |
| Connector marquee DS gap | ISS-37 (logos sized unevenly), ISS-19 (emoji icons) | **Split** — ISS-37 is the current visual inconsistency; ISS-86 is the DS gap that produced it. |
| Section ordering | None | **New** — no existing finding about IA / section sequence. |
| Two-pillar framing not parallel | None | **New** — no existing finding about pillar *naming* (vs ISS-61 which is bullet *counts*). |
| Semantic Layer jargon | ISS-89 (this) | **New** — no existing finding about glossary / definition gaps. |

Net: **12 splits / new, 0 merges**. All twelve filed as new ISS-NN.

---

## Findings

> **Migration note.** Findings ISS-01 through ISS-77 are migrated from the May 19 archive. The fields `Domain`, `Severity`, `Section`, `Title`, `Problem`, `Recommendation`, `Evidence` are byte-equal to the archived `homepage-audit-summary.md` / `homepage-audit-extension.md` / `audit-findings-extension.js`. The new fields (`Category` per the UI/UX/DS/A11y/Scalability lens; `Complexity`; `Confidence`; `Linked`; `Why It Matters`; `Status`; `Status history`) were added without editorial change to the originals. `Visual` references the existing compare panes in `archive/2026-05-19-baseline/audit-findings-extension.js` and `design-system-audit.html`. ISS-05 is permanently dropped (third-party brand assets, out of scope per `review-framework.md` §1.5).

---

### ISS-01 — Hero `<h1>` nests block-level `<div>` children (Status: Accepted)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code |
| Severity | Critical |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-43 (Hero typography), ISS-49 (H1 size) |

**Problem** — The hero `<h1>` contains two `<div>` blocks ("Your data knows the answer" / "Now you can ask it"). Block-level inside `<h1>` is invalid HTML and assistive tech announces it as separate paragraphs rather than one heading. On the live page the same markup also concatenates the two clauses with no whitespace.

**Why It Matters**
- Accessibility impact: violates WCAG 1.3.1 (Info and Relationships); screen readers announce two paragraphs instead of one heading.
- Consistency impact: every page that copies this hero pattern (Roadmap, AI Chat, About) inherits the invalid markup.
- Enterprise UX impact: visible to a 5-second AT audit; ship-blocker on any accessibility review.

**Recommendation** — A single `<h1>` with the two clauses as inline spans separated by a `<br>`, or with the line-break baked into the CSS via `display:block` on each `<span>`. Screen readers should hear one heading: "Your data knows the answer. Now you can ask it."

**Evidence** — `Homepage.html:94` — `<h1>` contains two `<div>` children; live render concatenates the strings. See compare panes in `archive/2026-05-19-baseline/` via `design-system-audit.html`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing (iteration 1) |
| 2026-05-20 | Pending Review | Carried forward; HTML unchanged from May 18 |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-02 — KPI stats stuck at zero on initial load (Status: Accepted)

| | |
|---|---|
| Category | UX |
| Domain | Code |
| Severity | Critical |
| Area | KPI / numbers strip |
| Section (taxonomy) | KPI / numbers strip |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-73 (no loading skeletons), ISS-65 (KPI weight) |

**Problem** — "What is Insightis" section renders `0x / 0% / 0+ / 0.9%` on initial load — counter animation never reaches real values.

**Why It Matters**
- User impact: SEO crawlers, social-card screenshotters, RSS readers, and no-JS visitors all see "0" where real KPIs should appear.
- Readability impact: a five-second viewer who scrolls past during the count-up sees an unfinished page.
- Enterprise UX impact: marketing-team review will flag this immediately; counter-animation must enhance, not gate, the rendered numbers.

**Recommendation** — The initial HTML must already contain the final figures (5x, 41 %, 581+, 99.9 %). The count-up animation should only run on top of that, so SEO crawlers, social-card screenshotters, and no-JS visitors all see real numbers instead of zeros.

**Evidence** — Live rendered "0x Faster Insights / 0 % Time Saved / 0+ Companies / 0.9 % Uptime SLA".

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing (iteration 1) |
| 2026-05-20 | Pending Review | Carried forward; HTML unchanged |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-03 — Three styling systems mixed on one page (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code |
| Severity | High |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | High |
| Confidence | High |
| Linked | blocks: ISS-08, ISS-09, ISS-36 (all per-call-site token / radius / spacing fixes) |

**Problem** — The page styles itself via three parallel mechanisms — Tailwind utilities (`rounded-full`, `text-sm`, `px-4`), raw inline `style="…"` attrs (200+ occurrences), and DS tokens / `.ins-*` classes (a handful). Same role, three different patterns; impossible to audit a button or a card without checking three places.

**Why It Matters**
- Consistency impact: a designer cannot reason about a single button's styling without checking three places.
- Scalability impact: every new page inherits the mix; the technical debt grows linearly with surface area.
- DS impact: undermines the DS's value proposition (one canonical style per component).

**Recommendation** — Pick one primary system. The DS publishes `.ins-btn` / `.ins-card` / `.ins-badge` / `.ins-input` with variants and sizes; use those as the default and reserve inline `style` only for one-off positioning. Tailwind utilities, if kept, should be wrapped into component classes rather than scattered at call sites.

**Evidence** — 2 hits for `class="ins-"` vs 206 inline style attrs and 600+ Tailwind utility classes.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-04 — Two competing token vocabularies (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code |
| Severity | High |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | blocks: ISS-06, ISS-44, ISS-45, ISS-57, ISS-65, ISS-66 (all per-call-site token migrations) |

**Problem** — HTML uses `tokens.css` names (`--ins-color-teal-500`, `--ins-font-family-mono`) while `colors_and_type.css` — the canonical brief — uses `--ins-primary-400`, `--ins-font-mono`, `--ins-state-live-fg`.

**Why It Matters**
- Consistency impact: two vocabularies for the same value means every audit doubles in cost.
- Scalability impact: until reconciled, every dependent token fix is blocked.
- DS impact: the design system has two competing source-of-truth files. Whichever loads later wins, which is fragile.

**Recommendation** — Pick one canonical file (`colors_and_type.css` is the brief's source of truth). In the other file, re-export every token as an alias of the canonical name (e.g. `--ins-color-teal-400: var(--ins-primary-400)`). Then deprecate the duplicates so call sites only ever reference one vocabulary.

**Evidence** — Token names differ across `colors_and_type.css` and `design-system/assets/tokens.css`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Conflicts verified: primitive naming diverges between files. tokens.css is canonical; call sites should use semantic tokens only — never primitives from either file directly. |

---

### ISS-06 — 56 raw `rgba()` values bypass alpha tokens (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code |
| Severity | High |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | depends-on: ISS-04 (token vocab) |

**Problem** — Alpha values like `rgba(255,255,255,.04)`, `rgba(10,152,150,.12)` appear inline; DS already names these (`--ins-color-white-a-06`, `--ins-color-teal-a-20`).

**Why It Matters**
- Consistency impact: 56 places where a designer must read an opacity calculation instead of a named token.
- DS impact: undermines the named-alpha primitive design (one of the DS's strengths per `README.md`).

**Recommendation** — Replace every inline `rgba()` with the matching named primitive: `rgba(255,255,255,.06)` → `var(--ins-border-default)`, `rgba(10,152,150,.12)` → `var(--ins-surface-brand-tint)`, `rgba(255,255,255,.45)` → `var(--ins-color-white-a-45)`. The tokens are already defined — call sites should not be re-inventing them.

**Evidence** — `grep -c "rgba("` → 56.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-07 — Sub-12 px font sizes in pillar illustrations break minimum legibility floor (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Medium |
| Area | Primary value pillars |
| Section (taxonomy) | Decision Velocity mocks |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-62 (dashboard icons drift) |

**Problem** — Illustrative mockups inside the Architecture and Decision Velocity pillar sections use font sizes as small as 7–11 px. Illustrative mockups are not required to follow the DS type scale step-by-step — they are deliberately miniaturised to suggest a dashboard UI within a constrained space. However, 12 px is the absolute minimum at which text remains legible on a typical laptop screen (WCAG 1.4.4). Sizes below 12 px are effectively invisible to many users and communicate nothing meaningful — they add visual noise without delivering content.

**Why It Matters**
- Readability impact: sub-12 px text is unreadable at normal viewing distance on a 1×DPR screen; the detail it tries to suggest is lost.
- Accessibility impact: WCAG 1.4.4 Resize Text applies even to decorative mocks when the text carries meaning (labels, numbers).

**Recommendation** — Illustrative mocks may use their own visual sizing conventions; they do not need to map to DS type-scale classes. The one hard rule: **nothing below 12 px**. Any mock label currently below 12 px should be nudged up to 12 px or replaced with a non-text placeholder (e.g. a grey rule) if the content is purely decorative.

**Evidence** — Saved snapshot lines 118, 124, 127, 145, 233, 260, 395. ⚠️ *Needs screenshot: user was unable to identify the specific mock elements from description alone. Provide a cropped screenshot of the pillar illustration text labels before acting on this finding.*

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Pending Review | Rework — recommendation scoped to legibility floor only (mockups exempt from DS type scale). Screenshot evidence needed before fix. |

---

### ISS-08 — Spacing off the 4 px grid (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Code |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-04 (token vocab); related: ISS-42, ISS-60 (spacing) |

**Problem** — Inline padding uses 1, 3, 5, 7, 9, 11, 13, 15, 17 px — none on the 4 px grid.

**Why It Matters**
- Consistency impact: every off-grid pixel breaks the vertical rhythm.
- DS impact: bypasses `--ins-space-*` tokens; weakens the spacing scale by exception.

**Recommendation** — Snap every padding / margin / gap to the 4 px grid via tokens: 4 → `--ins-space-xs`, 8 → `--ins-space-sm`, 12 → `--ins-space-md`, 16 → `--ins-space-lg`, 24 → `--ins-space-xl`, 32 → `--ins-space-2xl`. If you wrote 7 px, you almost certainly meant 8 (sm). Write `padding: var(--ins-space-sm)` instead of `padding: 7px`.

**Evidence** — 17 hits for padding with off-grid values.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-09 — Border-radius outside the scale (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code |
| Severity | Medium |
| Area | Connector mocks |
| Section (taxonomy) | Connector mocks |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-36 (button radius) |

**Problem** — Inline `border-radius` uses 3, 5, 9 px — none map to `--ins-radius-{xs:2, sm:4, md:6, lg:8, xl:12, 2xl:16, full:999}`.

**Why It Matters**
- Consistency impact: pill / rounded / square decisions become per-element instead of per-role.
- DS impact: undermines the radius scale's value (which exists exactly to remove this question).

**Recommendation** — Only these radii exist: `--ins-radius-xs` (2), `sm` (4), `md` (6), `lg` (8), `xl` (12), `2xl` (16), `full` (999). Default for buttons and inputs is `lg` (8 px); default for cards is `xl` (12 px). Drop the 3 px / 5 px / 9 px values — replace with the nearest token (3 → 4, 5 → 4, 9 → 8).

**Evidence** — 18 hits for `border-radius (3|5|9)px`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-10 — Third-party stock portraits in testimonials (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | High |
| Area | Social proof / testimonials |
| Section (taxonomy) | Social proof / testimonials |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-11 (avatar + initials redundant), ISS-63 (testimonial card height) |

**Problem** — All six avatars load from `randomuser.me` — uncontrolled stock faces. Questionable for trust, GDPR, consent.

**Why It Matters**
- User impact: erodes credibility — savvy visitors recognize stock faces.
- Enterprise UX impact: legal / brand teams flag this immediately (no consent, no GDPR cover).
- Consistency impact: third-party CDN is one outage away from broken avatars across all testimonials.

**Recommendation** — Use either (a) real customer photos with signed photo releases, or (b) branded monogram avatars rendered as a teal gradient with two-letter initials. Never `randomuser.me` — those are AI-generated stock faces on a third-party CDN with no consent chain and no GDPR cover.

**Evidence** — Avatar URLs `randomuser.me/api/portraits/{women,men}/*.jpg` ×6.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-11 — Avatar image + initials shown redundantly (Status: Pending Review)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Low |
| Area | Social proof / testimonials |
| Section (taxonomy) | Social proof / testimonials |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-10 (stock avatars) |

**Problem** — Each testimonial renders both a photo and a two-letter initials chip — initials are meant as a fallback.

**Why It Matters**
- Consistency impact: the DS `.ins-avatar` component handles the swap; the page is reimplementing the pattern incorrectly.
- Readability impact: decorative noise — two competing identity cues for the same person.

**Recommendation** — The avatar component shows ONE thing at a time: a photo when the image loads, OR a two-letter initials chip when the image is missing or fails. Rendering both at once defeats the fallback pattern and creates decorative noise. Use the DS `.ins-avatar` component, which already handles the swap.

**Evidence** — Pattern repeats ×6 on the live page.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-12 — Decorative quote glyph reads as "99" (Status: Accepted)

| | |
|---|---|
| Category | Accessibility |
| Domain | Design |
| Severity | Low |
| Area | Social proof / testimonials |
| Section (taxonomy) | Social proof / testimonials |
| Complexity | Low |
| Confidence | High |
| Linked | — |

**Problem** — Each card opens with a literal "99" before the testimonial — likely a stylized double-quote glyph rendered as numbers in the DOM.

**Why It Matters**
- Accessibility impact: screen readers announce "ninety-nine, Insightis transformed how we make decisions" — disrupts the testimonial reading.
- Readability impact: sighted viewers parse "99" as a numeric label before realizing it's decorative.

**Recommendation** — Use either (a) a typographic curly-quote " styled large with `.ins-decoration-quote`, or (b) a Lucide "quote" SVG marked `aria-hidden="true"`. Either way a screen reader should read the testimonial text directly — never "ninety-nine, Insightis transformed how we make decisions".

**Evidence** — "99" appears before every testimonial quote ×6.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-13 — Steps double-numbered (1. 01) (Status: Accepted)

| | |
|---|---|
| Category | Accessibility |
| Domain | Design |
| Severity | Medium |
| Area | How it works |
| Section (taxonomy) | How it works / step list |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-41 (step title casing) |

**Problem** — Steps render "1. 01 Connect your data", "2. 02 Configure…" — both an `<ol>` counter and a custom 01/02 label.

**Why It Matters**
- Accessibility impact: screen readers announce each step number twice ("list item 1, oh-one, Connect your data").
- Readability impact: visual duplication suggests the steps are doubly indexed for a reason — confusing.

**Recommendation** — Pick one numbering system. Either (a) keep the visual "01/02/03" badges and switch the wrapping list to `<ul>` so the browser doesn't auto-number, or (b) keep `<ol>` and remove the "01/02/03" badges. Both at once means screen readers announce every step twice.

**Evidence** — Live rendered list 1-5 with 01-05 duplicates.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-14 — Duplicate copyright symbol (Status: Accepted)

| | |
|---|---|
| Category | UX |
| Domain | Code |
| Severity | Low |
| Area | Footer |
| Section (taxonomy) | Footer |
| Complexity | Low |
| Confidence | High |
| Linked | — |

**Problem** — Footer renders "© Copyright © Devart 2026" — the symbol appears twice.

**Why It Matters**
- Readability impact: visible "©…©" looks like a typo — erodes polish perception on a high-trust footer.

**Recommendation** — Pick a single copyright format. Recommended: "© Devart 2026" (compact). Acceptable alternatives: "Copyright Devart 2026" or "© 2026 Devart". The current "© Copyright © Devart 2026" duplicates both the symbol and the word.

**Evidence** — WebFetch footer text.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-15 — URLs contain unencoded spaces (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Code |
| Severity | Medium |
| Area | Footer |
| Section (taxonomy) | Footer |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-16 (placeholder hrefs) |

**Problem** — Footer links use paths like `/Platform/AI Chat`, `/Solutions/RevOps BizOps` — raw spaces in URLs are not portable.

**Why It Matters**
- User impact: pasting these into chat / email / analytics shows ugly `%20` escapes.
- Enterprise UX impact: URL schemes are a brand surface; spaces signal sloppiness.

**Recommendation** — URLs should be lowercase and hyphen-separated, no spaces. `/Platform/AI Chat` → `/platform/ai-chat`. `/Solutions/RevOps BizOps` → `/solutions/revops-bizops`. `/Resources/Cookie Settings` → `/resources/cookie-settings`. Browsers escape spaces to `%20` but the result is ugly when shared in chat, tickets, or analytics dashboards.

**Evidence** — Live footer link hrefs.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-16 — Primary CTAs use `href="#"` placeholders (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Code |
| Severity | Medium |
| Area | Header / Hero |
| Section (taxonomy) | Header / Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-15 (URL hygiene), ISS-51 (no hero CTA) |

**Problem** — Sign In, Start for Free, Start Free Trial, Schedule a Demo, Explore Pricing all link to `#`.

**Why It Matters**
- User impact: clicking any CTA scrolls the page to the top with no feedback — feels broken.
- Accessibility impact: `<a href="#">` looks live to AT, jumps Tab focus.

**Recommendation** — Point CTAs at real routes — `/signup`, `/sign-in`, `/pricing`, `/demo`. If a route doesn't exist yet, render the CTA as `<button type="button" disabled aria-disabled="true">` with a tooltip "Coming soon" — not as `<a href="#">`. The latter looks live to assistive tech, jumps Tab focus, and scrolls the page to top on click.

**Evidence** — Live rendered CTAs `href="#"`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-17 — Nav triggers lack dropdown affordance (Status: Accepted)

| | |
|---|---|
| Category | UX |
| Domain | Code |
| Severity | Medium |
| Area | Header / Nav |
| Section (taxonomy) | Header / Nav |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-77 (no focus ring on nav), ISS-72 (mobile hamburger size) |

**Problem** — "Platform", "Solutions", "Resources" appear as plain text — no chevron, no `aria-haspopup`, no link target.

**Why It Matters**
- User impact: discoverability of menus depends on hover; keyboard users have no signal that these are interactive.
- Accessibility impact: missing ARIA means SR users have no idea menus exist.

**Recommendation** — Render Platform / Solutions / Resources as `<button>` elements (not plain `<span>`) with: a chevron-down icon to the right showing they're expandable, `aria-haspopup="menu"`, `aria-expanded` that toggles, and keyboard handlers (Enter or Space to open, Esc to close, arrow keys to navigate menu items).

**Evidence** — WebFetch shows plain text labels.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-18 — Marquee track duplicated without `aria-hidden` (Status: Pending Review)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code |
| Severity | Medium |
| Area | Connector strip |
| Section (taxonomy) | Trust / proof strip |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-86 (no DS logo-wall variant) |

**Problem** — The "200+ Integrations" marquee duplicates the connector list for seamless scroll; screen readers announce each connector twice.

**Why It Matters**
- Accessibility impact: AT users hear every vendor name twice.

**Recommendation** — Keep the first marquee track in the accessibility tree as-is. Add `aria-hidden="true" inert` to the visually duplicated track so screen readers skip it entirely. Both still scroll for the seamless-loop effect, but a blind user hears "HubSpot, Salesforce, Stripe…" once instead of twice.

**Evidence** — WebFetch shows the 15-connector list duplicated immediately after itself.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-19 — Emoji glyphs used as product icons (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Medium |
| Area | Connector mocks |
| Section (taxonomy) | Connector mocks |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-20 (stroke widths), ISS-21 (hard-coded stroke colors), ISS-31 (eyebrow glyph) |

**Problem** — Connector and metric mocks include 🛒 📊 📈 💳 ☁️ 🟠 — emoji render differently per OS and break the Lucide-only icon rule.

**Why It Matters**
- Consistency impact: identical UI renders differently per OS (Windows / macOS / Linux emoji renderers diverge).
- DS impact: violates the Lucide-only icon hard rule from `design-system/README.md`.

**Recommendation** — Replace each emoji with the equivalent Lucide icon: 🛒 → ShoppingCart, 📊 → BarChart3, 📈 → TrendingUp, 💳 → CreditCard, ☁️ → Cloud. Render as inline `<svg>` with `stroke="currentColor"` `stroke-width="1.5"`. Same icon then renders identically on every OS — emoji do not.

**Evidence** — 10 emoji glyphs in saved snapshot.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-20 — Inline SVGs use stroke widths other than 1.5 (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code |
| Severity | Medium |
| Area | Mock SVGs |
| Section (taxonomy) | Mock SVGs |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-19, ISS-21 |

**Problem** — Mockup icons declare `stroke-width` 0.8, 1, 1.1, 1.2, 1.3, 1.4, 1.6, 1.8, 2 — breaking the single Lucide stroke style.

**Why It Matters**
- Consistency impact: nine different stroke weights on one page; visual weight of icons becomes random.

**Recommendation** — Set `stroke-width="1.5"` on every icon in the page — that's the Lucide default and the DS standard. Anything thinner looks faint on dark backgrounds; anything thicker looks blocky next to the rest of the UI. Bulk-update every inline SVG: `stroke-width="0.8" / 1 / 1.2 / 1.4 / 1.6 / 1.8 / 2` → `stroke-width="1.5"`.

**Evidence** — Saved snapshot lines 113, 143, 170, 175, 228, 275.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-21 — SVG icons use hard-coded stroke colors (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code |
| Severity | Medium |
| Area | Mock SVGs |
| Section (taxonomy) | Mock SVGs |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-19, ISS-20 |

**Problem** — Several inline SVGs declare `stroke="#111"`, `stroke="white"`, `stroke="#4A6670"` — bypassing `currentColor`.

**Why It Matters**
- Consistency impact: icons pinned to one color cannot inherit hover / focus / disabled state colors from their parent.
- DS impact: breaks the "icons via `currentColor`" pattern documented in `design-system/foundations/icons.html`.

**Recommendation** — Set `stroke="currentColor"` on every icon — it then inherits whatever color its parent has. An icon inside `.ins-btn--primary` turns white; an icon inside a muted `<span>` turns grey; an icon inside a hover state shifts with it. Hard-coded `stroke="white"` or `stroke="#111"` pins the icon to a single color and breaks every theme variant.

**Evidence** — Saved snapshot lines 113, 143, 170, 228, 275.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-22 — Demo buttons below 44 × 44 minimum tap target (Status: Pending Review)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code |
| Severity | Medium |
| Area | Mock buttons |
| Section (taxonomy) | Mock buttons |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-72 (mobile hamburger 40×40), ISS-53 (chat input height) |

**Problem** — Mock buttons compute to ~24–30 px (`padding:4px 10px font:9.5px` → ~24 px; `padding:9px font:12px` → ~30 px) — under WCAG 2.5.5.

**Why It Matters**
- Accessibility impact: violates WCAG 2.5.5 Target Size; mobile / motor-impaired users mis-tap.

**Recommendation** — Any element a user can tap or click must be at least 44 × 44 px (WCAG 2.5.5). For the demo "Connect" pills, either bump padding to `min-height: 44px; padding: 12px 16px`, OR — if they aren't actually clickable — mark them `aria-hidden="true"` with `tabindex="-1"` so they drop out of the interactive surface.

**Evidence** — Saved snapshot lines 164, 259, 260, 306.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-23 — Inputs have no associated `<label>` (Status: Accepted)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code |
| Severity | Medium |
| Area | Mock inputs |
| Section (taxonomy) | Mock inputs |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-75 (no error state for inputs) |

**Problem** — Demo inputs use `aria-label` only. The page contains zero `<label>` elements.

**Why It Matters**
- Accessibility impact: clicking a label should focus its input; without `<label>`, that affordance is missing.
- User impact: labels are not translatable via browser tools, hurting non-English visitors.

**Recommendation** — Each `<input>` needs an associated `<label for="…">`: `<label for="emailField">Work email</label><input id="emailField" type="email">`. If the label can't be shown visibly, add `class="ins-u-sr-only"` to hide it for sighted users while keeping it for screen readers. `aria-label` alone is not translatable, not clickable to focus the input, and not visible.

**Evidence** — 4 `<input>` elements, 0 `<label>` elements.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-24 — No `:focus-visible` outlines defined (Status: Accepted)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-77 (no focus ring on nav), ISS-48 (`prefers-reduced-motion`) |

**Problem** — No outline / focus-visible rules in the page CSS — keyboard users have no visible focus indicator.

**Why It Matters**
- Accessibility impact: keyboard users cannot see where they are; effectively unnavigable by keyboard.
- Enterprise UX impact: every enterprise procurement / a11y audit fails on this single point.

**Recommendation** — Add to every interactive element: `:focus-visible { outline: none; border-color: var(--ins-border-focus); box-shadow: 0 0 0 3px var(--ins-color-teal-a-15); }`. This gives keyboard users a clear teal ring without affecting mouse users (because `:focus-visible` only triggers on keyboard nav). Currently keyboard users have no visible focus at all.

**Evidence** — `grep "outline:|focus-visible"` → 0 matches.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-25 — Mono font misused for UI labels (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Low |
| Area | Mock connector strip |
| Section (taxonomy) | Connector mocks |
| Complexity | Low |
| Confidence | Medium |
| Linked | — |

**Problem** — Connector-card metadata ("Last Sync", "Records", chip text) rendered in `--ins-font-family-mono`. Mono is reserved for data.

**Why It Matters**
- Consistency impact: mono is a *signal* token ("this is a numeric measurement"); applying it to UI labels dilutes the signal.

**Recommendation** — Wrap only the numeric value in Space Mono: `<span style="font-family: var(--ins-font-mono)">12,481</span>`. The surrounding label ("Records · ") stays in Geist. Mono is a signal for "this is a measurement / numeric value", not a styling default for chip text, timestamps, or @-mentions.

**Evidence** — Saved snapshot lines 118, 125, 127, 255, 285.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-26 — Active labels using `--ins-text-inactive` where `--ins-text-muted` is correct (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Low |
| Area | Mock body content |
| Section (taxonomy) | Mock body content |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-04 (token vocab); related: ISS-91 (text hierarchy systemic) |

**Problem** — Static metadata labels (Last Sync, Records, Payments) use `color: var(--ins-text-inactive)`. In this DS `--ins-text-inactive` = disabled/inactive — the correct semantic for elements that are turned off. These labels are active and readable; they just occupy a lower visual hierarchy than primary body text. The right token for active-but-lower-hierarchy text is `--ins-text-muted`.

**Why It Matters**
- Consistency impact: `--ins-text-inactive` signals "this element is off" — using it on active labels mis-communicates state.
- Accessibility impact: WCAG 1.4.3 contrast exception applies to genuinely disabled text; `--ins-text-inactive` applied to active prose could fail contrast without the exception applying.
- Readability impact: active metadata labels read as unavailable/greyed-out, reducing confidence in the mock data shown.

**Recommendation** — Use `--ins-text-body` for active labels regardless of their visual hierarchy level. `--ins-text-body` (6.94:1 AA) is the correct token for all readable, active text that is not a heading, link, placeholder, or disabled element. `--ins-text-inactive` (#7FA0AC) is for placeholder text in inputs and passive non-interactive text only — never for active metadata labels.

**Evidence** — Saved snapshot lines 127, 137, 145, 162.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-27 — Alt text cannot be fully verified from snapshot (Status: Accepted)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code |
| Severity | Low |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | Medium |
| Linked | — |

**Problem** — Marketing illustrations, dashboard mockup and logo live inside the React bundle; static `<img>` alt attributes can not be audited.

**Why It Matters**
- Accessibility impact: any missing `alt` excludes blind users from image meaning.

**Recommendation** — Every `<img>` needs an `alt` attribute. Use descriptive `alt` for content imagery (`alt="Insightis dashboard showing revenue by region"`). Use `alt=""` plus `aria-hidden="true"` for purely decorative imagery (hero illustration, background pattern, separator graphic). Never omit `alt` entirely — that leaves screen readers reading the filename.

**Evidence** — Single static `<img>` in saved snapshot.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-28 — Hero claim and KPI multipliers conflict (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Low |
| Area | Hero / KPI |
| Section (taxonomy) | Hero / Stats |
| Complexity | Low |
| Confidence | Medium |
| Linked | related: ISS-02 (KPI counter), ISS-65 (KPI weight) |

**Problem** — Hero subhead says "3x more accurate" while the KPI strip headline is "5x faster insights" (currently 0x — see ISS-02).

**Why It Matters**
- User impact: visitor sees "3x" and "5x" in two places and assumes one is wrong.
- Readability impact: parallel claims with different multipliers signal "we don't know which to lead with".

**Recommendation** — If both "3x more accurate" and "5x faster" are real claims, show both with full context in the KPI strip: two cards labelled "3x more accurate · vs spreadsheets" and "5x faster · vs traditional BI". Currently the hero leaks the 3x and the KPI strip leaks the 5x — visitors see two unrelated numbers and assume one is wrong.

**Evidence** — Hero "3x more accurate" vs KPI "5x Faster Insights".

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-29 — Social links rendered as raw URLs (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Code |
| Severity | Low |
| Area | Footer |
| Section (taxonomy) | Footer |
| Complexity | Low |
| Confidence | High |
| Linked | — |

**Problem** — Footer renders literal `https://x.com/Insightisai`, `https://www.tiktok.com/…`, `https://www.youtube.com/…`, `https://www.linkedin.com/…` as link text.

**Why It Matters**
- Readability impact: raw URLs as anchor text look unfinished.
- Enterprise UX impact: every modern footer uses brand-mark icons; raw URLs read as broken templating.

**Recommendation** — Replace each raw URL with a 28×28 anchor wrapping a brand-mark SVG: `<a href="https://x.com/Insightisai" aria-label="X"><svg>…X glyph…</svg></a>`. The visible element is the brand mark; the accessible name is the platform name. Compact, accessible, matches every other modern footer.

**Evidence** — WebFetch footer renders full URLs as anchor inner text.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-30 — "Get Insight" CTA reads as a fragment (Status: Accepted)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Low |
| Area | Final CTA |
| Section (taxonomy) | Footer / Final CTA |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-68 (same problem on bottom CTA), ISS-34 (CTA arrow inconsistency) |

**Problem** — Closing CTA pairs "Still waiting on insights that take days?" with a button labelled "Get Insight" — singular and missing a closing noun.

**Why It Matters**
- User impact: button label reads as a noun fragment / brand name, not an action.
- Consistency impact: every other CTA has a verb; this one stands out as the weakest.

**Recommendation** — Use a verb + object. "Get Insight" reads as a noun fragment (the brand name, almost). Pick one of: "Get insights" (plural object, mirrors the question), "Try Insightis free" (verb + product + qualifier), or "See it in action" (verb + complement). Mirror the section question: "Still waiting on insights?" → "Get insights →".

**Evidence** — WebFetch rendered CTA "Get Insight".

Note: ISS-68 (same button, separately filed) is merged into this finding — Declined as duplicate.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-31 — `✦` Unicode glyph used as eyebrow decoration (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Low |
| Area | Global / Eyebrows |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-57 (eyebrow color drift), ISS-58 (eyebrow rhythm), ISS-19 (emoji icons) |

**Problem** — Every section eyebrow ("✦ Architecture", "✦ How it works", "✦ Verified Impact", "✦ By the numbers", "✦ Featured") leads with a U+2726 BLACK FOUR POINTED STAR character — a font glyph, not a Lucide SVG. Renders differently across OS / fallback fonts.

**Why It Matters**
- Consistency impact: same eyebrow looks different per OS (Windows / macOS emoji renderers differ).
- DS impact: violates the Lucide-only icon hard rule.

**Recommendation** — Drop the ✦ Unicode glyph. Either (a) use a small Lucide "sparkles" or "star" SVG at 10×10 with `stroke="currentColor"` before the eyebrow text, or (b) remove the glyph entirely — the eyebrow caps style + teal color already signals "section label" without needing decoration.

**Evidence** — WebFetch output: ✦ appears before five eyebrow labels.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Replace ✦ with 10×10 Lucide SVG (sparkles or star) with stroke=currentColor. |

---

### ISS-32 — H2 capitalization style is not consistent (Status: Accepted)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Medium |
| Area | Global / Section headings |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-41 (step casing), ISS-59 (eyebrow casing) |

**Problem** — Section H2s mix Title Case ("The Semantic Intelligence Layer", "Built for Decision Velocity", "Start Making Smarter Decisions Today") with sentence case ("Loved by a community", "What is Insightis", "Why teams switch to Insightis", "Still waiting on insights that take days?"). Same role, different rule.

**Why It Matters**
- Consistency impact: capitalization is one of the loudest brand-voice signals; mixing reads as careless.
- Readability impact: Title Case capitalizes verbs and reads "marketing-shouty"; sentence case reads conversational.

**Recommendation** — Standardize every H2 on sentence case (only first letter and proper nouns capitalized): "The semantic intelligence layer", "Built for decision velocity", "Start making smarter decisions today", "Loved by a community", "What is Insightis", "Why teams switch to Insightis". This matches the page voice and reads less marketing-shouty.

**Evidence** — WebFetch: 7 H2s on the page, 3 Title Case + 4 sentence case.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-33 — Eyebrow label lengths vary too widely (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Low |
| Area | Global / Eyebrows |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | Medium |
| Linked | related: ISS-31, ISS-57, ISS-58, ISS-59 (all eyebrow concerns) |

**Problem** — Eyebrow labels go from one word ("Features", "Architecture") to three words ("By the numbers", "Verified impact", "How it works"). Visual rhythm above the section H2 jumps from 6 chars to 14 chars and back.

**Why It Matters**
- Readability impact: eyebrows are meant to be a uniform rhythm element; varied lengths break the scan.

**Recommendation** — Trim every eyebrow to one or two words: "Architecture", "Workflow" (was How it works), "Impact" (was Verified Impact), "Numbers" (was By the numbers), "Features" (was Featured). Two-word labels max gives a consistent visual rhythm under the `.ins-label-caps` style; currently labels jump from 6 chars to 18.

**Evidence** — WebFetch eyebrow labels: Architecture / How it works / Verified Impact / By the numbers / Featured.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-34 — Right-arrow glyph used inconsistently on CTAs (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Low |
| Area | Global / CTAs |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | Medium |
| Linked | related: ISS-30, ISS-68 (CTA copy) |

**Problem** — "Start Free Trial →" carries an arrow; "Schedule a Demo", "Explore Pricing", "Get Insight" do not. Same CTA role, different visual treatment.

**Why It Matters**
- Consistency impact: arrow glyph is a forward-action signal; using it on some CTAs and not others implies a hierarchy that isn't documented.

**Recommendation** — Add the trailing arrow → to every primary CTA, or remove it from all — don't mix. Recommended: include → on primary CTAs that lead forward in a flow ("Start free trial →", "Schedule a demo →", "Explore pricing →"); omit on secondary / ghost buttons. The `.ins-btn` component should expose an `icon-after` prop so the rule is enforced by construction.

**Evidence** — WebFetch CTA labels: Start Free Trial → / Schedule a Demo / Explore Pricing / Get Insight.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Remove → from all CTAs — do not add to more; simpler CTA labels without arrows. |

---

### ISS-35 — Architecture feature list duplicated in the DOM (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | High |
| Area | Primary value pillars |
| Section (taxonomy) | Semantic Intelligence Layer |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-61 (pillar asymmetry) |

**Problem** — The 5 architecture features (Insightis · Semantic AI / Answers in Seconds / Semantic Layer / 200+ Data Connectors / No-Code Setup / Real-Time Info) appear twice on the page — once as the diagram's right-rail cards, then immediately again as a second flat list below.

**Why It Matters**
- User impact: visitor reads the same five items twice in a row — feels broken or padded.
- Readability impact: redundant scrolling wastes attention budget on the key pillar.

**Recommendation** — Render the architecture-features list exactly once. The duplication is almost certainly a leftover copy-paste from a React refactor. If a second visual treatment is genuinely intended (e.g. icon grid vs detailed cards), each variant must expose different content — otherwise mark the second copy `aria-hidden="true"` with `display: none` on mobile.

**Evidence** — WebFetch shows the 5-item feature list rendered twice back-to-back.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-36 — Button corner-radius inconsistent across roles (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Medium |
| Area | Global / Buttons |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-04 (token vocab); related: ISS-09 (radius scale) |

**Problem** — Header CTAs render as pill-rounded (full radius), the primary "Start Free Trial" appears with medium radius (~8 px), step-list "Connect" pills look smaller-radius (~6 px). Same component role, three different radii.

**Why It Matters**
- Consistency impact: three different button silhouettes on one page.
- DS impact: violates "one radius per component variant" pattern.

**Recommendation** — Buttons use exactly `--ins-radius-lg` (8 px) for default size, regardless of where they appear on the page — header, hero, step list, footer. `--ins-radius-full` (999 px) is reserved for navigation chips and pill badges. Currently visually identical buttons render with 6 px, 8 px, and 999 px radii.

**Evidence** — Screenshot + saved snapshot inline `border-radius` values.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Parent container roundness must be respected by nested interactive elements. Rounding need not be identical but should feel intentionally related — avoid sharp/mismatched corners that break the softness of the surrounding container. |

---

### ISS-37 — Connector logos sized inconsistently in the marquee (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Medium |
| Area | Connector strip |
| Section (taxonomy) | 200+ Integrations |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-18 (marquee a11y), ISS-86 (DS logo-wall gap) |

**Problem** — The connector strip mixes vendor logos at very different visual weights — Salesforce (filled blue cloud), HubSpot (small orange square), Shopify (large green bag), Stripe (purple "S"), Slack (multi-colored hash). Some fill their bounding box, others appear small / lost.

**Why It Matters**
- Readability impact: eye snaps to the brightest logo, skipping the rest.
- Enterprise UX impact: looks like a list of "logos we managed to grab" rather than a curated partnership strip.

**Recommendation** — Wrap every vendor logo in a 32 × 32 container with 6 px internal padding and a subtle `border-color: var(--ins-border-default)`. Render the mark itself as monochrome (`currentColor` at `color: var(--ins-text-body)`) so all logos carry equal visual weight. The marquee then reads as a uniform strip of icons, not a clash of brand colors fighting for attention.

**Evidence** — Screenshot connector strip + saved snapshot connector tiles.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Logos should be visually balanced within their containers. |

---

### ISS-38 — Hero chat input shows truncated / test placeholder (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Medium |
| Area | Hero |
| Section (taxonomy) | Hero chat |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-74 (no empty state), ISS-78 (chat ambiguity), ISS-85 (no DS chat component) |

**Problem** — The hero chat textbox displays placeholder copy "What's driving city" — looks cut off or like test text rather than a finished, demo-quality prompt.

**Why It Matters**
- User impact: above-the-fold copy reads as "page not finished".
- Enterprise UX impact: 5-second visual audit catches this; brand polish hit.

**Recommendation** — Replace "What's driving city" with a complete, on-message demo prompt that shows the product, e.g. `Ask anything — "Show MRR by region last quarter"`. Better: rotate through three example prompts every 4 seconds (revenue, marketing, ops) so visitors see the product's breadth without typing.

**Evidence** — Screenshot of hero chat widget.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-39 — Hero trust line packs too much into one sentence (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Low |
| Area | Hero / Trust strip |
| Section (taxonomy) | Hero / Trust strip |
| Complexity | Low |
| Confidence | Medium |
| Linked | related: ISS-46, ISS-54 (same trust-line concerns) |

**Problem** — "Built by the Devart team — the trusted data partner of 40,000+ companies worldwide for over 28 years." is rendered full-width below the hero CTA — a long parenthetical that's slow to scan above-the-fold.

**Why It Matters**
- Readability impact: visitors don't read above-the-fold sentences; they scan for signals.

**Recommendation** — Convert the single sentence into a three-pill trust strip with middle-dot separators: `<span>Built by <b>Devart</b></span> · <span><b>40,000+</b> companies</span> · <span><b>28 yrs</b> of data tooling</span>`. The line shrinks from ~110 characters to ~50 and the eye scans it in a single sweep.

**Evidence** — Screenshot + WebFetch hero subhead area.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-40 — Comparison cards have no color signal (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Medium |
| Area | Comparison / "Why us" |
| Section (taxonomy) | Why teams switch |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-66 (alpha asymmetry), ISS-84 (DS comparison gap) |

**Problem** — "Traditional Approach" and "With Insightis" cards render in the same neutral dark surface with the same border. The eye gets no visual help telling which side is the legacy pain and which is the win.

**Why It Matters**
- Readability impact: comparison's whole purpose is "win vs lose at a glance"; neutral coloring defeats it.
- User impact: 2× the time to read both sides before parsing which is recommended.

**Recommendation** — Tint the "Traditional Approach" card with a low-alpha red wash: `background: rgba(248,113,113,.06); border-color: rgba(248,113,113,.2);` heading color `#F87171`; X icons on bullets. Tint the "With Insightis" card with low-alpha teal: `background: rgba(14,196,193,.08); border-color: rgba(14,196,193,.25);` heading color `#0EC4C1`; check icons. The eye then snaps to "teal = win" in under a second.

**Evidence** — Screenshot of "Why teams switch to Insightis" comparison.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward — note that May 20 screenshot does show X / ✓ icons in red / teal, but the *card surface* itself still has no tint — symptom of ISS-40 remains. |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-41 — Step titles mix sentence and Title Case (Status: Accepted)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Low |
| Area | How it works |
| Section (taxonomy) | How it works / step list |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-32 (H2 casing), ISS-59 (eyebrow casing) |

**Problem** — Step labels are mostly sentence case ("Connect your data", "Ask in plain English", "Get instant insights", "Share with your team") but one is Title Case ("Configure the Semantic Layer").

**Why It Matters**
- Consistency impact: one outlier in a five-step sequence reads as a typo.

**Recommendation** — Standardize all five step titles on sentence case: "Connect your data", "Configure the semantic layer" (was Title Case), "Ask in plain English", "Get instant insights", "Share with your team". Keep proper nouns capitalized — Insightis, English, Slack, Teams.

**Evidence** — WebFetch step titles.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-42 — Vertical rhythm between sections looks uneven (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Medium |
| Area | Global / Sections |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-60 (How it works padding) |

**Problem** — The gaps between hero → connector strip → semantic layer → how it works → testimonials → stats → comparison → final CTA → footer don't appear to follow a single section-spacing token; some sections sit close to the previous, others have generous breathing room.

**Why It Matters**
- Readability impact: page rhythm is broken — eye expects regular cadence, gets jitter.
- Consistency impact: every new section will inherit the same per-section spacing decisions.

**Recommendation** — Apply the same vertical rhythm to every `<section>`: `padding-top: var(--ins-space-section-top-md)` (80 px) and `padding-bottom: var(--ins-space-section-bottom)` (48 px). Don't let individual sections set their own padding — the rhythm tokens in `colors_and_type.css` exist exactly so every section breathes the same.

**Evidence** — Full-page screenshot vertical rhythm.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-43 — Hero `<h1>` uses `font-family: 'Outfit'` which is never loaded (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Code |
| Severity | High |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-01 (hero h1 markup), ISS-49 (H1 size) |

**Problem** — The hero `<h1>` declares `font-family: 'Outfit', sans-serif` inline at `Homepage.html:94`. Outfit is not loaded via `@font-face` or `@import` anywhere on the page, so the heading falls through to a system sans-serif on every machine that doesn't happen to have Outfit installed locally.

**Why It Matters**
- Consistency impact: the brand heading renders in a system font on every visitor's machine.
- DS impact: violates "Geist everywhere" hard rule in `design-system/README.md` + `UX_IMPROVEMENTS.md` item #8.

**Recommendation** — Use Geist via the canonical token — either drop the inline `font-family` so it inherits `var(--ins-font-display)`, or set the heading to the `.ins-display-l` class. `UX_IMPROVEMENTS.md` item #8: Geist everywhere.

**Evidence** — `Homepage.html:94` inline style; no Outfit `@font-face` anywhere in the bundle.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-44 — Page references `--ins-font-family-*` tokens that only exist in the bundled CSS (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | depends-on: ISS-04 (token vocab); blocks: ISS-43 |

**Problem** — Inline styles call `var(--ins-font-family-sans)` and `var(--ins-font-family-mono)`. These tokens are defined inside `Homepage_files/Footer-Df_CUxIf.css` (bundled by the React build) but not inside the canonical `colors_and_type.css`. The page works only because the bundled CSS happens to load first; nothing in the source-of-truth file declares them.

**Why It Matters**
- Consistency impact: source of truth file is not self-sufficient; bundled CSS is doing hidden work.
- DS impact: any consumer that loads only `colors_and_type.css` (e.g. a new microsite) will see broken fonts.

**Recommendation** — Either rename call sites to the canonical names (`--ins-font-ui` / `--ins-font-mono`) or add legacy aliases inside `colors_and_type.css` so the canonical file is self-sufficient. One token file should be enough to render the page correctly.

**Evidence** — `grep --ins-font-family Homepage.html` → 2 distinct names; `grep` same names in `colors_and_type.css` → 0 matches.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Two font-naming conventions coexist (--ins-font-family-sans vs --ins-font-ui). Decide which is canonical and align all call sites. |

---

### ISS-45 — Non-system grays used in Tailwind arbitrary classes (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Code |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | depends-on: ISS-04 (token vocab); related: ISS-26 (inactive token misuse) |

**Problem** — The page uses `text-[#A0A0B8]` (×28), `text-[#9090C0]` (×5), `text-[#7878A8]` (×2), `text-[#7A8A9A]` (×1) — purple-leaning grays that don't exist in the DS gray scale. The DS grays are slightly teal-tinted (#A8BFC8 / #7FA0AC / #6E8D9A) and a side-by-side comparison shows a visible hue shift.

**Why It Matters**
- Consistency impact: 36 hardcoded gray hexes bypass the DS gray scale; brand hue drifts toward purple.
- DS impact: undermines the gray token system.

**Recommendation** — Map every off-system gray to its closest DS semantic role: `text-[#A0A0B8]` / `#9090C0` → `--ins-text-inactive` (#6E8D9A) or `--ins-text-body` (#A8BFC8) depending on whether it is meta / disabled or normal prose.

**Evidence** — `grep text-[#A0A0B8` → 28 hits; `#9090C0` → 5; `#7878A8` → 2; `#7A8A9A` → 1.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-46 — Hero trust sentence pushes the connector marquee below the fold on mobile (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Code |
| Severity | Medium |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-39, ISS-54 (same trust-line concerns) |

**Problem** — Below the hero CTA, the long sentence "Built by the Devart team — the trusted data partner of 40,000+ companies worldwide for over 28 years." wraps to 4 lines on <480 px screens and pushes the connector marquee out of the initial viewport. The "200+ integrations" social proof is one of the strongest trust signals; losing it above the fold weakens hero conversion.

**Why It Matters**
- User impact: above-the-fold trust signal lost on mobile.
- Scalability impact: pattern will recur on every mobile-first page that uses long trust sentences.

**Recommendation** — Split into three scannable proof points with dot separators that wrap to 2 lines maximum on mobile: "Built by Devart · 40,000+ companies · 28 yrs of data tooling". Keeps the connector marquee in view at 375 px and 414 px.

**Evidence** — Saved snapshot trust line; viewport simulation at 375 / 414 / 480 px.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-47 — `responsive.css` uses legacy 600 / 900 px breakpoints (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Code |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | — |

**Problem** — `Homepage_files/responsive.css` declares media queries at 600 px and 900 px — legacy values flagged in `UX_IMPROVEMENTS.md` item #10. The DS canonical breakpoints are 480 / 768 / 1024 / 1280. Card grids and section paddings therefore snap at the wrong viewports, most visibly in the 600–768 and 900–1024 ranges.

**Why It Matters**
- Consistency impact: breakpoint mismatch means cards reflow at unexpected viewports.
- Scalability impact: every page that loads `responsive.css` inherits the mismatch.

**Recommendation** — Rebuild `responsive.css` against the canonical stops (480 / 768 / 1024 / 1280). Once aligned, every page that loads this CSS inherits the same breakpoints — no per-page retrofit needed.

**Evidence** — `grep "@media" Homepage_files/responsive.css` → matches at 600 / 900.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-48 — `prefers-reduced-motion` not honored (Status: Accepted)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code |
| Severity | Low |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-24 (no focus-visible), ISS-73 (no loading skeletons) |

**Problem** — The hero caret blink (`animation: blink 1s step-end infinite`), the connector marquee scroll, and the KPI counter all run regardless of the visitor's `prefers-reduced-motion: reduce` setting. Vestibular-disorder users get no relief.

**Why It Matters**
- Accessibility impact: vestibular-disorder users get no relief from constant motion.

**Recommendation** — Wrap every decorative animation in `@media (prefers-reduced-motion: reduce) { ... animation: none; transform: none; }` so the page freezes to its final state for users who request it. State-communicating animations (spinners, typing dots) may keep running — they communicate live status.

**Evidence** — `grep "prefers-reduced-motion" Homepage.html / responsive.css` → 0 matches.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Baseline filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-49 — Hero H1 font-size off the type scale (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Code + Design |
| Severity | Medium |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-01, ISS-43, ISS-50 (all hero H1 concerns), ISS-55 (H2 size drift) |

**Problem** — Hero `<h1>` uses inline `font-size: clamp(2.2rem, 3.2vw, 3.6rem)` — resolves to 46.08 px at 1440 viewport. The DS publishes only 36 (h1) / 48 (display-l) / 76 (display-hero); 46.08 maps to none.

**Why It Matters**
- DS impact: off-scale heading; weakens the type scale by exception.

**Recommendation** — Use `.ins-display-hero` (76 px) at desktop, stepping to `.ins-display-l` (48) at tablet and `.ins-h1` (36) at mobile. Drop the inline `clamp()` so the heading inherits the published scale.

**Evidence** — `getComputedStyle(h1).fontSize === "46.08px"`; inline style `font-size: clamp(2.2rem, 3.2vw, 3.6rem)`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 (visual extension) |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-50 — H1 letter-spacing -.04em off scale (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Code |
| Severity | Low |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-49 |

**Problem** — Hero H1 inline `letter-spacing: -.04em`. The DS uses -.048 (display-hero), -.03 (h1), -.02 (h2), -.015 (display-l). -.04 matches none.

**Why It Matters**
- DS impact: off-scale tracking.

**Recommendation** — Inherit tracking from `.ins-display-hero` (-0.048em). Never override `letter-spacing` inline at call sites.

**Evidence** — h1 inline style `letter-spacing: -.04em`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-51 — Hero has no primary CTA below headline (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | High |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-78 (chat ambiguity), ISS-79 (competing CTAs), ISS-16 (placeholder hrefs) |

**Problem** — Hero contains H1 + sub-headline + chat widget but no standalone primary CTA. The only top-of-funnel button is a 32 px pill in the floating nav. The chat widget Send button is styled as a ghost (`rgba(255,255,255,.08)` bg) — not a primary affordance.

**Why It Matters**
- User impact: visitor lands on the page and has no obvious "what's the action" affordance above the fold.
- Enterprise UX impact: every modern SaaS hero has a primary CTA above the fold; absence reads as "page not ready".

**Recommendation** — Add one `.ins-btn--primary.ins-btn--lg` under the sub-headline ("Start free trial →" or "Try Insightis free"). Industry baseline: every modern SaaS hero has a primary CTA above the fold.

**Evidence** — Hero section button audit: zero buttons match primary CTA pattern; chat widget Send btn bg = `rgba(255,255,255,0.08)`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-52 — Chat Send button styled as ghost not primary (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Medium |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-85 (no DS chat component); related: ISS-51, ISS-76 |

**Problem** — Chat widget Send button uses `bg: rgba(255,255,255,.08)` — visually identical to a disabled state and same tier as ghost chips Connectors / Gemini Pro next to it.

**Why It Matters**
- User impact: send button reads as inactive even when ready.

**Recommendation** — Render Send with `--ins-interactive-primary` (#07807E) + white text — same teal as the "Now you can ask it" accent. Connectors / Gemini Pro stay ghost.

**Evidence** — computed bg `rgba(255,255,255,0.08)`; padding 8px 16px; radius 12px.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-53 — Chat input only 18 px tall — below 44 px target (Status: Pending Review)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code + Design |
| Severity | Medium |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-85; related: ISS-22, ISS-72 (sub-44 targets) |

**Problem** — Hero chat's typing surface is a single-line `<input>` at 18 px computed height. The card pads to 180 px but the actual hit area is the input sliver. WCAG 2.5.5 minimum is 44 × 44.

**Why It Matters**
- Accessibility impact: violates WCAG 2.5.5 Target Size.

**Recommendation** — Either swap for `<textarea>` at `min-height: 44px` + 12 px vertical padding, OR wrap the whole 180 px card in a `<label for>` so taps anywhere focus the input.

**Evidence** — `input[aria-label="Search by name or @short name"] getBoundingClientRect().height === 18`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-54 — Trust line lacks scannable proof points (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Low |
| Area | Trust / proof strip |
| Section (taxonomy) | Trust / proof strip |
| Complexity | Low |
| Confidence | Medium |
| Linked | related: ISS-39, ISS-46 |

**Problem** — Directly below the hero CTA buttons, a small trust sentence reads: *"Built by the Devart team — the trusted data partner of 40,000+ companies worldwide for over 28 years."* This is a 138-character run-on sentence that embeds three distinct credibility claims (brand provenance, customer count, years of expertise) into a single flowing paragraph with no visual breaks, no bold, and no size contrast. Visitors who scan rather than read will miss all three claims.

**Why It Matters**
- Readability impact: credibility signals in prose form are ignored by scanning visitors; the same three facts as separate visual proof points would be processed in under a second.
- Consistency impact: the token reference in the original recommendation used `--ins-text-inactive` (= disabled); the correct token for this text is `--ins-text-muted` (active lower-hierarchy caption).

**Recommendation** — Reformat as three uniform proof points using `·` separators. Keep all text the same weight — no bold/regular mix, which creates uneven scanning rhythm. Single style, `.ins-caption-md` (12 px), `--ins-text-muted`:
`✓ Built by Devart · 40,000+ companies · 28 years of data expertise`
Note: ISS-39 (declined) proposed a full pill/chip redesign — this finding targets only the text formatting and token, not the layout.

**Evidence** — Hero section, below CTA buttons — trust sentence visible in `audit-screenshots/s02-hero.png`. Text node 138 chars with no visual segmentation.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-55 — H2 sizes drift 30 / 36 / 38.4 / 48 px (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Code + Design |
| Severity | High |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-49, ISS-67 (CTA H2 size), ISS-32 (H2 casing) |

**Problem** — Eight H2s on the page render at four different computed font-sizes — 48 (×5 sections), 38.4 (clamp), 36 (Smarter Decisions), 30 (Still waiting). Four sizes for the same role on one page.

**Why It Matters**
- Consistency impact: one role, four sizes — page rhythm breaks every time the eye lands on a section title.
- DS impact: bypasses the published type scale.

**Recommendation** — One size per role. Section titles all at `.ins-display-l` (48 px); ancillary H2s drop to `.ins-h1` (36). Never 30 or 38.4. Drop inline `clamp()` overrides.

**Evidence** — Computed fontSize values across all 8 h2 elements: 48, 38.4, 48, 36, 48, 48, 48, 30.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session. Distinguish visual typography tokens from semantic HTML heading structure — framework update needed. |

---

### ISS-56 — Sub-pixel borders (0.8 px) on 240+ elements (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code + Design |
| Severity | High |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-04 (token vocab) |

**Problem** — Computed-style sweep: 240 elements with `border-top-width 0.8px`, 13 with `1.6px`. Sub-pixel widths sub-sample on 1× DPR displays — fuzzy edges on cards, buttons, dividers.

**Why It Matters**
- Readability impact: 240 fuzzy edges across the page; subtle but pervasive softness.
- Consistency impact: DS only ships 1 px and 1.5 px; everything else is a defect.

**Recommendation** — Replace 0.8 px with 1 px (`var(--ins-border-width)`); 1.6 px → 1.5 px (`--ins-border-focus-w`) or 2 px. The DS only ships 1 px and 1.5 px.

**Evidence** — `document.querySelectorAll` filter for `borderTopWidth not in [0,1,1.5,2,3,4]` → 253 hits.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-57 — Eyebrow ✦ color drifts across sections (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Code + Design |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-04; related: ISS-31 (✦ glyph), ISS-58, ISS-59 |

**Problem** — Four sections use the ✦ eyebrow. Two use `text-[var(--ins-color-teal-500)]` (#148F8D). One uses inline #09A09D (`--ins-primary-700`). Two different teals for one decorative role.

**Why It Matters**
- Consistency impact: same element renders in two near-identical-but-not-equal teals.

**Recommendation** — One token: `--ins-primary-400` (#0EC4C1, brand accent). Replace inline hex #09A09D with the token. ISS-31 recommends replacing the ✦ with a Lucide star SVG — that fix also resolves this.

**Evidence** — Eyebrow computed colors: `rgb(20,143,141)` ×3, `rgb(9,160,157)` ×1.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-58 — Only 4 of 8 sections open with an eyebrow (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | Medium |
| Linked | related: ISS-31, ISS-57, ISS-59, ISS-33 |

**Problem** — Sections with eyebrow: Architecture, How it works, Verified Impact, By the numbers. Sections without: Decision Velocity, Final CTA banner, Why teams switch, Still waiting bottom CTA. No apparent rule for which gets one.

**Why It Matters**
- Consistency impact: half-coverage looks accidental rather than intentional.
- Scalability impact: every new section needs an undocumented "eyebrow yes / no" decision.

**Recommendation** — Decide once: every section title gets a 1–3 word eyebrow OR none does. Half-coverage reads as inconsistent rather than intentional.

**Evidence** — `innerText.split("✦").length === 5` (4 eyebrows on 8 sections).

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Banners and hero do not require eyebrows; content sections should have them. |

---

### ISS-59 — Eyebrow capitalisation drift (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Low |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-32, ISS-41 (case drift) |

**Problem** — Eyebrow strings on the page: "Architecture", "How it works", "Verified Impact", "By the numbers". Two sentence case, two Title Case.

**Why It Matters**
- Consistency impact: case rule for eyebrows is undocumented and inconsistently applied.

**Recommendation** — Pick one. Recommended: all-caps tracked (`.ins-label-caps` — 11 px, +.1em letter-spacing, uppercase) for the whole program. The eyebrow acts as a tracked label, eliminating per-eyebrow case decisions.

**Evidence** — Eyebrow strings — case audit.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-60 — "How it works" section padding 100 / 100 px is off the token scale (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Code |
| Severity | Medium |
| Area | How it works |
| Section (taxonomy) | How it works / step list |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-04; related: ISS-42, ISS-08 (spacing) |

**Problem** — "How it works" section has `padding-top: 100px` and `padding-bottom: 100px`. The DS spacing scale jumps 80 (5xl) → 96 (6xl); 100 is on the 4 px grid but not on the token scale. Surrounding sections use 96.

**Why It Matters**
- Consistency impact: one section is 4 px deeper than every other — eye notices the cadence break.

**Recommendation** — Use `--ins-space-section-top-md` (80) + `--ins-space-section-bottom` (48), per ISS-42. If more breathing room is needed escalate to `--ins-space-section-top-lg` (96) — never 100.

**Evidence** — `getComputedStyle(sections[2]).padding === "100px 0px"`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-61 — Pillar feature counts asymmetric (5 vs 4) (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Low |
| Area | Primary value pillars |
| Section (taxonomy) | Primary value pillar(s) |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-82 (pillars don't scale), ISS-88 (pillars not parallel), ISS-35 (pillar duplicated) |

**Problem** — Architecture (Semantic Intelligence Layer) lists 5 supporting bullets; Decision Velocity lists 4. Right-side column heights mismatch between the two pillar sections.

**Why It Matters**
- Consistency impact: asymmetric lists break visual balance between paired pillars.

**Recommendation** — Both pillars list the same number of bullets — 4 is the right floor for mobile readability. Keep parallel structure so the page reads as one rhythm.

**Evidence** — Pillar section 1 `ul li` × 5; pillar section 2 `ul li` × 4.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-62 — Dashboard mock icons drift 12–18 px (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Low |
| Area | Primary value pillars |
| Section (taxonomy) | Primary value pillar(s) |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-20 (stroke widths), ISS-07 (mock fonts) |

**Problem** — SVGs inside the hero and Decision Velocity mocks render at 12, 14, 16, 18 px widths in the same row of mock UI.

**Why It Matters**
- Consistency impact: icon visual weight randomized within a single UI row.

**Recommendation** — Three sizes only: 12 (caption), 16 (UI default), 20 (prominent). Pin each mock SVG to one of these.

**Evidence** — Hero / Decision Velocity SVG widths: 12, 14, 16, 18 (4 sizes, same UI context).

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-63 — Testimonial cards fixed 207 px height (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Medium |
| Area | Social proof / testimonials |
| Section (taxonomy) | Social proof / testimonials |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-83 (testimonial scalability), ISS-10, ISS-64 |

**Problem** — All six testimonial cards measure exactly 400 × 207 px with padding 24, radius 16. Quote bodies vary from ~14 words to ~32 words — short cards have empty bottom-half, long cards crowd the chip.

**Why It Matters**
- Readability impact: short quotes float in empty space; long quotes feel crowded.
- Consistency impact: fixed heights only work when content lengths are bounded; quotes are not.

**Recommendation** — Set `min-height: 200px; height: auto` so the card auto-fits; OR normalise quote copy to 18–24 words. Fixed heights only work when content lengths are bounded.

**Evidence** — All 6 cards `getBoundingClientRect`: `{w:400, h:207}`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-64 — No hover affordance on testimonial cards (Status: Pending Review)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Medium |
| Area | Social proof / testimonials |
| Section (taxonomy) | Social proof / testimonials |
| Complexity | Low |
| Confidence | Medium |
| Linked | related: ISS-63 |

**Problem** — Hovering a testimonial card produces no border-color shift, no shadow, no scale. Cards read as static blocks — no signal whether they're clickable.

**Why It Matters**
- User impact: unclear whether testimonials are link to case studies or just decorative.
- DS impact: card hover state inconsistent across the page.

**Recommendation** — Confirm cards are not interactive (and remove subtle hover); OR add DS hover: `border-color var(--ins-border-hover)` (`rgba(255,255,255,.12)`) + `--ins-shadow-md`, 150 ms ease.

**Evidence** — computed border / box-shadow unchanged on `:hover`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-65 — KPI numbers weight 500 vs DS prescribed 700 (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Code + Design |
| Severity | Medium |
| Area | KPI / numbers strip |
| Section (taxonomy) | KPI / numbers strip |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-04; related: ISS-02 (KPI counter zero) |

**Problem** — "What is Insightis" KPI strip renders 10x / 80 % / 1,200+ / 99.9 % at 48 px Geist `font-weight: 500` (font-medium). DS `.ins-stat-kpi__value` component prescribes `font-weight: 700` (bold) at the same 48 px size.

**Why It Matters**
- Readability impact: bold vs medium at 48 px is a significant visual weight difference — "this number matters" signal lost.
- DS impact: violates documented component spec.

**Recommendation** — Use `.ins-stat-kpi__value` (font-weight 700; 48 px desktop / 36 mobile). The visual difference between 500 and 700 at 48 px is significant — bold reads "this number matters".

**Evidence** — `design-system/assets/components.css:683` → `.ins-stat-kpi__value font-weight 700`; rendered font-weight 500.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-66 — Comparison borders asymmetric (red 0.2α / teal 0.4α) (Status: Accepted)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Low |
| Area | Comparison / "Why us" |
| Section (taxonomy) | Comparison / "Why us" |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-40, ISS-84 |

**Problem** — "Traditional Approach" card uses `rgba(248,113,113,0.2)` — red, low alpha. "With Insightis" card uses `rgba(7,128,126,0.4)` — teal, double alpha. Win-side border reads twice as strong as pain-side.

**Why It Matters**
- Consistency impact: asymmetry isn't documented as intentional emphasis — reads as accidental.

**Recommendation** — Pick one alpha for both ("equal weight"): 0.25 each; OR document a deliberate +0.15 brightness rule for win. The current asymmetry isn't a rule — it's a slip.

**Evidence** — Comparison card 1 border `rgba(248,113,113,0.2)`; card 2 border `rgba(7,128,126,0.4)`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-67 — Final CTA H2 sized 30 px — breaks rhythm (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Code + Design |
| Severity | Medium |
| Area | Final CTA |
| Section (taxonomy) | Final CTA |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-55 (H2 size drift), ISS-70 (final CTA layout) |

**Problem** — Bottom-page CTA ("Still waiting on insights that take days?") renders H2 at 30 px (text-3xl) — the smallest H2 on the page. Surrounding H2s are 48 px; this is ~60 % as large.

**Why It Matters**
- User impact: final CTA reads as a footer subtitle rather than the closing pitch.
- Readability impact: closing CTAs need maximum visual weight, not minimum.

**Recommendation** — Match section-title rhythm at `.ins-display-l` (48 px). At 30 px the headline reads as a footer subtitle, not a closing CTA. A final CTA must be at least as prominent as upstream H2s.

**Evidence** — final-cta h2 computed font-size 30 px; other section h2s 48 px.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-68 — "Get Insight" reads as a fragment (Status: Declined — duplicate of ISS-30)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Low |
| Area | Final CTA |
| Section (taxonomy) | Final CTA |
| Complexity | Low |
| Confidence | High |
| Linked | duplicate-of: ISS-30 (kept as separate ID — both refer to same fragment but ISS-30 is on the *footer/final* CTA and ISS-68 is iteration-2's re-filing of the same problem at the bottom CTA. Surface separately so a single fix closes both.) |

**Problem** — Final CTA button text is "Get Insight" — a noun without verb or article. Reads as a navigation label, not an action.

**Why It Matters**
- User impact: CTA copy reads as a brand name rather than an action.

**Recommendation** — Verb + object: "Get insights →" (plural, sentence case), or "Try Insightis free →" matching the nav. Final CTAs lead with an action verb.

**Evidence** — Final CTA button `textContent === "Get Insight"`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing — kept as separate ID for surface-level visibility |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Declined | Duplicate of ISS-30 — merged. Same CTA copy issue on the final section button. |

---

### ISS-69 — Double-spaces visible in H2 source (Status: Accepted)

| | |
|---|---|
| Category | UX |
| Domain | Code |
| Severity | Low |
| Area | Final CTA |
| Section (taxonomy) | Final CTA |
| Complexity | Low |
| Confidence | High |
| Linked | — |

**Problem** — Final CTA H2 source: `Still waiting on <span> insights</span> that take <span> days?</span>` — leading spaces inside the spans render a wider gap than a single space.

**Why It Matters**
- Readability impact: visible "double-space" between words on the most prominent closing CTA.

**Recommendation** — Move the space outside the span: `Still waiting on <span>insights</span> that take <span>days</span>?` — the gap collapses to clean single spaces.

**Evidence** — H2 `outerHTML` contains `<span style="color:rgba(7, 128, 126)"> insights</span>`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-70 — Final CTA laid out horizontally (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Low |
| Area | Final CTA |
| Section (taxonomy) | Final CTA |
| Complexity | Low |
| Confidence | Medium |
| Linked | related: ISS-67 (CTA size) |

**Problem** — The bottom CTA places the H2 and "Get Insight" button inline on the same row, left / right-aligned. Standard closing-CTA pattern is centred and stacked.

**Why It Matters**
- User impact: closing CTA emphasis is diluted by horizontal layout.

**Recommendation** — Stack vertically: centred H2 at `.ins-display-l` over a centred primary button. The closing CTA is high-conversion real estate — emphasise it with stacked centred composition.

**Evidence** — Final CTA flex direction row; `h2.flex-shrink-0`; button `m-1` inline.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-71 — Footer columns end on different rows (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Design |
| Severity | Low |
| Area | Footer |
| Section (taxonomy) | Footer |
| Complexity | Low |
| Confidence | High |
| Linked | — |

**Problem** — Footer column item counts: Platform 4, Solutions 6, Resources 6, Company 4, Legal 4. All columns top-align so the bottoms are staggered by up to two rows.

**Why It Matters**
- Readability impact: ragged column bottoms read as accidental.
- Scalability impact: every column will grow at different rates; without a balancing rule, the stagger increases.

**Recommendation** — Balance column lengths (move one Solutions item to Resources, etc.) so every column lands at 4–5 items, OR explicitly align each column's last item to a shared baseline.

**Evidence** — Footer column item counts 4/6/6/4/4.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-72 — Mobile hamburger 40 × 40 — below 44 target (Status: Accepted)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code + Design |
| Severity | Medium |
| Area | Header / Nav |
| Section (taxonomy) | Header / Nav |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-22, ISS-53 (other sub-44 targets) |

**Problem** — At 375 px viewport the mobile menu trigger renders 40 × 40 (`p-2` × 24 px icon). WCAG 2.5.5 minimum is 44 × 44.

**Why It Matters**
- Accessibility impact: violates WCAG 2.5.5 Target Size on the entry point to mobile navigation.

**Recommendation** — `p-2` → `p-2.5` (10 × 24 = 44) or `p-3` (12 × 24 = 48). The DS `.ins-btn--icon` spec ships 44 × 44 default; use that instead of inline-padded `<button>`.

**Evidence** — `getBoundingClientRect` on `button[aria-label="Open menu"]` at 375 viewport = `{w:40, h:40}`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Use .ins-btn--icon component (44×44 default). |

---

### ISS-73 — No loading skeletons defined anywhere (Status: Pending Review)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-02 (KPI counter), ISS-74, ISS-75 (state coverage gaps), ISS-48 (reduced-motion) |

**Problem** — Three surfaces need a loading state: hero chat widget (after Send), KPI counter strip (animates from 0), Decision Velocity dashboard mock. None render a skeleton; KPI strip even animates from 0 (baseline ISS-02).

**Why It Matters**
- User impact: pages "flash" between initial render and animated values; perceived performance suffers.
- DS impact: loading-state vocabulary is incomplete across the page.

**Recommendation** — Define one DS skeleton (shimmer-bg pulsing, `--ins-shadow-xs`, radius matches host) and apply on chat widget response, KPI initial render, async surfaces. Shimmer animation must respect `prefers-reduced-motion`.

**Evidence** — No `.ins-skeleton` class or shimmer keyframe applied to chat / KPI / mock surfaces.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-74 — No empty-state visual for chat widget (Status: Pending Review)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Low |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Medium |
| Confidence | Medium |
| Linked | depends-on: ISS-85; related: ISS-38, ISS-78 |

**Problem** — Hero chat input cycles through example placeholders ("Why did our…", "What's driving city…") via animation. No suggestion chips, no zero-state illustration, no focus-state border-glow.

**Why It Matters**
- User impact: empty state is passive (rotating placeholder) rather than guided (clickable suggestions).
- DS impact: empty-state pattern incomplete for the homepage's most prominent input.

**Recommendation** — Render 2–3 suggestion chips below the input ("Show MRR by region last quarter", "Which campaigns drove signups last week?") that pre-fill on click. Empty state = guided next-action; rotating placeholders are too passive.

**Evidence** — Hero chat widget — no suggestion chips, no zero-state illustration, no focus glow defined.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |

---

### ISS-75 — No error-state pattern defined for inputs (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Low |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-23 (no labels) |

**Problem** — Four `<input>` elements on the page (hero chat, two metric-config mocks, search). None has `.is-error` / `--ins-border-error` / helper-text slot. DS publishes `--ins-border-error` #F87171 but homepage never instantiates it.

**Why It Matters**
- DS impact: error-state pattern published but never demonstrated on the highest-traffic page.

**Recommendation** — Define `.ins-input.is-error` + `<p class="ins-helper ins-helper--error">` at DS level; demo on at least one mock surface so the page anchors a complete state matrix.

**Evidence** — 4 input elements, 0 with `.is-error` or `--ins-border-error` applied.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-76 — No disabled-state demo for Send button (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Low |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | depends-on: ISS-85; related: ISS-52, ISS-78 |

**Problem** — Chat widget Send button is visually identical regardless of input state — `rgba(255,255,255,.08)` on empty input AND on filled input. No transition between disabled / enabled.

**Why It Matters**
- User impact: no feedback that typing has armed the action.

**Recommendation** — Send disabled (opacity:.4, cursor:not-allowed, `--ins-text-inactive`) while input empty; escalate to filled teal (`--ins-interactive-primary` + white) the moment the user types. 150 ms transition.

**Evidence** — Send button bg `rgba(255,255,255,0.08)` unchanged across empty / filled input states.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Use DS button states: passive/inactive (empty input) → active/teal (input filled). Not disabled → enabled; rather inactive → active. Apply .ins-btn state matrix. |

---

### ISS-77 — No visible focus ring on any nav element (Status: Accepted)

| | |
|---|---|
| Category | Accessibility |
| Domain | Code + Design |
| Severity | Medium |
| Area | Header / Nav |
| Section (taxonomy) | Header / Nav |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-24 (global focus-visible), ISS-17 (nav affordance), ISS-72 (mobile target size) |

**Problem** — Tabbing through nav (Platform / Solutions / Resources / Pricing / Sign In / Start for Free) produces no visible focus ring. Computed `outline:none 0px` on each. Keyboard-only users can't see where they are.

**Why It Matters**
- Accessibility impact: nav is the entry point; failing focus rings here blocks every downstream keyboard journey.

**Recommendation** — Apply DS focus-ring globally via `:focus-visible` — `outline 1.5px solid var(--ins-border-focus)` + `box-shadow 0 0 0 3px rgba(9,160,157,.2)`. The DS already publishes `--ins-border-focus-w` 1.5 px and `--ins-border-focus`.

**Evidence** — `getComputedStyle(navButton).outline === "none 0px"`; no `:focus-visible` rule in stylesheets.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-19 | Pending Review | Iteration 2 filing |
| 2026-05-20 | Pending Review | Carried forward |
| 2026-05-20 | Accepted | Apply DS :focus-visible pattern per ISS-24 — outline 1.5px solid var(--ins-border-focus) + box-shadow ring. |

---

## Iteration 3 — net-new findings (ISS-78 → ISS-89)

> All twelve are filed at `Status: Pending Review` and apply the new framework's lens vocabulary (UI / UX / DS / Accessibility / Scalability) alongside the rubric's domain split. None modify any existing ISS-NN; none silently address an Accepted decision (there are no Accepted decisions yet — by user choice, all 76 prior findings start as Pending Review).

---

### ISS-78 — Hero chat widget conflates demo and primary CTA — interactive-vs-illustrative ambiguity (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | High |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | High |
| Confidence | High |
| Linked | blocks: ISS-38, ISS-52, ISS-74, ISS-76 (all hero chat-widget symptom findings); related: ISS-51, ISS-79, ISS-85 |

**Problem** — The hero chat widget visually promises interactivity — cycling placeholder copy ("Why did our|" with blinking caret), input field, Send button, Connectors / Gemini Pro selectors. A first-time visitor reads this as the primary CTA (type a question, get an answer). In reality, the page is a marketing landing and the chat widget almost certainly does not return real product responses — clicking Send either does nothing or navigates to signup. The page never resolves the ambiguity: is this a live demo, a static illustration, or a CTA in disguise?

**Why It Matters**
- User impact: above-the-fold mental-model whiplash on the most prominent hero element.
- Cognitive load: visitor wastes attention deciding whether to type vs sign up vs scroll.
- Workflow clarity: the action the page wants the visitor to take is undefined.
- Enterprise UX impact: enterprise evaluators flagging this as "demo-bait" lose trust in subsequent claims.
- Scalability impact: if the chat widget is the visual centerpiece of the homepage, every product page (AI Chat, Platform) inherits the same ambiguity unless resolved at pattern level.

**Recommendation** — Pick one of three explicit framings and commit to it visually:
1. **Live demo** — the chat widget actually returns AI-generated answers against a sandbox dataset. Requires backend work; if you ship this, add a "Try a sample question" guided onboarding so visitors don't dead-end on empty input. Pair the Send action with a primary CTA above the fold ("Get full access →") so the demo doesn't compete with signup.
2. **Static illustration** — render the chat as an obviously-non-interactive screenshot frame (lower opacity input, no caret, no Send hover). Add a "Try Insightis →" primary CTA below the illustration as the unambiguous action. The illustration *shows* the product; the CTA *converts*.
3. **Embedded signup proxy** — type-to-signup pattern. Whatever the visitor types becomes the first message in their workspace post-signup. This requires clear copy: "Ask anything — we'll save it to your free workspace". Highest commitment, highest risk if poorly implemented.

Until this is decided, the chat-widget-state findings (ISS-52 / ISS-53 / ISS-74 / ISS-76) cannot be cleanly fixed.

**Evidence** — `audit-screenshots/full-desktop-trimmed.png` (hero chat widget at 1440), `audit-screenshots/s02-hero.png`, `audit-screenshots/s02-hero-no-cta-current.png`, `audit-screenshots/s02-hero-send-button-current.png`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: UX mental model) |

---

### ISS-79 — Two competing primary actions in the hero region (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Medium |
| Area | Hero |
| Section (taxonomy) | Header / Hero |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-51, ISS-78, ISS-87 |

**Problem** — Two visually-prominent actions occupy the hero region simultaneously: the floating top-nav "Start for Free" teal pill (always visible, ~32 px tall, top right) and the hero chat widget (~400 px tall, center-screen). They compete for the visitor's first action. A visitor doesn't know whether to sign up first, ask a question first, or scroll. Neither path is reinforced by the other.

**Why It Matters**
- User impact: decision paralysis — visitors freeze on a two-path choice with no implied default.
- Cognitive load: top-of-page should have one dominant action, not two equally-treated ones.
- Scalability impact: every page that uses the floating nav inherits this competition with whatever hero content it has.
- Enterprise UX impact: conversion analytics on this hero region will show both paths splitting traffic; neither will hit baseline rates.

**Recommendation** — Establish hierarchy. Three viable patterns:
1. **Nav CTA dominant** — chat widget becomes a static illustration (per ISS-78 option 2); "Start for Free" is the unambiguous primary action.
2. **Chat dominant** — nav CTA changes copy from "Start for Free" to "Sign In" (secondary action), removing competition. Add a hero-section primary "Try Insightis →" below the chat (ISS-51).
3. **Sequential** — nav CTA disappears on scroll until the visitor passes the comparison section; reappears as a sticky bar with stronger emphasis. Requires scroll-based JS but resolves the competition by time-shifting it.

The choice depends on what conversion event matters most — and that choice is a product decision, not a design fix.

**Evidence** — `audit-screenshots/full-desktop-trimmed.png` (both elements visible in initial viewport), `audit-screenshots/s01-nav.png`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: UX mental model) |

---

### ISS-80 — Nine-section page has no in-page navigation (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | Medium |
| Linked | related: ISS-87 (section ordering), ISS-89 (jargon) |

**Problem** — The homepage has nine content sections (Hero, Connectors, Semantic Layer, Decision Velocity, How it works, Testimonials, KPI, Comparison, Final CTA) plus a footer — total scroll height ~5500 px desktop, ~9200 px mobile. There is no in-page navigation: no jump-link anchors, no sticky in-page nav, no "skip to comparison" affordance. A returning visitor or a mid-funnel evaluator who already knows what AI / BI is must scroll past 3–5 sections to reach the comparison or pricing pitch.

**Why It Matters**
- User impact: mid-funnel readers (already-interested, validating against alternatives) waste 30–60 s scrolling.
- Cognitive load: forced linear consumption of a page whose audience varies in maturity.
- Accessibility impact: keyboard-only and AT users have no quick path to specific content.
- Scalability impact: every new section makes this worse; at 12+ sections (likely as the product expands) the page becomes unscannable.
- Enterprise UX impact: enterprise procurement reviewers want comparison and pricing fast — making them scroll past everything else signals "we don't respect your time".

**Recommendation** — Add a sticky in-page anchor nav that appears once the visitor scrolls past the hero — a thin row of links: `Architecture · How it works · Pricing · Comparison · Get started`. Renders via `position: sticky; top: 64px;`, hides on mobile, uses the existing DS `.ins-nav` styling. Anchors link to `#section-id` per `<section id="…">` on each major block. Pattern is already covered conceptually by `design-system/components/scroll-spy-toc.html` — repurpose it as a horizontal sticky variant for marketing pages.

**Evidence** — `audit-screenshots/full-desktop.png` (full-page scroll), `audit-screenshots/full-mobile.png` (9200 px mobile scroll height).

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: UX scalability) |

---

### ISS-81 — Hero subheadline packs three claims into one ungrammatical fragment (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Medium |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-28 (claim conflicts), ISS-89 (jargon) |

**Problem** — Hero subheadline reads: "Insightis connects your real data and delivers answers 3x more accurate with AI Semantic Layer". Three claims compressed into one sentence (1: connects real data, 2: 3x more accurate, 3: AI semantic layer). Grammar: missing article ("with **the** AI Semantic Layer" or "with **an** AI Semantic Layer"). The sentence ends mid-thought because "AI Semantic Layer" is treated as a proper noun without clarification.

**Why It Matters**
- User impact: visitor parses three abstract claims before understanding the product.
- Readability impact: above-the-fold copy must be scannable; this one isn't.
- Cognitive load: requires the visitor to already know what "AI Semantic Layer" means (see ISS-89).
- Consistency impact: the brand voice elsewhere is concise; this is the outlier.

**Recommendation** — Rewrite as two distinct lines:
- Subheadline (8–12 words, the value): "Ask questions in plain English. Get answers 3× more accurate than spreadsheets."
- Caption (smaller, the differentiator): "Powered by the Insightis Semantic Layer — your data dictionary, unified."

The two-line pattern matches modern SaaS landing-page conventions, separates *value* from *mechanism*, and defines "Semantic Layer" inline rather than assuming familiarity. The mechanism caption is also a natural jumping-off point for the Architecture pillar below.

**Evidence** — `audit-screenshots/s02-hero.png`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: UX content) |

---

### ISS-82 — Pillar pattern doesn't scale past two pillars (Status: Pending Review)

| | |
|---|---|
| Category | Scalability |
| Domain | Design |
| Severity | Medium |
| Area | Primary value pillars |
| Section (taxonomy) | Primary value pillar(s) |
| Complexity | High |
| Confidence | Medium |
| Linked | related: ISS-61 (pillar asymmetry), ISS-88 (pillar framing), ISS-35 (pillar duplication) |

**Problem** — The Homepage's "Primary value pillars" pattern currently shows two full-section pillars: Semantic Intelligence Layer (~700 px desktop) and Decision Velocity (~700 px desktop). Each consumes a viewport. As the product expands (likely adding "Insightful Workflow Automation", "Real-Time Decisioning", or vertical-specific pillars), a third pillar would push the page over 4000 px desktop *just for pillars*, before testimonials / KPI / comparison. The DS does not publish a "compact pillar grid" or "3-up pillar" pattern; `design-system/patterns/feature-grid.html` is the closest but doesn't carry the visual weight pillars need.

**Why It Matters**
- Scalability impact: the page architecture caps at N=2 pillars; product growth will force a rework.
- DS impact: pillar pattern doesn't exist in the DS pattern library — every page implements it ad-hoc.
- Consistency impact: future pages (Platform, Solutions) will likely re-implement variants, leading to drift.

**Recommendation** — File as a DS pattern gap. The DS needs `design-system/patterns/value-pillars.html` covering at least three variants:
- **Single dominant pillar** — full hero+section treatment, max 1 per page.
- **Two-pillar paired** — current pattern; both pillars treated equally, paired sections.
- **Three-up compact pillars** — grid of 3 cards with icon + 3-bullet feature list each, fits in one viewport. Substitutes pages with N > 2 pillars.

Defer the visual design to the DS team; this Homepage stays on the current two-pillar layout until a third pillar is needed, at which point swap to the compact variant.

**Evidence** — `audit-screenshots/s04-pillar-architecture.png` (~700 px), `audit-screenshots/s04-pillar-decision-velocity.png` (~700 px).

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: scalability + DS maturity) |

---

### ISS-83 — Testimonial 6-card fixed grid doesn't scale to 12+ entries (Status: Pending Review)

| | |
|---|---|
| Category | Scalability |
| Domain | Design |
| Severity | Low |
| Area | Social proof / testimonials |
| Section (taxonomy) | Social proof / testimonials |
| Complexity | Medium |
| Confidence | Medium |
| Linked | related: ISS-63 (card height), ISS-10 (stock avatars), ISS-64 (no hover) |

**Problem** — The testimonial section uses a fixed 6-card grid (3 × 2 on desktop, 1 × 6 stack on mobile). As Insightis accumulates customers, this pattern caps at 6 visible testimonials. There is no "see more", carousel, or pagination — adding a 7th testimonial requires either replacing one of the existing six or restructuring the section. The DS publishes `design-system/components/marquee.html` but not a testimonial-carousel pattern.

**Why It Matters**
- Scalability impact: at N=12 testimonials, the section must be restructured.
- DS impact: pattern gap — no testimonial-carousel / "see more" variant.
- Product impact: limits the social-proof surface area as the product wins more customers.

**Recommendation** — Add a DS pattern `design-system/patterns/testimonial-carousel.html` covering:
- **Static 6-card grid** — current pattern, max 6.
- **Marquee variant** — auto-scrolls 8–24 testimonials horizontally, pauses on hover. Same card design, different container.
- **Paginated grid** — 6 visible, "Show more" reveals next 6.

For the immediate Homepage, the static grid is fine; this finding marks the future ceiling.

**Evidence** — `audit-screenshots/s06-testimonials.png`, `audit-screenshots/s07-testimonials-fixed-height-current.png`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: scalability) |

---

### ISS-84 — No DS pattern for N-column comparison (Status: Pending Review)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Medium |
| Area | Comparison / "Why us" |
| Section (taxonomy) | Comparison / "Why us" |
| Complexity | High |
| Confidence | High |
| Linked | related: ISS-40 (no color signal), ISS-66 (alpha asymmetry) |

**Problem** — The Homepage's "Why teams switch to Insightis" section uses a hardcoded 2-column comparison (Traditional Approach vs With Insightis). The DS file `design-system/components/comparison-grid.html` documents the layout structure but does not publish:
- color-signal pattern (red-tint pain side vs teal-tint win side — see ISS-40)
- N-column scaling rule (what happens at 3 columns: "us vs Tableau vs PowerBI"?)
- row-grouping primitive (compare across categories: "ease of use / pricing / time to value")
- mobile reflow strategy (do columns stack or carousel?)

Every comparison the program ships (Homepage, Pricing, Platform comparison page, Solutions / vs competitors page) will improvise its own conventions.

**Why It Matters**
- DS impact: comparison is a core marketing pattern; absence forces every page to reimplement it.
- Scalability impact: N > 2 comparison breaks current layout.
- Consistency impact: ISS-40 and ISS-66 are symptoms of the missing pattern.

**Recommendation** — File as DS pattern enhancement. Spec sheet for `design-system/components/comparison-grid.html` v2 should cover:
- 2-, 3-, 4-column variants
- color-signal tokens: `--ins-compare-pain-tint`, `--ins-compare-win-tint`, `--ins-compare-neutral-tint`
- row-grouping with category headers (`.ins-compare-row-group`)
- mobile reflow: 2-col stays side-by-side at 480+, stacks below; 3+ col scrolls horizontally with snap

Move ISS-40 and ISS-66 to `depends-on: ISS-84` once accepted.

**Evidence** — `audit-screenshots/s08-comparison.png`, `audit-screenshots/full-desktop.png` (comparison region).

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: DS maturity) |

---

### ISS-85 — Chat-input component has no DS equivalent (Status: Pending Review)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | High |
| Area | Hero |
| Section (taxonomy) | Hero |
| Complexity | High |
| Confidence | High |
| Linked | blocks: ISS-52, ISS-53, ISS-74, ISS-76 (all chat-state symptoms); related: ISS-78 |

**Problem** — The Homepage's hero chat widget — input field + Send button + Connectors / Gemini Pro selectors — is a custom one-off implementation. `design-system/components/` includes `chat-bubble.html` (for displaying messages) but not a `chat-input` component covering the typing surface, model selector, attachment button, and send action. Four separate findings (ISS-52 Send tier, ISS-53 input height, ISS-74 empty state, ISS-76 disabled state) are all symptoms of the missing DS component. Future product pages (AI Chat, Platform) will re-implement variants of this same widget — and the variants will drift.

**Why It Matters**
- DS impact: a marquee product element exists outside the DS.
- Scalability impact: every page that uses chat-input will improvise; drift is guaranteed.
- Consistency impact: ISS-52, ISS-53, ISS-74, ISS-76 cannot be fixed cleanly at page level without the DS component to anchor against.
- Enterprise UX impact: a chat widget is the most-recognizable AI-product affordance; quality here disproportionately drives brand perception.

**Recommendation** — File as DS component addition. Spec `design-system/components/chat-input.html` to cover:
- input field (textarea, min 44 px hit area, auto-grows up to 6 lines)
- send button (primary teal when input non-empty, disabled state when empty)
- left utility row (attachment icon, connectors selector)
- right utility row (model selector, send button)
- suggestion chips slot (under input, for empty-state guided prompts)
- focus / hover / disabled / loading / error states all documented

This is a multi-week DS effort — move to `Backlog (DS roadmap)`. Once it lands, ISS-52 / ISS-53 / ISS-74 / ISS-76 collapse into a single migration PR.

**Evidence** — `audit-screenshots/s02-hero.png` (full chat widget), `audit-screenshots/s02-hero-send-button-current.png`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: DS maturity) |

---

### ISS-86 — Connector marquee has no DS logo-wall variant (Status: Pending Review)

| | |
|---|---|
| Category | DS |
| Domain | Design |
| Severity | Medium |
| Area | Trust / proof strip |
| Section (taxonomy) | Trust / proof strip |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-37 (logo sizing), ISS-18 (marquee a11y), ISS-19 (emoji icons) |

**Problem** — The connector strip (200+ Integrations) renders vendor logos as a horizontal marquee. The DS publishes `design-system/components/marquee.html` for general auto-scroll but does not publish a `logo-wall` or `logo-marquee` variant with: 32 × 32 monochrome tile, `currentColor` mark, equal visual weight, brand-color reveal on hover. ISS-37 (logos rendered at wildly different visual weights) is a direct symptom of the missing pattern.

**Why It Matters**
- DS impact: logo-wall is a core marketing pattern; absence forces every page to improvise.
- Scalability impact: Roadmap, About, Platform pages will all need a logo strip; without a shared pattern they drift.
- Consistency impact: ISS-37 cannot be cleanly fixed at page level without a DS pattern to anchor against.

**Recommendation** — Add `design-system/patterns/logo-wall.html` covering:
- **Static grid** — 6–10 logos in a 2-row grid, equal sizes.
- **Marquee variant** — auto-scrolls 15+ logos horizontally, pauses on hover, `aria-hidden` on the duplicate track (resolves ISS-18).
- **Tile spec** — 32 × 32 px container, 6 px internal padding, `border: 1px solid var(--ins-border-default)`, `color: var(--ins-text-body)` (monochrome via `currentColor`).
- **Hover** — reveals brand color (optional) and 1.05× scale.

Move ISS-37 and ISS-18 to `depends-on: ISS-86` once accepted.

**Evidence** — `audit-screenshots/full-desktop-trimmed.png` (connector strip region), `audit-screenshots/s03-trust-strip.png`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: DS maturity) |

---

### ISS-87 — Section ordering delays social proof to position 6 of 10 (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | High |
| Confidence | Medium |
| Linked | related: ISS-80, ISS-88, ISS-89 |

**Problem** — Current Homepage section order is: 1. Hero · 2. Connectors · 3. Semantic Intelligence Layer · 4. Decision Velocity · 5. "Start Making Smarter Decisions Today" banner · 6. Testimonials ("Loved by a community") · 7. KPI strip · 8. Comparison ("Why teams switch") · 9. Final CTA · 10. Footer. Social proof (testimonials, KPI) appears in positions 6–7, after two architecture-heavy pillar sections. Modern SaaS landing pages put social proof above the fold or immediately after the hero (positions 2–3), because trust precedes feature comprehension for cold visitors.

**Why It Matters**
- User impact: cold visitors spend 4 sections on architecture before any "other people use this" signal.
- Cognitive load: architecture-first ordering assumes the visitor already wants the product.
- Scalability impact: section-order rule isn't documented; future pages will reinvent ordering arbitrarily.
- Enterprise UX impact: enterprise procurement validates social proof early; current ordering delays it.

**Recommendation** — Re-order to: 1. Hero · 2. Connectors *(trust signal — keep)* · 3. **Testimonials** *(move up)* · 4. **KPI strip** *(move up)* · 5. Semantic Intelligence Layer · 6. Decision Velocity · 7. "Start Making Smarter Decisions" mid-page banner · 8. How it works · 9. Comparison · 10. Final CTA · 11. Footer.

Front-loading social proof: testimonials right after the hero, KPI as a bridge to architecture. The architecture pillars then carry conviction because the visitor has already seen "people use this, with results". This is a *product* decision, not a *visual* fix — mark as `Discuss` if the team wants a design crit before implementation.

**Evidence** — `audit-screenshots/full-desktop.png` (full-page scroll, section sequence visible).

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: product structure) |

---

### ISS-88 — Two-pillar framing is non-parallel ("Architecture" vs "Decision Velocity") (Status: Pending Review)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Medium |
| Area | Primary value pillars |
| Section (taxonomy) | Primary value pillar(s) |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-61 (pillar count), ISS-82 (pillar pattern doesn't scale), ISS-35 (pillar duplicated) |

**Problem** — The two pillar sections are titled:
- Pillar 1: **"The Semantic Intelligence Layer"** (eyebrow "Architecture")
- Pillar 2: **"Built for Decision Velocity"** (no eyebrow)

These aren't parallel framings. Pillar 1 is a *thing* (the layer — a system component). Pillar 2 is a *quality* (velocity — an outcome attribute). The reader can't model whether these are co-equal features, sequential layers ("first the layer, then velocity"), or product lines ("Semantic Layer™ and Decision Velocity™"). Combined with ISS-61 (5 features vs 4 features) and ISS-58 (eyebrow on one, not the other), the asymmetry compounds: the two pillars look like they were designed by different teams.

**Why It Matters**
- User impact: visitor cannot place the two pillars in a single mental model.
- Cognitive load: parallel structure is the foundation of a feature comparison; non-parallel framing forces re-reading.
- Consistency impact: every program asset that references the two pillars inherits the asymmetric framing.
- Product impact: pillar naming is brand-strategic; the asymmetry signals incomplete product positioning.

**Recommendation** — Decide what each pillar *is* (architecture component? user outcome? product line?), then frame both pillars in the same grammar. Three viable framings:
1. **Both as system components** — "Semantic Intelligence Layer" + "Decision Velocity Engine". Both are nouns. Both get eyebrows ("Architecture", "Engine"). Both list 4 features each.
2. **Both as user outcomes** — "Trustworthy AI insights" + "Faster decisions". Both are outcomes. No eyebrows; the H2 carries the role. Both list 4 features.
3. **Sequential layers** — "Layer 1: Your data, unified" + "Layer 2: Your team, accelerated". Mandates visual treatment that shows them as a stack, not a pair.

Pick one, apply consistently; ISS-61 and ISS-58 collapse into ISS-88's fix.

**Evidence** — `audit-screenshots/s04-pillar-architecture.png`, `audit-screenshots/s04-pillar-decision-velocity.png`.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: product structure) |

---

### ISS-89 — "Semantic Layer" jargon never explained on-page (Status: Accepted)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Medium |
| Area | Hero / Primary value pillars |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-81 (subheadline overpacked), ISS-88 (pillar framing) |

**Problem** — The phrase "AI Semantic Layer" appears in the hero subheadline ("3x more accurate with AI Semantic Layer"). The H2 of pillar 1 is "The Semantic Intelligence Layer". The page assumes the reader knows what a *semantic layer* is — a term of art from data engineering and BI tooling. Likely target audiences (CFO, RevOps lead, marketing ops, line-of-business analyst) include many who don't. The page never defines the term. The closest is the pillar's feature list ("Semantic Layer · One trusted source of truth") which still doesn't explain *what* a semantic layer does.

**Why It Matters**
- User impact: visitors who don't know the term either bounce (cognitive cost too high) or skip the section (missing the differentiator).
- Cognitive load: forcing a glossary lookup above the fold is friction at the worst possible moment.
- Consistency impact: ISS-81 (subheadline overpacked) and ISS-89 are symptoms of the same root — the product positioning leans on technical vocabulary.
- Enterprise UX impact: enterprise buyers can be either technical or business; a homepage must explain *to both*.

**Recommendation** — Define the term inline, at first use. The hero subheadline becomes:
> "Ask questions in plain English. Get answers 3× more accurate than spreadsheets.
> **Powered by your Semantic Layer — a unified dictionary of every metric, dimension, and join in your data.**"

The pillar 1 H2 then re-anchors the term:
> "The Semantic Intelligence Layer · Your data dictionary, AI-readable."
> Body copy first paragraph: "Insightis builds a Semantic Layer by reading your schemas, joining your tables, and labelling every metric. The AI then queries the layer — not raw SQL — which is why answers are 3× more accurate."

Two sentences of definition transform "Semantic Layer" from a jargon barrier into a differentiator. Pair with ISS-81 (subheadline split into value + mechanism).

**Evidence** — `audit-screenshots/s02-hero.png` (hero subheadline visible), `audit-screenshots/s04-pillar-architecture.png` (pillar H2 + body).

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Iteration 3 filing (new lens: content / UX) |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-90 — Section-level supporting copy does not use `--ins-text-body` (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code |
| Severity | Medium |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-91 (text hierarchy systemic), ISS-45 (raw hex values) |

**Problem** — Supporting description copy that sits beneath section headings across the page does not consistently use `--ins-text-body` (`var(--ins-gray-300)`), the canonical DS token for paragraph-level text. Confirmed instances:

| Location | Element / class | Current state |
|---|---|---|
| All sections | `.sc-desc` | Wrong token or hardcoded hex |
| All sections | `.section-sub` | Wrong token or hardcoded hex |
| Final CTA — "Start Making Smarter Decisions Today" | Supporting copy: "Join 1,200+ data-driven teams. Set up in minutes, no credit card required, and cancel anytime." | Renders lighter than `--ins-text-body`; not using the correct token |
| Testimonial cards | Quote body text — e.g. "Insightis transformed how we make decisions. The AI insights are incredibly accurate — we now move 3x faster on strategic calls." | Insufficient contrast; renders below `--ins-gray-300` level; should use `--ins-text-body` |

All three instances fill the same typographic role — supporting description copy below an H2. All should resolve to identical computed color via the single token `--ins-text-body`.

**Why It Matters**
- Consistency impact: the same visual role uses different color values in different sections; the page has no unified body-text color for description copy.
- Readability impact: description copy outside the body token drifts visually when the DS color scale is updated, requiring manual re-fixes at each call site.
- DS impact: `--ins-text-body` is the single source of truth for paragraph-level text color. Every deviation creates a separate maintenance obligation.

**Recommendation** — Apply `color: var(--ins-text-body)` to `.sc-desc`, `.section-sub`, and any other selector used for section-level supporting copy. Conduct a full-page audit to catch additional class names using the same role. Never override with hardcoded hex. If classes serve genuinely distinct roles in the future, define separate DS text-role tokens — don't hardcode.

**Evidence** — User-identified during iteration-3 status review session (2026-05-20). Screenshot: Final CTA section — "Join 1,200+ data-driven teams…" visible at lighter-than-body color beneath the teal-accented H2.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified text-hierarchy issue (`.sc-desc`) |
| 2026-05-20 | Pending Review | Scope expanded — `.section-sub` merged in (same problem, same fix) |
| 2026-05-20 | Pending Review | Scope expanded — Final CTA supporting copy merged in; finding broadened to cover all section-level description roles |
| 2026-05-20 | Pending Review | Scope expanded — testimonial quote body text merged in (same token gap, insufficient contrast) |
| 2026-05-20 | Accepted | Use --ins-text-body (var(--ins-gray-300)) on .sc-desc, .section-sub, testimonial quotes, Final CTA supporting copy. |

---

### ISS-91 — Text colors across the page do not follow DS semantic text hierarchy (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code + Design |
| Severity | High |
| Area | Global |
| Section (taxonomy) | Global |
| Complexity | Medium |
| Confidence | High |
| Linked | related: ISS-45 (raw hex values), ISS-90 (sc-desc token), ISS-26 (inactive vs disabled token confusion) |

**Problem** — Text elements across the page use a mix of hardcoded hex values, Tailwind arbitrary-value classes, and DS semantic tokens applied at the wrong hierarchy level. The DS defines a clear text color hierarchy:

DS text color token reference (from `design-system/foundations/colors.html`):

| Token | Value | Contrast on surface-page | Role |
|---|---|---|---|
| `--ins-text-heading` | — | 19.35:1 AA | H1–H3, nav labels, strong UI labels |
| `--ins-text-body` | `var(--ins-gray-300)` | 6.94:1 AA | Body paragraphs, descriptions, table cells, input values |
| `--ins-text-inactive` | #7FA0AC | 6.94:1 AA | Placeholder text in inputs; passive non-interactive text |
| `--ins-text-disabled` | #6E8D9A | 5.04:1 Exempt | Disabled interactive element labels only — WCAG exempt |
| `--ins-text-highlight` | — | 8.92:1 AA | Links, teal accent text |

**Note:** `--ins-text-inactive` and `--ins-text-disabled` are separate tokens with different values. `text-inactive` is for placeholder/passive text; `text-disabled` is for disabled interactive elements and is WCAG-exempt. There is no `--ins-text-muted` token in this DS.

This hierarchy is not consistently applied on the page. Section descriptions miss `--ins-text-body` (ISS-90). Active metadata labels use `--ins-text-inactive` (placeholder token) where `--ins-text-body` is correct (ISS-26). The footer uses wrong colors throughout (ISS-98). Thirty-six text calls use raw hex outside the token system entirely (ISS-45).

**Why It Matters**
- Readability impact: without the correct contrast steps between hierarchy levels, visitors cannot scan the page by importance.
- Consistency impact: the DS token hierarchy exists but is not enforced; future pages will inherit the same non-pattern.
- DS impact: `--ins-text-inactive` and `--ins-text-disabled` are distinct tokens — conflating them or using them for wrong roles breaks both interactive-state feedback and passive text signalling.
- Accessibility impact: WCAG 1.4.3 applies to all active text; `--ins-text-disabled` (5.04:1) is exempt only when the element is genuinely disabled.

**Recommendation** — Audit every text-color declaration on the page and map to the correct DS token per the reference table above. Specific actions:
1. Replace all 36 raw-hex text classes (ISS-45) with semantic tokens.
2. Apply `--ins-text-body` to all `.sc-desc`, `.section-sub`, and equivalent section-description selectors (ISS-90).
3. Replace `--ins-text-inactive` on active metadata labels (Last Sync, Records, Payments) with `--ins-text-body` — `--ins-text-inactive` is for placeholder/passive text only (ISS-26).
4. Fix footer text colors to match DS tokens (ISS-98).
5. Establish a lint rule blocking `text-[#…]` Tailwind arbitrary classes for any text color.

**Evidence** — User-identified during iteration-3 status review session (2026-05-20). Corroborated by ISS-26, ISS-45, ISS-90.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified systemic text-hierarchy issue |
| 2026-05-20 | Accepted | Full audit: replace all 36 raw-hex text classes; apply correct hierarchy tokens throughout page. |

---

### ISS-92 — Nav "Start for Free" button not built on DS button component (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code + Design |
| Severity | High |
| Area | Header / Nav |
| Section (taxonomy) | Header / Nav |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-36 (button radius inconsistency), ISS-16 (CTA href="#" placeholder), ISS-77 (no focus ring on nav) |

**Problem** — The nav "Start for Free" button is a custom implementation that does not use the DS `.ins-btn` component. As a result its hover, focus, active, and disabled interaction states are either absent or hand-rolled — not matching the DS-defined button behavior. Visually it renders as a full-pill shape with a teal fill, which may or may not match `.ins-btn--primary` depending on the radius token applied. Because it sits outside the DS component, any future DS button update (state colors, focus ring, animation) will not propagate to this element automatically.

**Why It Matters**
- Consistency impact: the most prominent CTA on the page — above the fold, always visible in the sticky nav — does not behave like DS buttons elsewhere. Visitors on slow connections or keyboard navigation notice the missing states immediately.
- Accessibility impact: a button without a DS-defined `:focus-visible` ring (ISS-77) fails WCAG 2.4.7.
- DS impact: the nav CTA is the highest-frequency button on the entire site; if it doesn't use the DS component, it sets a precedent for every future page to hand-roll their own.
- Scalability impact: future button state changes (e.g. loading spinner, disabled pricing gate) must be applied manually rather than inherited from the component.

**Recommendation** — Replace the custom nav button with `.ins-btn.ins-btn--primary.ins-btn--sm` (or the nav-appropriate size variant). This gives the button the full DS state matrix for free: hover (`--ins-interactive-primary-hover`), active (scale 0.97), focus (`:focus-visible` ring via ISS-77), disabled (opacity 0.4, `cursor: not-allowed`), and loading (spinner slot). The pill shape is preserved if `.ins-btn--primary` uses `--ins-radius-full` — confirm with DS component spec.

**Evidence** — Screenshot: nav bar — "Start for Free" button visible as teal full-pill CTA, right-aligned. Custom hover/focus behavior confirmed absent on interaction.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified from nav screenshot |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-93 — Mid-page CTA banner: headline highlight color inconsistent with hero (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code + Design |
| Severity | Medium |
| Area | How it works / Mid-page CTA |
| Section (taxonomy) | How it works |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-57 (eyebrow teal drift), ISS-91 (text color hierarchy) |

**Problem** — The mid-page CTA banner headline "Still waiting on **insights** that take **days?**" highlights two words in teal, but the two highlights use different teal values — "insights" and "days?" resolve to different computed colors. Neither is confirmed to match the hero headline's accent teal. The hero establishes the page's single teal-accent pattern for highlighted headline words; every subsequent section that uses the same device must reference the same token.

**Why It Matters**
- Consistency impact: two teal shades in the same heading make the accent look like a rendering artefact, not a design decision.
- DS impact: the page-level "headline highlight" pattern is not backed by a named token — each instance hand-picks a value, guaranteeing drift.

**Recommendation** — Define one token for headline word-highlights — `--ins-primary-400` (#0EC4C1) — and apply it to every highlighted word across all headings (hero H1, mid-page CTA, Final CTA). Both "insights" and "days?" in this heading must resolve to the same value as the hero's highlighted word.

**Evidence** — Screenshot: mid-page CTA banner — "insights" and "days?" visible in two distinct teal shades.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified from screenshot |
| 2026-05-20 | Accepted | Token confirmed: use --ins-text-highlight: var(--ins-color-teal-400) for all headline word-highlights — not --ins-primary-400. |

---

### ISS-94 — Mid-page CTA banner: placeholder text wrong and unclear (Status: Accepted)

| | |
|---|---|
| Category | UX |
| Domain | Design |
| Severity | Medium |
| Area | How it works / Mid-page CTA |
| Section (taxonomy) | How it works |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-38 (hero chat truncated placeholder), ISS-85 (no DS chat-input component) |

**Problem** — The mid-page CTA banner contains a chat input with the placeholder "What info are you looking for?" This is a meta-question about intent rather than a concrete example query. It tells the visitor nothing about what kind of question the product can answer, and it differs in style from the hero chat input which uses a partial business query as its placeholder. Two chat inputs on the same page with different placeholder conventions look inconsistent and uninstructive.

**Why It Matters**
- User impact: a vague meta-placeholder ("What info are you looking for?") gives no model for what to type — the visitor stares at an empty box with no prompt.
- Consistency impact: the hero and mid-page banner use different placeholder styles for the same interaction pattern.
- Conversion impact: the mid-page CTA is a second-chance conversion moment for visitors who scrolled past the hero — a weak placeholder reduces the chance they engage.

**Recommendation** — Replace with a specific, on-brand example query in the same style as the hero — e.g. *"Show me MRR by region last quarter"* or *"Which campaigns drove the most signups?"* The placeholder should demonstrate product capability, not ask a generic meta-question. Align placeholder conventions between hero and all other chat inputs on the page.

**Evidence** — Screenshot: mid-page CTA banner — placeholder "What info are you looking for?" visible in chat input field.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified from screenshot |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-95 — "Explore Pricing" button has wrong hover behaviour (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code + Design |
| Severity | Medium |
| Area | Global / CTAs |
| Section (taxonomy) | Global |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-92 (nav "Start for Free" not on DS component), ISS-36 (button radius inconsistency), ISS-16 (CTAs href="#") |

**Problem** — The "Explore Pricing →" button displays a hover state that does not match the DS button interaction spec. Screenshot shows the button in what appears to be a hover or active state: dark background, teal text, teal-glowing border — a custom visual treatment not defined in the DS `.ins-btn` component. The DS defines explicit hover tokens for each button variant (primary, secondary, ghost); this button is using none of them, producing an interaction that feels inconsistent with every other button on the page.

**Why It Matters**
- Consistency impact: hover behaviour that differs from the DS button creates a "cheap" impression — the button feels like it belongs to a different product.
- DS impact: custom hover states are unmaintainable; any future DS hover-color change must be manually replicated here.
- Accessibility impact: a non-standard hover state may lack sufficient contrast ratio change to satisfy WCAG 1.4.11 Non-text Contrast.

**Recommendation** — Replace with the appropriate DS button variant and let the component supply the hover state automatically:
- If this is a secondary action: `.ins-btn.ins-btn--secondary` — DS hover: border-color shifts to `--ins-border-hover`, background lifts to `--ins-surface-overlay`.
- If this is a ghost action: `.ins-btn.ins-btn--ghost` — DS hover: background fills to `--ins-surface-tint`.
The teal text + dark background at rest is consistent with either variant; the DS component will correct the hover, focus, and active states in one change.

**Evidence** — Screenshot: "Explore Pricing →" button — teal text on dark background with teal glow border visible in hover/active state.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified from screenshot |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-96 — Comparison cards not using DS Glow card shadow and color (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code + Design |
| Severity | High |
| Area | Comparison / "Why us" |
| Section (taxonomy) | Comparison / "Why us" |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-40 (no color signal on comparison cards), ISS-66 (border alpha asymmetry), ISS-84 (no DS comparison pattern) |

**Problem** — The "Traditional Approach" and "With Insightis" comparison cards use a plain dark background with a basic border. The DS publishes a **Glow card** component that defines both the shadow depth and the border glow color using DS tokens. These cards are not using it — they apply neither the correct `--ins-shadow-*` depth token nor the DS glow border color. The result is two flat, visually undifferentiated cards that fail to communicate the "pain vs win" contrast the section is designed to deliver.

**Why It Matters**
- Visual hierarchy: Glow card styling creates immediate left/right visual contrast — the red-glow card reads as "avoid this" and the teal-glow card reads as "this is the answer" before a single word is read.
- DS impact: the Glow card component is a published DS pattern; using a custom card instead creates a maintenance split between the DS and the homepage.
- Consistency impact: every future comparison section on other pages (Roadmap, Pricing, Solutions) will invent its own card style unless this page establishes the Glow card as the canonical pattern for comparisons.

**Recommendation** — Apply the DS Glow card component to both comparison cards:
- **"Traditional Approach"** card: Glow card with `--ins-shadow-glow-error` (red glow) — reinforces the × icons already using red.
- **"With Insightis"** card: Glow card with `--ins-shadow-glow-brand` (teal glow) — reinforces the ✓ icons already using teal.
The card body (dark surface, border-radius, padding) comes from the DS Glow card component; only the glow color changes per side. This also resolves the border-alpha asymmetry in ISS-66 since the DS token governs both sides uniformly.

**Evidence** — Screenshot: comparison section — both cards visible with flat dark background and basic border, no glow effect.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified from screenshot |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-97 — Comparison card list items have broken left reading line (Status: Pending Review)

| | |
|---|---|
| Category | UI |
| Domain | Code |
| Severity | Medium |
| Area | Comparison / "Why us" |
| Section (taxonomy) | Comparison / "Why us" |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-96 (comparison cards not using DS Glow card), ISS-08 (spacing off 4 px grid) |

**Problem** — The bullet list inside the "Traditional Approach" (and likely "With Insightis") comparison card has a broken left reading line: the × / ✓ icons and the text labels that follow them do not form a consistent left-aligned column. The vertical left edge of the text content is ragged — each item's text starts at a slightly different x-position depending on icon width, padding, or flex alignment. This breaks the fundamental list-reading contract: the eye expects a clean vertical anchor on the left so it can scan items quickly without re-finding the start of each line.

**Why It Matters**
- Readability impact: a broken left reading line slows scanning — the eye has to search for the start of each item rather than tracking a clean vertical axis.
- Consistency impact: the same list pattern is used in both comparison cards; the misalignment is visible across both sides simultaneously, doubling the visual noise.
- DS impact: the DS list component (`.ins-list--check` / `.ins-list--cross`) should enforce icon + gap + text alignment via a fixed icon-column width; if it does, the card is not using it.

**Recommendation** — Fix the list layout so every item's text left-edge is pixel-identical:
- Use `display: flex; align-items: flex-start` on each list item.
- Fix the icon to a constant width container: `width: 16px; flex-shrink: 0`.
- Set a consistent `gap: var(--ins-space-2)` (8 px) between icon and text.
- If the DS `.ins-list--check` / `.ins-list--cross` component already defines this layout, replace the custom list with the component directly.

**Evidence** — Screenshot: "Traditional Approach" card — × icons and list text labels visible with ragged left alignment across all five items.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified from screenshot |

---

### ISS-98 — Footer text colors do not match DS token specification (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code |
| Severity | Medium |
| Area | Footer |
| Section (taxonomy) | Footer |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-91 (text hierarchy systemic), ISS-45 (raw hex values), ISS-14 (duplicate copyright), ISS-71 (footer column balance) |

**Problem** — Footer text elements use wrong color values that do not match the DS token specification. Expected color assignments per the DS contrast table (`design-system/foundations/colors.html`):

| Footer element | Expected DS token | Expected contrast |
|---|---|---|
| Column headings / section labels | `--ins-text-heading` | 19.35:1 AA on `surface-page` |
| Navigation link text | `--ins-text-body` | 6.94:1 AA on `surface-page` |
| Legal / copyright / small print | `--ins-text-body` | 6.94:1 AA on `surface-page` |
| Placeholder / passive labels | `--ins-text-inactive` (#7FA0AC) | 6.94:1 AA on `surface-page` |

The footer currently uses hardcoded hex or mismatched tokens that deviate from these values, producing text that is either too dim (potential WCAG 1.4.3 failure on non-exempt text) or visually inconsistent with the DS-defined palette.

**Why It Matters**
- Accessibility impact: footer links and labels that fall below 4.5:1 contrast on `surface-page` fail WCAG 1.4.3 unless they are genuinely disabled (which footer links are not).
- Consistency impact: the footer is the last element every visitor sees; wrong text colors here undermine the DS credibility across the whole page.
- DS impact: the footer will be reused across all program pages — establishing the wrong token usage here propagates it site-wide.

**Recommendation** — Audit every text element in the footer and replace hardcoded hex values with the correct DS tokens per the table above. Column headings → `--ins-text-heading`. Navigation links and body copy → `--ins-text-body`. Do not use `--ins-text-disabled` (#6E8D9A, WCAG exempt) for any active footer text.

**Evidence** — User-identified from DS contrast reference screenshot (2026-05-20). DS expected values: `text-heading` 19.35:1, `text-body` 6.94:1, `text-inactive` #7FA0AC 6.94:1, `text-disabled` #6E8D9A 5.04:1 Exempt.

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified wrong colors in footer, DS reference attached |
| 2026-05-20 | Accepted | Accepted in interactive review session |

---

### ISS-99 — Connectors / Gemini Pro chips appear disabled — low contrast, not using DS interactive tokens (Status: Accepted)

| | |
|---|---|
| Category | DS |
| Domain | Code + Design |
| Severity | Medium |
| Area | Hero / Chat widget |
| Section (taxonomy) | Hero |
| Complexity | Low |
| Confidence | High |
| Linked | related: ISS-52 (Send button ghost styling), ISS-91 (text hierarchy systemic), ISS-92 (nav button not on DS component) |

**Problem** — The "Connectors" and "Gemini Pro" selector chips in the hero chat widget toolbar appear visually disabled. The chip text is insufficiently contrasted against the dark chip background, and the treatment does not use DS interactive chip tokens. In ambient-light conditions (outdoors, bright window, sunny environment), the chips are difficult to read and are misread as inactive/unavailable controls. These chips are interactive selectors (data source and AI model) — they must signal "choose me", not "unavailable". The dark background with dim text mirrors the exact pattern the DS uses for genuinely disabled UI, producing a false disabled signal on active controls.

**Why It Matters**
- Readability impact: low-contrast text on a dark chip is the DS's disabled pattern — applying it to active interactive chips mis-signals state.
- Accessibility impact: interactive chips must meet WCAG 1.4.3 AA contrast (4.5:1); the current dim treatment may not.
- UX impact: users do not know these chips are tappable; they read as static labels or disabled selectors.
- DS impact: the DS publishes chip/badge tokens with correct interactive-resting contrast; this widget bypasses them.

**Recommendation** — Apply DS chip tokens to both Connectors and Gemini Pro chips. Interactive resting state:
- Text: `color: var(--ins-text-body)` (`#A8BFC8`, 6.94:1 on `surface-page`) — not a dimmer value.
- Border: `1px solid var(--ins-border-default)` (`rgba(255,255,255,0.06)`).
- Background: `--ins-surface-hover` (`rgba(255,255,255,0.04)`) minimum for the chip container.
- Icon: `stroke="currentColor"` so the chevron inherits the text color.
- Hover: `border-color: var(--ins-border-hover)` + background lifts to `rgba(255,255,255,0.08)`.

Use the DS `.ins-chip` or `.ins-badge--interactive` component if published; otherwise apply the tokens above inline until the DS component covers this pattern. The send button, connector chip, and model chip in the same toolbar must each read at a distinct, correct hierarchy — neither should look disabled unless it genuinely is.

**Evidence** — Screenshot: hero chat widget toolbar — Connectors and Gemini Pro chips visible with low-contrast text on dark background, appearing disabled. User note: "the background is too dark that makes it hard to read it in sun."

**Status history**
| Date | Status | Rationale |
|---|---|---|
| 2026-05-20 | Pending Review | Filed mid-session; user-identified from screenshot — chips appear disabled, low contrast, not on DS tokens |
| 2026-05-20 | Accepted | Use DS chip tokens: --ins-text-body on chip text; 1px solid var(--ins-border-default) border; --ins-surface-hover background minimum; hover lifts to --ins-border-hover. Use .ins-chip or .ins-badge--interactive. |

---

## Iteration 3 — post-review summary (2026-05-20)

> Interactive review session completed. All 97 findings walked; user decided Status per finding. Below is the final state after this session.

### Final decisions tally

| Outcome | Count | Where recorded |
|---|---|---|
| **Accepted** (actionable on Homepage) | **57** | This log, Status-history rows |
| **Declined** (formally, in log) | **1** | ISS-68 (duplicate of ISS-30 — merged) |
| **Declined** (decision recorded in archive; remain Pending Review in log per user convention) | ~49 | `archive/review-decisions-2026-05-20.md` |
| **Pending Review** (no decision yet recorded) | 39 (log status) | — |

### Accepted findings — action checklist by area

**Hero / Chat widget (8):** ISS-01, ISS-02, ISS-39, ISS-49, ISS-52, ISS-89, ISS-92, ISS-99
**Global tokens / DS hygiene (12):** ISS-04, ISS-06, ISS-08, ISS-09, ISS-13, ISS-44, ISS-45, ISS-56, ISS-57, ISS-65, ISS-66, ISS-91
**Typography / text hierarchy (6):** ISS-32, ISS-43, ISS-55, ISS-65, ISS-90, ISS-93
**Buttons / CTAs (6):** ISS-30, ISS-34, ISS-36, ISS-50, ISS-72, ISS-76
**Eyebrows / decoration (5):** ISS-19, ISS-31, ISS-57, ISS-58, ISS-62
**Connectors / marquee (3):** ISS-12, ISS-37, ISS-42
**Accessibility (6):** ISS-01, ISS-03, ISS-23, ISS-24, ISS-48, ISS-72, ISS-77
**KPI / Pillars / Comparison (5):** ISS-02, ISS-40, ISS-41, ISS-60, ISS-66
**Testimonials (2):** ISS-20, ISS-21
**Footer (4):** ISS-14, ISS-95, ISS-96, ISS-98
**Mid-page CTA banner (2):** ISS-93, ISS-94
**Other (3):** ISS-17, ISS-27, ISS-75

### Critical blockers (still Critical, still actionable)

- **[ISS-01](#iss-01)** — Hero `<h1>` nests block-level children. WCAG 1.3.1 violation. *Accepted*.
- **[ISS-02](#iss-02)** — KPI strip renders `0x / 0% / 0+` on initial load. *Accepted*.

Both are single-PR fixes; resolve first to unlock the "stabilize" phase.

### Quick wins (Low complexity, High confidence, Accepted)

Stack-ranked for immediate execution:

1. **ISS-14** — Footer "© Copyright © Devart 2026" duplicate symbol — one string edit.
2. **ISS-43** — Hero `<h1>` `font-family: 'Outfit'` never loaded — drop inline style.
3. **ISS-69** — Final CTA H2 leading-space drift — move spaces outside `<span>`.
4. **ISS-65** — KPI numbers `font-weight: 500` → `700`.
5. **ISS-57** — Eyebrow `✦` color drift → `--ins-text-highlight`.
6. **ISS-72** — Mobile hamburger 40×40 → `.ins-btn--icon` (44×44).
7. **ISS-31** — Replace `✦` Unicode glyph with 10×10 Lucide SVG.
8. **ISS-34** — Remove → arrows from all CTAs.

### Largest-impact accepted items (unlock chains)

- **[ISS-04](#iss-04)** — *tokens.css is canonical; call sites use semantic tokens only.* Unblocks ISS-06, ISS-44, ISS-45, ISS-57, ISS-65, ISS-66.
- **[ISS-44](#iss-44)** — Decide canonical font-family naming convention; aligns all call sites.
- **[ISS-91](#iss-91)** — Full text-hierarchy audit; replace 36 raw-hex text classes with semantic tokens.
- **[ISS-90](#iss-90)** — Use `--ins-text-body` on all `.sc-desc` / `.section-sub` / testimonial quotes / Final CTA copy.
- **[ISS-77](#iss-77)** — Apply DS `:focus-visible` globally; affects every keyboard journey.
- **[ISS-76](#iss-76) + ISS-99** — Apply DS chip + button state tokens to hero chat widget.

### Systemic patterns confirmed by user decisions

1. **DS token vocabulary is the foundation blocker.** ISS-04 (Accepted with corrected framing) + ISS-44 (Accepted) + ISS-91 (Accepted) + ISS-90 (Accepted) + ISS-93 (Accepted with exact token specified) together establish: *semantic tokens only at call sites; never primitives from either token file directly.* Every per-call-site token migration now has a clear north star.
2. **DS interactive-state coverage is the second blocker.** ISS-76 (Accepted), ISS-77 (Accepted), ISS-99 (Accepted), ISS-92 (Accepted prior). Pattern: every interactive element must read its state from a DS state token — disabled vs inactive vs hover vs focus. User explicitly endorsed the inactive → active (not disabled → enabled) semantic for inputs.
3. **Container geometry is now a DS principle.** ISS-36 (Accepted): parent container roundness must be respected by nested interactive elements. Rounding need not be identical but must feel intentionally related. This becomes a DS-wide rule.
4. **Marketing-page chrome (eyebrows, glyphs, arrows) gets simplified.** ISS-31 (Accepted — Lucide SVG), ISS-34 (Accepted — remove → entirely), ISS-58 (Accepted — banners/hero exempt, content sections required). Net: simpler, more uniform decoration vocabulary.
5. **Mock / placeholder / decorative content is exempt from page-level rules.** ISS-07 (Declined), ISS-22 (Declined), ISS-46 (Declined), ISS-79 (Declined), ISS-80 (Declined). User explicitly accepts mock-button non-44×44, sub-12 px mock text, and placeholder hrefs as acceptable pre-launch states.

### Declined patterns (issues the user does not want filed)

- Carried-forward "from prior session" findings that re-asserted in iteration 3 (~26 items): user re-confirmed all declines.
- DS roadmap items (ISS-82, ISS-83, ISS-84, ISS-85): declined as "not a homepage concern".
- Placeholder content (testimonial photos, footer URLs, href="#" CTAs): all declined pre-launch.
- Intentional design choices (testimonial card height, CTA layout, pillar asymmetry, section ordering): all declined.

### Iteration 3 — what changed in the page

**Nothing.** Source HTML byte-equal to May 18 baseline (modulo 71-byte `.fade-up` rule). No Resolved findings possible. No Regressions possible.

### Recommended next priorities (post-decision)

For implementation, in this order:

1. **Critical first.** ISS-01, ISS-02 — single PRs each.
2. **Token-vocabulary unification.** ISS-04, ISS-44, ISS-91, ISS-90, ISS-93 — pre-requisite for all per-call-site migrations.
3. **Text-hierarchy sweep.** ISS-45 (36 raw hex), ISS-26-correction, ISS-91 audit — all gated on §2 above.
4. **Global accessibility sweep.** ISS-24 (`:focus-visible`), ISS-77 (nav focus ring), ISS-48 (`prefers-reduced-motion`), ISS-23 (input labels), ISS-72 (44×44 hamburger).
5. **Hero chat-widget DS pass.** ISS-76, ISS-99, ISS-92 — apply DS button/chip state tokens uniformly.
6. **Quick-win batch.** ISS-14, ISS-43, ISS-65, ISS-69, ISS-57, ISS-31, ISS-34 — one PR, low risk.
7. **Container-geometry principle (ISS-36)** — write up as DS guideline, then audit page nesting.
8. **Remaining accepted DS / scalability findings** — ISS-37 (logo balance), ISS-39 (trust-line layout), ISS-95/96/98 (footer cleanup).

---

## End of iteration 3

When the page is updated (new HTML / new screenshots), open iteration 4 by following [review-iteration-protocol.md](review-iteration-protocol.md) §1–§5. The first comparison pass should run against this iteration-3 post-review state.
