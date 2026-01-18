# Building the Validated Knowledge Synthesis Skill

## Summary

Transformed a 300-line prompt into a streamlined skill for synthesizing raw information into actionable knowledge documents.

- Initialized skill structure at `skills/validated-knowledge-synthesis/`
- Wrote concise SKILL.md with 8-step workflow and parameter handling
- Created `references/frameworks.md` covering Golden Path, Answer-Explain-Educate, What-So What-Now What
- Created `references/writing-principles.md` for reader empathy, strong verbs, simple words
- Created `references/document-types.md` specifying curated context, guidance, and reference formats

## Skill Structure

```
validated-knowledge-synthesis/
├── SKILL.md                          # Core workflow (117 lines)
└── references/
    ├── document-types.md             # Curated context, guidance, reference specs
    ├── writing-principles.md         # Reader empathy, short sentences, strong verbs
    └── frameworks.md                 # Golden Path, Answer-Explain-Educate, What-So What-Now What
```

## Key Features

- Transforms raw information into validated knowledge documents
- Three document types: curated context (default), guidance, reference
- 8-step workflow: source validation, pattern recognition, synthesis strategy, document type execution, writing execution, framework application, validation, output generation
- Progressive disclosure: detailed frameworks and writing principles in reference files
- Troubleshooting guide for common issues

## Installation

After `package_skill.py` completes, install the skill with these steps:

### Step 1: Locate the packaged skill

```
/Users/ljack/github/ai-skills/packages/skills/validated-knowledge-synthesis.skill
```

### Step 2: Extract to personal skills directory

```bash
mkdir -p ~/.claude/skills  # -p creates directory only if it doesn't exist
unzip /path/to/skill-name.skill -d ~/.claude/skills/
```

### Step 3: Restart Claude Code

Start a new session for the skill to be discovered.

### Verification

```bash
ls ~/.claude/skills/validated-knowledge-synthesis/
# SKILL.md
# references
```

### Why This Works

From [skill-file-installation.md](/Users/ljack/github/ai-skills/research/skill-file-installation.md):

> **Option C: Use ~/.claude/skills/ (Bypasses Plugin System) - RECOMMENDED**
>
> Extract directly to personal skills directory:
>
> ```bash
> mkdir -p ~/.claude/skills
> unzip ~/.claude/plugins/writing-eval-sloptastic.skill -d ~/.claude/skills/
> ```
>
> **Result:** Skill appears as `writing-eval-sloptastic` (no namespace prefix)
>
> **Pros:**
> - Simplest approach
> - No plugin system involvement
> - No JSON modification needed
> - **Auto-discovered on startup** - no registration required
> - **Higher priority** than plugin skills (personal skills override plugin skills)
> - Changes take effect immediately on save
>
> **Cons:**
> - No namespace organization
> - Skills not managed through plugin system
> - No version tracking

Key insight: `.skill` files are ZIP archives. Claude Code auto-discovers skill **directories** in `~/.claude/skills/` at startup. Loose `.skill` files in `~/.claude/plugins/` are **NOT** auto-discovered.

## Usage

Start a new Claude Code session and trigger the skill with requests like:

- "Synthesize this information into a knowledge document"
- "Help me organize this research"
- "Transform these notes into actionable guidance"
- "Create knowledge document from these sources"

## Source

Built from: `validated-knowledge-synthesis.md` prompt file using the `document-skills:skill-creator` skill.
