# The Empty Container Thesis

**Latent Pattern: Agent Resourcefulness as the Missing Layer in Agentic Commerce**

Synthesis of Peter Steinberger (OpenClaw) and Tobi Lutke (Shopify, 21 Years) -- March 2026

---

## Executive Summary

Peter Steinberger put an AI agent in an empty Docker container and told it to fetch a website. With nothing but a C compiler and network access, the agent built its own cURL from TCP sockets. Tobi Lutke describes agentic commerce -- how AI agents buy things on behalf of humans -- as the critical problem every team at Shopify is trying to solve, but the space is "all dark." They're wandering an unlit room.

These two observations are deeply connected. The empty container and the dark room are the same structure. Both reveal a counterintuitive principle: agents don't need pre-built tools to accomplish goals. They need primitives and permission. The teams wandering in the dark may be lost precisely because they're trying to build the map before entering the room.

---

## Source Validation Matrix

| Source | Authority | Recency | Relevance | Internal Consistency |
|--------|-----------|---------|-----------|---------------------|
| Peter Steinberger (Builders Unscripted, OpenAI) | High. Creator of OpenClaw, 13+ years as founder/CEO of PSPDFKit, deep hands-on experience with agentic systems | March 2026 | Direct. Firsthand account of agent behavior in constrained environments | Strong. Multiple examples reinforce same pattern (voice message, Docker cURL, Discord deployment) |
| Tobi Lutke (Founders Podcast / David Senra) | Very High. 21-year CEO of Shopify ($200B+), front-row seat to millions of entrepreneurs, directly responsible for agentic commerce strategy | January 2026 | Direct. Describes exact problem space and current approach | Strong. Philosophy of toolmaking, first-principles thinking, and "dark box" exploration is internally coherent |

---

## Synthesis Strategy

**Tension preservation** between the two frameworks, converging only where the evidence demands it. Peter speaks from the agent-infrastructure layer. Tobi speaks from the commerce-platform layer. The connection is not obvious from either vantage point alone -- it emerges at their intersection.

---

## The Two Observations

### Peter's Empty Container

Peter sandboxed his agent (Molty) by moving it from his Mac Studio into a minimal Docker container. The container had almost nothing in it -- no cURL, no wget, no standard networking tools.

When he asked the agent to check a website, it reported: "There's not even cURL, there's nothing in here." Peter's response: "Be creative."

The agent found a C compiler. It opened raw TCP sockets. It wrote its own HTTP client -- a crude, functional version of cURL -- compiled it, and used it to fetch the website. It worked.

This was not an isolated incident. Earlier, when Peter sent a voice message through WhatsApp, the agent received an untyped binary file. It inspected the file header, identified the Opus audio codec, used FFmpeg to convert it, discovered there was no local transcription tool, found an OpenAI API key in the environment, used cURL to hit the Whisper API, got the transcription back, and replied. Peter had never programmed any of this behavior.

Peter's conclusion: "Those things are so resourceful. It's incredible."

### Tobi's Dark Room

Tobi describes the central challenge facing Shopify in 2026:

> "Right now, my world, in the commerce world, is attempting to figure out what agentic commerce is, how it works, how all the companies are working together, how the research labs work with everyone else, how to expose product catalogues from the entrepreneurs, how to make sure that transactions can be met, what the large language models need in terms of information to do a fantastic job when people ask them to be their personal shoppers."

He frames it explicitly as a dark box:

> "Inside of this, somewhere in it, it's all dark, is the most beautiful solution. What tools do we have to explore this box? It's like, dark. I don't know. I can take a stab at it. I can paint a picture of what I think is good, but that's just like sending people into the room with a couple of tools."

Tobi's instinct, refined over 21 years, is not to pre-specify the solution. He wants to define the box (the problem space), equip people with tools and agency, and let them explore. But the translation of this philosophy to agent-native commerce is still unresolved.

---

## The Thesis

**The empty container and the dark room are structurally identical problems. Peter solved the infrastructure version. Tobi is still working on the commerce version. The solution to both is the same: provide primitives, not tools.**

Three claims support this:

### Claim 1: Pre-built tools are the wrong abstraction layer for agents

The instinct across the commerce industry is to design structured APIs, standardized product feeds, and well-defined transaction protocols so AI agents can "shop." This mirrors the instinct to fill a Docker container with pre-installed tools before handing it to an agent.

Peter's experiment proves this instinct is backwards. His agent didn't need cURL. It needed a compiler and a network stack. From those primitives, it constructed the specific tool it needed for the specific task at hand.

