# CLAUDE.md — Mplify HTML Presentation Design & Brand Guide

This file is the design and brand reference for building HTML-based slide presentations for **Mplify Alliance** (mplify.net). It captures the visual language, component patterns, and structural conventions established in the reference presentation, so that any future presentation built in Claude looks and behaves consistently.

Use this guide whenever the user asks for a new Mplify presentation, a new slide for an existing deck, or any HTML deliverable that should match Mplify's house style. This is **not** for Reveal.js decks (those follow their own brand rules) — this is specifically for the standalone, self-contained HTML presentation format with a left sidebar and navigable slides.

---

## 1. Brand identity

### Colour palette

All colours are defined as CSS custom properties on `:root`. Always use the variables — never hardcode the hex values inside components.

```css
:root {
  --navy:     #000136;  /* primary brand colour — titles, sidebar background */
  --blue:     #3D7BC7;  /* secondary accent — icons, highlights */
  --orange:   #FD7801;  /* primary accent — eyebrows, emphasis spans, active states */
  --dkblue:   #244E9E;  /* tertiary blue — stat cards, pilot pills */
  --yellow:   #FEBF10;  /* accent — gradient bar endpoint only */
  --gray:     #A1A1A1;  /* counter text, dates, meta */
  --purple:   #790072;  /* used sparingly — human-led badges, timeline phase 3 */
  --charcoal: #555555;  /* body copy */
  --light:    #F0F1F2;  /* stage/slide light background */
  --white:    #FFFFFF;  /* card backgrounds */
}
```

**Usage rules:**
- **Navy** is the dominant brand colour. Use for the sidebar, all slide titles, and primary text.
- **Orange** is the highlight colour. Use sparingly: eyebrows, emphasised `<span>` words inside titles, accent borders on cards, and active sidebar states. Do not flood slides with orange.
- **Blue** is a calmer secondary accent. Pair with orange for variety in numbered cards (orange for items 1–3, blue for items 4–6).
- **Yellow** appears only as the third stop in the gradient bar. Avoid using it anywhere else.
- **Purple** is reserved for genuinely distinct categories (human-led workflow steps, late-stage timeline phases). Don't introduce it casually.
- **Light gray (`--light`)** is the soft slide background used on content-heavy slides to differentiate them from the white title slide.

### Gradient bar

The signature gradient bar appears at the bottom of the main area, spanning the full width below the slide stage:

```css
background: linear-gradient(to right, var(--orange), var(--blue), var(--yellow));
```

Always orange → blue → yellow, left to right. This is a recognisable Mplify motif — keep it consistent.

### Typography

```html
<link href="https://fonts.googleapis.com/css2?family=Sansation:wght@400;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
```

Two faces only:

- **Sansation** (700) — display face. Use for: slide titles, card titles, numeric badges, big quotes, definition terms, layer names. This is the brand's voice.
- **DM Sans** (300/400/500/600) — body face. Use for: body copy (`.card-text`), eyebrows, navigation, counter, badges, captions.

`body { font-family: 'DM Sans', sans-serif; }` is the default. Override with `font-family: 'Sansation', sans-serif;` only on titular/display elements.

**Do not** introduce additional fonts (no Roboto, no Inter, no Helvetica fallbacks beyond `sans-serif`). The Mplify Reveal.js decks use Sansation/Roboto; the standalone HTML presentation format uses Sansation/DM Sans. Don't mix them up.

---

## 2. Page structure

The presentation is a single HTML file with a fixed left sidebar (chapter navigation) and a main stage that swaps slides via `display: none/flex`. The whole document occupies `100vh` with `overflow: hidden` on the body — slides do not scroll.

### Viewport assumptions

The format is **designed for 16:9 landscape viewports at roughly 1280×720 or larger**. Slides are absolutely positioned with `inset: 0` and do not reflow; the sidebar takes a fixed 220px and the stage fills whatever's left. There are no responsive breakpoints by design.

Consequences worth knowing:
- On portrait viewports or very narrow windows, multi-column card grids will crush their content; this is not a bug to fix in CSS, it's a sign the deck is being viewed in the wrong shape.
- The format is **not** for mobile, print, or PDF export. See §6.
- If a client needs to view on an unusual aspect ratio (ultra-wide, 4:3), test it before delivery — `60px 70px` slide padding can leave content visibly off-centre on wide displays.

