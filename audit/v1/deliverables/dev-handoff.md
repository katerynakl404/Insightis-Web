# Developer Handoff — Insightis Audit v1

**For:** the maintainer of the site repository (`insightis-site`, with commit/deploy access).
**Source:** generated from [`../findings.md`](../findings.md) (Accepted findings AUD-01 … AUD-12).
If a step and the findings disagree, the findings file wins — regenerate this handoff.

> This file is a **Claude-executable instruction**. Hand the prompt block below to Claude Code (or
> another agent) at the root of the site repo, or apply it by hand — the steps are identical.
> Stack: Vite + React, multi-page. Dev `npm run dev`, build `npm run build`, deploy Vercel
> (`vercel.json`, no catch-all rewrite).

---

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
> ### Verification
> 1. `npm run dev` — open `/pricing`: discount figure matches between cards and FAQ (Task 1); FAQ
>    names only Free/Starter/Pro (Task 2).
> 2. Open `platform/ai-chat.html` (markup, no JS): both inline links resolve to real routes (Task 3).
> 3. Open `http://localhost:5173/404.html` — dark branded 404 with teal "404", logo, buttons (Task 4).
> 4. Grep confirms the metric numbers now match across Home / Integrations / Semantic Layer (Task 5).
> 5. Keyboard-test the nav menus: `aria-expanded` toggles, Esc closes (Task 6).
> 6. `npm run build` — no errors.
> 7. After deploy — open any non-existent URL (e.g. `/nope`): branded 404, not the raw Vercel page.

---

## Notes
- **Product decisions embedded above:** the exact discount % (Task 1), whether Team/Enterprise are
  real (Task 2), and the canonical metric values (Task 5) need product/content sign-off before the
  copy is finalized. The engineer applies the agreed values.
- The branded `public/404.html` is already prepared in the working copy `insightis-site/` — copy it
  or recreate from the block above.
- For the *why it matters* and before/after visuals behind each task, see
  [`report-visual.html`](report-visual.html).