The implication for commerce: agents don't need a perfect Shopify API. They need access to raw product information (even unstructured), payment primitives (ability to initiate transactions), and communication channels. They will construct the intermediary logic themselves, custom-fitted to each purchasing task.

### Claim 2: Over-specification creates the darkness

Tobi's teams are "wandering in the dark" because they're trying to design the complete agentic commerce stack before deploying agents into the commerce environment. They are trying to illuminate the entire room before entering it.

Peter's approach was the opposite. He put the agent in the empty room first and observed what it did. The agent's behavior -- building its own cURL -- revealed what the room actually needed. The agent's actions were the flashlight.

The darkness in agentic commerce is self-imposed. The teams can't see the solution because they're designing from the platform side ("what do we expose to agents?") rather than from the agent side ("what do agents do when you give them commercial primitives and a goal?").

### Claim 3: The breakthrough pattern is constraint + permission, not capability + instruction

Both Peter and Tobi independently advocate for the same management philosophy applied to different substrates:

- **Peter on agents**: Minimal environment, maximum creativity. The Docker container had almost nothing. The agent built what it needed.
- **Tobi on teams**: Define the box, give them tools and agency, don't prescribe the solution. "I'm not there. I don't want to control every decision."
- **Tobi on Shopify OS**: Desired state systems. Define what should be, compute the minimum steps to get there, let the reconciler figure out the path.

The pattern is consistent: specify the constraints and the goal. Do not specify the method. This principle works for humans (Tobi's teams), for companies (Shopify OS), and for agents (Peter's Docker experiment). Agentic commerce is the application of this pattern to the intersection of agents and commercial activity.

---

## What This Means for Each Domain

### For Agentic Infrastructure (Peter's Domain)

Peter's Docker anecdote is not a curiosity. It is evidence of a design principle.

**The "empty container" pattern should be the default agent sandbox architecture.** Not because emptiness is the goal, but because it forces agents to reveal what tools they actually need by constructing them. This produces:

- **Minimal attack surface**: Agents only have capabilities they build, which are observable and auditable.
- **Task-specific tooling**: The agent builds exactly the tool required for the task, not a general-purpose tool that may be over-privileged.
- **Emergence data**: Watching what agents build in empty containers tells you what the ecosystem actually needs -- a form of demand discovery that no product roadmap can replicate.

The risk: agents building tools from primitives is slower and less reliable than using pre-built tools. The counterargument: pre-built tools encode assumptions about what the agent will need. Those assumptions are wrong often enough to matter.

### For Agentic Commerce (Tobi's Domain)

Tobi's instincts are correct. His framework -- define the box, don't prescribe the method -- is the right approach. The translation to agent-native commerce looks like this:

**Stop designing the agent-facing commerce API. Start providing commercial primitives.**

Instead of structured product feeds optimized for LLM consumption, provide:
- Raw product data with enough fidelity that agents can construct their own representations
- Transaction primitives (initiate payment, confirm delivery, dispute) rather than end-to-end purchase flows
- Trust signals (merchant reputation, return policies, product reviews) as raw data, not pre-computed scores

Let agents build their own "commerce cURL" -- the intermediary logic between a user's purchase intent and a completed transaction. Each agent will build it differently based on the user's preferences, risk tolerance, and shopping style.

This reframes the problem. The question is not "what do LLMs need to be good personal shoppers?" The question is "what are the minimum commercial primitives an agent needs to construct a shopping experience?"

The teams wandering in the dark should stop trying to design the room. They should put agents in the room with commercial primitives and observe what the agents build. The agents' behavior will illuminate the space.

### For Both Domains Combined

There is a convergence point where these two domains meet: **the agent that builds its own commerce tools from commercial primitives, operating in a constrained sandbox**.

This agent doesn't use Shopify's API as designed. It accesses raw product data, constructs its own comparison logic, builds its own trust evaluation, initiates transactions through primitive payment rails, and handles exceptions by constructing new tools on the fly -- exactly as Peter's agent built cURL from TCP sockets when it needed to fetch a webpage.

This is terrifying to platform companies. It means agents route around designed interfaces. It means the platform's value shifts from the API layer to the primitive layer -- who controls the raw data, the payment rails, the trust infrastructure.

Shopify's advantage, if this thesis holds, is not their API. It is their access to millions of product catalogues, their payment infrastructure (Shop Pay), and their trust signals from 21 years of merchant data. Those are the primitives. The agents will build everything else.

---

## Preserved Tensions

These tensions are productive and should not be resolved prematurely:

| Tension | Peter's Side | Tobi's Side |
|---------|-------------|-------------|
| **Control vs. emergence** | Agents should be creative and autonomous. The Docker experiment is celebrated as a feature. | Agents acting in commerce need guardrails. A creative agent spending your money is different from one building a cURL binary. |
| **Speed vs. safety** | Agent-built tools are task-specific but unaudited. "It worked. Crazy." | Commerce requires reliability. A "crappy version of cURL" fetching a webpage is fine. A crappy version of a payment processor is not. |
| **Platform value** | The infrastructure layer (sandbox, compute, network) is the value. Tools are ephemeral. | The platform layer (product data, merchant relationships, trust) is the value. But if agents route around the API, what exactly is the product? |
| **Human oversight** | Peter monitors but celebrates autonomous behavior. The voice message story is a positive surprise. | Tobi wants people to "fall in love with the problem." But agentic commerce involves other people's money and livelihoods. The stakes of surprise are higher. |

---

## Extension: Spec-Driven Development as the Counter-Thesis

The principle -- primitives over tools, emergence over specification -- faces a direct challenge from the most sophisticated agent workflow systems being built today. Amazon's Strands Agent SOPs and AWS's Kiro IDE represent the industry's heaviest bet on the opposite principle: **specification over emergence, constraints over creativity**.

This tension is not theoretical. It is the live engineering debate defining how agents will actually be deployed.

### The Spec-Driven Stack

Amazon Strands' agent-sop repository (github.com/strands-agents/agent-sop) implements a complete spec-driven development pipeline through five interlocking SOPs:

1. **PDD (Prompt-Driven Development)**: Transforms a rough idea into a formal design document through structured requirements clarification, research, and architecture. Every step uses RFC 2119 constraints (MUST, SHOULD, MAY). The agent asks one question at a time, saves each answer, iterates between research and requirements, and only proceeds to design with explicit user confirmation.

2. **Code Task Generator**: Takes PDD's design document and decomposes it into sequenced implementation tasks. Each task follows a rigid format: Description, Background, Technical Requirements, Dependencies, Implementation Approach, Acceptance Criteria (Given-When-Then), and Metadata. Tasks are never generated without explicit user approval of the breakdown.

3. **Code Assist**: Executes each task using strict TDD -- RED, GREEN, REFACTOR. The agent writes tests first, implements only what's needed to pass them, refactors to match existing conventions, validates, and commits. Every phase is documented in context.md, plan.md, and progress.md.

4. **Codebase Summary**: Generates comprehensive documentation (AGENTS.md) so agents can understand existing codebases before modifying them.

5. **EvalKit**: Evaluates agent performance against measurable criteria using real execution data.

Kiro's IDE wraps this in a three-stage specification process: Requirements (using EARS notation) to Architecture to Tasks. "Steering files" enforce coding standards. The entire system is designed to prevent exactly what Peter celebrated -- agents improvising solutions that weren't specified.

### What the Spec-Driven Approach Gets Right

The Strands SOPs exist because of real failures. The PDD SOP's constraints reveal hard-won lessons:

- "You MUST ask ONLY ONE question at a time" -- because agents overwhelm users with multi-part questions
- "You MUST NOT pre-populate answers" -- because agents hallucinate user preferences
- "You MUST NOT proceed without explicit user confirmation" -- because agents drift from intent
- "You MUST NOT create steps that are solely dedicated to testing" -- because agents will skip integration testing if given the chance

Every MUST NOT in the specification is a scar from an agent failing. The PDD SOP alone contains 78 MUST constraints and 23 MUST NOT constraints. This is not over-engineering. This is a system built by people who watched agents fail in specific, repeated, predictable ways.

For known engineering tasks -- building a CRUD app, implementing an authentication system, creating an email validator -- this approach works. The solution space is well-understood. The risk is agent drift, not lack of creativity. Spec-driven development solves drift.

### What the Spec-Driven Approach Cannot Do

The Strands pipeline has a critical assumption baked into its architecture: **someone already knows what the solution looks like**.

PDD Step 1 is "Create Project Structure" -- directories for rough-idea.md, research/, design/, implementation/. This presupposes the output is a software project. Step 3 asks the user to clarify requirements. This presupposes the user can articulate requirements. Step 6 creates a detailed design with Architecture Overview, Components and Interfaces, Data Models. This presupposes the problem decomposes into these categories.

For Tobi's dark room, none of these presuppositions hold. What is the "architecture" of agentic commerce? What are the "components"? What are the "data models"? No one knows. That is the problem. The teams are wandering in the dark precisely because they cannot fill in these templates.

The PDD SOP's own troubleshooting section acknowledges this failure mode:

> "If the requirements clarification process seems to be going in circles or not making progress, you SHOULD suggest moving to a different aspect of the requirements."

Going in circles is the symptom of applying specification methodology to a discovery problem. You cannot clarify requirements for a system no one has built yet. You can only observe what happens when agents interact with raw materials.

Peter's Docker experiment was not PDD. There was no requirements clarification. No design document. No Given-When-Then acceptance criteria. There was a goal ("check this website"), primitives (C compiler, network stack), and an agent. The agent's behavior -- building its own cURL -- was the discovery. No specification process would have produced that insight, because no human would have written "the agent should build an HTTP client from TCP sockets" as a requirement.

### The Phase Model: Discovery Precedes Specification

These two approaches are not contradictory. They operate at different phases of a problem's lifecycle.

**Phase 1: Discovery (Empty Container)**
Unknown problem space. You don't know what the solution looks like. Provide primitives and permission. Observe what agents build. Peter's Docker experiment. Tobi's "dark box" exploration. The agent's behavior is the data.

**Phase 2: Specification (Strands/Kiro)**
Known problem space, revealed by discovery. You now know what the solution looks like because you watched agents find it. Formalize the patterns into requirements, architecture, and tasks. PDD, Code Task Generator, Code Assist. The specification encodes what discovery revealed.

**Phase 3: Execution (TDD + Deploy)**
Build the production system to the spec. Strict TDD, acceptance criteria, conventional commits. Strands' Code Assist is purpose-built for this phase.

The mistake every team makes is applying Phase 2 methodology to Phase 1 problems. Shopify's agentic commerce teams are trying to write PDD design documents for a system that hasn't been discovered yet. They're filling in "Architecture Overview" and "Components and Interfaces" for a dark room.

The error is understandable. PDD looks like rigor. Empty containers look like chaos. Organizations choose what looks rigorous. But premature specification is not rigor. It is the illusion of progress -- filing detailed plans for a building whose foundation hasn't been surveyed.

### Tobi's Phase Transition System Is the Bridge

Tobi already has the framework for connecting these phases. His project system at Shopify mirrors this exact structure:

- **Prototype phase**: "Explore the problem." This is the empty container. Agents and teams are given a box, tools, and agency. They search the dark room. No formal specification. No PDD design docs.
- **Phase transition meeting**: "Tell me what you've learned." This is the moment discovery converts to specification. The team presents findings. Tobi gives "Okay two." The risk transfers from team to company.
- **Build phase**: "New box. Agency to make decisions in there." This is Strands territory. Known problem, known architecture, execute with discipline.

The Strands SOPs are excellent Phase 2-3 tools. They are the wrong tool for Phase 1. The empty container thesis provides what Strands lacks: a methodology for discovery.

### What This Means for Agentic Commerce

The synthesis is concrete:

**Step 1 (Discovery):** Put agents in a minimal commercial environment. Raw product data. Basic payment primitives. Trust signals. No structured APIs. No spec'd transaction flows. Tell the agent: "Buy the best running shoes for under $150." Observe. What data does it request? What tools does it build? What workflows does it create? What fails?

**Step 2 (Specification):** Take the behavioral patterns from Step 1 and run them through PDD. Now you have real requirements -- derived from agent behavior, not human imagination. "The agent needs structured size availability data because it built three separate scrapers to find it." "The agent needs a trust verification primitive because it refused to transact with merchants lacking return policies." These are requirements no human would have written, revealed by agents in empty containers.

**Step 3 (Execution):** Code Task Generator decomposes the design. Code Assist implements it with TDD. The production agentic commerce stack is built to a spec that was discovered, not imagined.

### The Industry Blind Spot

The Strands/Kiro ecosystem reveals a blind spot in how the industry thinks about agent development. The entire pipeline assumes the hardest problem is execution fidelity -- making sure agents follow instructions precisely. Every SOP is designed to constrain agent behavior, prevent drift, ensure compliance with the spec.

For most software engineering, this is correct. The hardest problem is execution fidelity.

For novel problem spaces -- agentic commerce, autonomous scientific research, open-ended planning -- the hardest problem is discovery. Making sure agents follow instructions precisely is useless when you don't know what instructions to give.

Peter Steinberger discovered this by accident. He gave an agent an empty container and said "be creative." The agent's creativity was the product. Tobi Lutke's instinct says the same thing: define the box, not the method. Amazon's Strands does the opposite: define the method completely, then let the agent execute.

