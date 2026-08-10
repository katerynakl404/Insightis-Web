# Developer Handoff — Insightis Audit v1

**For:** the maintainer of the site repository (`insightis-site`, with commit/deploy access).
**Source:** generated from [`../findings.md`](../findings.md) — **all 77 Accepted findings**. Regenerate via [`HANDOFF-GEN.md`](HANDOFF-GEN.md) after any findings change.
If a step and the findings disagree, the findings file wins — regenerate this handoff.

> This file is a **Claude-executable instruction**. Hand the prompt block below to Claude Code (or
> another agent) at the root of the site repo, or apply it by hand — the steps are identical.
> Stack: Vite + React, multi-page. Dev `npm run dev`, build `npm run build`, deploy Vercel
> (`vercel.json`, no catch-all rewrite).

---

## Scope note

This handoff is the **complete, prioritized action list — all 77 Accepted findings** (P0 → P3), generated from [`../findings.md`](../findings.md). [`report-visual.html`](report-visual.html) is the same findings as a visual report (why-it-matters + before/after). Tasks 1–16 cover AUD-01…23; the **Continuation** section below covers AUD-24…80 (blockers first, then a compact P2/P3 list so nothing is dropped). Larger design-system refactors and some items need design sign-off first (see [`fix-examples.html`](fix-examples.html)). Concept/design references (branded 404, empty states) are linked from the report's **Concepts** section; the 404 body is in Task 4.

## PROMPT (copy the whole block)

