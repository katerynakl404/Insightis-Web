# Developer Handoff — Insightis Audit v1

**For:** the maintainer of the site repository (`insightis-site`, with commit/deploy access).
**Source of truth:** [`../findings.md`](../findings.md) — **all 77 Accepted findings**, prioritized P0 → P3, each with location (page › block + `file:line`), current state, expected state, and the fix.

This handoff is **just the instruction for applying them** — it does not restate the findings. If this file and `findings.md` ever disagree, the findings win. Regenerate via [`HANDOFF-GEN.md`](HANDOFF-GEN.md) if the process changes.

> This file is a **Claude-executable instruction**. Hand the prompt block below to Claude Code (or another agent) at the root of the site repo, or apply it by hand — the steps are identical.

## PROMPT (copy the whole block)

> You are working in the Insightis site repository (`insightis-site`).
> Stack: Vite + React, multi-page — dev `npm run dev`, build `npm run build`, deploy Vercel (`vercel.json`, no catch-all rewrite).
>
> 1. Open `findings.md` (Insightis Audit v1) — the complete, prioritized list of all 77 Accepted findings (P0 → P3). Each finding gives its location (page › block + `file:line`), the current state, the expected state, and the fix.
> 2. Apply the fixes **in priority order**: P0 ship-blockers first, then P1 → P2 → P3. Do **not** restyle the site — these are targeted fixes only.
> 3. Some items are **content/product decisions** (exact discount %, whether the Team/Enterprise tiers are real, the canonical metric values and terminology). Confirm those with product/content first, then apply the agreed value. They are flagged in `findings.md`.
> 4. Some items need **design sign-off** or are larger DS refactors — see [`fix-examples.html`](fix-examples.html) before touching them.
> 5. Verify at the end: `npm run build` passes with no errors; spot-check each P0 fix in `npm run dev`; after deploy, an unknown URL (e.g. `/nope`) shows the branded 404, not the raw Vercel page.

## Where to look
- **The list to work from:** [`../findings.md`](../findings.md) (authoritative).
- **Why each fix matters + before/after visuals:** [`report-visual.html`](report-visual.html).
- **Proposed redesigns pending sign-off:** [`fix-examples.html`](fix-examples.html).
- **Design references (concept mockups, not tasks):** the [Concepts](concepts.html) page — e.g. the branded 404 ([404-design.html](404-design.html)). Reproduce these against the live design system; don't inline them as tasks.

## Notes
- The branded `public/404.html` is already prepared in the working copy `insightis-site/` — copy it, or recreate from the [404 concept](404-design.html).
- Product-decision items (above) block only the *final copy*, not the engineering — wire the mechanics, drop in the agreed values when confirmed.
