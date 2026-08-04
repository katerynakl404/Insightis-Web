# Insightis — Audit Process

How global UX/UI audits of the Insightis website are run, versioned, and delivered.
This folder is the **single home** for audits. Read this file before starting or continuing an audit.

> **TL;DR** — An audit is a full-site weaknesses sweep at a point in time. Every global audit
> gets its own **numbered version folder** (`v1/`, `v2/`, …). It is run as an **interactive,
> gated process** (Claude proposes findings, the user decides each one). When finalized, every
> version ships **two English deliverables**: a **visual report** (`report-visual.html`) and a
> **developer handoff** (`dev-handoff.md`).

---

## 1. Core concepts

| Term | Meaning |
|---|---|
| **Global audit** | One full-site weaknesses sweep (all in-scope pages) captured at a point in time. Each global audit = one version. |
| **Version** | A numbered, self-contained folder `vN/`. Once **Finalized**, its contents are immutable — the next audit starts a new folder `vN+1/`. |
| **Finding** | One issue, with the schema from [`../review-framework.md`](../review-framework.md) §1.4. IDs are `AUD-NN`, immutable and append-only within a version. |
| **Decision gate** | The interactive step: Claude proposes findings, the user Accepts / Declines / Defers each. Only **Accepted** findings reach the deliverables. |
| **Source of truth** | `vN/findings.md`. The two deliverables are **projections** generated from it — never edit the deliverables by hand to change a finding. |

This process **reuses** the existing program machinery — do not duplicate it:

- **Taxonomy & severity** (Domain / Category / Severity / Section, finding schema, out-of-scope list): [`../review-framework.md`](../review-framework.md).
- **Decision machinery** (Accepted / Declined / Deferred, terminal-decline archive, iteration diffs, duplicate detection): [`../review-iteration-protocol.md`](../review-iteration-protocol.md).

The only thing this file adds on top: **global versioning** + **the two required deliverables** + **the interactive run flow**.

---

## 2. Version folder layout

Every version folder is self-contained:

```
audit/
├── README.md                     ← this instruction
├── templates/                    ← copy these to start a new version
│   ├── findings.template.md
│   ├── report-visual.template.html
│   └── dev-handoff.template.md
└── vN/
    ├── VERSION.md                ← metadata: scope, date, status, changelog vs vN-1
    ├── findings.md               ← SOURCE OF TRUTH — all findings (AUD-NN schema)
    ├── deliverables/             ← the two FINAL English outputs
    │   ├── report-visual.html    ← DELIVERABLE 1 — before/after visuals
    │   └── dev-handoff.md        ← DELIVERABLE 2 — Claude-executable dev prompt
    └── evidence/                 ← supporting material cited by findings
        ├── heatmaps/             ← per-page attention/friction heatmaps (HTML + PNG)
        └── screenshots/          ← breakpoint captures
```

---

## 3. The interactive process

An audit runs in six phases. **Phases 3 is the gate** — Claude never finalizes findings the
user hasn't decided. Each phase ends with an explicit handoff back to the user.

### Phase 0 — Open the version
- Create `audit/vN/` by copying `templates/` into it.
- Fill `VERSION.md`: version number, date, pages in scope, and (from v2 onward) which prior version this diffs against.
- Set `Status: Draft`.

### Phase 1 — Capture evidence
- Inspect the **live site** (DOM/CSS) and the **source** (`insightis-site/`).
- Capture screenshots at the canonical breakpoints (1440 · 1024 · 768 · 375) into `evidence/screenshots/`.
- Produce/refresh per-page **heatmaps** into `evidence/heatmaps/`.
- From v2 onward: run the diff-vs-previous step from [`../review-iteration-protocol.md`](../review-iteration-protocol.md) §1.

### Phase 2 — Draft findings
- Walk each in-scope page top-to-bottom using the section taxonomy (framework §1.7).
- File each finding in `findings.md` with `Status: Pending Review`, using the schema (framework §1.4): Domain, Severity, Section, Category, Current, Expected, Visual (before/after), Notes.
- From v2 onward: run **duplicate detection** against prior versions (protocol §3) before filing anything net-new.

