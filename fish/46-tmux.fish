if not status is-interactive
    return
end

if not set -q TMUX
    return
end

set -g fish_handle_reflow 0
set -Ua fish_features no-query-term no-mark-prompt no-keyboard-protocols

function __fish_tmux_sync_tty_size
    set -l dim (command stty size 2>/dev/null | string split ' ')
    if test (count $dim) -eq 2
        set -gx LINES $dim[1]
        set -gx COLUMNS $dim[2]
    end
end

function __fish_tmux_sync_tty_size_winch --on-signal WINCH
    __fish_tmux_sync_tty_size
end

function __fish_tmux_sync_tty_size_prompt --on-event fish_prompt
    __fish_tmux_sync_tty_size
end

__fish_tmux_sync_tty_size
