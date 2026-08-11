# Audit report style — the one instruction

Every audit **report** deliverable is built to look like one document. This file
is the rule; `report.css` is the code. Read both before creating or editing a
report.

---

## 1 · Two categories — don't mix them

| Category | Files | Styling |
|---|---|---|
| **Report** (findings, handoffs, concepts) | `report-visual.html`, `dev-handoff.html`, `fix-examples.html`, any future index/summary | Use the shared **report chrome** in `report.css`. |
| **DS mockup** (a pixel of the real product) | `404-design.html` | Link the real design system (`design-system/ds/index.css`); reproduce the live site. **Never** apply the report chrome to these. |

A report *describes* the site. A DS mockup *is* a slice of the site. They look
different on purpose.

---

## 2 · How to apply the chrome (self-contained, on purpose)

Reports must render from raw GitHub / htmlpreview with **no network fetch**, so a
relative `<link rel="stylesheet" href="report.css">` is **not** used — htmlpreview
does not resolve it (that is why `404-design.html` hard-codes an absolute DS URL).

Instead **embed a copy of `report.css` inline**, fenced by markers:

```html
<style>
/* >>> report.css shared chrome — synced from report.css, do not hand-edit <<< */
…the entire contents of report.css…
/* <<< end shared chrome >>> */

/* page-specific styles only, below the marker */
.cmp-card{ … }
</style>
```

**Workflow:** edit `report.css` first → paste it back into each report between the
markers → keep only truly page-specific rules after the end marker. `report.css`
is the source of truth; the inline blocks are synced copies.

---

## 3 · Page skeleton (every report)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Insightis — Audit v1 · <Page></title>
  <style>/* shared chrome (inline copy) + page-specific */</style>
</head>
<body>
<div class="wrap">            <!-- .wrap--wide for demo-heavy pages -->

  <!-- top bar: brand left, cross-links right, current page marked -->
  <div class="bar">
    <span class="brand">&#9670; Insightis — Audit v1</span>
    <nav>
      <a href="report-visual.html" aria-current="page">Report</a>
      <a href="dev-handoff.html">Dev handoff</a>
      <a href="fix-examples.html">Fix examples</a>
      <a href="concepts.html">Concepts</a>
      <a href="../findings.html">Findings</a>
    </nav>
  </div>

  <h1>…</h1>
  <p class="sub">…</p>

  <!-- content -->

  <!-- closing link row -->
  <h2>More</h2>
  <p class="sub more">Source of truth: <a href="../findings.html">findings</a> · … </p>

</div>
</body>
</html>
```

The bar is identical on every page; only `aria-current="page"` moves. That single
marker is what makes them read as one set.

---

## 4 · Tokens & scale (all in `report.css`)

- **Surfaces:** `--page #0A0E13` · `--surface #0D1117` · `--card #131820` · `--line rgba(255,255,255,.08)`
- **Text:** `--heading #E8F2F5` · `--text #C0D4DC` · `--muted #7FA0AC`
- **Brand:** `--teal #0EC4C1` (= `--ins-text-highlight`) · `--teal500 #148F8D` · `--teal600 #07807E`
- **Severity:** `--crit #F87171` · `--high #FB923C` · `--med #FBBF24` · `--low #7FA0AC`
- **Verdict:** `--good #34D399` · `--bad #F87171`
- **Type:** body `14px/1.55` system sans; `--mono` for code/ids. `h1` 22px · `h2`
  14px UPPERCASE + underline (section divider) · `h3` 11px uppercase muted label.
- **Width:** `.wrap` 960px; `.wrap--wide` 1180px for side-by-side demo pages.

Use the tokens — never hard-code a hex in a report. (This mirrors the site rule:
build from the design system, don't reinvent.)

---

## 5 · Components

- **Finding** — `.f` + severity (`.crit/.high/.med/.low`) → header `.fh` (`.sv`
  badge, `.id`, `.ti`, `.lnk`) → rows `.r` with `.k`/`.v`, one per line:
  **Where** (`.r.loc`) · **Now** (`.r.now`) · **Should be** (`.r.exp`) · **Fix**
  (`.r.fix`). Keep that four-line order.
- **Callout** — `.callout` (neutral); `.callout--crit` for release-blockers (red).
- **Before/after demo** — `.grid2` → `.demo.bad` / `.demo.good` with a `.tag`
  (`.bad`/`.good`); code in `<pre>`, captions in `.note`.
- **Long-form doc** — wrap markdown in `.doc` (headings, tables, blockquotes,
  lists). Used by `dev-handoff.html`.

---

## 6 · Content rules (carried from the audit)

- **Buttons carry no shadow/glow** in any visualization (glow only where the user
  approved it — the comparison "before/after" cards).
- **Sentence case** for button labels and UI copy.
- A **"Current"/"Now"** pane must reproduce the live site 1:1 — never approximate.
  If you don't have the exact content, fetch it before rendering.
- A fix that only needs to **match a pattern already on the site** is a *finding*
  (put the concrete required state in the finding), not a redesign *proposal*.
  Redesigns needing sign-off go to `fix-examples.html`.

---

*Change the look?* Edit `report.css` + this file first, then re-sync every inline
copy so the set stays consistent.
