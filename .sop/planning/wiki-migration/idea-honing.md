# Idea Honing: Wiki to KWDB Migration

## Requirements Clarification Q&A

---

### Q1: Migration Scope

The wiki contains ~152 articles across varied categories. The research identified that some content is likely obsolete (Windows XP, Windows Vista, older hardware like E61i).

**Question:** What is your preferred approach to migration scope?

- **Option A:** Migrate all articles as-is, preserve everything
- **Option B:** Prioritized migration - start with high-value, evergreen content (Unix/Linux commands, networking, version control) and skip obsolete topics
- **Option C:** Selective migration - you'll manually curate which articles to migrate

**Answer:** Option A - Migrate all articles as-is, preserve everything.

---

### Q2: Wiki Server Availability

The research found that `wiki.ljackson.us` was unavailable (ECONNREFUSED). To fetch the actual article content, we need access to the wiki.

**Question:** How should we handle content retrieval?

**Answer:** Wiki is accessible via HTTP (not HTTPS) at `http://wiki.ljackson.us`. Use curl for fetching content.

---

### Q3: Content Transformation

MediaWiki uses its own markup syntax. When converting to markdown, how should we handle the transformation?

**Question:** What level of content enhancement do you want during migration?

- **Option A:** Direct conversion only - convert MediaWiki markup to equivalent markdown, preserve content exactly as-is
- **Option B:** Light cleanup - convert markup + fix obvious formatting issues, broken links, typos
- **Option C:** Full enhancement - convert markup + restructure to match KWDB conventions (add Quick Reference sections, FAQ format, proper headers, etc.)

**Answer:** Option B - Light cleanup: convert markup + fix obvious formatting issues, broken links, typos.

---

### Q4: File Naming Convention

The KWDB research identified naming patterns like `category--topic.md` (double-dash for namespacing) and `lowercase-kebab-case.md`.

Wiki articles have titles like "Awk Command", "Public Key Authentication", "Asterisk Dialplan".

**Question:** How should wiki article titles map to KWDB filenames?

- **Option A:** Simple kebab-case - `awk-command.md`, `public-key-authentication.md`, `asterisk-dialplan.md`
- **Option B:** Category-prefixed - `unix--awk-command.md`, `security--public-key-authentication.md`, `voip--asterisk-dialplan.md`
- **Option C:** Flat with topic suffix - `awk-command-reference.md`, `public-key-authentication-guide.md`

**Answer:** Option B - Category-prefixed with double-dash separator.

---

### Q5: Category Taxonomy

For category-prefixed filenames, we need to define the category set. Based on the wiki content analysis:

**Question:** Which category structure do you prefer?

- **Option A:** Broad categories (~6):
  - `unix--` (Linux/Unix commands, shell)
  - `windows--` (Windows admin, commands)
  - `networking--` (SSH, DNS, firewalls)
  - `voip--` (Asterisk and related)
  - `media--` (ffmpeg, imagemagick, video)
  - `software--` (misc apps, web tech)

- **Option B:** Granular categories (~12):
  - `shell--`, `filesystem--`, `networking--`, `security--`, `voip--`, `windows--`, `web--`, `database--`, `media--`, `graphics--`, `config--`, `misc--`

- **Option C:** You'll define the categories manually

**Answer:** Option B - Granular categories (~12 prefixes).

---

### Q6: Migration Execution

With ~152 articles to migrate, how should the migration be executed?

**Question:** What is your preferred migration approach?

- **Option A:** Batch automated - script fetches all articles, converts, and saves in one run
- **Option B:** Interactive batches - process 10-20 articles at a time, review each batch before continuing
- **Option C:** One-by-one - migrate articles individually with review after each

**Answer:** Option B - Interactive batches with a script to run batches and validate for completeness (track progress, detect failures, ensure all articles migrated).

---

### Q7: Related Articles

Some wiki topics have multiple related articles (e.g., Asterisk has 12 sub-articles, Bash has 5).

**Question:** How should related articles be handled?

- **Option A:** Keep separate - each article becomes its own markdown file (e.g., `voip--asterisk.md`, `voip--asterisk-dialplan.md`, `voip--asterisk-queue.md`)
- **Option B:** Merge related - consolidate sub-articles into parent document where sensible (e.g., single comprehensive `voip--asterisk.md`)
- **Option C:** Decide per-cluster during migration

**Answer:** Option B - Merge related articles into comprehensive parent documents where sensible.

---

### Q8: File Location

The KWDB repository currently has markdown files in the root directory.

**Question:** Where should migrated wiki articles be stored?

- **Option A:** Root directory - alongside existing files (`/Users/ljack/github/m31uk3/kwdb/*.md`)
- **Option B:** Subdirectory - in a dedicated folder (`/Users/ljack/github/m31uk3/kwdb/wiki/*.md` or `/Users/ljack/github/m31uk3/kwdb/reference/*.md`)
- **Option C:** Category subdirectories - organized by category (`/Users/ljack/github/m31uk3/kwdb/unix/*.md`, `/Users/ljack/github/m31uk3/kwdb/networking/*.md`, etc.)

**Answer:** Option B - Subdirectory at `kwdb/wiki/*.md`.

---

### Q9: Internal Wiki Links

Wiki articles contain internal links to other wiki pages (e.g., `[[SSH]]`, `[[Grep Command]]`).

**Question:** How should internal wiki links be handled?

- **Option A:** Convert to relative markdown links - `[[SSH]]` becomes `[SSH](security--ssh.md)`
- **Option B:** Remove links - convert to plain text references
- **Option C:** Preserve as-is - keep wiki syntax (requires post-processing later)

**Answer:** Option A - Convert to relative markdown links pointing to the new filenames.

---

## Additional Research Completed (2026-01-18)

| Research Area | Document | Key Findings |
|---------------|----------|--------------|
| Sample Articles | `research/sample-articles-analysis.md` | HTML structure patterns, conversion strategy |
| Test Conversion | `wiki/shell--awk-command.md` | Proof-of-concept converted article |
| Category Mapping | `research/article-category-mapping.md` | 152 articles → 12 categories, 142 final files |
| Merge Clusters | `research/merge-clusters.md` | 8 clusters, 31 articles → 8 merged files |

## Design Complete (2026-01-18)

See `design/detailed-design.md` for:
- Architecture with component diagrams
- Batch processing strategy (11 batches)
- State tracking for resume capability
- Validation system design

## Implementation Plan Complete (2026-01-18)

See `implementation/plan.md` for:
- 10-step implementation checklist
- Script specifications with code examples
- Test procedures for each step
- Execution order and review checkpoints

---

## Requirements Summary

| Decision | Choice |
|----------|--------|
| Scope | All ~152 articles |
| Access | HTTP via curl (`http://wiki.ljackson.us`) |
| Transformation | Light cleanup (markup conversion + formatting fixes) |
| File naming | Category-prefixed (`category--topic.md`) |
| Categories | Granular (~12): shell, filesystem, networking, security, voip, windows, web, database, media, graphics, config, misc |
| Execution | Interactive batches with validation script |
| Related articles | Merge into comprehensive parent documents |
| Location | `kwdb/wiki/*.md` subdirectory |
| Internal links | Convert to relative markdown links |