### Phase 3 — Decision gate (interactive) ⟵ the heart of the process
- Claude presents findings to the user **in batches** (e.g. by page or by severity), each with a one-line proposal.
- For each finding the user chooses:
  - **Accept** → stays in `findings.md`, will appear in both deliverables.
  - **Decline** → moved to `archive/declined-findings.md` (terminal — never re-proposed; protocol §2a).
  - **Defer** → `Status: Backlog`, kept but excluded from this version's deliverables.
  - **Discuss** → `Status: Discuss`, resolved before finalizing.
- **Claude proposes; the user decides.** No status other than carry-forward flips without the user's explicit yes.
- Every decision is recorded as a Status-history row on the finding.

### Phase 4 — Finalize findings
- Confirm no finding is still `Pending Review` or `Discuss`.
- Write the end-of-pass report (protocol §5, 10 sections) into `findings.md`.

### Phase 5 — Generate the two deliverables
Both are generated **from the Accepted findings**, written in **English**, into `vN/deliverables/`:
1. `deliverables/report-visual.html` — from `templates/report-visual.template.html` (see §4.1).
2. `deliverables/dev-handoff.md` — from `templates/dev-handoff.template.md` (see §4.2).

### Phase 6 — Close the version
- Set `VERSION.md` → `Status: Finalized` with the finalize date.
- Add a row to the **version index** (§5) in this README.
- The version is now immutable. The next global audit is `vN+1`.

---

## 4. The two deliverables

Both are **always English** and are **projections of `findings.md`** — regenerate them, never
hand-patch a finding into them.

### 4.1 `report-visual.html` — visual report (stakeholder-facing)
- Self-contained HTML, dark theme, built on the design-system tokens (`--ins-*`; see [`../design-system/assets/tokens.css`](../design-system/assets/tokens.css)). **Do not hardcode hex** — reuse tokens.
- One card per Accepted finding: ID, severity badge, domain, section, **Problem**, **Expected**, and a **before/after visual compare** (two panes: *Current* vs *Recommended*).
- Header with severity totals; the prioritized action plan table; links to the heatmaps.
- Purpose: let a non-engineer see *what's wrong and what "good" looks like*.

### 4.2 `dev-handoff.md` — developer handoff (engineer-facing)
- A **Claude-executable instruction**: an engineer (or an agent in the site repo) can act on it directly.
- Structure: context header (repo, stack, dev/build/deploy commands) → tasks grouped by priority (P0…P3), each with **file path**, **exact current code**, **exact replacement**, and **reason** → a final **verification checklist**.
- Models the shape of the existing 404 handoff. Purpose: *unambiguous, ready-to-apply fixes*.

---

## 5. Version index

| Version | Date | Scope | Status | Findings (accepted) | Deliverables |
|---|---|---|---|---|---|
| [v1](v1/) | 2026-08-04 | Full site (17 pages) | Finalized | 74 | [visual](v1/deliverables/report-visual.html) · [handoff](v1/deliverables/dev-handoff.md) · [concepts](v1/deliverables/fix-examples.html) · [404](v1/deliverables/404-design.html) |

---

## 6. Rules (do not break)

- **A finalized version is immutable.** Corrections after finalize = a new version `vN+1`, diffed against `vN`.
- **`findings.md` is the source of truth.** The two deliverables are regenerated from it; never edit a deliverable to change a finding.
- **The user decides every status transition** (except carry-forward). Claude proposes.
- **Declined is terminal.** A declined finding is archived and never re-proposed (protocol §2a).
- **IDs are immutable and append-only** within a version. `AUD-NN` is never renumbered or reused.
- **Reuse the design system** in `report-visual.html` (tokens/classes) — no inline hardcoded styles.
- **Deliverables are English**, regardless of the working language used during the audit.

---

## 7. Quickstart — start or continue an audit

Paste this to Claude to kick off an interactive audit:

> Run a global audit of the Insightis site following `audit/README.md`. Open the next version
> folder, capture evidence, draft findings against `review-framework.md`, then take me through the
> decision gate finding-by-finding before generating `report-visual.html` and `dev-handoff.md`.
