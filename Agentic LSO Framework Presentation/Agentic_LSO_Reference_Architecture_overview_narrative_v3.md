# Agentic LSO Reference Architecture Overview — Presentation Narrative (v3)

## Document purpose

This narrative is the planning document for an HTML slide deck (built per `mplify-presentation-context.md`) that introduces Mplify member SMEs to the current state of work on the **Agentic LSO Reference Architecture** and the associated **Agentic LSO Blueprints**.

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
- The "Open Questions" slide (Slide 12) is not just a recap — it is the operative slide of the deck. Everything before it is context for those questions.

---

## Audience and framing

- **Audience:** Mplify member subject matter experts — people who already know LSO, MEF/Mplify standards, and the LSO API programme. They do not need to be sold on the value of standards work; they need to be brought up to speed on current thinking and invited into the open decisions.
- **Tone:** Direct, progress-reporting cadence. *"We are progressing X. The current draft proposes Y. Question Z is open for member input."* Match the Mplify voice in `mplify-presentation-context.md` §7.
- **Outcome:** SMEs leave understanding (a) what Agentic LSO is in its current working form, (b) what the Reference Architecture and Blueprints are and how they relate, (c) which design directions the committee is leaning toward, (d) the specific questions where SME input is wanted, and (e) how to engage with the next phase (use cases, pilots, certification).

---

## Deck-level shape

13 slides, organised in four arcs:

1. **Framing** — Slide 1 (cover), Slide 2 (what is Agentic LSO).
2. **Architecture** — Slide 3 (Reference Architecture), Slides 4–6 (Blueprints).
3. **Design considerations** — Slide 7 (customisation), Slide 8 (non-LSO APIs), Slide 9 (sandboxes/emulation), Slide 10 (certification).
4. **Forward** — Slide 11 (use cases), Slide 12 (open questions for SMEs), Slide 13 (next steps).

Slides 12 and 13 close the loop with an audience that is being asked to engage, not just observe.

---

## Slide-by-slide

### Slide 1 — Cover

- **Title:** Agentic LSO Reference Architecture
- **Subtitle / framing line:** *A work-in-progress snapshot of the reference architecture and blueprints — for Mplify member review and discussion.*
- **Eyebrow:** `MPLIFY · WORK IN PROGRESS`
- **Layout:** §3.1 Title slide (single full-width panel, no right-hand TOC).
- **Audience takeaway:** Sets context — this is a working-group update inviting member input, not a finished position.
- **Discussion prompt:** None on this slide; the eyebrow does the work of signalling status.

---

### Slide 2 — What is Agentic LSO?

- **Title:** What is Agentic LSO?
- **Eyebrow:** `INTRODUCING · DRAFT DEFINITION`
- **Layout:** §3.4 Definition slide (single centred `definition-box`).
- **Audience takeaway:** A shared, one-sentence working definition the rest of the deck can lean on — explicitly draft.
- **Content points:**
  - **Working definition (draft, for member review):** *Agentic LSO is the application of AI agents and the Model Context Protocol (MCP) to Lifecycle Service Orchestration, allowing AI agents acting on behalf of stakeholders to negotiate, quote, order, and manage inter-provider services through standardised, machine-readable interfaces.*
  - **Supporting note (italic):** Agents augment human operations teams — they do not replace the LSO API programme; they extend its reach to agentic consumers and providers.
- **Discussion prompt:** Does this definition capture what we collectively mean by Agentic LSO? What is missing or wrong?

---

### Slide 3 — What is the Agentic LSO Reference Architecture?

- **Title:** What is the Agentic LSO Reference Architecture?
- **Eyebrow:** `REFERENCE ARCHITECTURE · CURRENT DRAFT`
- **Layout:** Two-region custom layout — left column: short framing paragraph + 2–3 bullet-style cards; right column: the architecture diagram (`obraz.png`). If a full-width diagram reads better, split into Slide 3a (framing) and Slide 3b (diagram full-bleed).
- **Audience takeaway:** The Reference Architecture is the structural backbone of Agentic LSO — analogous to the role MEF 51.1 plays for the LSO API programme. The diagram shown is the current working draft.
- **Content points:**
  - **Analogy to MEF 51.1.** MEF 51.1 defined the reference architecture (entities, interfaces, management domains) that underpinned the entire LSO API programme. The Agentic LSO Reference Architecture is being developed to play the same role for the agentic layer: defining the entities (agents, MCP servers, identities), the interfaces between them (A2A, MCP, LSO API), and how they relate to stakeholders.
  - **What the current draft specifies:**
    - The **types of agents** required and which stakeholders they belong to (buyer-side, seller-side, intermediary).
    - The **types of MCP servers** that expose LSO capabilities (one per LSO API domain: Product Catalog, Address Validation, POQ, Quote, Product Order, Product Inventory).
    - The **interrelationships** between these entities and the protocols connecting them (A2A between agents, MCP between agent and server, LSO API between MCP server and back-end).
    - The role of **Legal Identity** attached to each participating entity.
  - **What it does not specify:** Implementation details of any specific agent or MCP server — those belong to the Blueprints (see slides 4–6).
