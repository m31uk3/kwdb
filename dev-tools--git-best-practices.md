# AI Dev - Git Best Practices

## Context

**Issue Identified:** Made two commits with identical messages because the first commit (21c8dc0) linked a YouTube video ID to GitHub repo instead of YouTube, requiring a second commit (1b15df6) to fix the URL.

```diff
# First commit (incorrect):
-1. Technical vlog transcript "fundamental skills and knowledge you must have in 2026 for SWE" (Jr2auYrBDA4), recorded January 13, 2026
+1. Technical vlog transcript "fundamental skills and knowledge you must have in 2026 for SWE" ([Jr2auYrBDA4](https://github.com/m31uk3/ai-skills/blob/main/docs/swe-baseline-skills-2026--curated-context.md)), recorded January 13, 2026

# Second commit (corrected):
-1. Technical vlog transcript "fundamental skills and knowledge you must have in 2026 for SWE" ([Jr2auYrBDA4](https://github.com/m31uk3/ai-skills/blob/main/docs/swe-baseline-skills-2026--curated-context.md)), recorded January 13, 2026
+1. Technical vlog transcript "fundamental skills and knowledge you must have in 2026 for SWE" ([Jr2auYrBDA4](https://www.youtube.com/watch?v=Jr2auYrBDA4)), recorded January 13, 2026
```

**File:** `docs/swe-baseline-skills-2026--curated-context.md:914`

---

## CI/CD Changes to Make

### 1. Pre-Commit Hooks for Link Validation

**Problem:** Invalid URLs in markdown that weren't caught before committing.

**Solution:** Add pre-commit hooks to validate markdown links:

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/tcort/markdown-link-check
    rev: v3.11.2
    hooks:
      - id: markdown-link-check
        args: ['--quiet']

  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: check-merge-conflict
      - id: check-yaml
      - id: end-of-file-fixer
      - id: trailing-whitespace
      - id: mixed-line-ending
```

**Installation:**
```bash
# Install pre-commit
pip install pre-commit

# Install hooks into git
pre-commit install

# Test on all files
pre-commit run --all-files
```

This would have caught the GitHub link pointing to the wrong location before committing.

---

### 2. Amend Instead of New Commit (When Appropriate)

**Current approach:** Made two separate commits for what should have been one change.

**Better approach:**
```bash
# If you haven't pushed yet:
git commit --amend --no-edit  # Fix the file and amend previous commit

# If you have pushed but no one else has pulled:
git commit --amend
git push --force-with-lease origin main  # Safer than --force
```

**When NOT to amend:**
- After others have pulled your changes
- On shared branches with collaborators
- If commits are already in a PR being reviewed

**When TO amend:**
- Quick fixes to last commit
- Before pushing
- Typos in commit message
- Forgot to include a file

---

### 3. GitHub Actions for Documentation Validation

**Current state:** No CI/CD pipeline exists.

**Add basic validation:**

```yaml
# .github/workflows/validate.yml
name: Validate Documentation

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Check markdown links
        uses: gaurav-nelson/github-action-markdown-link-check@v1
        with:
          use-quiet-mode: 'yes'
          config-file: '.markdown-link-check.json'

      - name: Lint markdown
        uses: DavidAnson/markdownlint-cli2-action@v14
        with:
          globs: '**/*.md'

      - name: Check for TODO/FIXME
        run: |
          if grep -r "TODO\|FIXME" docs/ skills/; then
            echo "Found TODO/FIXME markers"
            exit 1
          fi
```

**Companion config file:**

```json
# .markdown-link-check.json
{
  "ignorePatterns": [
    {
      "pattern": "^http://localhost"
    }
  ],
  "timeout": "20s",
  "retryOn429": true,
  "retryCount": 3,
  "fallbackRetryDelay": "30s",
  "aliveStatusCodes": [200, 206]
}
```

---

### 4. Conventional Commits

**Current commits:** Both had identical messages, making history unclear.

**Better approach:**
```bash
# First commit should have been:
git commit -m "docs(swe): add YouTube link for baseline skills video"

# If you need to fix:
git commit -m "fix(swe): correct YouTube URL (was pointing to GitHub)"
```

**Format:** `<type>(<scope>): <subject>`

**Common types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting changes (not code style)
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance tasks

**Benefits:**
- Clear commit types in history
- Better changelogs (can be auto-generated)
- Easier to understand what changed
- Semantic versioning compatibility

---

### 5. Pull Request Workflow (Even Solo)

**Current approach:** Direct commits to main.

**Better approach:**
```bash
git checkout -b fix/youtube-link
# Make changes
git commit -m "fix(swe): add YouTube link for baseline skills video"
git push -u origin fix/youtube-link
gh pr create --fill  # Creates PR with checks
```

**Benefits:**
- CI runs before merge
- Can review your own changes in GitHub UI
- Cleaner main branch history
- Practice for collaboration
- Rollback is easier

**Quick PR workflow:**
```bash
# Create branch, commit, push, PR in one flow
git checkout -b feature/my-change
git add .
git commit -m "feat(skill): add new workflow pattern"
git push -u origin feature/my-change
gh pr create --title "Add new workflow pattern" --body "Description here"

