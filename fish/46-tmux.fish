if not status is-interactive
    return
end

if not set -q TMUX
    return
end

set -g fish_handle_reflow 0
set -Ua fish_features no-query-term no-mark-prompt

function __fish_tmux_sync_term_size --on-signal WINCH
    set -e COLUMNS 2>/dev/null
    set -e LINES 2>/dev/null
end

set -e COLUMNS 2>/dev/null
set -e LINES 2>/dev/null
