# How to (re)generate the dev handoff — so it never drifts

`dev-handoff.md` kept going stale because findings were added to the report but not
to the handoff. Fix: **treat it as generated.** Never hand-edit finding data in the
handoff — edit `../findings.md`, then regenerate the handoff by following this file.

> **One source of truth:** `../findings.md`. `report-visual.html` and `dev-handoff.md`
> are both *derived views* of it (findings.md itself says so at the top). If a
> deliverable disagrees with findings.md, findings.md wins — regenerate.

---

## When to run this

After **any** change to `../findings.md` (new finding, status change, edited fix).
Hand this to Claude Code (or apply by hand):

> Regenerate `dev-handoff.md` from `../findings.md` following `HANDOFF-GEN.md`.

---

## Rules (deterministic)

1. **Cover every Accepted finding — no subset.** Read `../findings.md`; include every
   finding whose heading is `(Accepted …)`. **Skip** `(Declined …)` / withdrawn ones.
   The handoff's task count must equal the Accepted count in the findings status table
   (today: **77**). This is the rule that was being broken.

2. **Priority = severity.** Map and order:
   - 🔴 Critical → **P0** · 🟠 High → **P1** · 🟡 Medium → **P2** · ⚪ Low → **P3**
   - Inside P0/P1, list **release blockers first** — the Critical set plus the High set
     called out in `report-visual.html`'s "Release blockers" callout
     (AUD-01, 02, 24; 03, 04, 05, 21, 25, 26, 27, 43, 50, 51, 66).

3. **Per-finding task shape** — pull straight from the findings.md entry:
   `**AUD-NN (Sev) — <title>.**` then `<Current → Fix>` and the `File`/where.
   - **Ship-blockers + mechanical fixes** get full detail, including any code block the
     finding specifies. The branded-404 body comes from `404-design.html`; the AI-Chat
     fallback link edit from AUD-03.
   - The **long tail** (Low consistency / IA / copy) may be compact one-liners grouped
     by category — still one line per AUD so nothing is dropped.

4. **Keep the fixed scaffolding:** the `For:` / `Source:` header, the Claude-executable
   `PROMPT` wrapper, the `Verification` checklist, and the product-decision `Notes`.
   Update the header's finding count and the "generated from" line each run.

5. **Design mockups are references, not tasks.** 404 (AUD-04), the empty states, etc.
   link to their concept pages (see the report's **Concepts** section) — don't inline
   their full HTML as tasks beyond the one code block P1 needs.

---

## Output skeleton

```
# Developer Handoff — Insightis Audit v1
For / Source: generated from ../findings.md — regenerate via HANDOFF-GEN.md. (N Accepted findings.)
## Scope note      (this is the COMPLETE actionable set; report-visual = the visual view)
## PROMPT (copy the whole block)
   ### P0 — ship-blockers            (blockers first)
   ### P1 — before next release
   ### P2 — accessibility & readability
   ### P3 — consistency / copy / IA cleanup   (compact, one line per remaining AUD)
   ### Verification
## Notes           (product decisions to confirm)
```

*Want zero-touch?* This same spec can be encoded as a Node generator
(`scripts/gen-handoff.mjs` reading findings.md → writing dev-handoff.md); the manual
instruction above is the low-setup version. See [`REPORT-STYLE.md`](REPORT-STYLE.md)
for the shared report chrome.