```
<body>                                     # flex row, full viewport, dark backdrop
├── #sidebar                               # 220px fixed nav, navy background
│   ├── #sidebar-logo                      # reserved slot for a future logo asset (empty by default)
│   └── .chapter-item × N                  # one per slide, with .active state
└── #main                                  # flex column, fills remaining space
    ├── #stage                             # contains all .slide elements
    │   ├── #counter                       # "1 / 10", top-right
    │   ├── .nav-arrow#prev / #next        # circular ← → buttons
    │   └── .slide × N                     # absolutely positioned, one .active
    └── .gradient-bar                      # 6px bottom strip
```

### Sidebar

- The sidebar is the **only** navigation in the deck. Do not add a second nav surface (e.g. a right-hand TOC panel on the title slide). See §3.1.
- Width is **fixed at 220px** (`min-width: 220px`).
- Background `var(--navy)`, white text at reduced opacity.
- Chapter items use a 3px transparent left border that turns orange when active. Active items also get a faint orange tint background (`rgba(253,120,1,0.08)`) and become semi-bold.
- Chapter number is a 16px-wide inline span at 60% opacity — keeps numbering aligned regardless of label length.
- `#sidebar-logo` is a **reserved empty slot**. It holds vertical space (matching padding plus a `min-height`) and carries the `1px` bottom border at 10% white opacity that separates the logo region from the chapter list. Insert a real logo asset via `<img src="..." style="width:100px;">` only when one is provided. **Do not put placeholder text in this slot** — placeholder text ships to clients by mistake.

### Slides

- Each `.slide` is absolutely positioned with `inset: 0`, hidden by default, shown via `.active { display: flex; flex-direction: column; }`.
- Default padding is `60px 70px`. The title slide (`#slide-1`) overrides this with `padding: 0` and a horizontal split layout.
- Content-heavy slides use `background: var(--light)`; the title slide and "foundation" slides stay white.

### Navigation

- Counter is pill-shaped (`border-radius: 20px`) with a translucent white background, top-right at `top: 14px; right: 20px`.
- Nav arrows are 40px circles with subtle shadow; on hover they invert to orange background, white arrow.
- Keyboard: arrow keys (Left/Up = previous, Right/Down = next) — see JS at the bottom of the file.

### JavaScript

Minimal and self-contained. No frameworks. The full nav logic is:

```js
const slides = document.querySelectorAll('.slide');
const chapterItems = document.querySelectorAll('.chapter-item');
const counter = document.getElementById('counter');
let current = 0;

function updateUI() {
  slides.forEach((s, i) => s.classList.toggle('active', i === current));
  chapterItems.forEach((c, i) => c.classList.toggle('active', i === current));
  counter.textContent = (current + 1) + ' / ' + slides.length;
}
function goTo(n) { current = Math.max(0, Math.min(slides.length - 1, n)); updateUI(); }
function nextSlide() { goTo(current + 1); }
function prevSlide() { goTo(current - 1); }

document.addEventListener('keydown', e => {
  if (e.key === 'ArrowRight' || e.key === 'ArrowDown') nextSlide();
  if (e.key === 'ArrowLeft'  || e.key === 'ArrowUp')   prevSlide();
});
updateUI();
```

`onclick="goTo(N)"` on each chapter item, and `onclick="nextSlide()/prevSlide()"` on the arrow buttons.

### Adding a slide (the two-place sync rule)

Slides and sidebar items are matched by DOM order — the script's `querySelectorAll('.slide')` and `querySelectorAll('.chapter-item')` walk the document top to bottom and pair index-by-index. **Adding a slide therefore means editing two places, in the same order, with the same indexing:**

1. **Sidebar** — append a new `.chapter-item` at the bottom of `#sidebar`, with `onclick="goTo(N)"` and `data-slide="N"` where N is the zero-indexed position. Update the two-digit `.chapter-number`. Use a `<button>` element, not a `<div>`, so it's focusable (see §4 Accessibility minimum).
2. **Stage** — append a new `.slide` block inside `#stage` with `id="slide-N+1"` (slide IDs are 1-indexed). Update the counter's denominator inline (`<div id="counter">1 / N</div>`) — the JS will overwrite this on first paint, but having the correct number in the markup avoids a flash of the wrong count.

The script at the bottom doesn't need changing. It picks up new slides automatically.

**Failure modes to watch for:**
- Sidebar has more items than slides exist → clicking the orphan item silently does nothing.
- Slide added without a sidebar entry → the slide is reachable via arrow keys but invisible in the nav.
- Sidebar order doesn't match slide order → `.active` highlights the wrong row.

When removing a slide, do the same two-place edit in reverse.

---

## 3. Slide types and templates

The reference deck uses a small, repeated set of slide patterns. New decks should reuse these rather than invent new layouts.

