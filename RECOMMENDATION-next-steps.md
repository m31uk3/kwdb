# VKS Next Steps: Slash Commands, Skills, and YAML Frontmatter

**Date:** 2025-12-28
**Context:** Integrating VKS with Claude Code patterns, YAML frontmatter from yt-dlp, and official skills framework

---

## Executive Summary

**Recommendation:** Create a dual-pattern implementation:
1. **Keep `/vks` as a slash command** (user-controlled synthesis execution)
2. **Create a new VKS methodology skill** (Claude auto-loads synthesis guidance)
3. **Integrate YAML frontmatter** into both genInfoNugget.yt and /vks command
4. **Update genInfoNugget.yt** to extract yt-dlp metadata into frontmatter

**Why:** This aligns with Anthropic's design intent (commands for user-control, skills for Claude auto-invocation), leverages progressive disclosure, and creates a complete knowledge synthesis ecosystem.

---

## Key Insights from Research

### 1. Slash Commands vs Skills (Critical Understanding)

**From `docs/slash-commands-vs-skills.md`:**

| Aspect | Skills | Slash Commands |
|--------|--------|----------------|
| **Who decides** | Claude (automatic) | User (manual) |
| **Design intent** | On-demand knowledge | Standardized workflows |
| **Best for** | API docs, style guides | PR formatting, workflows |
| **Loading** | Progressive disclosure | Each invocation loads fresh |
| **Future** | Will diverge from commands | Will diverge from skills |

**Critical insight:** "Don't optimize for current mechanics. Optimize for intent." — Anthropic

### 2. VKS Current State Analysis

**VKS as `/vks` slash command:**
- ✅ User explicitly decides when to synthesize knowledge
- ✅ Workflow-oriented (research → validate → synthesize → output)
- ✅ Aligns with "slash command" design intent
- ❌ No automatic invocation when Claude sees unstructured info

**What's missing:**
- No skill that teaches Claude the VKS methodology
- Claude doesn't automatically apply synthesis principles
- No progressive disclosure of VKS framework

### 3. YAML Frontmatter Integration

**From PROPOSAL-vks-yaml-frontmatter.md:**
- yt-dlp provides rich metadata (video_id, title, uploader, duration, chapters)
- Currently discarded after extraction
- Should be preserved in frontmatter for provenance and discoverability

**Integration points:**
1. genInfoNugget.yt → source metadata frontmatter
2. /vks command → synthesis metadata + source metadata merge
3. Final document → comprehensive YAML frontmatter

### 4. Official Skills Structure

**From official skills (now in `reference/official-skills/`):**

```
skill-name/
├── SKILL.md                    # Core instructions (1,500-2,000 words)
├── references/                 # Detailed docs (loaded as needed)
│   ├── patterns.md
│   └── advanced.md
├── examples/                   # Working examples
│   └── example-synthesis.md
└── scripts/                    # Utilities
    └── validate-frontmatter.sh
```

**Writing style requirements:**
- Frontmatter description: Third person, specific trigger phrases
- Body: Imperative/infinitive form (not second person)
- Progressive disclosure: Core in SKILL.md, details in references/

---

## Recommended Architecture

### Pattern 1: VKS Slash Command (Keep & Enhance)

**File:** `.claude/commands/vks.md`

**Purpose:** User-invoked workflow for synthesizing knowledge

**Enhancements needed:**
1. Detect YouTube source files (check for video ID in filename)
2. Extract metadata from adjacent .info.json if available
3. Prompt for synthesis parameters (topic, audience, document_type)
4. Merge source metadata + synthesis metadata
5. Generate document with comprehensive YAML frontmatter
6. Apply VKS v2.1 frameworks (Golden Path, Answer-Explain-Educate, etc.)

**Frontmatter:**
```yaml
---
# Prevent auto-invocation - user controls when to synthesize
disable-model-invocation: true
---
```

### Pattern 2: VKS Methodology Skill (New - Create This)

**File:** `.claude/skills/validated-knowledge-synthesis/SKILL.md`

**Purpose:** Teach Claude the VKS methodology for automatic application

**Trigger phrases:**
```yaml
---
name: Validated Knowledge Synthesis
description: This skill should be used when the user asks to "synthesize knowledge", "create curated context", "validate information", "apply Golden Path criteria", "use Answer-Explain-Educate framework", or discusses transforming raw information into actionable knowledge using systematic validation.
version: 2.1
---
```

