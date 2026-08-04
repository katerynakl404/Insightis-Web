# Insightis — Website Design & Audit

Working repository for the **design system** and **UX/UI reviews & audits** of the Insightis website
(`insightis-landing.vercel.app`). It holds **design sources and review/audit documents — not the
deployed site code**. The site that ships to production lives in a separate repository and is built
& deployed via Vercel; changes proposed here are handed off to whoever has commit/deploy access there.

---

## Contents

| Path | What it is |
|---|---|
| [`design-system/`](design-system/) | Design system source — `assets/` (tokens & base CSS), `components/`, `foundations/`, `patterns/`. |
| [`audit/`](audit/) | **Current UX/UI audit.** See below. |
| [`IMPLEMENTATION-BRIEF.md`](IMPLEMENTATION-BRIEF.md) | Iteration-3 homepage review — engineer entry point (scope rule, PR gates, systemic principles, verification). |
| [`homepage-review-log.md`](homepage-review-log.md) | Iteration-3 review log — 57 accepted findings under stable `ISS-NN` IDs. |
| [`review-framework.md`](review-framework.md) | Taxonomy (Category / Domain / Severity / Section) used by findings. |
| [`review-iteration-protocol.md`](review-iteration-protocol.md) | How to run the next review iteration. |
| [`colors_and_type.css`](colors_and_type.css) | Canonical token brief (cited by ISS-04). |
| [`archive/`](archive/) | Declined findings — out of scope, kept for reference only. |

---

## `audit/` — versioned UX/UI audits

The audit program is a **versioned, interactive process**. Each global audit is a full-site
weaknesses sweep captured as a numbered version folder; every finalized version ships two English
deliverables. Read [`audit/README.md`](audit/README.md) before running or continuing an audit.

| Path | Purpose |
|---|---|
| `audit/README.md` | **The process** — versioning, the interactive decision gate, the two deliverable formats. Start here. |
| `audit/templates/` | Starter files for a new version (findings, visual report, dev handoff). |
| `audit/v1/` | **First global audit** (2026-08-04): `findings.md` (source of truth) + `deliverables/report-visual.html` (visual) + `deliverables/dev-handoff.md` (engineer) + `evidence/`. |

---

## What this repo is NOT

- **Not the deployed website.** Site code (the HTML/JSX/CSS that ships) lives in the separate site
  repository and deploys via Vercel. Functional changes — e.g. the custom **404 page** — cannot be
  committed here to take effect; they are delivered as a handoff (`audit/handoff-embed-404.md`) to the
  person/repo that deploys the site.

---

## Hard rules (review process)

- `homepage-review-log.md` is the scope for the iteration-3 review. `ISS-NN` IDs are **immutable** and
  findings are **append-only** — never renumber or edit; a new ID supersedes.
- `archive/declined-findings.md` is **terminal** — read-only reference, never re-proposed or silently fixed.

---

## Provenance

- Iteration-3 homepage review conducted 2026-05-20 (57 accepted, 40 declined).
- Current UX/UI audit added 2026-08-04 — see [`audit/`](audit/).
