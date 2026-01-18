# Shell Basics: Taxonomy and Mental Models

**Created:** 2026-01-17
**Topic:** Understanding the core taxonomy of shells, REPLs, and command types

---

## Shell vs REPL

### Shell (bash, zsh, fish)
- Command-line interpreter providing interface between user and OS
- Manages process execution, file redirection, pipes, environment variables
- Has its own scripting language with control structures (if/while/for)
- Not strictly a REPL - can run scripts non-interactively

### REPL (Read-Eval-Print Loop)
- Programming pattern: read input → evaluate → print result → loop
- Interactive shells operate *like* REPLs, but primary purpose is launching programs
- True REPLs (python, node, irb) evaluate code in persistent runtime environment
- Shells don't maintain program state between commands - each command is typically a separate process

---

## Command Taxonomy

When you type something in a shell, it could be:

### 1. Shell Builtins
- Examples: `cd`, `export`, `source`, `alias`
- Implemented inside the shell itself
- Must be builtins because they modify shell state
- `cd` changes the shell's working directory - an external program can't do this

### 2. External Programs/Executables
- Separate binary files found in `$PATH` (e.g., `/usr/bin/ls`)
- Shell spawns a new process to run them
- `which command` shows you where they live

### 3. Shell Functions
- User-defined commands written in shell script
- Defined in `.bashrc`/`.zshrc` or scripts
- Run in the current shell process

### 4. Aliases
- Simple text substitutions
- Example: `alias ll='ls -la'` - shell replaces `ll` with `ls -la` before executing

---

## Command Resolution Order

When you type `foo`:
1. Is it an alias? → expand and re-evaluate
2. Is it a function? → execute in current shell
3. Is it a builtin? → execute directly
4. Search `$PATH` for executable → spawn new process
5. Not found? → error

**Tip:** Use `type <command>` to see what category a command falls into

---

## Key Mental Model

Think of a shell as:

- **A process manager** - spawns and manages child processes
- **A mini programming language** - variables, loops, conditionals
- **An interface layer** - connects keyboard input to program execution
- **A state container** - working directory, environment variables, job control

The "REPL" aspect is just the interactive mode. The shell's real power is orchestrating how programs connect (pipes, redirection) and managing execution context (env vars, working dir, signals).

---

## Session Metadata

**User Prompts:**
1. Requested explanation of shell/REPL/command taxonomy
2. Asked for session summary
3. Requested list of all user prompts
4. Requested creation of this knowledge stub

**Artifacts Created:**
- This document: `shell-basics-taxonomy.md`
