# Dev Tools - Shell PATH Configuration

## Context

**Issue Identified:** Installed `go-grip` via `go install` but command wasn't accessible in new terminal sessions.

**Root Cause:** `$HOME/go/bin` directory not in shell PATH.

---

## Problem

Go installs binaries to `~/go/bin/` by default, but this directory isn't automatically added to your PATH on macOS.

**Symptom:**
```bash
$ go install github.com/chrishrb/go-grip@latest
# Install succeeds, binary created at ~/go/bin/go-grip

$ go-grip --help
command not found: go-grip
```

**Verification:**
```bash
$ echo $PATH
# ~/go/bin is missing from the output

$ ls ~/go/bin/
go-grip    # Binary exists but isn't accessible
```

---

## Solution

### 1. Understand macOS Shell Configuration Loading

**Files and their purposes:**

| File | When Loaded | Purpose |
|------|-------------|---------|
| `/etc/zprofile` | Login shells (system-wide) | Sets up base PATH via `path_helper` |
| `~/.zprofile` | Login shells (user-specific) | Homebrew setup, aliases, history config |
| `~/.zshrc` | Every interactive shell | Tool-specific configurations |

**Loading order for new terminal window:**
1. `/etc/zprofile` → Sets base PATH
2. `~/.zprofile` → Adds Homebrew to PATH (`eval "$(/opt/homebrew/bin/brew shellenv)"`)
3. `~/.zshrc` → Loads tool configs (LM Studio, Kiro CLI, etc.)

### 2. Where Homebrew's bin Gets Added

**File:** `~/.zprofile:3`

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

This single line adds `/opt/homebrew/bin` and `/opt/homebrew/sbin` to your PATH.

**Why `.zprofile` and not `.zshrc`?**
- Homebrew installer puts it there by convention
- Login shells load it once per terminal window
- Avoids redundant PATH modifications on every new tab/pane

### 3. Add Go bin to PATH

**File:** `~/.zshrc:8`

**Added:**
```bash
# Add Go bin to PATH
export PATH="$PATH:$HOME/go/bin"
```

**Why `.zshrc`?**
- Consistent with other tool configurations (LM Studio CLI, etc.)
- Loaded for all interactive shells (terminal tabs, tmux panes)
- Keeps all development tool PATHs in one place

**Location in file:**
```bash
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/ljack/.lmstudio/bin"
# End of LM Studio CLI section

# Add Go bin to PATH
export PATH="$PATH:$HOME/go/bin"

# Kiro CLI post block. Keep at the bottom of this file.
```

### 4. Activate the Change

**For current session:**
```bash
source ~/.zshrc
```

**For new sessions:**
Open a new terminal window/tab (PATH automatically loaded).

### 5. Verify

```bash
$ which go-grip
/Users/ljack/go/bin/go-grip

$ go-grip --help
Render markdown document as html
...
```

---

## go-grip Usage

**Installed:** `go-grip@v0.5.6` (markdown renderer with live preview)

**Basic commands:**
```bash
go-grip README.md              # Render and auto-open in browser (localhost:6419)
go-grip file.md --port 8080    # Use custom port
go-grip --theme dark           # Force dark theme
go-grip --help                 # Full options
```

**Features:**
- Renders markdown to HTML with syntax highlighting
- Live reload on file changes
- GitHub-flavored markdown support
- Auto-opens browser tab on start

---

## Pattern for Future Tool Installations

When installing CLI tools via package managers:

1. **Install the tool:**
   ```bash
   go install github.com/user/tool@latest
   npm install -g tool
   cargo install tool
   ```

2. **Check if tool is accessible:**
   ```bash
   which tool-name
   ```

3. **If not found, locate the binary:**
   ```bash
   # Go bins
   ls ~/go/bin/

   # npm global bins
   npm config get prefix  # Usually ~/.npm-global or similar

   # Cargo bins
   ls ~/.cargo/bin/
   ```

4. **Add to PATH in ~/.zshrc:**
   ```bash
   # Add [Tool] bin to PATH
   export PATH="$PATH:$HOME/path/to/tool/bin"
   ```

5. **Reload and verify:**
   ```bash
   source ~/.zshrc
   which tool-name
   ```

---

## Shell Configuration Best Practices

### File Organization Strategy

**`~/.zprofile` - System setup (runs once on login):**
- Homebrew initialization
- Shell history configuration
- System-wide aliases
- Environment variables that rarely change

**`~/.zshrc` - Development tools (runs on every interactive shell):**
- Tool-specific PATH additions (Go, npm, cargo, etc.)
- Shell prompt customizations
- Directory-specific configurations
- Frequently changing development settings

### PATH Addition Order

Current PATH priority (first to last):
1. `/opt/homebrew/bin` (from `.zprofile`)
2. `/opt/homebrew/sbin` (from `.zprofile`)
3. `/usr/local/bin` (system default)
4. Core system paths (`/usr/bin`, `/bin`, etc.)
5. `~/.local/bin` (user local binaries)
6. `~/.lmstudio/bin` (from `.zshrc`)
7. `$HOME/go/bin` (from `.zshrc`)

**Why order matters:**
- Earlier paths take precedence when commands conflict
- Homebrew before system ensures you use latest versions
- User bins before system bins allows overrides

### Troubleshooting PATH Issues

**Debug current PATH:**
```bash
echo $PATH | tr ':' '\n'  # Show each PATH entry on separate line
```

**Check if directory exists:**
```bash
ls $HOME/go/bin  # Should show installed Go binaries
```

**Test command resolution:**
```bash
which -a go-grip  # Shows all matches in PATH, in order
```

**Force reload shell config:**
```bash
exec zsh  # Restarts shell, reloading all config files
```

---

## References

**Files modified:**
- `~/.zshrc:8` - Added Go bin to PATH

**Tools installed:**
- `go-grip@v0.5.6` - Markdown renderer with live preview
- Location: `/Users/ljack/go/bin/go-grip`

**Related context:**
- See `dev-tools--git-best-practices.md` for Git workflow patterns
- See `tmux-knowledge.md` for terminal multiplexer configuration

---

## Quick Reference

```bash
# Check Go bin in PATH
echo $PATH | grep "go/bin"

# List installed Go tools
ls ~/go/bin/

# Verify go-grip works
go-grip --version

# Render markdown file
go-grip README.md

# Reload shell config
source ~/.zshrc
```
