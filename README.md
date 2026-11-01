# shell

Fish login shell, starship, lsd, zoxide, direnv, and git/gh fish shortcuts for `config.common.username`.

- NixOS: `programs.fish`, login shell (`pkgs.fish`) for `common.username` and root, root HM starship
- Home Manager: `git` and `gh` on PATH (fish shortcuts), aliases (`ll` → `lsd`), `conf.d` fish snippets (`46-tmux` fish/tmux display fixes when `$TMUX` is set, including SSH in a split pane; `55-tmux-alt-keys` passes Alt+arrows to tmux), starship toml, lsd yaml

Requires **`./common`** only. Sets `users.users.<common.username>.isNormalUser` (default `true`) and login shell `pkgs.fish`.

Subpaths: `fish/`, `lsd/`, `starship/`.
