# Audit v1 — metadata

| | |
|---|---|
| **Version** | v1 |
| **Status** | Finalized |
| **Opened** | 2026-08-04 |
| **Finalized** | 2026-08-04 |
| **Object** | insightis-landing.vercel.app (dark theme) |
| **Pages in scope** | Full site (17 pages): Home, Pricing, AI Chat, Integrations, Semantic Layer, 6× Solutions, Docs, Blog, Connectors, Roadmap, Prompt Library, Contact Support |
| **Diffed against** | — (baseline version) |
| **Accepted findings** | 74 (3 Critical · 11 High · 27 Medium · 33 Low) |

## Contents

- [`findings.md`](findings.md) — source of truth (AUD-01 … AUD-12).
- [`deliverables/report-visual.html`](deliverables/report-visual.html) — visual report, 74 findings, each with a verify link (English).
- [`deliverables/dev-handoff.md`](deliverables/dev-handoff.md) — developer handoff (English).
- [`deliverables/fix-examples.html`](deliverables/fix-examples.html) — proposed redesigns (button/footer fixes, neutral comparison, metrics-catalog rethink) — **pending sign-off**, kept separate from findings.
- [`deliverables/404-design.html`](deliverables/404-design.html) — branded 404 design reference (AUD-04).
- [`evidence/heatmaps/`](evidence/heatmaps/) — attention/friction heatmaps for all 17 pages.

## Changelog

- **2026-08-04** — v1 established as the baseline. Migrated and translated from the initial
  weaknesses audit (`audit-findings.md`, Ukrainian) and the standalone 404 handoff
  (`handoff-embed-404.md`), then **expanded with a live-site + heuristic pass** (AUD-13…23:
  cross-page number/terminology inconsistency, copy/typography, accessibility). 23 findings filed
  under `AUD-NN`; both deliverables generated. Process defined in [`../README.md`](../README.md).

## Provenance note

The original audit used ad-hoc IDs (A1–A3, U1–U4, C1–C4, M1). Mapping to v1 IDs:

| Original | v1 ID | | Original | v1 ID |
|---|---|---|---|---|
| C2 | AUD-01 | | A1 | AUD-06 |
| C1 | AUD-02 | | U3 | AUD-07 |
| U1 | AUD-03 | | A2 | AUD-08 |
| U2 | AUD-04 | | A3 | AUD-09 |
| C3 | AUD-05 | | U4 | AUD-10 |
| | | | C4 | AUD-11 |
| | | | M1 | AUD-12 |
