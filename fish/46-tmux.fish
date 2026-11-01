if not status is-interactive
    return
end

if not set -q TMUX
    return
end

set -g fish_handle_reflow 0
set -Ua fish_features no-query-term
set -g fish_ambiguous_width 2

function __fish_tmux_repaint_after_cancel --on-event fish_cancel
    commandline -f repaint 2>/dev/null
end
