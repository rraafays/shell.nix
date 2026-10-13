if status is-interactive
    if set -q SSH_CONNECTION; or set -q SSH_CLIENT; or set -q SSH_TTY
        set -l config_home $HOME/.config
        if set -q XDG_CONFIG_HOME
            set config_home $XDG_CONFIG_HOME
        end
        set -l ssh_config "$config_home/starship-ssh.toml"
        if test -f $ssh_config
            set -gx STARSHIP_CONFIG $ssh_config
        end
    end
end