> You are working in the Insightis site repository (`insightis-site`). Apply the tasks below **in
> priority order** and verify at the end. Do not restyle the site — these are targeted fixes only.
>
> ### P0 — ship-blockers (content that misinforms + a broken link)
>
> **Task 1 — Fix the contradictory discount (AUD-01).**
> On the Pricing page the plan cards show `50% OFF` ($7.99 vs $15.99) but the FAQ says "save 20% per
> seat." Make both agree on one number. Confirm the intended discount with the product owner; if the
> card math ($7.99 vs $15.99 ≈ 50%) is correct, change the FAQ copy from "save 20% per seat" to
> "save 50% per seat" (or the agreed figure). Search the Pricing markup/FAQ for `20%` and `50%`.
>
> **Task 2 — Remove phantom pricing tiers from the FAQ (AUD-02).**
> The plan grid has only Free / Starter / Pro, but the FAQ mentions **Team** and **Enterprise**
> ("14-day free trial", "available on Team and Enterprise"). Edit the FAQ so it references only the
> tiers that exist (or add the tiers if they are real). Search the FAQ for `Team` and `Enterprise`.
>
> **Task 3 — Fix the broken link in the AI Chat static fallback (AUD-03).**
> In `platform/ai-chat.html` (line ~193) replace:
> ```html
> <p><a href="/pricing">Start for free</a> · <a href="/integrations">See all integrations</a></p>
> ```
> with:
> ```html
> <p><a href="/auth/sign-up/">Start for free</a> · <a href="/platform/integrations">See all integrations</a></p>
> ```
> Reasons: `/integrations` 404s (correct path is `/platform/integrations`); "Start for free" should
> lead to sign-up, not `/pricing`.
>
> ### P1 — before next release
>
> **Task 4 — Add a branded 404 page + remove dead route mappings (AUD-04).**
> Create `public/404.html` with the content below (Vite copies `public/*` to `dist/`; Vercel serves
> `/404.html` on unknown routes automatically — no extra config):
> ```html
> <!DOCTYPE html>
> <html lang="en">
> <head>
> <meta charset="UTF-8">
> <meta name="viewport" content="width=device-width, initial-scale=1.0">
> <link rel="icon" type="image/svg+xml" href="/favicon.svg?v=2">
> <title>Page not found — Insightis</title>
> <meta name="robots" content="noindex,follow">
> <meta name="theme-color" content="#0A0E13">
> <link rel="preload" href="/fonts/Geist-Variable.ttf" as="font" type="font/ttf" crossorigin>
> <style>
>   @font-face{ font-family:"Geist"; src:url("/fonts/Geist-Variable.ttf") format("truetype"); font-weight:100 900; font-display:swap; }
>   :root{ --page:#0A0E13; --surface:#0D1117; --heading:#E8F2F5; --text:#C0D4DC; --muted:#7FA0AC;
>     --border:rgba(255,255,255,0.06); --border-strong:rgba(255,255,255,0.10);
>     --teal-400:#0EC4C1; --teal-500:#148F8D; --teal-600:#07807E; --teal-650:#096968; }
>   *{box-sizing:border-box} html,body{height:100%}
>   body{ margin:0;background:var(--page);color:var(--text);
>     font-family:"Geist",-apple-system,BlinkMacSystemFont,"Segoe UI",system-ui,sans-serif;
>     -webkit-font-smoothing:antialiased;display:flex;flex-direction:column;min-height:100vh;
>     background-image:radial-gradient(60% 55% at 50% 0%, rgba(14,196,193,0.10), transparent 70%),
>       radial-gradient(40% 40% at 85% 100%, rgba(20,143,141,0.08), transparent 70%);
>     background-repeat:no-repeat; }
>   header{padding:22px 24px}
>   .brand{display:inline-flex;align-items:center;gap:10px;text-decoration:none;color:var(--heading)}
>   .brand img{width:26px;height:26px;display:block} .brand span{font-size:19px;font-weight:700;letter-spacing:-.01em}
>   main{flex:1;display:flex;align-items:center;justify-content:center;padding:24px}
>   .box{max-width:560px;text-align:center}
>   .code{font-size:clamp(84px,18vw,150px);line-height:.9;font-weight:800;letter-spacing:-.04em;margin:0;
>     background:linear-gradient(135deg,var(--teal-400) 0%,var(--teal-500) 55%,var(--teal-650) 100%);
>     -webkit-background-clip:text;background-clip:text;color:transparent;}
>   h1{color:var(--heading);font-size:clamp(22px,4vw,30px);letter-spacing:-.02em;margin:14px 0 10px;font-weight:700;text-wrap:balance}
>   p.lead{color:var(--muted);font-size:16px;line-height:1.6;margin:0 auto 30px;max-width:44ch;text-wrap:pretty}
>   .actions{display:flex;gap:12px;justify-content:center;flex-wrap:wrap}
>   .btn{display:inline-flex;align-items:center;gap:8px;height:44px;padding:0 22px;border-radius:999px;
>     font-size:15px;font-weight:600;text-decoration:none;transition:background .18s ease,border-color .18s ease}
>   .btn-primary{background:var(--teal-600);color:#fff;border:1px solid var(--teal-500)} .btn-primary:hover{background:var(--teal-650)}
>   .btn-ghost{background:transparent;color:var(--heading);border:1px solid var(--border-strong)}
>   .btn-ghost:hover{border-color:var(--teal-500);color:var(--teal-400)}
>   .links{margin-top:34px;padding-top:22px;border-top:1px solid var(--border)}
>   .links .t{font-size:12px;letter-spacing:.14em;text-transform:uppercase;color:var(--muted);margin-bottom:12px}
>   .links nav{display:flex;gap:8px 22px;justify-content:center;flex-wrap:wrap}
>   .links a{color:var(--text);text-decoration:none;font-size:14px;transition:color .18s ease} .links a:hover{color:var(--teal-400)}
>   footer{padding:20px 24px;text-align:center;color:var(--muted);font-size:12.5px}
>   a:focus-visible,.btn:focus-visible{outline:2px solid var(--teal-400);outline-offset:2px}
> </style>
> </head>
> <body>
>   <header><a class="brand" href="/" aria-label="Insightis home"><img src="/favicon.svg?v=2" alt=""><span>Insightis</span></a></header>
>   <main><div class="box">
>     <p class="code">404</p>
>     <h1>This page doesn’t exist</h1>
>     <p class="lead">The page you’re looking for was moved, renamed, or is still on the way. Let’s get you back to your data.</p>
>     <div class="actions">
>       <a class="btn btn-primary" href="/">Back to home</a>
>       <a class="btn btn-ghost" href="/pricing">See pricing</a>
>     </div>
>     <div class="links"><div class="t">Popular pages</div><nav>
>       <a href="/platform/ai-chat">AI Chat</a><a href="/platform/integrations">Integrations</a>
>       <a href="/platform/semantic-layer">Semantic Layer</a><a href="/docs/">Documentation</a>
>       <a href="/resources/contact-support">Support</a>
>     </nav></div>
>   </div></main>
>   <footer>© Devart — Insightis · AI Analytics Workspace</footer>
> </body>
> </html>
> ```
> Then remove the dead route mapping in **both** `src/components/Header.jsx` (line ~66) and
> `src/components/Footer.jsx` (line ~21) — delete the line:
> ```js
> 'Memory & Storage': '/platform/memory-storage',
> ```
> `/platform/memory-storage` does not exist. The "Memory & Storage" nav item is marked
> `notClickable`, so nothing in the nav breaks; this removes a latent trap. *Alternative:* if the
> feature ships soon, create `platform/memory-storage.html` and add it to `input` in `vite.config.js`.
>
> **Task 5 — Sync numbers across pages (AUD-05).**
> Home says "500+ pre-built definitions" but Semantic Layer says "498 built-in metrics"; Home says
> "200+ connectors" but Integrations says "20 sources." Pick one source-of-truth value per metric
> and use it everywhere. Grep the site for `500+`, `498`, `200+`, `20 sources` and reconcile.
>
> **Task 6 — Add ARIA state to the nav menu buttons (AUD-06).**
> In `src/components/Header.jsx`, the `Platform` / `Solutions` / `Resources` buttons need
> `aria-haspopup="menu"` and a toggled `aria-expanded` (WCAG 4.1.2). Verify keyboard open/close and
> that Esc closes the menu.
>
> ### P2 — accessibility & readability polish
>
> **Task 7 — Tap targets ≥44px (AUD-07).**
> The "Made for every team" tabs (Home) and the Platform submenu items are ≈18–19px tall. Increase
> the clickable padding so the hit area is ≥44px on mobile (WCAG 2.5.8 / 2.5.5).
>
> **Task 8 — Fix low-contrast functional captions (AUD-08).**
> In the demo widgets (AI Chat, Integrations, Semantic Layer, Home), functional labels such as the
> `Thinking` state (≈2.8:1) and the "before" side of comparisons (≈2.5:1) fall below AA. Raise
> functional labels to ≥4.5:1 and ≥12px, and add a non-color cue to the "before"/"bad" side so
> meaning isn't carried by color alone (WCAG 1.4.1). Decorative graphic labels that already pass
> 3:1 can stay.
>
> **Task 9 — Raise body descriptions to 15–16px (AUD-09).**
> Description paragraphs default to 14px. Raise **only real description paragraphs** to 15–16px (the
> "how it works" steps, Solutions descriptions, the Devart trust line, plan features on Pricing).
> Do not change labels, badges, nav, or eyebrow text (11–13px is intentional).
>
> ### P3 — cleanup
>
> **Task 10 — Reduce CTA repetition (AUD-10).**
> "Get answers… not days" is duplicated and the `Start for free / Explore Pricing` pair repeats in
> almost every section. Keep one primary CTA per intent and vary the supporting copy.
>
> **Task 11 — Fix copy defects (AUD-11).**
> H1 words glued by `<br>` ("Get answers in / seconds" → "Get answers inseconds") and a double space
> in "Stop arguing about  which number." Fix spacing.
>
> **Task 12 — Extract inline `<style>` blocks (AUD-12).**
> Each page has inline CSS with media queries inside `<main>`. Move these to stylesheets /
> design-system tokens. No visual change intended — hygiene only.
>
> ### Additional consistency & a11y fixes (v1 live-site pass)
>
> **Task 13 — Accessible discounted price (AUD-20).** On Pricing, the old price is only visually
> struck through, so it reads as "$7.99 $15.99" with no relationship. Wrap the old price in
> `<s>` with an sr-only "was", and label the new price sr-only "now" (WCAG 1.3.1).
>
> **Task 14 — Reconcile connector numbers (AUD-21).** Integrations shows "200+ connectors" and
> "+180 more connectors available" together. Reconcile to one consistent statement.
>
> **Task 15 — Unify terminology (AUD-13, AUD-14, AUD-22).** Pick canonical nouns and apply site-wide:
> one term for connectors/integrations/sources; one term for pre-built metrics (currently
> "Pre-built metrics" / "built-in metrics" / "Predefined Metrics" / "Metric definitions"). On Home,
> the same 200+ stat is labeled both "Integrations" and "Connectors" — pick one.
>
> **Task 16 — Copy & notation cleanup (AUD-15, AUD-16, AUD-17, AUD-18, AUD-19, AUD-23).**
> - AUD-17: Home H1 "Talk to your data It already knows the answer" → add punctuation/break.
> - AUD-16: add a space in "12×faster", "90%fewer" (Integrations), "3×more" (Semantic Layer).
> - AUD-15: use one accuracy notation ("3×", not "X3").
> - AUD-18: one terminal-punctuation rule for page H1s.
> - AUD-19: one label for the pricing CTA ("Explore Pricing" vs "Pricing").
> - AUD-23: one casing rule for Home stat labels ("28 years" vs "28 Years", "companies" vs "Companies").
>
> Most of Task 15–16 are content decisions — confirm the canonical values/terms with product first.
>
> ### Continuation — the rest of the audit (AUD-24 … AUD-80)
> Generated from findings.md so nothing is dropped (see `HANDOFF-GEN.md`). Blockers first.
>
> #### P0 / P1 — remaining release blockers
> **Task 17 — 30 dead help-topic links (AUD-24, 🔴).** Contact Support self-service grid: all 30 `href="#"` links go nowhere. Point each to its real doc URL, or remove until docs exist.
> **Task 18 — Remove the Ask-AI mock (AUD-25, 🟠).** Delete the "Ask a question / Ask AI" input (`contact-support.jsx` ~:276), the "Ask AI" button (~:303) and the mock response (~:326). Decision: **remove, don't wire.** Resolves AUD-30 too.
> **Task 19 — Associate Support form labels (AUD-26, 🟠).** SupportTicketModal fields need `id`+`htmlFor` (or `aria-label`) — Subject / Details / Email.
> **Task 20 — Connector CTA reachable without hover (AUD-27, 🟠).** Shared ConnectorCard "Sign in to connect" is hover-only. Reveal on `:focus-within`; keep visible under `@media (hover:none)`.
> **Task 21 — Modals use the DS shell (AUD-43, 🟠).** `SupportTicketModal.jsx` / `SalesEnquiryModal.jsx` → `.ins-modal` header/body/footer with focus trap + Esc.
> **Task 22 — One primary button (AUD-50, 🟠).** Replace the hand-rolled gradient/pill CTAs (`success-stories.jsx:290`, `WaitlistForm.jsx`, `app.css:160`) with `<Button variant="primary">`; make any gradient a DS variant.
> **Task 23 — One comparison component (AUD-51, 🟠).** Standardize on `<ComparisonCards>` (Home / `ai-chat.jsx:884` / `semantic-layer.jsx:442` / `integrations.jsx:558`); deprecate the duplicate class; remove dead imports.
> **Task 24 — Fix Security privacy link (AUD-66, 🟠).** `security.jsx:140` `href="Privacy"` → `/privacy` (currently 404s at `/security/Privacy`).
>
> #### P2 — content, functionality & DS consistency (🟡)
> - **AUD-28 / AUD-67** support email `support@insightis.io` → canonical domain; unify contact domain (.ai vs .io) everywhere + boilerplate.
> - **AUD-29** Contact Support status badge hardcoded "All systems operational · 2 min ago" — bind to real status or drop the line.
> - **AUD-31** Roadmap contradicts itself (Now vs shipped; timeline vs kanban; "Q2 2026" past-as-present) — dedupe + align + update the present marker.
> - **AUD-32** Blog 2026 titles vs 2024 body — fix frontmatter `description` + body years.
> - **AUD-65** FAQPage JSON-LD with no on-page FAQ (AI Chat, Integrations) — render `<FAQAccordion>` or drop the schema.
> - **AUD-69** Success Stories closing CTA form does nothing (`success-stories.jsx:288`) — wire to sign-up or use `<BottomCTA>`.
> - **AUD-39** secondary button resting border too faint — dedicated `--ins-button-secondary-border` (see `fix-examples.html`).
> - **AUD-40** footer reflow gap at tablet — 3-col `1fr` grid, `align-items:start`, drop `justify-content:flex-end`.
> - **AUD-44** chat widgets diverge — codify the site's chat look into the DS component; site consumes it (no visual change).
> - **AUD-47** eyebrows overridden to 10px mono (~14 pages) — put text in `.ins-eyebrow`, remove overrides.
> - **AUD-48** parallel stat system — use `.ins-stat-kpi` / `StatStrip`.
> - **AUD-52** hand-rolled bottom CTA (`success-stories.jsx:279`, `security.jsx:232`) → `<BottomCTA>` + `.ins-section--tint`.
> - **AUD-53** raw colours/radii → tokens (`--ins-color-teal-*` / `--ins-radius-*` / `--ins-surface-*`).
> - **AUD-54** DS control primitives bypassed — use `.ins-badge--tab`, `.ins-segmented`, `.ins-input-group`.
> - **AUD-56** comparison "before" card uses red — neutral grey (keep glow); red only for real errors.
> - **AUD-58** Semantic-Layer subhead teal too low-contrast — raise to `--ins-text-highlight` (keep it green).
> - **AUD-64** heading hierarchy skips h1→h3 (Blog, Connectors, Prompt Library, Contact Support, Solutions heroes) — section titles = h2; demote decorative headings.
>
> #### P3 — polish: consistency / copy / IA / a11y / hygiene (⚪)
> - **Content:** AUD-42 remove duplicate "Data Sources" eyebrow (Integrations connect-flow); AUD-70 rename Security "certifications" heading to match content.
> - **Broken:** AUD-34 drop "or data source" placeholder (Prompt Library) or add the facet; AUD-35 add trailing slash to Docs sign-up link (`content/welcome.md:9`).
> - **Numbers/terms:** AUD-15 one accuracy notation ("3×"); AUD-57 Semantic metrics footer "498 / 20" uniform colour + typeface.
> - **Design-system:** AUD-41 remove button glow/box-shadows (`app.css:167`, `main.jsx:372`); AUD-45 heading letter-spacing from tokens (~-.02em); AUD-46 Success-Stories cards → `.ins-article-card` / `.ins-card`; AUD-55 remove copied `SearchInput` markup + dead/undefined classes (`docs.jsx:251`); AUD-59 sentence-case button labels ("Explore pricing"); AUD-60 banner highlight → `--ins-text-highlight` (teal-400, not teal-600); AUD-61 "See all 200+ integrations" → `<Button variant="secondary">`; AUD-63 ConnectorCard hover eased + DS button; AUD-68 delete dead imports/stubs (`product-teams.jsx`, `analytics-teams.jsx`).
> - **Accessibility:** AUD-33 Solutions integrations pill ≥44px; AUD-36 Blog thumbnails descriptive `alt` (`blog.jsx:96`); AUD-37 Roadmap/Executive mockup text ≥12px or text alt; AUD-49 `.ins-link` keeps underline on hover; AUD-62 FAQ row clear hover state; AUD-73 Roadmap SVG milestones in the DOM outline; AUD-75 Docs sidebar hover only brightens label — fill reserved for `[aria-current]`.
> - **Copy:** AUD-16 space in "12×faster" / "90%fewer" / "3×more"; AUD-11 fix `<br>` glue + double space; AUD-18 one H1 terminal-punctuation rule; AUD-23 lowercase Home stat labels; AUD-38 Finance mockup interpunct / casing.
> - **IA:** AUD-71 Home uses `<SectionHeader>` / `<StepsProcess>` (overview first); AUD-72 reframe Solutions Use Cases vs Feature Spotlights.
> - **Responsive:** AUD-74 Pricing table stack/scroll at 320px (`pricing.jsx:170`).
> - **Code hygiene:** AUD-12 — already Task 12.
> - **New (v1 live pass, 2026-08-10):** AUD-77 footer socials → `--ins-text-primary` (`Footer.jsx:133`); AUD-78 remove home hero animation text labels (`main.jsx`); AUD-79 AI-chat "Thinking" logo matches label colour at end (`ai-chat.jsx:1066`); AUD-80 "View prompts" no hover/press shift (`prompt-library.jsx:452`).
>
> ### Verification
> 1. `npm run dev` — open `/pricing`: discount figure matches between cards and FAQ (Task 1); FAQ
>    names only Free/Starter/Pro (Task 2).
> 2. Open `platform/ai-chat.html` (markup, no JS): both inline links resolve to real routes (Task 3).
> 3. Open `http://localhost:5173/404.html` — dark branded 404 with teal "404", logo, buttons (Task 4).
> 4. Grep confirms the metric numbers now match across Home / Integrations / Semantic Layer (Task 5).
> 5. Keyboard-test the nav menus: `aria-expanded` toggles, Esc closes (Task 6).
> 6. Contact Support: help-topic links resolve or are removed (Task 17); the Ask-AI panel is gone (Task 18); the support/sales modals trap focus + close on Esc (Task 21); the connector "Sign in to connect" CTA is reachable by keyboard (Task 20).
> 7. `npm run build` — no errors.
> 8. After deploy — open any non-existent URL (e.g. `/nope`): branded 404, not the raw Vercel page.

---

## Notes
- **Product decisions embedded above:** the exact discount % (Task 1), whether Team/Enterprise are
  real (Task 2), and the canonical metric values (Task 5) need product/content sign-off before the
  copy is finalized. The engineer applies the agreed values.
- The branded `public/404.html` is already prepared in the working copy `insightis-site/` — copy it
  or recreate from the block above.
- For the *why it matters* and before/after visuals behind each task, see
  [`report-visual.html`](report-visual.html).
