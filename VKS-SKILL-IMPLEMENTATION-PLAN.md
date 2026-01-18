# VKS Skill Implementation Plan

**Date:** 2025-12-28
**Based on:** Official skills analysis from `/Users/ljack/github/ai-skills/reference/official-skills`

---

## Executive Summary

Build a single **Validated Knowledge Synthesis (VKS)** skill following official Claude Code patterns. Target ~500-600 lines for SKILL.md with progressive disclosure through references/, examples/, and scripts/ subdirectories.

**User invocation:** `/vks` (short skill name)
**Auto-invocation:** When Claude detects synthesis, validation, or knowledge curation language

---

## Analysis of Official Skills Patterns

### Size Distribution (8 official skills analyzed)

| Skill | Lines | Structure |
|-------|-------|-----------|
| example-skill | 84 | Minimal template |
| agent-development | 415 | Standard with refs |
| plugin-structure | 476 | Standard with refs |
| plugin-settings | 544 | Standard with refs |
| mcp-integration | 554 | Standard with refs |
| skill-development | 637 | Comprehensive |
| hook-development | 712 | Comprehensive |
| command-development | 834 | Most comprehensive |

**Target for VKS:** 500-600 lines (standard-comprehensive range)

### Frontmatter Description Patterns

**Structure:** `"This skill should be used when the user asks to [quoted phrases], [more phrases], or [conditions]. [Optional: what it provides]"`

**Examples from official skills:**
- Hook Development: Lists 8+ specific trigger phrases in quotes
- Agent Development: Lists 10+ specific phrases with commas
- Command Development: Lists 12+ specific phrases
- Skill Development: Lists 6+ specific phrases with "or needs guidance on..."

**Key insight:** Be VERY specific with trigger phrases. Use exact user language.

### Directory Structure (Standard Pattern)

```
skill-name/
├── SKILL.md                    # 400-700 lines, core guidance
├── references/                 # Detailed content (7-10K each)
│   ├── pattern-name.md
│   ├── advanced-topic.md
│   └── detailed-guide.md
├── examples/                   # Working examples (1-3K each)
│   ├── example-1.ext
│   └── example-2.ext
└── scripts/                    # Utilities
    ├── README.md
    ├── utility-1.sh
    └── utility-2.sh
```

**Usage in SKILL.md:** Point to references explicitly in "Additional Resources" section at end

### SKILL.md Content Pattern

**Standard sections:**
1. **Overview** - What it is, key capabilities (50-100 lines)
2. **Core Concepts** - Main ideas with brief examples (100-200 lines)
3. **Workflow/Process** - Step-by-step guidance (100-200 lines)
4. **Common Patterns** - Quick reference, decision matrices (100-150 lines)
5. **Additional Resources** - Explicit pointers to references/, examples/, scripts/ (30-50 lines)

**Writing style:** Imperative form, objective, instructional (from skill-development analysis)

---

## VKS Skill Specification

### File Location

```
.claude/skills/vks/
├── SKILL.md
├── references/
│   ├── frameworks.md
│   ├── synthesis-strategies.md
│   ├── validation-methods.md
│   └── frontmatter-schema.md
├── examples/
│   ├── youtube-synthesis-example.md
│   ├── technical-doc-synthesis.md
│   └── interview-transcript-synthesis.md
└── scripts/
    ├── README.md
    ├── validate-frontmatter.sh
    └── extract-yt-metadata.sh
```

### Frontmatter (SKILL.md header)

```yaml
---
name: Validated Knowledge Synthesis
description: This skill should be used when the user asks to "synthesize knowledge", "create curated context", "validate information sources", "apply Golden Path criteria", "use Answer-Explain-Educate framework", "apply What-So What-Now What", "transform unstructured information", "validate synthesis", "merge source metadata", "create knowledge base", "extract yt-dlp metadata", or discusses transforming raw information into actionable, validated knowledge through systematic synthesis with YAML frontmatter provenance.
version: 2.1.0
---
```

**Trigger phrase count:** 12+ specific phrases (matches official skills pattern)

### SKILL.md Content Structure (~550 lines target)

