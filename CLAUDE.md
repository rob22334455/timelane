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
- "sub-lane" — a band within a scoped lane view (optional
  Sub-lane CSV column; never affects the whole-plan layout)
- "View lane" — the drill-down affordance on lane labels and
  "+ n more items" strips
- "Whole plan" — the unscoped view; the breadcrumb's first step
- "item" — a bar with a start and end (never "task", "activity")
- "milestone" — a single-date diamond
- "status" — the colour: green / amber / red / blue / grey
- "today line" — the vertical current-date marker
- "axis" — the time scale; the Axis control (Slide tab) offers
  exactly "Auto", "Months", "Quarters" — Auto picks weeks /
  months / quarters from the range, forced units affect gridlines
  and labels only (bars never move)
- "year start" — the month the plan's year begins; the "Year
  starts" control (Slide tab, Year section). January is the
  calendar year and the default. Quarters align to it (April →
  Q1 is Apr–Jun) and year markers move to that month. A quarter
  typed in the data ("Q1 2026") means the plan year that STARTS
  in that year, so with an April start "Q4 2026" is Jan–Mar 2027
- "year label" — how the year is named in axis labels; the "Year
  label" control offers exactly "2026", "FY26", "FY2026", "FY27"
  (named by the year it ends) and "FY26/27", each shown as a live
  example from the plan on screen. It renames the year only —
  never moves a bar or a gridline
- "range" — the slice of time the slide shows; the Range control
  (Slide tab) offers "Whole plan" (default), every year and every
  quarter the plan touches (named by the year label), and
  "Custom…", which reveals "From" and "To" taking the same date
  formats as the data. Either Custom end may be blank (open to
  that end of the plan); an unreadable one leaves that end open
  and says so, never guesses. Items outside the range are absent,
  an item crossing an edge is cut there and drawn FLUSH and
  square to the rail (never rounded — a clipped item must not
  read as one that stops), a lane that empties keeps its band,
  and the footer counts only what the slide shows
- "fold" / "+ n more items" — lane overflow behaviour
- "slide" — what you see and export
- "Show folded items strip" — Slide-tab toggle; off hides the
  "+ n more items" indicators (folding still limits rows)
- "Show milestones" — Slide-tab toggle; off hides diamonds and
  their labels (milestone-only lanes keep their empty band)
- "Transparent background" — Slide-tab toggle; hides the title,
  checkerboard preview (UI-only), alpha PNG, SVG without its
  background rect
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
10. Axis control: Months and Quarters each forced on the
    long-range AND short-range cases — gridlines hold to the
    forced unit, labels thin evenly and never collide, year
    markers ("Jan '27") survive thinning, bars don't move
    (except the padded coarser-than-range case); Auto identical
    to unforced behaviour. Repeat one forced unit in a scoped
    lane view.
11. Range: a year window and a quarter window (axis spans exactly
    the window, first cell named for the window's own first day,
    items outside absent, crossing items flush and square to the
    rail, empty lanes keep their bands, footer counts what is
    shown); Custom with both ends, one end, an unreadable end and
    From after To (each says so); a range that catches nothing;
    a range whose year the plan no longer contains (falls back to
    the Whole plan); range + scope together; a windowed export.
    "Whole plan" must render byte-identically to no Range feature
    at all.
12. Fiscal years: with "Year starts" on January every render is
    byte-identical to the calendar behaviour (this is the first
    thing to check after any axis change). With April and one
    other start: quarter cells begin on the year-start month,
    year markers sit there too, all five year labels render and
    thin without collision on the long AND short range in Auto /
    Months / Quarters, dd/mm and month dates never move, and
    "Q1 2026"-style data lands in the fiscal quarter. Repeat one
    in a scoped lane view and in SVG/PNG exports.
13. Sub-plans: a scoped lane WITH sub-lanes (bands in first-
    appearance order, unlabelled band on top, axis recomputed,
    whole-plan folded items all visible) and one WITHOUT (single
    band); a scoped view with each Slide toggle off; scoped
    SVG/PNG exports (scoped title and footer, zero nav chrome);
    scope restored after refresh; deleting or renaming the
    scoped lane falls back to the Whole plan, never a stranded
    view.

## The sample must permanently exercise every checklist case
that renders on a clean slide (crowding/folding, milestone
clusters, all four date formats, today line). It must load with
ZERO warnings — the warning cases in item 7 are verified with
throwaway edge-case CSVs at review time, never by shipping broken
rows in the sample.

## Decided, do not revisit without the user

- Dependency arrows: never (see Hard rules). Sequence is position.
- Sub-plans: shipped — optional "Sub-lane" CSV column, lane
  drill-down mirroring Orgami's View team pattern; one level
  only (no drilling into sub-lanes).
- Range: shipped — a slide-wide window (Whole plan / year /
  quarter / Custom From-To). No per-lane ranges, and clipping
  never hides that an item continues.
- Fiscal years: shipped — a year-start month plus a year-label
  format, both slide-wide settings. No per-row year column, no
  arbitrary start DATE (quarters stay whole months), and the
  footer's date range stays in real calendar months.