Both are right. Neither is complete. The complete system is: discover with empty containers, then specify with Strands SOPs, then execute with TDD. The principle -- primitives over tools, emergence over specification -- governs Phase 1. The Strands principle -- constraints over creativity, specification over emergence -- governs Phases 2 and 3.

The teams that figure this out first will own agentic commerce. The ones still trying to write PDD design documents for a dark room will keep wandering.

---

## Updated Source Validation Matrix

| Source | Authority | Recency | Relevance | Internal Consistency |
|--------|-----------|---------|-----------|---------------------|
| Peter Steinberger (Builders Unscripted, OpenAI) | High | March 2026 | Direct | Strong |
| Tobi Lutke (Founders Podcast / David Senra) | Very High | January 2026 | Direct | Strong |
| Amazon Strands Agent SOPs (github.com/strands-agents/agent-sop) | High. Amazon's agent workflow framework. 5 production SOPs, RFC 2119 constraint system, active development (56+ PRs). Integrated with Kiro IDE. | March 2026 (latest commits) | Direct. Represents the industry's strongest counter-thesis to emergence-over-specification. | Very Strong. Internally coherent system where each SOP feeds into the next. Constraints are empirically derived from agent failure patterns. |
| Kiro IDE (kiro.dev, AWS) | High. AWS-backed IDE with spec-driven development as core philosophy. Three-stage spec process (Requirements, Architecture, Tasks). EARS notation for formal requirements. | March 2026 | Direct. The commercial implementation of spec-driven agent development. | Strong. Philosophy is consistent with Strands SOPs and extends them with IDE-level integration. |

---

## Updated Preserved Tensions

| Tension | Empty Container Side | Spec-Driven Side |
|---------|---------------------|------------------|
| **Discovery vs. execution** | Agents discover solutions by building tools from primitives. The behavior IS the data. | Agents execute known solutions reliably. The specification IS the product. |
| **When to constrain** | Constrain the environment (primitives available), not the method. | Constrain the method (78 MUSTs per SOP), not the environment. |
| **What "rigor" means** | Rigorous observation of emergent behavior. Systematic documentation of what agents build. | Rigorous specification of expected behavior. Systematic enforcement of constraints. |
| **Source of requirements** | Requirements emerge from agent behavior in primitive environments. You watch and learn. | Requirements emerge from human analysis and stakeholder clarification. You ask and document. |
| **Risk model** | Risk of missing the solution because you never let agents search for it. | Risk of drifting from the solution because agents hallucinate and wander. |
| **Phase applicability** | Phase 1: Unknown problem spaces. High uncertainty. Novel domains. | Phases 2-3: Known problem spaces. Low uncertainty. Engineering execution. |

---

## Objective Assessment: Strength of the Connection

**Strong. Strengthened by the counter-thesis.**

The structural parallel between the empty container and the dark room is genuine, not forced. Both describe the same epistemological problem: how do you find solutions in an unknown space? Both arrive at the same answer: equip actors with primitives, define constraints, observe what emerges.

The Strands/Kiro counter-thesis does not weaken this connection. It sharpens it. The spec-driven ecosystem demonstrates precisely what the industry reaches for when confronting agent development -- and precisely why that reflex fails for novel problem spaces. The 78 MUST constraints in PDD are the right tool for known engineering. They are the wrong tool for a dark room. The fact that Amazon built this elaborate system and it still cannot address Tobi's core problem ("what IS agentic commerce?") is itself evidence that ==the principle -- primitives over tools, emergence over specification== -- identifies a real gap.

The caveat remains domain transfer. A bad cURL binary crashes. A bad commerce transaction costs money. But the phase model resolves this: use empty containers for discovery (where the stakes are research budgets, not customer money), then use Strands-style specification for production (where the stakes are real transactions). Discovery is cheap. Premature specification is expensive. Building the wrong system to spec costs more than letting an agent flail in a sandbox.

The connection is monumental in two senses. First, it suggests Shopify's teams are solving the wrong problem -- designing the room instead of observing what agents do in it. Second, it suggests the entire agent development industry has a Phase 1 gap. Amazon built the best Phase 2-3 tools. Nobody has built the Phase 1 methodology. Peter stumbled into it with an empty Docker container. The team that systematizes "empty container discovery" and connects it to Strands-style specification will own the next layer of agent infrastructure.

---

*Synthesized: 2026-03-06*
*Sources: Peter Steinberger -- Builders Unscripted (OpenAI, 2026); Tobi Lutke -- Founders Podcast / David Senra (2026); Amazon Strands Agent SOPs (github.com/strands-agents/agent-sop, 2026); Kiro IDE (kiro.dev, AWS, 2026)*
