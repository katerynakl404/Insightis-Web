# Homepage review — implementation handoff (2026-05-20)

> Everything an engineer needs to apply iteration-3 review decisions to the Insightis homepage. **Start with [`IMPLEMENTATION-BRIEF.md`](IMPLEMENTATION-BRIEF.md).**

---

## What's in this folder

| File / folder | Purpose | When to read it |
|---|---|---|
| **[`IMPLEMENTATION-BRIEF.md`](IMPLEMENTATION-BRIEF.md)** | One-page entry point: scope rule, 8 PR gates, 5 systemic principles, token reference, verification checklist. | **Read first.** |
| [`homepage-review-log.md`](homepage-review-log.md) | Source of truth — all 97 findings under stable `ISS-NN` IDs with Status, Status-history, recommendation. Filter on `Status: Accepted` (57 items) for implementation scope. | Reference per PR. |
| [`review-framework.md`](review-framework.md) | Taxonomy (Category / Domain / Severity / Section) used by each finding. | Reference when categorising. |
| [`review-iteration-protocol.md`](review-iteration-protocol.md) | How to run iteration 4 once PRs land and the page changes. | After all PRs merged. |
| [`colors_and_type.css`](colors_and_type.css) | Canonical token brief. Cited by ISS-04. Add legacy aliases here so it's self-sufficient. | When implementing token migrations (Gate 2). |
| [`design-system/`](design-system/) | Design system source — `assets/tokens.css` (canonical token names), `components/*.html`, `foundations/*.html`, `patterns/*.html`. | Reference per PR. |

---

## What's NOT in this folder (you already have it in the project)

- The homepage source (`Homepage.html` + React/JSX build).
- The bundled CSS (`Homepage_files/`).
- Audit screenshots (`audit-screenshots/`) — referenced by ~12 findings that need visual judgment.

If any of those went missing, ask before proceeding.

---

## Workflow

1. Read `IMPLEMENTATION-BRIEF.md` end to end.
2. Pick the next gate from §3 "Order of operations".
3. Filter `homepage-review-log.md` for the IDs in that gate. For each one:
   - Read the **Problem** and **Recommendation**.
   - Read the latest `Accepted` row in **Status history** for the exact user-specified guidance.
   - Implement using DS tokens / components per the §4 systemic principles.
4. Verify per §6 of the brief (grep for raw hex, contrast checks, component-API match).
5. Open the PR. Reference the ISS-NN IDs in the PR description.

---

## Hard rules

- **Implement only `Status: Accepted`.** Never silently address Pending Review or Declined.
- **IDs are immutable.** Never renumber `ISS-NN`.
- **Findings are append-only.** Don't edit `Problem` / `Recommendation` fields. If a finding needs amendment, raise it back to the user — a new ISS-NN supersedes it.

---

## Provenance

- Iteration 3 conducted 2026-05-20 against `Homepage-audit-render.html` (byte-equal to May 18 baseline modulo one CSS rule).
- 97 findings total: 57 Accepted, 1 formally Declined (ISS-68 duplicate-merge), 39 still Pending Review.
- Source HTML, screenshots, and prior-baseline archive remain in the main project tree.