# After CI passes and review:
gh pr merge --squash --delete-branch
```

---

### 6. Branch Protection Rules

**GitHub repo settings to enable:**

1. **Require status checks to pass before merging**
   - Forces CI to pass
   - Prevents broken code in main

2. **Require branches to be up to date before merging**
   - Ensures changes work with latest main
   - Prevents integration issues

3. **Don't allow direct pushes to main (even from you)**
   - Forces PR workflow
   - All changes go through validation

4. **Require pull request reviews**
   - Optional for solo projects
   - Good for important repos

**Setup location:**
Settings → Branches → Add branch protection rule → `main`

---

### 7. Squash on Merge

**Problem:** Multiple small commits (like your two duplicates) clutter history.

**Solution:** Enable "Squash and merge" as the default merge strategy.

**Result:**
- Two commits in branch → One commit in main
- Clean history without manual rebasing
- Can still see details in PR if needed

**GitHub Settings:**
Settings → General → Pull Requests → Allow squash merging (enable)
                                    → Default to squash merging (set as default)

---

## Priority Recommendations

### High Priority (Do Now)

1. **Install pre-commit hooks with link validation**
   - Prevents issues before they're committed
   - Takes 5 minutes to set up
   - Saves time fixing issues later

2. **Use `git commit --amend` for quick fixes before pushing**
   - Simple habit change
   - No tools needed
   - Keeps history cleaner

3. **Add basic GitHub Actions for link checking**
   - Catches issues you miss locally
   - Runs automatically
   - Free for public repos

### Medium Priority

1. **Adopt conventional commits format**
   - Better commit messages
   - Can add validation later
   - Makes history searchable

2. **Switch to PR-based workflow**
   - Good practice
   - Enables better CI/CD
   - Prepares for collaboration

3. **Add branch protection**
   - Enforces good practices
   - Prevents mistakes
   - Can always disable temporarily

### Low Priority

1. **Add more sophisticated markdown linting**
   - Style consistency
   - Better docs quality
   - Optional refinement

2. **Set up automated changelog generation**
   - Requires conventional commits
   - Nice to have
   - Tools: conventional-changelog, release-please

3. **Add commit message validation hooks**
   - Enforces conventional commits
   - Can be annoying if too strict
   - Add after establishing habits

---

## Quick Reference Commands

### Amending Commits

```bash
# Fix last commit (not pushed yet)
git add <file>
git commit --amend --no-edit

# Fix last commit and update message
git commit --amend -m "New message"

# Push amended commit (if already pushed, use with caution!)
git push --force-with-lease origin main
```

### Pre-commit Usage

```bash
# Install pre-commit
pip install pre-commit

# Install hooks
pre-commit install

# Run manually on all files
pre-commit run --all-files

# Run manually on staged files
pre-commit run

# Skip hooks (emergency only!)
git commit --no-verify
```

### Squashing Commits Manually

```bash
# Squash last 2 commits
git reset --soft HEAD~2
git commit -m "Combined commit message"

# If already pushed
git push --force-with-lease origin main
```

### PR Workflow

```bash
# Create branch from issue
gh issue develop <issue-number> --checkout

# Create PR
gh pr create --fill

# View PR in browser
gh pr view --web

