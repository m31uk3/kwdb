# AI Agent Architecture & Development Patterns

Knowledge synthesis for Amazon Global Real Estate interview preparation. Curated context optimized for recall during live conversation.

---

## Executive Summary

Eight sources converge on a paradigm shift: building AI solutions is moving from writing code to writing specifications, with quality measured by scenario satisfaction rather than code review. Two forms of digital twins — software-behavioral (API clones) and physics-based (facility simulation) — both solve the same problem: testing against the real thing is too expensive, slow, or risky. The emerging frontier is not better individual agents but better agent colonies — orchestrated factories where coordination trumps individual capability. For Amazon Global Real Estate, this means the competitive advantage lies in how you structure and verify AI work, not which model you pick.

---

## Source Validation Matrix

| # | Source | Authority | Recency | Relevance |
|---|--------|-----------|---------|-----------|
| 1 | [OpenClaw Architecture](https://www.distributedthoughts.org/openclaw-and-the-architecture-nobody-noticed/) | Industry analysis, 209K GitHub stars validates thesis | 2025-2026 | Architecture decisions > model capabilities |
| 2 | [PDD SOP](https://github.com/strands-agents/agent-sop/blob/main/agent-sops/pdd.sop.md) | Strands Agents (AWS-affiliated) | 2025 | Direct prototyping methodology |
| 3 | [Skill Authoring Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) | Anthropic official docs | 2025-2026 | Agent design patterns from model creator |
| 4 | [Effective Harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) | Anthropic Engineering | 2025-2026 | Production agent infrastructure |
| 5 | [StrongDM Software Factory](https://simonwillison.net/2026/Feb/7/software-factory/) | Practitioner report via Simon Willison | Feb 2026 | Most advanced production pattern documented |
| 6 | [Five Levels Framework](https://www.danshapiro.com/blog/2026/01/the-five-levels-from-spicy-autocomplete-to-the-software-factory/) | Dan Shapiro (CEO, practitioner) | Jan 2026 | Mental model for AI adoption maturity |
| 7 | [NVIDIA Omniverse / Digital Twins](https://www.nvidia.com/en-us/glossary/digital-twin/) | NVIDIA official | 2025-2026 | Physical-world twin for real estate/facilities |
| 8 | [Future of Coding Agents](https://steve-yegge.medium.com/the-future-of-coding-agents-e9451a84207c) + [Welcome to Gas Town](https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04) | Steve Yegge (ex-Amazon, ex-Google, 40yr practitioner) | Jan 2026 | Colony/factory paradigm, velocity/coordination at scale, 8-stage dev evolution |
| 9 | [Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md) + [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) | Dexter Horthy / HumanLayer | 2025-2026 | Production LLM principles: own your context, stateless reducers, human-in-loop via tools |
| 10 | [Everything is a Ralph Loop](https://ghuntley.com/loop/) | Geoffrey Huntley | 2025-2026 | Monolithic single-task loops, context engineering as universal pattern, autonomous iteration |

---

## Convergent Knowledge

### 1. Evaluation-First Development

Three sources independently converge: define how you'll measure success before writing anything.

**The pattern:** Create scenario tests as external holdout sets — end-to-end user stories stored outside the codebase. Measure "satisfaction": what fraction of observed trajectories through all scenarios satisfy the user? [5]

**Supporting evidence:**
- "Build evaluations BEFORE writing extensive documentation" — create 3+ scenarios, establish baseline, then write minimal instructions to pass [3]
- Feature lists (JSON format, not Markdown) track completion with mandatory browser automation verification before marking complete [4]
- PDD Step 3 explores success metrics during requirements clarification before any building [2]

**Application:** When prototyping for a real estate use case, define scenario tests first. "Given a lease renewal request, the agent retrieves the correct property data, applies current market rates, and generates a recommendation within 30 seconds" — test this before building.

### 2. Specification-Driven Development

The shift from writing code to writing specifications represents a fundamental restructuring, not an acceleration.

**The Five Levels** [6]:
- **L0 Manual** → L1 Assisted → L2 Collaborative → **L3 Human-in-Loop** → L4 Spec-Driven → L5 Dark Factory
- Most teams plateau at L3. Advancing requires restructuring how work operates.
- L4+: Developer becomes product manager. Quality comes from scenario satisfaction, not code review.

**StrongDM's principle:** "Code must not be written by humans. Code must not be reviewed by humans." Quality validated entirely through scenario satisfaction metrics. [5]

**Anthropic's harness pattern:** Initializer agent sets up infrastructure (init.sh, progress files, feature list, baseline commit). Coding agent works on single features incrementally, each session starting from progress files. [4]

**PDD operationalizes this:** 8-step process from rough idea → requirements → research → design → implementation plan. Each implementation step produces "working, demoable functionality." [2]

**Yegge's verification principle:** "How good are your tests? How good is your verification suite? Does it meet the customer's needs? That's all that matters." Programming has always been best-effort — the difference now is the black box is AI instead of an engineer. The output quality standard hasn't changed. [8]

### 3. Colonies Over Individual Agents

The emerging frontier is not better workers but better factories.

**The colony thesis:** "When work needs to be done, nature prefers colonies." Every agent vendor builds pair programmers (workers). The competitive advantage is building factories that coordinate swarms. "Colonies are going to win. Factories are going to win. Automation is going to win." [8]

**Orchestrator evolution:** Yegge iterated through 4 orchestrator versions (TypeScript/Temporal → Go/monolithic → Python/scripts → Go/Gas Town). The key pivot: stop trying to make agents better, start making MORE of them and coordinating them. "Gas Town has all the features of the other two, with a tiny fraction of the code." [8]

**Desire Paths for agent UX:** "Tell the agent what you want, watch closely what they try, and then implement the thing they tried. Make it real. Over and over." This observation-driven approach converges with Anthropic's "observe how Claude navigates Skills" pattern. [8][3]

**The velocity/coordination problem:** Teams using AI coding at full velocity find that "2 hours ago is ancient." One company adopted "one engineer per repo" because they couldn't solve the merge problem. Everything must be 100% transparent and announced in real-time. Small shops dramatically outperform large ones. [8]

**Implication for Amazon:** Large organizations face a structural disadvantage — coordination overhead grows while individual velocity explodes. The answer isn't slowing down individuals; it's building better orchestration infrastructure (the "Orchestrator API Surface"). [8]

### 4. Digital Twins — Two Domains, One Principle

Both forms solve: "it's too expensive, slow, or risky to test against the real thing."

| Dimension | Software-Behavioral (DTU) [5] | Physics-Based (Omniverse) [7] |
|-----------|-------------------------------|-------------------------------|
| **Twins what** | Third-party APIs (Okta, Jira, Slack) | Physical world (factories, warehouses) |
| **Built from** | Public API docs + SDK client validation | CAD/BIM/IoT data + PhysX simulation |
| **Fidelity** | 100% SDK compatibility | Physics-accurate, ray-traced |
| **Speed** | Thousands of API scenarios/hour | Real-time facility simulation |
| **Use at Amazon** | Enterprise software integrations | Warehouse layout, HVAC, occupancy |

**DTU construction method:** Dump public API documentation into agent harness → generate imitation services as self-contained binaries → validate against popular SDK client libraries targeting 100% compatibility. [5]

**Omniverse at Amazon scale:** Factory planning (BMW, Foxconn, PepsiCo use cases), robotic fleet simulation, facility optimization before physical implementation. [7]

### 4. Progressive Disclosure & Context Management

Agent effectiveness depends on information architecture, not information volume.

**Core principle:** "The context window is a public good." Only add context the agent doesn't already have. Challenge each piece: "Does this justify its token cost?" [3]

**Patterns:**
- SKILL.md as table of contents, reference files loaded on-demand [3]
- Keep primary instructions under 500 lines, split into domain-specific files [3]
- Pyramid Summaries — multi-level documentation for agent navigation [5]
- Feature tracking in JSON (more resistant to unintended modifications than Markdown) [4]

**Degrees of freedom:** Match specificity to task fragility. High freedom for heuristic tasks, low freedom for fragile operations (database migrations, API calls with strict sequencing). [3]

### 5. The Loop as Universal Pattern

Multiple independent sources converge on iterative loops as the fundamental unit of agent work.

**The Ralph Loop** [10]: Monolithic, single-task autonomous loops. "Allocate specifications and define an objective, then loop toward completion while monitoring for failure domains." Context engineering is "GENERIC and can be used for ALL TASKS."

**12-Factor Agents** [9]: "Make your agent a stateless reducer" — agents as pure functions that transform input state. Combined with "Launch/Pause/Resume" lifecycle management = resumable loops. "Compact errors into context window" = the loop self-corrects.

**Anthropic's harness** [4]: Initializer → coding agent loop. Each session: read progress → pick next feature → implement → test → commit → update progress → next session.

**Yegge's GUPP** [8]: "If there is work on your hook, YOU MUST RUN IT." Molecular workflows loop across sessions — agent crashes, next session picks up at exact step. Nondeterministic Idempotence: path is nondeterministic, outcome is guaranteed.

**Convergence:** The loop pattern appears in every source that describes production agent systems. Whether called a Ralph Loop, a patrol, a harness session, or an evaluation cycle — the shape is identical: pick up state → do one unit of work → validate → persist → repeat.

### 6. Own Your Context Window

Agent effectiveness depends on information architecture, not information volume.

**12-Factor Agents** [9]: "Own Your Context Window" — actively manage what information gets fed to the LLM. Don't passively accumulate context.

**CLAUDE.md best practices** [9]: LLMs can reliably follow ~150-200 instructions. Since the system prompt consumes ~50, your configuration should be minimal and universally applicable. Target under 300 lines. Store task-specific guidance in separate files with brief descriptions — progressive disclosure.

**Skill authoring** [3]: "The context window is a public good." SKILL.md as table of contents, reference files loaded on-demand. Keep primary instructions under 500 lines, split into domain-specific files.

**Pyramid Summaries** [5]: Multi-level documentation for agent navigation.

**Feature tracking** [4]: JSON format (more resistant to unintended modifications than Markdown).

**Degrees of freedom:** Match specificity to task fragility. High freedom for heuristic tasks, low freedom for fragile operations (database migrations, API calls with strict sequencing). [3]

### 7. Local-First / Compute-Over-Data

Architecture decisions drive adoption more than model capabilities.

**OpenClaw's lesson:** 209K GitHub stars in 84 days. Not because of AI capability — it's model-agnostic (Claude, GPT, DeepSeek, Llama). Success came from local-first compute, existing interface integration (WhatsApp, Slack), and data locality. [1]

**The pattern:** Processing occurs where information already resides. Eliminates centralized data movement. This is "a compute-over-data architecture." [1]

**Industry convergence:** Apple Intelligence, Google Gemini Nano, Samsung Galaxy AI all prioritize on-device processing. Consumer preference for local execution is persistent. [1]

---

## Preserved Tensions

### Autonomy vs. Oversight

StrongDM operates at L4-L5 (no human code review, scenario satisfaction only) [5][6]. Anthropic's harness pattern maintains human-in-the-loop with mandatory progress documentation and incremental commits [4]. The right level depends on domain risk — real estate lease decisions need more oversight than internal tooling.

### Cost Viability

StrongDM reports ~$1,000/day per engineer in token costs [5]. Yegge reports power users burning $60K/year and "quickly pushing up into dev-salary territory" [8]. This frames a critical decision point: when does AI prototyping cost more than the problem it solves? For high-value real estate decisions (multi-million dollar leases), the math works. For simple heuristic problems, it doesn't. Know when NOT to use AI.

### Top-Down vs. Bottom-Up Design

PDD prescribes structured requirements clarification before building (top-down) [2]. Yegge's Desire Paths methodology watches what agents try and makes it real (bottom-up) [8]. Both work. The right approach depends on domain risk: high-stakes real estate decisions warrant top-down; internal tooling benefits from bottom-up emergence.

### Scale: Solo Unicorns vs. Large Organizations

Yegge predicts "the entire world is going to explode into tiny companies" that dramatically outperform large ones [8]. Amazon is the opposite — massive coordination at scale. The tension is real: how does a large org capture factory-speed velocity without the merge problem destroying coordination? This is an unsolved problem as of early 2026.

---

## Feedback Loops Pattern

Every source that discusses quality includes some form of: **run validator → fix → repeat.**

- Scenario tests → measure satisfaction → fix → rerun [5]
- Browser automation → verify feature → update status → next feature [4]
- Validate XML → fix errors → revalidate → proceed [3]
- Requirements clarification → research → checkpoint → iterate [2]

The loop is the quality mechanism. Not code review. Not manual testing. Automated, repeatable validation against external criteria.

---

## Amazon LP Alignment

| Pattern | Leadership Principle |
|---------|---------------------|
| Evaluation-first, satisfaction metric | **Customer Obsession** — measure from user's perspective |
| Prototype fast, spec-driven | **Bias for Action** — working demos over planning docs |
| Know when NOT to use AI | **Frugality** — right tool for the problem |
| Digital twins, DTU pattern | **Invent and Simplify** — eliminate external dependencies |
| Five Levels maturity model | **Think Big** — restructure work, don't just accelerate |
| Progressive disclosure, context management | **Dive Deep** — right information at right time |
| Feedback loops | **Insist on the Highest Standards** — automated quality gates |
| Colony coordination, factory model | **Earn Trust** — transparent, real-time visibility into all agent work [8] |
| Desire Paths, observe-then-build | **Learn and Be Curious** — let agent behavior reveal optimal design [8] |
| Velocity/coordination problem at scale | **Have Backbone; Disagree and Commit** — small teams moving fast need clear decision protocols [8] |

---

## FAQs

### FAQ-1: How do Steve Yegge's 8 Stages and Dan Shapiro's 5 Levels compare and contrast?

Both frameworks describe the trajectory from manual coding to fully autonomous AI development, but they measure different axes and reveal different insights.

**Yegge's 8 Stages of Dev Evolution (2024-2026)** [8]:

| Stage | Description | Trust Level |
|-------|-------------|-------------|
| S1 | Zero/near-zero AI — code completions, chat questions | None |
| S2 | Agent in IDE, permissions on — narrow sidebar agent | Low |
| S3 | Agent in IDE, YOLO mode — permissions off, agent widens | Medium |
| S4 | In IDE, wide agent — agent fills screen, code is just for diffs | High |
| S5 | CLI, single agent, YOLO — diffs scroll by, may not look | Very high |
| S6 | CLI, multi-agent, YOLO — 3-5 parallel instances | Full trust, individual |
| S7 | 10+ agents, hand-managed — pushing limits of manual coordination | Full trust, swarm |
| S8 | Building your own orchestrator — automating the workflow itself | Factory operator |

**Shapiro's 5 Levels of AI-Assisted Development** [6]:

| Level | Description | Developer Role |
|-------|-------------|----------------|
| L0 | Manual — not a character hits disk without approval | Traditional coder |
| L1 | Assisted Tasks — delegate discrete tasks (tests, docs) | Coder + delegator |
| L2 | Collaborative Partnership — "autopilot on highway," flow states | Pair programmer |
| L3 | Human-in-the-Loop Review — reviewing AI-generated diffs | Code reviewer / manager |
| L4 | Specification-Driven — write specs, AI works autonomously | Product manager |
| L5 | Dark Factory — specs → production software, no human in loop | Factory owner |

**Approximate Mapping:**

```
Yegge S1        ≈  Shapiro L0    (no/minimal AI)
Yegge S2-S3     ≈  Shapiro L1    (AI assists specific tasks)
Yegge S4        ≈  Shapiro L2    (collaborative, AI fills screen)
Yegge S5        ≈  Shapiro L2-L3 (single CLI agent, diffs scroll by)
Yegge S6        ≈  Shapiro L3    (multi-agent, you're managing/reviewing)
Yegge S7        ≈  Shapiro L4    (10+ agents, you specify work not code)
Yegge S8        ≈  Shapiro L5    (orchestrator = dark factory)
```

**Key Contrasts:**

1. **Different measurement axes.** Yegge measures *practitioner behavior* — what are you physically doing with your hands? How many agents, what interface, what trust level? Shapiro measures *role transformation* — what is your job title becoming? Coder → reviewer → PM → factory owner.

2. **Horizontal vs. vertical scaling.** Yegge's progression scales *horizontally* (more agents: 1 → 5 → 10 → 30). Shapiro's scales *vertically* (more autonomy per agent). The factory endpoint is the same, but the path differs: Yegge gets there through coordination of many, Shapiro through delegation to few.

3. **Granularity differs.** Yegge has 4 stages (S1-S4) covering what Shapiro compresses into 2 levels (L0-L1) — the in-IDE journey. Conversely, Shapiro has sharper definition at the spec-driven stage (L4) as a distinct role shift, while Yegge's S7-S8 blend specification-writing with orchestrator-building.

4. **The plateau problem.** Shapiro warns most teams plateau at L3 (reviewing diffs) and fail to recognize that L4+ requires *restructuring how work operates*. Yegge says most devs are at S5-S6 and "not ready" for Gas Town (S7+). Same insight, different framing: the jump from "managing agents" to "running a factory" is the hardest transition in both models.

5. **Where they converge.** Both agree:
   - The endpoint is autonomous factory production (S8 ≈ L5)
   - The developer becomes a product manager / overseer, not a coder
   - Quality comes from verification suites and scenario testing, not code review
   - The transition requires a fundamental identity shift, not just better tooling

6. **Unique to Yegge:** The colony/swarm dimension. Yegge's model captures something Shapiro's doesn't: the *coordination problem* that emerges when you scale horizontally. "2 hours ago is ancient." Merge queues, witness agents, patrol loops — these are problems that only exist when you have 10+ agents, and Shapiro's framework doesn't address them.

7. **Unique to Shapiro:** The "deceptive plateau" insight. L2 (collaborative partnership) *feels* like the destination — "90% of AI-native developers are living right now" at this stage. Yegge's model doesn't explicitly call out this false summit; it focuses on the climb.

**Interview application:** When asked about AI tool maturity (Colin Q1, Q5), use Shapiro's levels to describe organizational readiness and Yegge's stages to describe personal practitioner evolution. They're complementary lenses — Shapiro for the boardroom, Yegge for the engineer's desk.

---

*Synthesized 2026-02-24. Ten sources, all validated. Convergence strong on evaluation-first, spec-driven, loop-as-universal-pattern, own-your-context, and colony/factory patterns. Tension preserved on autonomy level, cost viability, design methodology (top-down vs bottom-up), and organizational scale.*