**Structure:**
```
validated-knowledge-synthesis/
├── SKILL.md                          # Core VKS principles (1,500-2,000 words)
├── references/
│   ├── frameworks.md                 # Golden Path, A-E-E, W-SW-NW detailed
│   ├── synthesis-strategies.md      # Convergence vs tension preservation
│   ├── validation-methods.md        # Logic validation, source validation
│   └── frontmatter-schema.md        # YAML frontmatter specifications
├── examples/
│   ├── youtube-synthesis.md         # Example from Dex Horthy video
│   ├── technical-doc-synthesis.md   # Example from API docs
│   └── interview-synthesis.md       # Example from interview transcript
└── scripts/
    ├── validate-frontmatter.sh      # Validate YAML schema
    └── extract-yt-metadata.sh       # Helper for yt-dlp extraction
```

**SKILL.md content (lean):**
- Overview of VKS methodology
- When to apply (unstructured info → structured knowledge)
- Core principles (source validation, synthesis strategy selection)
- Pointer to references/ for detailed frameworks
- Quick reference decision matrix

**Key benefit:** Claude automatically applies VKS principles when encountering synthesis tasks, even without explicit `/vks` invocation.

### Pattern 3: Enhanced genInfoNugget.yt (Update)

**File:** `/Users/ljack/github/yt-dlp/genInfoNugget.yt`

**Add after Step 1 (yt-dlp download):**

```bash
# Extract metadata from info.json for frontmatter
if [ -f "$INFO_JSON" ]; then
    VIDEO_ID=$(jq -r '.id' < "$INFO_JSON")
    TITLE=$(jq -r '.title' < "$INFO_JSON")
    UPLOADER=$(jq -r '.uploader' < "$INFO_JSON")
    CHANNEL=$(jq -r '.channel // .uploader' < "$INFO_JSON")
    UPLOAD_DATE=$(jq -r '.upload_date' < "$INFO_JSON")
    DURATION=$(jq -r '.duration' < "$INFO_JSON")
    WEBPAGE_URL=$(jq -r '.webpage_url' < "$INFO_JSON")
    DESCRIPTION=$(jq -r '.description // "No description"' < "$INFO_JSON")

    # Create frontmatter
    cat > "${MARKDOWN_FILE}.tmp" <<EOF
---
# Source Metadata (from yt-dlp)
source_type: "youtube_transcript"
source_url: "$WEBPAGE_URL"
source_video_id: "$VIDEO_ID"
source_title: "$TITLE"
source_channel: "$CHANNEL"
source_uploader: "$UPLOADER"
source_upload_date: "$UPLOAD_DATE"
source_duration: "${DURATION}s"
extraction_date: "$(date +%Y-%m-%d)"
---

EOF

    # Prepend to markdown
    cat "$MARKDOWN_FILE" >> "${MARKDOWN_FILE}.tmp"
    mv "${MARKDOWN_FILE}.tmp" "$MARKDOWN_FILE"
fi
```

**Benefit:** Source provenance automatically captured at extraction time.

---

## Implementation Phases

### Phase 1: Foundation (Week 1)

**Goal:** Get source metadata flowing

✅ **Tasks:**
1. ✅ Copy official skills to reference/ (DONE)
2. Update genInfoNugget.yt with frontmatter extraction
3. Test with a new YouTube video download
4. Verify .info.json → frontmatter pipeline works

**Deliverable:** YouTube transcripts include source metadata frontmatter

### Phase 2: VKS Skill Creation (Week 1-2)

**Goal:** Create the VKS methodology skill

**Tasks:**
1. Create skill directory structure
2. Write SKILL.md with strong trigger phrases
3. Move VKS v2.1 detailed frameworks to references/
4. Add example syntheses from your existing work
5. Create validation scripts
6. Test skill triggers on relevant queries

**Deliverable:** Working VKS skill that Claude auto-invokes

### Phase 3: Slash Command Enhancement (Week 2)

**Goal:** Upgrade /vks command to merge metadata

**Tasks:**
1. Update /vks to detect YouTube sources
2. Extract existing frontmatter from source files
3. Prompt for synthesis-specific metadata
4. Merge source + synthesis metadata
5. Add `disable-model-invocation: true` frontmatter flag
6. Test complete workflow: genInfoNugget → /vks → final doc

**Deliverable:** Enhanced /vks command with full metadata support

### Phase 4: Documentation & Polish (Week 3)

**Goal:** Document the complete system

**Tasks:**
1. Create workflow diagram (YouTube → genInfoNugget → /vks → output)
2. Write usage guide for the complete pipeline
3. Add troubleshooting guide
4. Create video tutorial or walkthrough
5. Share with community for feedback