#### Section 1: Overview (60 lines)
- What VKS is (transformation methodology)
- Key capabilities (validation, synthesis strategies, frameworks)
- When to use (unstructured → structured knowledge)
- Core principle (reader empathy, minimal words, maximum grounding)

#### Section 2: Core Concepts (120 lines)
- **Source Validation** - Assess reliability before synthesis
- **Synthesis Strategies** - Convergent vs tension preservation vs dual-track
- **Document Types** - Curated context (default), guidance, reference, hybrid
- **Progressive Validation** - Validate at each step
- Brief examples for each

#### Section 3: Document Type Selection (80 lines)
- **Curated Context (Default)** - When to use, characteristics
  - Reader empathy as primary requirement
  - Golden Path criteria integration
  - Answer-Explain-Educate structure
  - What-So What-Now What flow
- **Other Types** - Guidance, reference, hybrid (brief)
- Quick decision matrix

#### Section 4: Synthesis Workflow (120 lines)
- **Step 1:** Validate sources → reliability assessment
- **Step 2:** Identify patterns → complementary vs conflicting
- **Step 3:** Choose strategy → convergent, tension, dual-track
- **Step 4:** Select document type → based on reader needs
- **Step 5:** Execute synthesis → apply frameworks
- **Step 6:** Validate output → logic, coherence, reader empathy
- **Step 7:** Generate with frontmatter → complete metadata

Brief workflow example showing all steps

#### Section 5: YAML Frontmatter Integration (70 lines)
- **Purpose** - Provenance, discoverability, organization
- **Source Metadata** - From yt-dlp or other sources
- **Synthesis Metadata** - VKS-specific fields
- **Merging Strategy** - How to combine source + synthesis metadata
- Template snippet (brief, full in references/frontmatter-schema.md)

#### Section 6: Writing Principles (Quick Reference) (50 lines)
- **Reader Empathy** - Who they are, what's asked of them
- **Short Sentences** - Manage cognitive load (John Rauser)
- **Strong Verbs** - Precise, concrete
- **Simple Words** - Best, most precise choice
- **Core Tenet** - Communicate in 30 seconds what takes others 5 minutes

#### Section 7: Decision Matrices (40 lines)
- **Input Type → Approach** matrix
- **Source Count → Strategy** matrix
- **Reader Need → Document Type** matrix

#### Section 8: Additional Resources (30 lines)

```markdown
## Additional Resources

### Reference Files

For detailed framework specifications and advanced techniques:
- **`references/frameworks.md`** - Complete Golden Path criteria, Answer-Explain-Educate, What-So What-Now What, writing principles with examples
- **`references/synthesis-strategies.md`** - Detailed decision criteria for convergent synthesis, tension preservation, and dual-track approaches with case studies
- **`references/validation-methods.md`** - Source validation matrices, logic coherence checks, narrative flow validation, practical testing methods
- **`references/frontmatter-schema.md`** - Complete YAML frontmatter schema with all fields, examples, templates, and yt-dlp integration

### Example Files

Working synthesis examples demonstrating VKS methodology:
- **`examples/youtube-synthesis-example.md`** - Conference talk synthesis (Dex Horthy context engineering)
- **`examples/technical-doc-synthesis.md`** - API documentation synthesis
- **`examples/interview-transcript-synthesis.md`** - Interview synthesis with multiple speakers

### Utility Scripts

Helper scripts for VKS workflow automation:
- **`scripts/validate-frontmatter.sh`** - Validate YAML frontmatter schema compliance
- **`scripts/extract-yt-metadata.sh`** - Extract metadata from yt-dlp .info.json files
- **`scripts/README.md`** - Script usage documentation
```

---

## Reference Files Content Specifications

### references/frameworks.md (~300 lines / 7-10K)

**Purpose:** Complete, detailed documentation of all VKS frameworks

**Sections:**
1. **Golden Path Criteria** (80 lines)
   - All 5 criteria with detailed explanations
   - Validation questions for each
   - Examples of good vs bad for each criterion

2. **Answer-Explain-Educate Framework** (60 lines)
   - Answer: Lead with direct response
   - Explain: Support with key details
   - Educate: Add important context
   - Multiple examples across different domains

