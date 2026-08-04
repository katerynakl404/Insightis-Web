# Developer Handoff — Insightis Audit vN

**For:** the maintainer of the site repository (`insightis-site`, with commit/deploy access).
**Source:** generated from `audit/vN/findings.md` (Accepted findings only). If a fix and the
findings disagree, the findings file wins — regenerate this handoff.

> This file is a **Claude-executable instruction**. You can hand the prompt block below to
> Claude Code (or another agent) at the root of the site repo, or apply the steps by hand — they
> are identical.

---

## PROMPT (copy the whole block)

> You are working in the Insightis site repository (Vite + React, multi-page; dev `npm run dev`,
> build `npm run build`, deploy Vercel). Apply the tasks below **in priority order** and verify.
>
> ### P0 — <ship-blockers>
>
> **Task 1. <title>.**
> File: `<path>` (line ~NN). Replace:
> ```<lang>
> <exact current code>
> ```
> with:
> ```<lang>
> <exact replacement>
> ```
> Reason: <why — cite the finding ID, e.g. AUD-01>.
>
> ### P1 — <before next release>
>
> **Task 2. <title>.**
> <same shape: file → current → replacement → reason>
>
> ### P2 / P3 — <polish>
>
> **Task N. <title>.**
> <same shape>
>
> ### Verification
> 1. `npm run dev` — <what to check in the browser>.
> 2. <per-fix check>.
> 3. `npm run build` — no errors.
> 4. After deploy — <production check>.

---

## Notes
- Findings that require a **design decision** (not a mechanical edit) are listed separately below
  and are **not** in the prompt block — they need Figma/design sign-off first.
- <Design-gated finding> — see `report-visual.html` (AUD-NN).
