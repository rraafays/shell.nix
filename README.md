# shell

Fish login shell, starship, lsd, zoxide, direnv, and git/gh fish shortcuts for `config.common.username`.

- NixOS: `programs.fish`, login shell (`pkgs.fish`) for `common.username` and root, root HM starship
- Home Manager: `git` and `gh` on PATH (fish shortcuts), aliases (`ll` → `lsd`), `conf.d` fish snippets, starship toml, lsd yaml

Requires `./common`. Importer must define `users.users.<common.username>` (e.g. `isNormalUser`); this module sets that user’s `shell`.

Subpaths: `fish/`, `lsd/`, `starship/`. Local vs SSH starship: `~/.config/starship.toml` / `~/.config/starship-ssh.toml` (yellow `user@host`, colon `fg:8`); `00-starship-ssh-config.fish` sets `STARSHIP_CONFIG` when `SSH_CONNECTION`, `SSH_CLIENT`, or `SSH_TTY` is set.
