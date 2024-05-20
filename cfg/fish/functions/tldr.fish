function t --description "TL;DR"
    if test -n "$argv"
        for arg in $argv
            tldr $arg
        end
    else
        tldr --list | fzf --preview 'tldr {1} --color=always' --height "75%" --preview-window=right,75% | xargs tldr
    end
end
