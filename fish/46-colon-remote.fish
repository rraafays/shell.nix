set -g __colon_remote_cmds \
    tail cat head less more bat \
    nvim vim vi nano \
    ls lsd stat file wc \
    diff jq yq \
    rm chmod chown

function __colon_remote_parse -a spec
    if string match -qr '^[^:]+:[^:]' -- $spec
        echo (string replace -r '^([^:]+):(.*)$' '$1	$2' -- $spec)
        return 0
    end
    return 1
end

function __colon_remote_ssh_hosts
    test -r $HOME/.ssh/config
    or return
    string match -r '^Host\s+(.+)$' <$HOME/.ssh/config \
        | string replace -r '^Host\s+' '' \
        | string split ' ' \
        | string match -v -r '^\*$|\*$'
end

function __colon_remote_needs_tty -a cmd argv
    switch $cmd
        case less more man nvim vim vi nano
            return 0
        case tail
            contains -- -f $argv
            and return 0
    end
    return 1
end

function __colon_remote_run -a cmd argv
    set -l remote_host
    set -l out_argv
    set -l saw_remote 0

    for arg in $argv
        set -l parsed (__colon_remote_parse $arg)
        if test -n "$parsed"
            set -l parts (string split \t -- $parsed)
            if set -q remote_host[1]
                and test "$remote_host" != "$parts[1]"
                echo "colon-remote: mixed remote hosts ($remote_host vs $parts[1])" >&2
                return 1
            end
            set remote_host $parts[1]
            set -a out_argv $parts[2]
            set saw_remote 1
        else
            set -a out_argv $arg
        end
    end

    if test $saw_remote -eq 0
        command $cmd $argv
        return $status
    end

    set -l ssh_argv
    if __colon_remote_needs_tty $cmd $out_argv
        set ssh_argv -t
    end

    ssh $remote_host $ssh_argv -- command $cmd $out_argv
end

function r
    if test (count $argv) -lt 1
        echo "usage: r COMMAND [ARGS...]" >&2
        return 1
    end
    __colon_remote_run $argv[1] $argv[2..-1]
end

for __colon_remote_cmd in $__colon_remote_cmds
    eval "function $__colon_remote_cmd --wraps $__colon_remote_cmd
        __colon_remote_run $__colon_remote_cmd \$argv
    end"
end

function __fish_complete_colon_remote
    set -l token (commandline -ct)

    if string match -qr '^([^@ ]+@)?[^: ]+:.+' -- $token
        set -l host (string replace -r ':.*' '' -- $token)
        set -l pathprefix (string replace -r '^[^:]*:' '' -- $token)
        set -l sq (string replace -r "'" "'\\''" -- $pathprefix)
        ssh -o BatchMode=yes -o ConnectTimeout=2 $host \
            "command ls -1p '$sq'"* 2>/dev/null \
            | while read -l p
                echo "$host:$p"
            end
        return
    end

    if string match -qr '^[^: ]*$' -- $token
        for h in (__colon_remote_ssh_hosts)
            string match -iq "$token*" -- $h
            and echo "$h:"
        end
    end
end

for __colon_remote_cmd in $__colon_remote_cmds
    complete --keep-order -c $__colon_remote_cmd \
        -f -a '(__fish_complete_colon_remote)' -k
end

complete --keep-order -c r -f -a '(__fish_complete_colon_remote)' -k

set -e __colon_remote_cmd