- **Collateral:** `obraz.png` — the current draft architecture diagram showing Buyer → Agent → six MCP Servers → Backend System Emulator → Mplify LSO Test Service, with Legal Identity attached to each participant and Blueprint attached to agent and servers.
- **Discussion prompt:** Are the entities and relationships shown the right ones? Is anything missing — additional agent types, additional MCP server types, additional protocols?

---

### Slide 4 — Agentic LSO Blueprints (introduction)

- **Title:** What are the Agentic LSO Blueprints?
- **Eyebrow:** `BLUEPRINTS · PART 1 OF 3`
- **Layout:** §3.2 Section slide with §3.3 `card-grid-2` (one card for "Blueprint", one for "how it differs from the Reference Architecture").
- **Audience takeaway:** Blueprints are the *implementation specifications* that sit one layer below the Reference Architecture — they describe *how* to construct a conforming agent or MCP server, not just *what* exists. Scope and depth are still being shaped.
- **Content points:**
  - **Working definition (draft):** A Blueprint is a normative specification for building one type of entity in the Reference Architecture (e.g. a Quote MCP Server, or a buyer-side Agent). It specifies the tools/resources/prompts the entity exposes, the identity model it implements, the expected behaviour, and any conformance criteria.
  - **Relation to Reference Architecture:** The Reference Architecture says *"a Quote MCP Server exists, and it sits here."* The Quote MCP Server Blueprint says *"and this is exactly what tools it exposes, what its identity claims look like, and how it must behave."*
  - **Blueprint inventory (current working scope):** One Blueprint per MCP Server type in the Reference Architecture (six today: Product Catalog, Address Validation, POQ, Quote, Product Order, Product Inventory), plus Agent Blueprint(s). The exact count and granularity is under review.
- **Discussion prompt:** Is one Blueprint per MCP server type the right granularity, or should there be a smaller set of generic Blueprints with per-domain profiles?

---

### Slide 5 — MCP Server vs LSO Agent: where does logic live?

- **Title:** MCP Server or Agent — where does the logic live?
- **Eyebrow:** `BLUEPRINTS · PART 2 OF 3 · OPEN QUESTION`
- **Layout:** §3.3 `card-grid-2` with two side-by-side `card-orange-left` cards contrasting the two design philosophies; below, a short concluding line.
- **Audience takeaway:** This is an open architectural choice with real trade-offs. The committee is actively weighing both directions and wants SME input.
- **Content points (the two competing approaches under consideration):**
  - **Approach A — Rich MCP Server, thin agent.** Push as much as possible into the MCP Server: instructions, resources, prompts, validation, business rules. Agents stay general-purpose; servers become opinionated about their domain. *Pros:* easier to certify a server's behaviour; centralised domain logic; agent vendors do not need deep LSO knowledge. *Cons:* fatter, more complex servers; harder to update per-buyer policy.
  - **Approach B — Minimised scope per entity (attack-surface minimisation).** Each MCP server and each agent does as little as possible. Logic is distributed; complex flows are composed at the agent layer. *Pros:* small attack surface per component; easier to reason about each entity's permissions; easier to swap implementations. *Cons:* more orchestration burden on agents; potentially more A2A traffic; harder to enforce consistent domain rules.
- **Closing line (small orange callout):** *Most real deployments will sit somewhere on this spectrum. The Blueprints should be permissive enough to accommodate both — but the reference position is still being chosen.*
- **Discussion prompt:** Where on this spectrum should the *reference* Blueprints sit?

---

### Slide 6 — Sub-agents and Blueprint conformance

