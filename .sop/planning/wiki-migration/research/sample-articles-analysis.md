# Sample Articles Analysis

**Research Date:** 2026-01-18

---

## Articles Analyzed

| Article | Size | Sections | Code Blocks | Internal Links | Categories |
|---------|------|----------|-------------|----------------|------------|
| Awk Command | Large | 9 H2, 17+ H3 | Many `<pre>` blocks | 1 (Alpha:) | - |
| SSH | Small | 2 | None | None | Mac OS X, Linux |
| Asterisk | Medium | 6 H2, 5 H3 | 4 `<pre>` blocks | 8 (tutorials) | VoIP, Linux, Mac OS X |
| Git | Tiny | 2 | 1 | None | - |

---

## HTML Structure Patterns

### Content Location
- Main content: `<div id="bodyContent">` ... `<!-- end content -->`
- Title: `<h1 class="firstHeading">`
- Categories: `<div id="catlinks">`

### Element Mapping (HTML → Markdown)

| HTML Element | Markdown Equivalent |
|--------------|---------------------|
| `<h2>` | `## ` |
| `<h3>` | `### ` |
| `<pre>...</pre>` | ` ```\n...\n``` ` |
| `<ul><li>` | `- ` |
| `<ol><li>` | `1. ` |
| `<b>` or `<strong>` | `**...**` |
| `<i>` or `<em>` | `*...*` |
| `<a href="/Page">` | `[Page](category--page.md)` |
| `<a href="http://...">` | `[text](url)` |
| `<code>` | `` `...` `` |

### MediaWiki Artifacts to Handle

1. **Edit section links**: `<div class="editsection">` - remove entirely
2. **TOC table**: `<table id="toc">` - remove (markdown viewers auto-generate)
3. **Jump-to-nav**: `<div id="jump-to-nav">` - remove
4. **Breadcrumbs**: `<div id="kwBreadCrumbs">` - remove
5. **Site subtitle**: `<h3 id="siteSub">` - remove
6. **Footer/metadata**: Everything after `<!-- end content -->` - remove
7. **Anchor tags**: `<a name="...">` - remove (use header anchors instead)

### Special Characters
- `&nbsp;` → space
- `&lt;` → `<`
- `&gt;` → `>`
- `&amp;` → `&`

---

## Content Quality Observations

### Comprehensive Articles (e.g., Awk Command)
- Well-structured with TOC
- Many practical examples
- Good for reference use
- Conversion: straightforward, preserve structure

### Minimal Articles (e.g., Git, SSH)
- Very brief, 1-2 sections
- May benefit from "stub" marker
- Consider merging into parent topics

### Hub Articles (e.g., Asterisk)
- Overview + links to sub-articles
- Contains FAQs
- Natural merge candidate with sub-articles

---

## Category Information

Categories appear in `<div id="catlinks">`:
```html
<div id="catlinks">
  <p class='catlinks'>
    Categories:
    <span dir='ltr'><a href="/Category:VoIP">VoIP</a></span> |
    <span dir='ltr'><a href="/Category:Linux">Linux</a></span>
  </p>
</div>
```

Categories found in samples:
- Mac OS X
- Linux
- VoIP

These can inform the category prefix mapping.

---

## Conversion Strategy

### Step 1: Extract Content
```
1. Fetch HTML via curl
2. Extract content between <div id="bodyContent"> and <!-- end content -->
3. Extract title from <h1 class="firstHeading">
4. Extract categories from <div id="catlinks">
```

### Step 2: Clean HTML
```
1. Remove edit section divs
2. Remove TOC table
3. Remove jump-to-nav
4. Remove anchor-only tags
5. Remove breadcrumbs
```

### Step 3: Convert to Markdown
```
1. Convert headers (h2→##, h3→###)
2. Convert pre blocks to fenced code blocks
3. Convert lists (ul/ol)
4. Convert links (internal→relative md, external→preserve)
5. Convert formatting (bold, italic, code)
6. Decode HTML entities
```

### Step 4: Apply KWDB Formatting
```
1. Add H1 title
2. Add horizontal rule after intro
3. Light cleanup (formatting fixes, typos)
4. Generate filename from title + category
```

---

*Analysis completed: 2026-01-18*