### 3.1 Title slide

A **single full-width panel** containing eyebrow, title, and subtitle. Nothing else.

- **Eyebrow** (`.eyebrow`): orange, uppercase, 13px, letter-spacing 2px, sits above the title.
- **Main title** (`.title-main`): Sansation 64px/700, navy, tight line-height (1.05).
- **Subtitle** (`.title-sub`): DM Sans 17px, charcoal, max-width 460px for readability.

Use this layout once per deck, as slide 1.

> **One-navigation rule.** The deck has exactly one navigation surface — the sidebar on the left. **Do not add a right-hand TOC, "Contents" panel, or any secondary navigation to the title slide or anywhere else.** Two parallel nav lists is a recurring failure mode that has to be undone every time it appears. The structural CSS for any such panel (e.g. `.title-right`, `.toc-item`, `.toc-label`, `.title-gradient-bar`) is deliberately not present in the boilerplate; do not reintroduce it.

### 3.2 Section slide (eyebrow + title + content)

The standard content slide. Has three parts in flex column:

```html
<div class="slide" id="slide-N">
  <div class="slide-eyebrow">Category Label</div>
  <div class="slide-title">Plain text with <span>orange highlight</span></div>
  <!-- content region: card grid, flow, definition, etc. -->
</div>
```

- **Eyebrow** (`.slide-eyebrow`): orange, uppercase, 11px, letter-spacing 2px, 600 weight. Acts as a section tag.
- **Title** (`.slide-title`): Sansation 34px/700, navy, line-height 1.15, margin-bottom 36px. Wrap the emphasis word(s) in a plain `<span>` — the CSS `.slide-title span { color: var(--orange); }` colours it. Don't use `<strong>` for this; `<span>` is the established convention.

### 3.3 Card grids

Two grid variants:

```css
.card-grid-3 { grid-template-columns: repeat(3, 1fr); gap: 24px; }
.card-grid-2 { grid-template-columns: repeat(2, 1fr); gap: 24px; }
```

Both set `flex: 1` so they fill the remaining slide height. For three-row grids use inline `grid-template-rows: 1fr 1fr; flex: 1;`.

#### Card variants

| Class | Use case | Visual signature |
|---|---|---|
| `.card` | Generic content card | White, 1px `#E8E9EB` border, 8px radius |
| `.card-light` | Subtle background card | `--light` background, no border |
| `.card-orange-left` | Concern / pain-point card | White, 4px orange left border, soft shadow, asymmetric radius `0 8px 8px 0` |
| `.num-card` | Numbered capability card | White, top accent border (orange or blue) — pairs with `.num-card-top-orange` / `.num-card-top-blue` |
| `.found-card` | Foundation/pillar card | White, 10px radius, larger 32px×28px padding, shadow |
| `.concern-card` | "Hard questions" card | White, 4px orange **bottom** border, padded |
| `.phase-card` | Timeline phase card | White, 1px border, smaller padding |
| `.gov-card` | Governance principle card | White, 1px border, subtle shadow, icon + title row on top |
| `.question-card` | Discussion question | White, 1px border, horizontal flex with large orange numeral on the left |

Inside every card, the standard text pair is:

```html
<div class="card-title">Heading</div>     <!-- Sansation 17px/700 navy -->
<div class="card-text">Body copy…</div>   <!-- DM Sans 14px charcoal, line-height 1.65 -->
```

When a card has an icon, the icon goes in an `.icon-circle` (48px circle) above the title. Icon circle colour matches the icon: `.icon-blue` (blue tint background), `.icon-orange` (orange tint background). The SVG inside is 24×24 and uses `stroke` only — no fills — at `stroke-width: 1.8`.

### 3.4 Definition slide

Single centred card, used for defining a key term:

```html
<div class="definition-box">
  <div class="definition-term">Term · Definition</div>     <!-- blue, uppercase, letter-spacing -->
  <div class="definition-text">The actual definition…</div> <!-- 22px navy, generous line-height -->
  <!-- optional 80px gradient divider -->
  <div class="definition-note">Italic supporting note.</div>
</div>
```

Wrap it in a flex container that centres it vertically:
`<div style="flex:1; display:flex; align-items:center;"> … </div>`.

### 3.5 Flow / process slide

Horizontal four-step process with badge, big number, title, body, and an orange circular arrow connector between steps:

```html
<div class="flow-container">
  <div class="flow-step">
    <span class="flow-badge badge-draft">Draft</span>
    <div class="flow-number">01</div>
    <div class="card-title">Setup</div>
    <div class="card-text">…</div>
    <div class="flow-arrow">→</div>  <!-- omit on last step -->
  </div>
  …
</div>
```

