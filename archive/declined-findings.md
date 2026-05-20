# Homepage — Declined findings (archive)

> 40 findings declined during iteration 3 (2026-05-20). Per project rule, **declined findings are kept here for the record and are never re-proposed in future iterations**. The IDs remain reserved — they are not reused.
>
> The live working log ([../homepage-review-log.md](../homepage-review-log.md)) contains only actionable (Accepted) findings.
>
> Each entry below preserves the original `Problem` / `Why It Matters` / `Recommendation` text verbatim, with the final Status-history row showing why it was declined.

---
### ISS-07 — Sub-12 px font sizes in pillar illustrations break minimum legibility floor (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-10 — Third-party stock portraits in testimonials (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-11 — Avatar image + initials shown redundantly (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-15 — URLs contain unencoded spaces (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-16 — Primary CTAs use `href="#"` placeholders (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-18 — Marquee track duplicated without `aria-hidden` (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-22 — Demo buttons below 44 × 44 minimum tap target (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-25 — Mono font misused for UI labels (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-26 — Active labels using `--ins-text-inactive` where `--ins-text-muted` is correct (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-28 — Hero claim and KPI multipliers conflict (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-29 — Social links rendered as raw URLs (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-33 — Eyebrow label lengths vary too widely (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-35 — Architecture feature list duplicated in the DOM (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-38 — Hero chat input shows truncated / test placeholder (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-46 — Hero trust sentence pushes the connector marquee below the fold on mobile (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-47 — `responsive.css` uses legacy 600 / 900 px breakpoints (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-51 — Hero has no primary CTA below headline (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-53 — Chat input only 18 px tall — below 44 px target (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-54 — Trust line lacks scannable proof points (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-59 — Eyebrow capitalisation drift (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-61 — Pillar feature counts asymmetric (5 vs 4) (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-63 — Testimonial cards fixed 207 px height (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-64 — No hover affordance on testimonial cards (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-67 — Final CTA H2 sized 30 px — breaks rhythm (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-70 — Final CTA laid out horizontally (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-71 — Footer columns end on different rows (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-73 — No loading skeletons defined anywhere (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-74 — No empty-state visual for chat widget (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-78 — Hero chat widget conflates demo and primary CTA — interactive-vs-illustrative ambiguity (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-79 — Two competing primary actions in the hero region (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-80 — Nine-section page has no in-page navigation (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-81 — Hero subheadline packs three claims into one ungrammatical fragment (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-82 — Pillar pattern doesn't scale past two pillars (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-83 — Testimonial 6-card fixed grid doesn't scale to 12+ entries (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-84 — No DS pattern for N-column comparison (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-85 — Chat-input component has no DS equivalent (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-86 — Connector marquee has no DS logo-wall variant (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-87 — Section ordering delays social proof to position 6 of 10 (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-88 — Two-pillar framing is non-parallel ("Architecture" vs "Decision Velocity") (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
### ISS-97 — Comparison card list items have broken left reading line (Status: Declined)

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
| 2026-05-20 | Declined | Declined in iteration 3 review session (see archive/review-decisions-2026-05-20.md for full rationale). |


---