**Deliverable:** Complete, documented VKS ecosystem

---

## Detailed Implementation: VKS Skill

### SKILL.md Structure

```markdown
---
name: Validated Knowledge Synthesis
description: This skill should be used when the user asks to "synthesize knowledge", "create curated context", "validate information sources", "apply Golden Path criteria", "use Answer-Explain-Educate framework", "apply What-So What-Now What", or discusses transforming unstructured information into actionable, validated knowledge through systematic synthesis.
version: 2.1
---

# Validated Knowledge Synthesis

## Overview

Validated Knowledge Synthesis (VKS) transforms raw, unorganized information into actionable knowledge through systematic validation. Use this methodology when encountering unstructured data that needs to become reliable, reusable knowledge.

## When to Apply VKS

Apply this skill when:
- Synthesizing interview transcripts, conference talks, or video content
- Consolidating multiple sources into unified knowledge
- Creating curated context documents for future recall
- Validating information reliability before synthesis
- Choosing between convergent synthesis vs tension preservation

## Core Principles

### 1. Source Validation First
Assess reliability, recency, authority, and internal consistency before synthesis.

### 2. Three Synthesis Strategies
- **Convergent**: Ideas strengthen each other → unify
- **Tension Preservation**: Contradictions generate insights → maintain separation
- **Dual-Track**: Combine approaches where appropriate

### 3. Document Type Awareness
Choose structure based on reader needs:
- **Curated Context**: Default - optimized for recall (Golden Path + frameworks)
- **Guidance**: Implementation-focused, narrative flow
- **Reference**: Quick lookup, categorical
- **Hybrid**: Mixed approach

### 4. Progressive Validation
Validate at each step: sources → patterns → logic → synthesis → output

## Quick Decision Matrix

| Input Type | Recommended Approach |
|-----------|---------------------|
| Single authoritative source | Light validation, direct synthesis |
| Multiple complementary sources | Convergent synthesis |
| Competing frameworks/perspectives | Tension preservation |
| Mixed content | Dual-track approach |

## Curated Context Requirements

When creating curated context documents (default):

**Reader Empathy (Primary):**
- Who is the reader? What do they need?
- What is being asked of them?
- Communicate key ideas in minimal words without sacrificing grounding

**Apply Frameworks:**
- Golden Path: Purpose, Clear & Concise, Structure, Evidence, Action
- Answer-Explain-Educate: Lead with answer, expand, educate
- What-So What-Now What: Facts → Analysis → Recommendation

**Writing Principles:**
- Short sentences (manage cognitive load)
- Strong verbs (precise, concrete)
- Simple words (best, most precise choice)

## Progressive Disclosure Pattern

This skill uses references for detailed content:

### Reference Files

**`references/frameworks.md`** - Complete framework details
- Golden Path 5 criteria
- Answer-Explain-Educate structure
- What-So What-Now What flow
- Short sentences principle
- Strong verbs & simple words guidance

**`references/synthesis-strategies.md`** - Detailed strategy selection
- When to use convergent synthesis
- When to preserve tensions
- Dual-track approach patterns
- Decision criteria and examples

**`references/validation-methods.md`** - Validation techniques
- Source validation matrix
- Logic coherence checks
- Narrative flow validation
- Practical validation tests

**`references/frontmatter-schema.md`** - YAML frontmatter specifications
- Complete schema documentation
- Field definitions and examples
- Integration with yt-dlp metadata
- Template variations

### Example Files

**`examples/youtube-synthesis.md`** - Conference talk synthesis example
**`examples/technical-doc-synthesis.md`** - API documentation example
**`examples/interview-synthesis.md`** - Interview transcript example

### Scripts

**`scripts/validate-frontmatter.sh`** - Validate YAML schema compliance
**`scripts/extract-yt-metadata.sh`** - Helper for YouTube metadata extraction

## Workflow Summary

1. **Validate sources** → reliability assessment
2. **Identify patterns** → complementary vs conflicting
3. **Choose strategy** → convergent, tension, or dual-track
4. **Select document type** → curated context, guidance, reference, hybrid
5. **Execute synthesis** → apply frameworks and principles
6. **Validate output** → logic, coherence, reader empathy
7. **Generate with frontmatter** → complete metadata

For detailed procedures and advanced techniques, consult the reference files.

## Integration with /vks Command

For user-controlled synthesis execution, use the `/vks` slash command which implements this methodology as a structured workflow. This skill provides the conceptual foundation; the command executes the process.
```

### references/frameworks.md