Badges use four flavours, one per step:
- `.badge-draft` (blue), `.badge-recommend` (orange), `.badge-manage` (dark blue), `.badge-human` (purple).

The big step number (`.flow-number`) is 36px Sansation in `--light` colour so it reads as a watermark behind the title.

### 3.6 Timeline

A multi-segment gradient bar with dots marking phases, followed by a 3-column phase grid:

```css
.timeline-bar {
  background: linear-gradient(to right,
    var(--blue) 0%, var(--blue) 25%,
    var(--orange) 25%, var(--orange) 62%,
    var(--purple) 62%, var(--purple) 100%);
}
```

Phases follow the colour sequence: blue → orange → purple. Use `.phase-label-blue`, `.phase-label-orange`, `.phase-label-purple` on the uppercase label inside each `.phase-card`.

### 3.7 Stacked layers

Used when listing categorical items vertically (e.g. architecture layers):

```html
<div class="layer-stack">
  <div class="layer-item" style="background: rgba(61,123,199,0.08);">
    <div class="layer-name">Layer Name</div>
    <div class="layer-desc">Description…</div>
  </div>
  …
</div>
```

`.layer-name` is fixed-width (120px) Sansation bold; `.layer-desc` fills the rest. Vary the row background tint to differentiate layers — use rgba forms of the brand colours at 6–12% opacity.

### 3.8 Stat cards (pilot/proposal)

A row of compact stat cards with a left blue accent border:

```html
<div class="stat-card">
  <div class="stat-label">METRIC NAME</div>   <!-- gray, uppercase, tiny -->
  <div class="stat-value">Value or short text</div>
</div>
```

### 3.9 Next-step slide

A single large boxed call-to-action:

```html
<div class="next-box">
  <span class="pilot-pill">Pilot Proposal</span>
  <!-- title + body -->
</div>
```

`.pilot-pill` is a small dark-blue rounded badge — use it to label the box as a specific phase or status.

---

## 4. Conventions and details

### Spacing

- Standard slide padding: `60px 70px`.
- Standard grid gap: `24px`.
- Card internal padding: `28px 24px` for grid cards; `30px 28px` for concern cards; `22px 20px` for compact phase cards.
- Section spacing inside a card: `margin-bottom: 10px` between title and text; `margin-bottom: 16px` between icon and title.
- Slide title to content: `margin-bottom: 36px` on `.slide-title`.

### Borders and radii

- Card border: `1px solid #E8E9EB` (never a brand colour for the full border).
- Card radius: `8px` for standard cards, `10–12px` for larger feature cards, `20px` for pills, `50%` for icon circles and nav arrows.
- Accent borders (orange/blue) are always **4px** for left/bottom accents, **3px** for top accents.

### Shadows

Three shadow levels, all subtle:

```css
box-shadow: 0 2px 8px  rgba(0, 0, 0, 0.04);  /* gov cards */
box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);  /* foundation cards, concern cards */
box-shadow: 0 4px 24px rgba(0, 1, 54, 0.08); /* next-box, larger features — uses navy tint */
box-shadow: 0 4px 30px rgba(0, 1, 54, 0.08); /* definition-box */
```

Mplify shadows are **soft and barely-there**. Never use harsh dark shadows.

### Icons

Use inline SVG with `viewBox="0 0 24 24"`, stroke-only (`fill="none"`), `stroke-width: 1.8` to `2`, rounded line caps and joins. Source from Lucide / Feather Icons style — simple line icons, no fill, no detail. Colour the stroke with a brand variable.

```html
<svg viewBox="0 0 24 24" fill="none" stroke="#3D7BC7" stroke-width="1.8" class="icon">
  <!-- path -->
</svg>
```

The `.icon` class sizes them to 24×24. Wrap in `.icon-circle` (with `.icon-blue` or `.icon-orange`) for the soft-tinted background.

### Emphasis inside body copy

Inside `.card-text`, the small inline-styled callout pattern (`margin-top: 16px; font-size: 12px; color: var(--orange); font-weight: 600;`) is used for short punchy concluding lines like *"It's a model that has worked. But it's under pressure."* Use this sparingly — once per slide at most.

### Transitions

Hover transitions are universally `transition: all 0.2s` (or `transition: color 0.2s` for text-only changes). Don't add longer animations or motion — the deck reads as professional, not animated.

### Accessibility minimum

The reference deck doesn't implement these, but new decks should. The format is small enough that accessibility costs nothing to do right:

- **Nav arrows** must carry `aria-label` — `aria-label="Previous slide"` and `aria-label="Next slide"` respectively. The `←` / `→` glyphs alone are not announced meaningfully by screen readers.
- **Chapter items** should be focusable. Use `<button class="chapter-item">` rather than `<div>` (and add `border: 0; background: transparent; text-align: left; width: 100%; font: inherit; color: inherit; cursor: pointer;` to keep the styling). The boilerplate already does this.
- **Active slide / active chapter item** should set `aria-current="true"` in addition to the `.active` class — update `updateUI()` in the script to toggle both.
- **Focus styles** must be defined so keyboard focus is visible. Add `:focus-visible` outline rules to `.chapter-item` and `.nav-arrow` — a 2px solid orange outline with 2px offset is on-brand and clearly visible.
- **Counter** should be `aria-live="polite"` so screen readers announce slide changes.
- **Decorative SVG icons** inside `.icon-circle` should carry `aria-hidden="true"` — they don't add information, they reinforce the adjacent text.
- **Sidebar** wraps a navigation landmark: `<nav id="sidebar" aria-label="Slide navigation">`.
- **Colour contrast**: navy on white and orange on white both clear WCAG AA at 14px+. Don't put body copy in `--gray` (`#A1A1A1`) at anything smaller than 14px — it's a borderline fail. The reference deck uses gray only for the counter and metadata-style labels, which is fine.

---

## 5. Authoring checklist for new presentations

When building a new Mplify HTML presentation, work through this list:

1. **Start from `boilerplate.html`** — it contains the full structural skeleton (sidebar, main, stage, gradient bar, counter, nav arrows, JS) plus all the component CSS. The HTML body only instantiates two example slides, so building a new deck is mostly additive.
2. **Define the chapter list first.** Each `.chapter-item` corresponds to one `.slide`. Decide on the number of slides and titles before writing slide content. When adding or removing slides, follow the two-place sync rule (§2): sidebar and stage need to stay in step.
3. **Slide 1 is always the title slide** — a single full-width panel with eyebrow, main title, and subtitle. No second navigation surface on this slide or any other (see §3.1).
4. **Use `.slide-light` (i.e. `background: var(--light);`) for content-heavy slides** to soften them, and keep white only for the title slide, the definition slide, and any slide where the content cards themselves provide the visual weight.
5. **Pick one slide pattern per content slide** from §3 — don't mix flow + card grid + timeline on the same slide.
6. **Reuse colour assignments consistently.** If items 1–3 are orange-themed and items 4–6 are blue-themed on one slide, keep that mapping coherent across the deck (e.g. don't switch orange to mean something different on the next slide).
7. **Sanity-check the colour balance.** Orange should appear as ~10–15% of visible colour on any given slide. If a slide is mostly orange, dial it back.
8. **Keep body copy short.** `.card-text` paragraphs read best at 30–55 words. If a card needs more, the slide is doing too much.
9. **Test arrow-key navigation and chapter clicks** before delivering. Tab through the deck too — keyboard focus should be visible at every step (see §4 Accessibility minimum).
10. **No external dependencies** beyond the Google Fonts link. Everything else is inline CSS, inline SVG, and a tiny JS block. The deck should work offline once loaded.

---

## 6. What this format is *not*

- It is **not** Reveal.js. Don't import reveal.css or use `<section>` for slides. The standalone HTML format uses `<div class="slide">` with absolute positioning.
- It is **not** for printable PDFs. The layout is designed for screen presentation at roughly 16:9.
- It is **not** meant to be edited collaboratively in real time. It's a deliverable artefact, built in one shot.
- It does **not** use Tailwind, Bootstrap, or any utility framework. All styling is hand-written CSS in a single `<style>` block.

---

## 7. Mplify content voice (brief)

When writing slide copy for Mplify, the established tone is:

- **Direct and confident** — Mplify is the coordinating body for industry standards (NaaS, LSO, AI networking, cybersecurity); the copy should sound like an authority, not a pitch deck.
- **Plain technical English** — no marketing jargon, no superlatives ("revolutionary", "cutting-edge"). Acronyms are spelt out on first use within the deck.
- **Progress-reporting cadence** — for committee/working-group materials, copy reflects active workstreams ("We are progressing X", "The committee has agreed Y"), not future promises.
- **Human-centred framing** for AI topics — digital SMEs, agentic LSO, and AI agent governance are framed as augmenting human experts, never replacing them. This framing is load-bearing for the brand.

Match this voice in any new slide content unless the user explicitly asks for a different tone.