3. **What-So What-Now What Framework** (60 lines)
   - What: Present facts and key details
   - So What: Analyze consequences for audience
   - Now What: Recommend action/decision
   - Examples in challenge-solution format

4. **Short Sentences Principle** (40 lines)
   - John Rauser's framework
   - Short sentences are free
   - Build patience reservoir
   - Examples with word count

5. **Strong Verbs & Simple Words** (60 lines)
   - Precise, concrete verbs
   - Avoid helper verbs, infinitives, "to be"
   - Simple = best, most precise (not necessarily short)
   - Extensive before/after examples

### references/synthesis-strategies.md (~250 lines / 6-8K)

**Purpose:** Detailed decision criteria and techniques for synthesis strategies

**Sections:**
1. **Convergent Synthesis** (80 lines)
   - When to use (complementary ideas, higher abstraction resolves contradictions)
   - How to execute (find common ground, unified narrative)
   - Validation criteria
   - 3-4 detailed examples with analysis

2. **Tension Preservation** (80 lines)
   - When to use (contradictions generate insights, context-dependent)
   - How to execute (maintain boundaries, document contexts)
   - Validation criteria
   - 3-4 detailed examples with analysis

3. **Dual-Track Approach** (50 lines)
   - When to use (mixed content)
   - How to combine convergence + tension
   - 2 examples

4. **Decision Framework** (40 lines)
   - Step-by-step decision tree
   - Signal detection (when ideas strengthen vs when separation adds value)
   - Edge cases and troubleshooting

### references/validation-methods.md (~200 lines / 5-7K)

**Purpose:** Complete validation techniques and checklists

**Sections:**
1. **Source Validation** (60 lines)
   - Reliability assessment criteria
   - Authority and credibility checks
   - Recency and relevance
   - Internal consistency
   - Citation quality
   - Validation matrix template

2. **Logic Validation** (50 lines)
   - Convergent synthesis logic checks
   - Tension preservation rigor checks
   - Circular reasoning detection
   - Abstraction level appropriateness

3. **Narrative Validation** (50 lines)
   - Flow without formatting test
   - Paragraph connection checks
   - Comprehension validation
   - For guidance documents specifically

4. **Practical Validation** (40 lines)
   - Consistency checks
   - Application tests
   - Expert review criteria
   - Outcome prediction metrics

### references/frontmatter-schema.md (~250 lines / 6-8K)

**Purpose:** Complete YAML frontmatter specification and templates

**Sections:**
1. **Schema Overview** (30 lines)
   - Purpose of frontmatter
   - VKS metadata sections
   - Versioning strategy

2. **Field Definitions** (100 lines)
   - VKS Document Metadata fields (vks_version, document_type, etc.)
   - Source Provenance fields (source_type, source_url, etc.)
   - Synthesis Details fields (synthesis_topic, synthesis_strategy, etc.)
   - Content Organization fields (primary_topics, key_concepts, etc.)
   - Usage Metadata fields (use_cases, estimated_read_time, etc.)
   - File Relationships fields
   - Each with description, type, examples

3. **yt-dlp Integration** (40 lines)
   - Available yt-dlp metadata fields
   - How to extract from .info.json
   - Mapping to VKS source_* fields
   - genInfoNugget.yt integration

4. **Templates** (80 lines)
   - Minimal template (10 essential fields)
   - Standard template (20 recommended fields)
   - Comprehensive template (all fields)
   - YouTube source template (with yt-dlp fields)

---

## Example Files Specifications

### examples/youtube-synthesis-example.md (~400 lines / 10K)

**Purpose:** Complete working example from conference talk

**Content:**
- Full YAML frontmatter (comprehensive template)
- Source: Dex Horthy "No Vibes Allowed" transcript
- Demonstrates:
  - Curated context document type
  - Convergent synthesis (context engineering principles)
  - Tension preservation (task complexity decisions)
  - All frameworks applied
  - Section A: Core Concepts (A-E-E structure)
  - Section B: Challenges (W-SW-NW structure)
  - Section C: Implementation (reference format)