# Merge PR
gh pr merge --squash --delete-branch
```

---

## Core Insight

The core issue is **lack of validation before commit**. Pre-commit hooks would have caught the bad link immediately, preventing the two-commit situation entirely.

**Best practice:** Validation should happen at multiple stages:
1. **Pre-commit:** Catch obvious issues (broken links, syntax errors)
2. **CI:** Verify integration (all links, full tests)
3. **Pre-merge:** Final check (branch up to date, CI passed)

---

## Setup Checklist

- [ ] Install pre-commit: `pip install pre-commit`
- [ ] Create `.pre-commit-config.yaml`
- [ ] Create `.markdown-link-check.json`
- [ ] Run `pre-commit install`
- [ ] Test with `pre-commit run --all-files`
- [ ] Create `.github/workflows/validate.yml`
- [ ] Add branch protection rules
- [ ] Enable squash merging
- [ ] Practice PR workflow with next change

---

## Additional Resources

- [Pre-commit hooks documentation](https://pre-commit.com/)
- [Conventional Commits spec](https://www.conventionalcommits.org/)
- [GitHub Actions documentation](https://docs.github.com/en/actions)
- [Git commit --amend guide](https://www.atlassian.com/git/tutorials/rewriting-history)
- [markdown-link-check](https://github.com/tcort/markdown-link-check)

---

## Git Remote URLs: HTTPS vs SSH

### Understanding `git remote -v`

When you run `git remote -v`, you see two lines for each remote:

```bash
origin    https://github.com/m31uk3/ai-skills.git (fetch)
origin    https://github.com/m31uk3/ai-skills.git (push)
```

**What these mean:**
- **`(fetch)`** - URL used when downloading changes (e.g., `git fetch`, `git pull`)
- **`(push)`** - URL used when uploading changes (e.g., `git push`)

Typically both point to the same URL, but you can configure different URLs if needed (e.g., fetching from upstream, pushing to your fork).

---

### HTTPS vs SSH URLs

**HTTPS format:**
```
https://github.com/username/repo.git
```

**SSH format:**
```
git@github.com:username/repo.git
```

**Key differences:**

| Aspect | HTTPS | SSH |
|--------|-------|-----|
| **Authentication** | Personal Access Token (PAT) as password | SSH key pair |
| **Setup** | Simpler, no key generation needed | Requires SSH key setup |
| **Credential entry** | May prompt for token (unless cached) | No prompts after setup |
| **Network requirements** | Works everywhere | May be blocked by firewalls |
| **Security** | Secure with PAT | More secure, key-based auth |
| **GitHub 2FA** | Requires PAT | Works seamlessly with SSH keys |

---

### Why HTTPS Still Exists (Password Auth Is Deprecated)

While GitHub no longer accepts **passwords** for HTTPS authentication, HTTPS itself is still fully supported using alternative methods:

**HTTPS authentication options:**

1. **Personal Access Token (PAT)**
   - Generate in GitHub Settings → Developer settings → Personal access tokens
   - Use PAT instead of password when prompted
   - Can scope permissions (read, write, repo access, etc.)

2. **Credential manager**
   - Git credential helpers store your PAT securely
   - macOS: Keychain
   - Windows: Credential Manager
   - Linux: libsecret or gnome-keyring

3. **GitHub CLI (`gh`)**
   - Authenticates via OAuth
   - Handles credentials automatically
   - No manual PAT management needed

**Why HTTPS is still offered:**
- Works in environments where SSH is blocked (corporate firewalls, restrictive networks)
- Simpler for beginners (no SSH key setup required)
- Some CI/CD systems prefer HTTPS with tokens
- Cross-platform compatibility without additional setup
- Can use multiple authentication methods

---

### When to Use Each Method

**Use SSH when:**
- You want "set and forget" authentication
- You work on the same machine regularly
- You have access to generate SSH keys
- You want the most secure option
- You use GitHub 2FA

**Use HTTPS when:**
- SSH ports are blocked (corporate environments)
- Working on shared/temporary machines
- You prefer token-based access control
- CI/CD pipelines (with tokens as secrets)
- You're new to Git and want simpler setup

---

### Switching Remote URLs

**If you cloned with HTTPS but want SSH:**

```bash
# Check current remote
git remote -v

# Switch to SSH
git remote set-url origin git@github.com:username/repo.git

# Verify the change
git remote -v
```

**If you cloned with SSH but want HTTPS:**

```bash
# Switch to HTTPS
git remote set-url origin https://github.com/username/repo.git

# Verify the change
git remote -v
```

**Setting different URLs for fetch and push:**

```bash
# Fetch from upstream (original repo)
git remote set-url origin https://github.com/original/repo.git

# Push to your fork
git remote set-url --push origin git@github.com:yourname/repo.git
```

---

### Initial Clone Setup

**The remote URL is set automatically based on how you clone:**

```bash
# Clone with HTTPS (sets HTTPS remote)
git clone https://github.com/username/repo.git

# Clone with SSH (sets SSH remote)
git clone git@github.com:username/repo.git
```

If you know you want SSH, clone with SSH from the start to avoid changing the remote later.

---

### Best Practice Recommendation

**For personal development:** Use **SSH**
- One-time setup with SSH keys
- No credential prompts
- Most secure and convenient

**For CI/CD and automation:** Use **HTTPS with tokens**
- Store PAT as environment variable or secret
- Easier to rotate and manage programmatically
- Fine-grained access control

**Setup SSH keys:**

```bash
# Generate SSH key (if you don't have one)
ssh-keygen -t ed25519 -C "your_email@example.com"

# Start ssh-agent
eval "$(ssh-agent -s)"

# Add key to ssh-agent
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard
pbcopy < ~/.ssh/id_ed25519.pub  # macOS
# Or manually: cat ~/.ssh/id_ed25519.pub

# Add to GitHub: Settings → SSH and GPG keys → New SSH key
```

**Test SSH connection:**

```bash
ssh -T git@github.com
# Should output: "Hi username! You've successfully authenticated..."
```

---

### Quick Reference: Authentication Methods

| Method | Setup Complexity | Ongoing Convenience | Use Case |
|--------|-----------------|---------------------|----------|
| SSH keys | Medium (one-time) | High (no prompts) | Personal development |
| HTTPS + credential manager | Low | Medium (occasional re-auth) | Quick setup, shared machines |
| HTTPS + PAT (manual) | Low | Low (enter each time) | Temporary access |
| GitHub CLI (`gh`) | Low | High (auto-managed) | Best HTTPS experience |

**Bottom line:** SSH is "set and forget" for regular development. HTTPS with PAT is for special cases or restricted environments.

---

*Generated: 2026-01-17*
*Repository: ai-skills*