```markdown
# VKS Frameworks: Detailed Reference

This document provides complete details on all frameworks used in Validated Knowledge Synthesis v2.1.

## Golden Path Criteria

The Golden Path ensures documents meet quality standards for professional knowledge work.

### 1. Purpose & Audience
- State reason for document's existence
- Orient reader to key problem and objective
- Tailor tone, content, and detail to intended reader
- Make it immediately clear who should read this and why

**Validation questions:**
- Can the reader identify the purpose in 30 seconds?
- Is the target audience explicitly stated?
- Does the opening orient rather than dive into details?

### 2. Clear & Concise
- Logical structure that guides the reader
- Easy to understand without jargon overload
- Free of unnecessary words
- Clear connections between ideas
- Maintain brevity without sacrificing clarity

**Validation questions:**
- Can ideas be understood without re-reading?
- Are transitions between sections smooth?
- Could any section be cut without losing essential meaning?

[... continue with all 5 criteria in detail ...]

## Answer-Explain-Educate Framework

[... detailed breakdown ...]

## What-So What-Now What Framework

[... detailed breakdown ...]

## Short Sentences Principle (John Rauser)

[... detailed guidance ...]

## Strong Verbs & Simple Words

[... detailed guidance with examples ...]
```

---

## Benefits of Dual Pattern (Slash Command + Skill)

### Slash Command (`/vks`)
✅ User has explicit control over synthesis execution
✅ Structured workflow with clear phases
✅ Parameter collection (topic, audience, document type)
✅ YAML frontmatter generation
✅ Aligns with Anthropic's design intent for commands

### Skill (`validated-knowledge-synthesis`)
✅ Claude automatically applies VKS principles
✅ Progressive disclosure keeps context lean
✅ Available as reference even without explicit invocation
✅ Teaches synthesis methodology to Claude
✅ Aligns with Anthropic's design intent for skills

### Together
✅ Complete ecosystem: methodology + execution
✅ Flexible: auto-application OR explicit control
✅ Context-efficient through progressive disclosure
✅ Future-proof as Anthropic diverges command/skill mechanics

---

## YAML Frontmatter Integration Points

### 1. genInfoNugget.yt Output
```yaml
---
source_type: "youtube_transcript"
source_url: "https://youtube.com/watch?v=..."
source_video_id: "rmvDxxNubIg"
source_title: "No Vibes Allowed..."
source_channel: "AI Engineer"
source_uploader: "Dex Horthy"
source_upload_date: "20251215"
source_duration: "1186s"
extraction_date: "2025-12-28"
---
```

### 2. /vks Command Merges Synthesis Metadata
```yaml
---
# Source Metadata (preserved from input)
source_type: "youtube_transcript"
source_url: "..."
[... all source fields ...]

# VKS Synthesis Metadata (added by /vks)
vks_version: "2.1"
document_type: "curated_context"
synthesis_date: "2025-12-28"
target_audience: "software engineers, engineering leaders"
synthesis_topic: "context engineering for AI coding agents"
synthesis_strategy:
  - "convergent: context engineering principles"
  - "tension_preservation: task complexity decisions"
primary_frameworks:
  - "Answer-Explain-Educate"
  - "Golden Path Criteria"
validation_status: "validated"
confidence_level: "high"
primary_topics: [...]
key_concepts: [...]
use_cases: [...]
---
```

### 3. Complete Provenance Chain

**YouTube Video** → genInfoNugget.yt (adds source metadata) → `/vks` (adds synthesis metadata) → **Final Document**

Every document can be traced back to its source with full context about how it was synthesized.

---

## Success Metrics

### Phase 1 Success
- [ ] genInfoNugget.yt consistently extracts metadata
- [ ] Source frontmatter appears in all new transcripts
- [ ] Metadata matches yt-dlp .info.json fields

### Phase 2 Success
- [ ] VKS skill triggers on synthesis-related queries
- [ ] References/ files load when Claude needs detail
- [ ] Skill description has strong, specific trigger phrases
- [ ] Examples demonstrate synthesis patterns

### Phase 3 Success
- [ ] /vks detects YouTube sources automatically
- [ ] Metadata merging works correctly
- [ ] Output documents have comprehensive frontmatter
- [ ] No double-loading issues (disable-model-invocation works)

### Phase 4 Success
- [ ] Complete workflow documented
- [ ] Troubleshooting guide helps resolve issues
- [ ] Community feedback incorporated
- [ ] System used successfully for 10+ synthesis tasks

---

## Risks & Mitigations