**Note:** We already have this! Copy from `/Users/ljack/github/kwdb/context-engineering-for-ai-coding-agents.md`

### examples/technical-doc-synthesis.md (~300 lines / 8K)

**Purpose:** API documentation synthesis example

**Content:**
- Full YAML frontmatter
- Source: Hypothetical API docs (multiple sources)
- Demonstrates:
  - Reference document type (not curated context)
  - Convergent synthesis (unifying API patterns)
  - Quick lookup structure
  - Minimal narrative, categorical organization

### examples/interview-transcript-synthesis.md (~250 lines / 6K)

**Purpose:** Interview synthesis with multiple perspectives

**Content:**
- Full YAML frontmatter
- Source: Hypothetical technical interview
- Demonstrates:
  - Hybrid document type
  - Tension preservation (different expert perspectives)
  - Speaker attribution
  - Synthesis of competing viewpoints

---

## Script Files Specifications

### scripts/validate-frontmatter.sh (~100 lines)

**Purpose:** Validate YAML frontmatter against VKS schema

**Functionality:**
- Parse YAML frontmatter from markdown file
- Check required fields present (vks_version, document_type, synthesis_date, etc.)
- Validate field types and formats
- Check enum values (document_type must be: curated_context, guidance, reference, hybrid)
- Exit codes: 0 = valid, 1 = invalid with error messages

**Usage:**
```bash
./scripts/validate-frontmatter.sh path/to/document.md
```

### scripts/extract-yt-metadata.sh (~150 lines)

**Purpose:** Extract metadata from yt-dlp .info.json and output YAML frontmatter

**Functionality:**
- Accept .info.json file path as input
- Extract key fields (id, title, uploader, channel, upload_date, duration, webpage_url, etc.)
- Generate YAML frontmatter in VKS source metadata format
- Output to stdout or file

**Usage:**
```bash
./scripts/extract-yt-metadata.sh video.info.json > frontmatter.yml
```

**Integration point:** Can be called from genInfoNugget.yt

### scripts/README.md (~80 lines)

**Purpose:** Document script usage and requirements

**Content:**
- Overview of available scripts
- Dependencies (jq, yq, bash 4+, etc.)
- Installation instructions
- Usage examples for each script
- Troubleshooting common issues
- Integration with VKS workflow

---

## Implementation Phases

### Phase 1: Directory Structure & Frontmatter (30 minutes)

**Tasks:**
1. Create directory structure
   ```bash
   mkdir -p .claude/skills/vks/{references,examples,scripts}
   touch .claude/skills/vks/SKILL.md
   ```

2. Write SKILL.md frontmatter
   ```yaml
   ---
   name: Validated Knowledge Synthesis
   description: [12+ trigger phrases as specified above]
   version: 2.1.0
   ---
   ```

3. Create placeholder reference files
   ```bash
   touch .claude/skills/vks/references/{frameworks.md,synthesis-strategies.md,validation-methods.md,frontmatter-schema.md}
   ```

**Deliverable:** Directory structure with frontmatter ready

### Phase 2: SKILL.md Core Content (3-4 hours)

**Tasks:**
1. Write Section 1: Overview (60 lines)
2. Write Section 2: Core Concepts (120 lines)
3. Write Section 3: Document Type Selection (80 lines)
4. Write Section 4: Synthesis Workflow (120 lines)
5. Write Section 5: YAML Frontmatter Integration (70 lines)
6. Write Section 6: Writing Principles (50 lines)
7. Write Section 7: Decision Matrices (40 lines)
8. Write Section 8: Additional Resources (30 lines)

**Writing guidelines:**
- Use imperative form (not second person)
- Brief explanations with pointers to references/
- Include quick examples inline
- Keep to ~550 lines total

**Deliverable:** Complete SKILL.md (~550 lines)

### Phase 3: Reference Files (4-5 hours)

**Tasks:**
1. Write `references/frameworks.md` (~300 lines)
   - Copy and expand from VKS v2.1 spec
   - Add extensive examples
   - Detailed validation questions

