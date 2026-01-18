# Tmux Knowledge Synthesis

Terminal multiplexer for managing multiple shell sessions within a single terminal window. Enables session persistence across disconnections, split-pane workflows, and remote session management.

---

## Quick Reference

All shortcuts use the prefix `Ctrl + b` followed by the key.

### Sessions
| Action | Shortcut | Command |
|--------|----------|---------|
| New session | | `tmux new -s name` |
| Attach to session | | `tmux a -t name` |
| Detach | `d` | |
| List sessions | `s` | `tmux ls` |
| Rename session | `$` | |
| Previous session | `(` | |
| Next session | `)` | |
| Kill session | | `tmux kill-session -t name` |

### Windows
| Action | Shortcut | Command |
|--------|----------|---------|
| New window | `c` | |
| Close window | `&` | |
| Rename window | `,` | |
| List windows | `w` | |
| Previous window | `p` | |
| Next window | `n` | |
| Select window 0-9 | `0-9` | |
| Last active window | `l` | |

### Panes
| Action | Shortcut | Command |
|--------|----------|---------|
| Split vertical | `%` | `:split-window -h` |
| Split horizontal | `"` | `:split-window -v` |
| Close pane | `x` | |
| Toggle zoom | `z` | |
| Next pane | `o` | |
| Show pane numbers | `q` | |
| Select pane 0-9 | `q 0-9` | |
| Move pane left | `{` | |
| Move pane right | `}` | |
| Toggle layouts | `Space` | |
| Last active pane | `;` | |
| Convert to window | `!` | |

### Copy Mode
| Action | Key |
|--------|-----|
| Enter copy mode | `[` |
| Quit copy mode | `q` |
| Start selection | `Space` |
| Copy selection | `Enter` |
| Paste buffer | `]` |
| Search forward | `/` |
| Search backward | `?` |

---

## Session Workflows

Sessions persist independently of terminal connections. Create a named session with `tmux new -s projectname` to establish a workspace that survives disconnection. The session continues running on the server even after you close your terminal or lose network connectivity.

Reattach to an existing session using `tmux a -t projectname`. The `-A` flag combined with `-s` creates if absent: `tmux new-session -A -s projectname`. This pattern works well in shell aliases or scripts where you want guaranteed session availability.

Managing multiple sessions requires visibility. Press `Ctrl + b s` to display an interactive session list with window previews. Navigate between sessions in sequence with `Ctrl + b (` and `Ctrl + b )`.

Session cleanup prevents accumulation. Kill a specific session with `tmux kill-session -t name`. Kill all sessions except current with `tmux kill-session -a`. Target a session to preserve while killing others: `tmux kill-session -a -t keepthis`.

Detach others from your session with `:attach -d` to maximize window dimensions when multiple clients connect to the same session.

---

## Window Workflows

Windows function as tabs within a session. Each window contains one or more panes sharing the same terminal dimensions. Create a session with an initial named window: `tmux new -s project -n editor`.

Window navigation follows intuitive patterns. Direct access via `Ctrl + b 0` through `Ctrl + b 9` reaches the first ten windows. Sequential navigation uses `Ctrl + b n` (next) and `Ctrl + b p` (previous). Toggle between current and last-used window with `Ctrl + b l`.

Reordering windows maintains logical arrangement. Swap two windows: `:swap-window -s 2 -t 1`. Shift current window left: `:swap-window -t -1`. Remove numbering gaps after closing windows: `:move-window -r`.

Move windows between sessions with explicit source and target: `:move-window -s source_session:0 -t target_session:9`. Omit target session to reposition within current session.

---

## Pane Workflows

Panes divide a window into independent terminals. Split vertically (side-by-side panes) with `Ctrl + b %`. Split horizontally (stacked panes) with `Ctrl + b "`. The terminology references the dividing line orientation, not the resulting pane arrangement.

Navigate panes directionally using arrow keys after the prefix. Cycle through panes in order with `Ctrl + b o`. Display pane numbers with `Ctrl + b q`, then press the number to select. Toggle between current and previous pane with `Ctrl + b ;`.

Resize panes by holding `Ctrl + b` and pressing arrow keys with `Ctrl` held. Alternatively, use `Ctrl + b` followed by arrow key, then repeat arrow presses without re-pressing prefix.

Zoom isolates a single pane temporarily. Press `Ctrl + b z` to maximize the current pane to fill the window. Press again to restore the layout. Zoomed panes display an indicator in the status bar.

Synchronize input across panes with `:setw synchronize-panes`. All keystrokes transmit to every pane in the window simultaneously. Useful for parallel command execution across multiple servers.

Merge windows into pane arrangements with `:join-pane -s 2 -t 1`. This converts window 2 into a pane within window 1. Reverse the operation with `Ctrl + b !` to promote a pane to its own window.

---

## Copy Mode

Enter copy mode with `Ctrl + b [` to scroll through terminal history and select text. Enable vi keybindings with `:setw -g mode-keys vi` for familiar navigation.

Movement follows vi conventions: `h j k l` for character movement, `w b` for word jumps, `g G` for document extremes. Search with `/` forward and `?` backward, navigate matches with `n N`.

Selection begins with `Space` and completes with `Enter`, copying to the paste buffer. Clear an incomplete selection with `Esc`. Paste with `Ctrl + b ]`.

Buffer management extends beyond single copy. View buffer contents with `:show-buffer`. Capture entire pane visible content with `:capture-pane`. List all buffers with `:list-buffers`, select interactively with `:choose-buffer`. Save buffer to file: `:save-buffer filename.txt`. Delete specific buffers: `:delete-buffer -b 1`.

---

## Configuration

Set options globally with `-g` flag. Session-wide options use `:set -g OPTION`. Window-wide options use `:setw -g OPTION`.

Enable mouse support for pane selection, resizing, and scrolling: `:set mouse on`.

Access command mode with `Ctrl + b :` for any tmux command. List all keybindings with `Ctrl + b ?` or `tmux list-keys`. Display comprehensive session information with `tmux info`.

---

## FAQ

**What problem does tmux solve?**
Standard terminals lose all running processes when closed or disconnected. Tmux maintains session state on the server, allowing reconnection to long-running processes, SSH sessions, or development environments.

**When should I use sessions vs windows vs panes?**
Sessions group related work contexts (one per project). Windows organize tasks within a context (editor, server, logs). Panes enable simultaneous visibility of related outputs.

**Why use named sessions?**
Unnamed sessions receive numeric identifiers. Named sessions (`tmux new -s project`) communicate purpose and simplify reattachment: `tmux a -t project` versus remembering session numbers.

**How do I persist my layout?**
Tmux does not save layouts automatically. Plugins like tmux-resurrect or tmuxinator provide session restoration. Alternatively, script session creation with shell functions.

**What does the prefix key do?**
`Ctrl + b` signals that the next keypress is a tmux command rather than input to the active program. All shortcuts require this prefix unless rebound in configuration.

---

## Source Validation

| Attribute | Assessment |
|-----------|------------|
| Source | tmuxcheatsheet.com |
| Authority | High - dedicated tmux reference |
| Recency | Current (2026-01-17) |
| Consistency | High - standard tmux commands |
| Coverage | Comprehensive |

**Synthesis strategy**: Convergent synthesis grouping related commands into workflow patterns. Shell commands and tmux command-mode alternatives preserved where both serve distinct contexts.
