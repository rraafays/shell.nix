# shell

Fish login shell, starship, lsd, zoxide, direnv, and git/gh fish shortcuts for `config.common.username`.

- NixOS: `programs.fish`, login shell (`pkgs.fish`) for `common.username` and root, root HM starship
- Home Manager: `git` and `gh` on PATH (fish shortcuts), aliases (`ll` → `lsd`), `conf.d` fish snippets, starship toml, lsd yaml

Requires `./common`. Importer must define `users.users.<common.username>` (e.g. `isNormalUser`); this module sets that user’s `shell`.

Subpaths: `fish/`, `lsd/`, `starship/`.

## Remote `host:path` (rsync-style)

Many file commands accept `[[user@]host:]path` like rsync. The wrapper runs the real command over SSH on that host, for example `tail -f srvr:~/nohup.out`. Use `r CMD …` for any other command. Tab completion lists `~/.ssh/config` hosts and remote paths after `host:`. Does not apply to `ssh`, `scp`, or `rsync`.