2. Write `references/synthesis-strategies.md` (~250 lines)
   - Detailed decision criteria
   - Multiple case studies
   - Edge cases and troubleshooting

3. Write `references/validation-methods.md` (~200 lines)
   - Complete checklists
   - Validation matrices
   - Testing procedures

4. Write `references/frontmatter-schema.md` (~250 lines)
   - All field definitions
   - Multiple templates
   - yt-dlp integration guide

**Deliverable:** Complete references/ directory with 4 detailed guides

### Phase 4: Example Files (2-3 hours)

**Tasks:**
1. Copy existing synthesis to `examples/youtube-synthesis-example.md`
   ```bash
   cp /Users/ljack/github/kwdb/context-engineering-for-ai-coding-agents.md \
      .claude/skills/vks/examples/youtube-synthesis-example.md
   ```

2. Create `examples/technical-doc-synthesis.md` (~300 lines)
   - Hypothetical API docs synthesis
   - Reference document type
   - Categorical organization

3. Create `examples/interview-transcript-synthesis.md` (~250 lines)
   - Hypothetical interview
   - Hybrid document type
   - Multiple perspectives

**Deliverable:** 3 working examples demonstrating different patterns

### Phase 5: Utility Scripts (2-3 hours)

**Tasks:**
1. Write `scripts/validate-frontmatter.sh`
   - YAML parsing
   - Schema validation
   - Error reporting

2. Write `scripts/extract-yt-metadata.sh`
   - .info.json parsing with jq
   - YAML frontmatter generation
   - Integration ready for genInfoNugget.yt

3. Write `scripts/README.md`
   - Usage documentation
   - Dependencies
   - Examples

4. Test scripts on example files

**Deliverable:** Working utility scripts with documentation

### Phase 6: Testing & Refinement (1-2 hours)

**Tasks:**
1. Test skill invocation
   - `/vks` manual invocation
   - Try various trigger phrases
   - Verify skill loads

2. Test progressive disclosure
   - Verify SKILL.md stays lean
   - Confirm references/ load when needed
   - Check examples are accessible

3. Validate frontmatter descriptions
   - Clear trigger conditions?
   - Specific enough?
   - No overlap with other skills?

4. Run scripts on test files
   - Validate frontmatter on examples/
   - Extract metadata from sample .info.json

5. Refinements based on testing

**Deliverable:** Tested, working VKS skill

---

## Quality Checklist

### SKILL.md Quality
- [ ] Frontmatter has name and description with 12+ trigger phrases
- [ ] Uses third-person in description ("This skill should be used when...")
- [ ] Body uses imperative/infinitive form (not second person)
- [ ] Total length ~500-600 lines (lean, not bloated)
- [ ] Clear overview and purpose
- [ ] Brief explanations with pointers to references/
- [ ] Includes decision matrices and quick references
- [ ] "Additional Resources" section explicitly references all subdirectories

### Progressive Disclosure
- [ ] SKILL.md core is lean (essential concepts only)
- [ ] Detailed content moved to references/ (frameworks, strategies, validation)
- [ ] Examples demonstrate patterns without bloating SKILL.md
- [ ] Scripts are utilities, not loaded in context

### Frontmatter Description
- [ ] Uses third-person format
- [ ] Includes 12+ specific trigger phrases in quotes
- [ ] Covers all major use cases (synthesis, validation, frameworks, metadata)
- [ ] No overlap with existing skills

### Content Quality
- [ ] Imperative form throughout body
- [ ] Objective, instructional language
- [ ] No second person ("you should")
- [ ] Clear, actionable guidance
- [ ] Working examples in examples/
- [ ] Scripts are executable and documented

### Directory Structure
- [ ] SKILL.md in root of skill directory
- [ ] references/ has 4 detailed guides
- [ ] examples/ has 3 working examples
- [ ] scripts/ has utilities + README

---

## Success Metrics

### Immediate Success
- [ ] Skill loads when invoked with `/vks`
- [ ] Skill auto-loads when synthesis language detected
- [ ] Progressive disclosure works (references load when Claude requests them)
- [ ] Examples are accessible and helpful

