if status is-interactive
  if set -q SSH_CONNECTION; or set -q SSH_CLIENT
    set -gx STARSHIP_CONFIG $__fish_config_dir/starship-ssh.toml
  end
end
