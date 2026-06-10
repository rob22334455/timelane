# Timelane

Single-file, client-side roadmap builder ("plan on a page").
Sister product to Orgami: same chassis, same aesthetic, same
privacy promise. index.html only — no build step, no dependencies.
Deployed to GitHub Pages via push to main.

## What it makes

Slide-ready 16:9 swimlane roadmaps: a time axis, horizontal lanes,
items as bars, milestones as diamonds, an optional today line.
Data in via CSV or a form editor; out via PNG/SVG/deck exports.
It is a picture generator, not a project management tool.

## Network & privacy policy (inviolable)

- The page makes ZERO network requests at runtime, ever, enforced
  by the CSP. The CSP may never be weakened; no external origin
  may ever be added to any directive.
- Nothing is loaded from any external source — no CDNs, no fonts,
  no hotlinked images. Everything ships inside index.html.
- The About popover stays in plain, user-facing language — data
  stays on your machine, nothing to install, no third-party
  services. Technical detail lives in README.md only.

## Hard rules

- ONE index.html; inline CSS/JS; no frameworks
- The slide frame (title, footer, axis labels) and the chart
  content are separate coordinate spaces; never anchor frame
  elements to content bounds
- Fitting may only ever scale DOWN — small roadmaps render at
  natural size, centred; never upscale to fill
- Folding is the core feature: lanes that overflow collapse to
  "+ n more items"; the chart must always fit one clean slide
- NO dependency arrows between items, ever. Arrows between bars
  require routing, routing requires a canvas, and a canvas is a
  different product. Sequence is shown by position on the time
  axis; nothing else.
- Exports contain zero UI chrome
- Dates are UK-first: dd/mm/yyyy, ISO yyyy-mm-dd, "Mar 2026",
  "Q1 2026" all accepted; ambiguous dates resolve dd/mm, never
  mm/dd. Unparseable dates produce a plain import warning naming
  the row, never a silent guess.

## Aesthetic

Matches Orgami exactly: same five themes (marine, claret, forest,
graphite, ochre), same font stack, same card/border/line tones,
same title treatment (top-left, accent rule), same "n items"
footer bottom-right. A Timelane slide and an Orgami slide in the
same deck must look like siblings.

## Vocabulary

User-facing strings use these terms exactly; new features must
name their concepts here before adding UI:

- "lane" — a horizontal workstream band (never "swimlane",
  "stream", "row")
- "item" — a bar with a start and end (never "task", "activity")
- "milestone" — a single-date diamond
- "status" — the colour: green / amber / red / blue / grey
- "today line" — the vertical current-date marker
- "fold" / "+ n more items" — lane overflow behaviour
- "slide" — what you see and export
- Export menu groups: "This slide", "Whole plan", "Your data";
  actions "PNG image", "SVG", "Deck (.pptx)", "CSV"

## Layout regression checklist

Any change touching layout, dates, folding, fitting, titles or
exports MUST be verified against ALL of these — in-app AND in
SVG/PNG exports — before committing, with results reported per
item:

1. Sample plan (default) — lanes, bars, milestones, today line
   all correct
2. Crowded lane: a lane with ~10 overlapping items — rows stack
   then fold, never overlap or spill
3. Tiny plan: 1 lane, 2 items — natural size, centred, no
   upscaling
4. Long range (3+ years) and short range (6 weeks) — axis units
   adapt (quarters vs months/weeks), labels never collide
5. Milestone-heavy: clustered same-date milestones — labels
   legible, no overlap
6. With a long title and with no title — title pinned to the same
   frame position and size in every view
7. Date edge cases: dd/mm/yyyy, "Q1 2026", an unparseable date
   (warns, names the row), an item ending before it starts
   (warns), items outside the axis range
8. Transparent export: PNG alpha background and SVG with no
   background rect — bars/text legible, no white fringing
9. Today line on, off, and out of range (hidden without error)

## The sample must permanently exercise every checklist case
that renders on a clean slide (crowding/folding, milestone
clusters, all four date formats, today line). It must load with
ZERO warnings — the warning cases in item 7 are verified with
throwaway edge-case CSVs at review time, never by shipping broken
rows in the sample.

## Decided, do not revisit without the user

- Dependency arrows: never (see Hard rules). Sequence is position.
- Sub-plans: planned for v2 — optional "Sub-lane" CSV column,
  lane drill-down mirroring Orgami's View team pattern. Not in v1.