### Usage Success (After 1 Week)
- [ ] Used skill on 5+ synthesis tasks
- [ ] Skill triggered automatically at least once
- [ ] References/ files loaded at least 3x
- [ ] Scripts successfully validated frontmatter
- [ ] No false triggers (skill loaded when not needed)

### Quality Success
- [ ] Synthesis outputs follow VKS methodology
- [ ] YAML frontmatter consistently included
- [ ] Reader empathy validated in outputs
- [ ] Frameworks correctly applied
- [ ] Source provenance captured

---

## Time Estimates

| Phase | Tasks | Time |
|-------|-------|------|
| Phase 1 | Directory structure & frontmatter | 30 min |
| Phase 2 | SKILL.md core content | 3-4 hours |
| Phase 3 | Reference files (4 files) | 4-5 hours |
| Phase 4 | Example files (3 files) | 2-3 hours |
| Phase 5 | Utility scripts (3 files) | 2-3 hours |
| Phase 6 | Testing & refinement | 1-2 hours |
| **Total** | | **13-17 hours** |

Can be spread over 2-3 days of focused work.

---

## Next Immediate Steps (Next 2 Hours)

### Step 1: Create Structure (15 min)
```bash
cd /Users/ljack/github/ai-skills
mkdir -p .claude/skills/vks/{references,examples,scripts}
touch .claude/skills/vks/SKILL.md
touch .claude/skills/vks/references/{frameworks.md,synthesis-strategies.md,validation-methods.md,frontmatter-schema.md}
touch .claude/skills/vks/examples/{youtube-synthesis-example.md,technical-doc-synthesis.md,interview-transcript-synthesis.md}
touch .claude/skills/vks/scripts/{validate-frontmatter.sh,extract-yt-metadata.sh,README.md}
```

### Step 2: Write SKILL.md Frontmatter (15 min)
Add the frontmatter specified above with 12+ trigger phrases

### Step 3: Draft SKILL.md Sections 1-2 (1.5 hours)
- Section 1: Overview (60 lines)
- Section 2: Core Concepts (120 lines)

Focus on clarity, brevity, pointers to references/

---

## Dependencies & Requirements

### Tools Needed
- **jq** - JSON parsing in scripts
- **yq** - YAML parsing (optional, can use grep/sed)
- **bash 4+** - For associative arrays in validation script

### Knowledge Required
- VKS v2.1 methodology (from `/vks` slash command)
- Official skills patterns (analyzed above)
- YAML frontmatter schema (from PROPOSAL doc)
- Writing principles (Golden Path, A-E-E, W-SW-NW)

### Source Materials Available
- `/Users/ljack/github/kwdb/context-engineering-for-ai-coding-agents.md` - Example synthesis
- `/Users/ljack/github/kwdb/PROPOSAL-vks-yaml-frontmatter.md` - Schema spec
- `/Users/ljack/github/kwdb/RECOMMENDATION-next-steps.md` - Architecture guidance
- `/Users/ljack/github/ai-skills/reference/official-skills/` - Pattern reference

---

## Risk Mitigation

### Risk: Skill Too Verbose
**Mitigation:** Strict line limits per section, aggressive use of references/

### Risk: Weak Trigger Description
**Mitigation:** 12+ specific trigger phrases, test with various user queries

### Risk: Double-Loading with /vks Command
**Mitigation:** We removed the command pattern, skill-only is simpler

### Risk: Examples Too Abstract
**Mitigation:** Use real synthesis (context-engineering) as primary example

### Risk: Scripts Don't Work
**Mitigation:** Test early and often, document dependencies clearly

---

## Conclusion

This plan creates a production-ready VKS skill following official Claude Code patterns:

✅ **Single source of truth** (no command/skill duplication)
✅ **Progressive disclosure** (lean SKILL.md, detailed references/)
✅ **Strong triggering** (12+ specific phrases)
✅ **Working examples** (real synthesis outputs)
✅ **Utility automation** (frontmatter validation, metadata extraction)
✅ **Official patterns** (matches hook-development, agent-development structure)

Estimated **13-17 hours** total implementation time over 2-3 days.

Ready to begin implementation starting with Phase 1.