### Risk 1: Double-Loading Context Waste
**Issue:** /vks command might cause Claude to re-invoke VKS skill, doubling context usage

**Mitigation:** Add `disable-model-invocation: true` to /vks frontmatter

### Risk 2: Skill Triggers Too Often
**Issue:** VKS skill loads when not needed, wasting context

**Mitigation:** Write very specific trigger phrases, test extensively, refine based on usage

### Risk 3: Frontmatter Schema Drift
**Issue:** Source and synthesis metadata schemas diverge over time

**Mitigation:**
- Version the schema (`vks_version: "2.1"`)
- Document schema in references/frontmatter-schema.md
- Create validation script

### Risk 4: genInfoNugget.yt Breaks Existing Files
**Issue:** Adding frontmatter breaks existing workflow

**Mitigation:**
- Add `--with-metadata` flag for opt-in
- Test thoroughly before making default
- Keep backup of original script

---

## Decision: What to Build First?

### Recommended Order

**1. Update genInfoNugget.yt (Highest ROI)**
- **Why:** Captures metadata at source, benefits all future downloads
- **Effort:** Low (bash script modification)
- **Risk:** Low (can make opt-in with flag)
- **Timeline:** 1-2 hours

**2. Create VKS Skill (High Value)**
- **Why:** Teaches Claude the methodology, benefits all synthesis work
- **Effort:** Medium (create structure, write SKILL.md, references)
- **Risk:** Medium (need good trigger phrases to avoid over-firing)
- **Timeline:** 4-6 hours

**3. Enhance /vks Command (Completes Ecosystem)**
- **Why:** Merges metadata, completes the workflow
- **Effort:** Medium (detect sources, merge frontmatter)
- **Risk:** Low (builds on existing command)
- **Timeline:** 3-4 hours

**4. Documentation & Polish (Ensures Adoption)**
- **Why:** Makes system usable by others
- **Effort:** Medium (diagrams, guides, examples)
- **Risk:** Low
- **Timeline:** 2-3 hours

**Total estimated time:** 10-15 hours spread over 1-2 weeks

---

## Immediate Next Steps (Next 48 Hours)

### Step 1: Update genInfoNugget.yt ✅
```bash
cd /Users/ljack/github/yt-dlp
cp genInfoNugget.yt genInfoNugget.yt.backup
# Edit genInfoNugget.yt to add frontmatter extraction (see code above)
# Test with a new video download
```

### Step 2: Create VKS Skill Directory Structure ✅
```bash
cd /Users/ljack/github/ai-skills
mkdir -p skills/validated-knowledge-synthesis/{references,examples,scripts}
touch skills/validated-knowledge-synthesis/SKILL.md
```

### Step 3: Draft SKILL.md ✅
- Write frontmatter with strong trigger phrases
- Write lean core content (1,500-2,000 words)
- Reference the detailed frameworks in references/
- Point to examples

### Step 4: Test End-to-End Flow 🔄
- Download a new YouTube video with updated genInfoNugget.yt
- Verify frontmatter appears
- Run /vks on the transcript
- Check if VKS skill loads (once skill is created)
- Validate final document has merged frontmatter

---

## References

**Official Skills Downloaded:**
- `/Users/ljack/github/ai-skills/reference/official-skills/`
  - agent-development/
  - command-development/
  - example-skill/
  - hook-development/
  - mcp-integration/
  - plugin-settings/
  - plugin-structure/
  - skill-development/

**Key Documents:**
- `docs/slash-commands-vs-skills.md` - Command vs skill design intent
- `PROPOSAL-vks-yaml-frontmatter.md` - Frontmatter schema proposal
- `context-engineering-for-ai-coding-agents.md` - Example VKS output with frontmatter

**External References:**
- [yt-dlp GitHub](https://github.com/yt-dlp/yt-dlp) - Metadata field documentation
- [Claude Code GitHub Issue #13115](https://github.com/anthropics/claude-code/issues/13115) - Official guidance on commands vs skills

---

## Conclusion

**Build both a slash command and a skill:**

1. **Slash command** (`/vks`) for explicit, user-controlled synthesis execution
2. **Skill** (`validated-knowledge-synthesis`) for automatic methodology application
3. **Enhanced genInfoNugget.yt** for source metadata capture
4. **YAML frontmatter** throughout for provenance and discoverability

This creates a complete, future-proof knowledge synthesis ecosystem that aligns with Anthropic's design philosophy and leverages progressive disclosure effectively.

**Start with genInfoNugget.yt enhancement** → highest ROI, lowest risk, enables everything else.
