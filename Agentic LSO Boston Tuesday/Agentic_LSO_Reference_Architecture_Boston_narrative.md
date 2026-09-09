# Agentic LSO Reference Architecture Overview — Boston Narrative (v3)

## Document purpose

This narrative is the planning document for an HTML slide deck (built per `CLAUDE.md`) that introduces Mplify member SMEs to the current state of work on the **Agentic LSO Reference Architecture** and the associated **Agentic LSO Blueprints**.

It is not the slide copy. It is the editorial brief: for each slide it states the **audience takeaway**, the **layout pattern** (mapped to a section of the Mplify design guide), the **content points** the slide must make, and any **discussion prompts** intended for the SME audience.

---

## Status of the work (read this first)

**Everything in this deck is work in progress, not finalised, and open for discussion by the Mplify membership.** That applies to:

- the working definition of Agentic LSO,
- the Reference Architecture as drawn,
- the Blueprint scope and design philosophy,
- the position on sub-agent conformance,
- the shortlist of pilot use cases,
- the status of the emulator and test service,
- and the certification roadmap.

This is not a hedging caveat. It is the central message: the deck's job is to give SMEs a snapshot of an active workstream and bring them into the design conversation. The copy throughout should reflect that tone — *"current direction is X, open question is Y"* — rather than presenting any of this as settled.

Practical consequences for the build:

- Every slide should carry the **in-progress** signal somewhere (an eyebrow tag, a small footer pill, or — preferred — a consistent `WORK IN PROGRESS · FOR MEMBER REVIEW` marker on the title slide and a subtler treatment elsewhere).
- Slide copy uses verbs like *"is being defined"*, *"the current draft proposes"*, *"the committee is weighing"* — not *"is"* / *"will be"* / *"has been agreed"*.

---

## Audience and framing

- **Audience:** Mplify member subject matter experts — people who already know LSO, MEF/Mplify standards, and the LSO API programme. They do not need to be sold on the value of standards work; they need to be brought up to speed on current thinking and invited into the open decisions.
- **Tone:** Direct, progress-reporting cadence. *"We are progressing X. The current draft proposes Y. Question Z is open for member input."* Match the Mplify voice in `CLAUDE.md` §7.
- **Outcome:** SMEs leave understanding (a) what Agentic LSO is in its current working form, (b) what the Reference Architecture and Blueprints are and how they relate, (c) which design directions the committee is leaning toward, (d) the specific questions where SME input is wanted, and (e) how to engage with the next phase (use cases, pilots, certification).
- The slides should be rather with diagrams and bullet points, big and readable than a lot of text to read. The presenter is knowledgable and will explain the content.
---

---
## Slide-by-slide

LSO Projects and roadmap TODO slide with roadmap.png
Release framework - General Availability and Marketing Releases.
Release framework - General Availability - diagram explained
Release framework - All-in-one package, urn reframing
Blueprint release announcement graphic
Blueprint release - scope in text
Blueprint - progress since Lisbon:
  - security added (Agent - MCP scope)
  - Trouble TIcketing Added
  - Capability statement
Capability statement slide
Blueprint vs. architecture Use case coverage - 2 use cases per slide + Table to progress
BLueprint - explain the transition possibilities and simultaneous integration on many levels
Blueprint - enterprise easy onboarding use case.
BLueprint - LSO to ASR Mapping use case
Blueprint Roadmap: A2A, L3 Agent, Asynchronous communications (notification use cases)
BLueprint - what next use cases to cover (from the architecture?)
Blueprint vs. architecture - gap analysis + ask what is the most important?


---

## Cross-cutting notes for the HTML build

These notes apply across the deck and should be honoured in implementation. They mirror conventions from `CLAUDE.md`.

- **In-progress signalling.** Title slide carries `MPLIFY · WORK IN PROGRESS` in the eyebrow. Most other slides carry an "· IN PROGRESS", "· OPEN QUESTION", "· CURRENT DRAFT", or "· CANDIDATE LIST" suffix on their eyebrow. The signal should be consistent and unmissable without dominating the visual hierarchy.
- **Sidebar.** One `.chapter-item` per slide, 13 entries. Numbers `01`–`13`. The sidebar is the only navigation surface — no right-hand TOC on the title slide (§3.1 of the design guide).
- **Backgrounds.** Title slide (1) and Definition slide (2) on white; all other content slides use `slide-light` (`var(--light)`). Slide 3 (with the architecture diagram) can stay white if the diagram has its own grid background that would clash.
- **Orange usage.** Per the §1 colour rules, keep orange to ~10–15% per slide. Reserve it for eyebrows, the highlighted span in slide titles, accent borders, and the active sidebar state.
- **Colour assignments.** On slides with numbered cards split between orange and blue (5, 6, 11), use orange for items 1–3 and blue for items 4–6 — and keep that mapping consistent across the deck.
- **Pattern-per-slide rule.** One pattern per content slide (don't combine card grid + flow + timeline on the same slide).
- **Accessibility.** Honour the §4 accessibility minimums: `<button>` chapter items, `aria-label` on nav arrows, `aria-current` on active items, visible `:focus-visible` outlines.
- **Diagram asset.** `obraz.png` is the current-draft architecture diagram for Slide 3. Label it as such on the slide (e.g. a small "current working draft" caption under the image).
- **Author/date metadata.** Working-group label, presenter, and date can be added at build time to the cover slide eyebrow or as a footer treatment (the boilerplate has no footer slot — adding one is a small extension).
- **Build-time placeholders.** Slide 13 contains three items (repo/link, engagement channel, timeline) that will be filled in by the working-group chair before the deck is shown. Mark them clearly in the HTML source (e.g. `<!-- TO BE INSERTED -->`) so they cannot be missed.

---

## What this deck is *not* trying to do

Worth stating explicitly so the copy stays on-target:

- It is **not** a finished specification. None of these slides should read as normative.
- It is **not** a sales pitch. The audience is members, not prospects; the value of standards work is assumed.
- It is **not** exhaustive. Many details of the Reference Architecture and Blueprints are deliberately deferred — the deck's job is to surface the shape of the work and the decisions in play, not to enumerate every entity and interface.
- It is **not** a one-way broadcast. Slide 12 is the centre of gravity; the rest is context for it.