- **Title:** When agents spin up sub-agents, do they use the Blueprint?
- **Eyebrow:** `BLUEPRINTS · PART 3 OF 3 · OPEN QUESTION`
- **Layout:** §3.2 Section slide with §3.3 `card-grid-3` showing three positions (Yes — always; No — only top-level; Conditional). Each card is a `num-card` with a brief rationale.
- **Audience takeaway:** A second open governance question: Blueprint scope when agents recurse. No committee position yet.
- **Content points (three positions under consideration):**
  1. **Yes, always.** Any agent in the system — top-level or spawned — must conform to an Agent Blueprint. Guarantees uniform behaviour and identity model end-to-end.
  2. **Only top-level agents conform.** Sub-agents are internal implementation; conformance applies at the boundary where the agent talks to MCP servers or peer agents. Simpler, but creates an invisible "shadow agent" layer.
  3. **Conditional.** Sub-agents conform to a Blueprint *when they cross a trust boundary* (e.g. invoke another organisation's MCP server) but not when purely internal. Pragmatic, but requires a clear definition of "trust boundary".
- **Discussion prompt:** Which of these positions should the programme adopt?

---

### Slide 7 — Customisation: where, and by whom?

- **Title:** Considerations for customising agents and MCP servers
- **Eyebrow:** `DESIGN CONSIDERATIONS · IN PROGRESS`
- **Layout:** §3.7 Stacked layers, showing customisation layers from generic to specific. Each row tinted differently per the layer-stack convention.
- **Audience takeaway:** A Blueprint defines the floor of behaviour, but every deployment customises. Knowing *where* customisation lives is part of the architecture — and is still being mapped.
- **Content points (proposed layers, top to bottom):**
  - **Blueprint baseline** — normative behaviour every conforming implementation must support.
  - **API-domain specialisation** — variations driven by which LSO API the entity wraps (Quote vs Product Inventory have very different access patterns: short-lived offers vs long-lived state).
  - **Use-case specialisation** — variations driven by the service ordered (e.g. Carrier Ethernet vs IP Transit may need different POQ logic).
  - **Operator policy** — per-deployment configuration: pricing rules, partner whitelists, identity policy, rate limits.
  - **Run-time context** — what a specific buyer asks for in a specific session.
- **Closing emphasis:** The current direction is to make the first layer normative and leave the lower layers explicitly configurable — but the exact boundary between normative and configurable is open.
- **Discussion prompt:** Which of these layers, if any, should the Blueprints prescribe versus leave open?

---

### Slide 8 — Non-LSO APIs

- **Title:** Supporting non-LSO APIs
- **Eyebrow:** `DESIGN CONSIDERATIONS · IN PROGRESS`
- **Layout:** §3.3 `card-grid-2` — left card: how non-LSO APIs are supported; right card: pros/cons split into two small lists.
- **Audience takeaway:** Agentic LSO can wrap pre-existing, non-standard provider APIs — important for members who have not yet implemented LSO APIs (and may not). The mechanism is being defined.
- **Content points:**
  - **Mechanism (current thinking).** An MCP Server can front any provider back-end — it does not require the underlying API to be an LSO API. The MCP Server presents an LSO-shaped interface to the agent; what it talks to behind that interface is its own concern.
  - **Pros under discussion.**
    - Lowers the barrier to entry for Agentic LSO — operators with legacy ordering APIs can still expose an LSO-conformant agentic surface.
    - Allows incremental migration toward full LSO APIs without blocking agent-level adoption.
    - The agent ecosystem is insulated from per-operator API variation.
  - **Cons under discussion.**
    - Each operator wrapping a proprietary back-end is solving the translation problem alone — a fragmentation risk.
    - Conformance testing is harder when the back-end is not standardised.
    - Without LSO API discipline behind the curtain, semantic drift can creep in (the same `getQuote` call may mean subtly different things across operators).
- **Closing emphasis:** Non-LSO API support, in the current view, is a *bridge*, not a destination — though this framing is itself a member discussion.
- **Discussion prompt:** Should the Blueprints actively support non-LSO API back-ends, or treat them as out-of-scope?

---

### Slide 9 — Sandboxes and emulation

- **Title:** Sandboxes and emulation
- **Eyebrow:** `OPERATIONAL READINESS · IN PROGRESS`
- **Layout:** §3.5 Flow slide, four steps showing the path from internal development to verified deployment.
- **Audience takeaway:** The programme is building toward a flow where companies can safely trial new Agentic LSO components — their own or third-party — against a verified Mplify emulator before connecting to live partners. Components of this flow are at different maturity levels.
- **Content points (four flow steps, badges draft → recommend → manage → human):**
  1. **Develop** — Build agent or MCP server internally, or receive one from a third-party partner.
  2. **Verify against emulator** — Connect to the Mplify Agentic LSO Emulator (in development): a controlled environment that replays known-good LSO flows and reports conformance.
  3. **Trial in sandbox** — Run end-to-end against an emulated partner with synthetic data; observe behaviour under load and failure conditions.
  4. **Promote to production** — With verified conformance and observed sandbox behaviour, connect to live partners.
- **Note:** This is one of the strongest member-value propositions of the programme — name-check it explicitly. The emulator and test service shown in `obraz.png` are part of this workstream.
- **Discussion prompt:** What conformance signals would your organisation need from an emulator before trusting it as a gate to production?

---

### Slide 10 — Agentic LSO and Mplify certification

- **Title:** Agentic LSO and Mplify certification
- **Eyebrow:** `CERTIFICATION · IN PROGRESS`
- **Layout:** §3.3 `card-grid-2` — two cards contrasting the two roles. Card titles emphasise the distinction: *"as a tool for"* vs *"as a subject of"*.
- **Audience takeaway:** Agentic LSO has a dual relationship with certification. Both directions are in scope; sequencing is open.
- **Content points:**
  - **As a tool for certification.** Agents and emulators can drive conformance test suites against any LSO implementation — automating what is today a largely manual certification process. Agentic LSO becomes part of the *certification machinery*.
  - **As a subject of certification.** Conforming agents and MCP servers — built to Blueprints — can themselves be certified. The committee is starting to define what "Agentic LSO Certified" would mean for each Blueprint type.
- **Closing emphasis:** The tooling story is faster to deliver; the subject-of-certification story is more strategically important. Both are being pursued in parallel.
- **Discussion prompt:** Which direction should the programme prioritise first?

---

### Slide 11 — Use cases

- **Title:** Use cases — where to focus first
- **Eyebrow:** `WHAT NEXT · CANDIDATE LIST`
- **Layout:** §3.3 `card-grid-3` with `num-card` styling, alternating orange and blue top borders (orange for 1–3, blue for 4–6 per the colour assignment rule in `mplify-presentation-context.md` §1).
- **Audience takeaway:** A candidate shortlist of use cases for the first Agentic LSO pilots, with brief rationale. The list is open — SMEs are asked to weigh in on prioritisation and additions.
- **Content points** *(candidate list, for member discussion):*
  1. **Quote-to-Order for Carrier Ethernet** — the canonical LSO flow; well-understood, easy to compare against existing API behaviour.
  2. **Address validation and serviceability** — narrow scope, low risk, high frequency. A good first agentic touchpoint.
  3. **Product Inventory queries** — read-only, low blast radius; good for testing agent identity and authorisation.
  4. **Cross-operator POQ** — exercises A2A between agents from different operators.
  5. **Trouble-ticketing / incident triage** — high SME interest, but requires non-LSO APIs in many deployments (see Slide 8).
  6. **Multi-domain ordering** — long-term ambition; unlikely as a first pilot.
- **Discussion prompt:** Which of these would your organisation commit pilot resources to? What is missing from the list?

---

### Slide 12 — Open questions for SMEs

- **Title:** Where we need your input
- **Eyebrow:** `OPEN QUESTIONS · MEMBER INPUT REQUESTED`
- **Layout:** §3.3 `card-grid-2` of `question-card` style (white card, large orange numeral on left, question text on right). Up to four questions, two rows.
- **Audience takeaway:** A clean, consolidated view of the questions surfaced through the deck, framed as direct asks. This is the **operative slide** of the presentation — it is what the audience is being brought into the room for.
- **Content points (the consolidated questions):**
  1. **Working definition.** Does the working definition of Agentic LSO (Slide 2) hold? Anything missing or wrong?
  2. **MCP server vs agent boundary.** Where on the spectrum (Slide 5) should the reference Blueprints sit?
  3. **Sub-agent conformance.** Which of the three positions (Slide 6) should the programme adopt?
  4. **Pilot use cases.** Which use cases (Slide 11) would your organisation commit pilot resources to?
- **Discussion prompt:** This whole slide is the prompt. Treat it as the place where the audience is expected to start contributing.

---

### Slide 13 — Next steps and how to engage

- **Title:** Next steps
- **Eyebrow:** `WHAT NEXT · HOW TO ENGAGE`
- **Layout:** §3.9 Next-step slide — single large `next-box` with a `pilot-pill` label.
- **Audience takeaway:** Concrete next actions and the channels for SME engagement.
- **Content points:**
  - Working-group meeting cadence and where the live drafts of the Reference Architecture and Blueprints sit (link or repo reference — to be inserted at build time from the working group chair's pointer).
  - Call for pilot volunteers and the engagement channel (committee mailing list / Slack / GitHub repo — exact channel to be inserted at build time).
  - Indicative timeline for the next deliverable (e.g. *"Draft Blueprints v0.x for member review by Qx"* — wording to be inserted at build time).
- **Discussion prompt:** None — this slide is closing the loop, not opening a new one.

---

## Cross-cutting notes for the HTML build

These notes apply across the deck and should be honoured in implementation. They mirror conventions from `mplify-presentation-context.md`.

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
