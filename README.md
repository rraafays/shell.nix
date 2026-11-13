# shell

Fish login shell, starship, lsd, zoxide, direnv, and git/gh fish shortcuts for `config.common.username`.

- NixOS: `programs.fish`, login shell (`pkgs.fish`) for `common.username` and root, root HM starship
- Home Manager: `git` and `gh` on PATH (fish shortcuts), aliases (`ll` → `lsd`), `conf.d` fish snippets (`42-vi-selection-reverse`, `43-cursor-blink` for vi cursors and reverse selection; `46-pty-term-size` keeps `$COLUMNS`/`$LINES` equal to the PTY for fish tab completion and starship when `$TMUX` or `$SSH_CONNECTION`; `55-tmux-alt-keys` passes Alt+arrows to tmux), starship toml, lsd yaml

Requires **`./common`** only. Sets `users.users.<common.username>.isNormalUser` (default `true`) and login shell `pkgs.fish`.

Subpaths: `fish/`, `lsd/`, `starship/`.
