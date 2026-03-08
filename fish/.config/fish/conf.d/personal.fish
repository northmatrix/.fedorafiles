alias asage "conda activate sage"
alias isage "conda activate sage  && sage"
alias dsage "conda deactivate"

export TERM=xterm-256color
export SSH_AUTH_SOCK=/home/jamie/snap/bitwarden/current/.bitwarden-ssh-agent.sock

alias vim nvim
alias vi nvim
alias ls "ls --color"

# osc7_cd: changes directory and updates xterm OSC 7 working directory
function osc7_cd --description 'cd and update OSC 7 (window file://) with encoded path'
    if test (count $argv) -eq 0
        builtin cd
    else
        builtin cd $argv
    end

    set -l tmp $PWD
    set -l enc ''

    while test -n "$tmp"
        set -l c (string sub -s 1 -l 1 -- "$tmp")
        set -l cut (string sub -s 2 -- "$tmp")

        # characters that don't need percent-encoding
        # include alphanumerics and - / : _ . ! ' ( ) ~
        if string match -qr '^[A-Za-z0-9\-/:_\.!\x27()\~]$' -- "$c"
            set enc "$enc$c"
        else
            # percent-encode using the first byte's hex
            # use printf to get ordinal value; wrap in POSIX single-quote to handle special chars
            set -l hex (printf "%02X" "'$c")
            set enc "$enc%$hex"
        end

        set tmp $cut
    end

    printf "\033]7;file://%s%s\033\\" (hostname) "$enc"
end

osc7_cd $PWD

set -g fish_greeting ""

function fish_prompt
    set_color normal
    printf '[%s@%s] ' (whoami) (hostname -s)
    set_color normal
    printf '%s ' (prompt_pwd)
    printf '%s' (set_color normal)
end


function fish_prompt
    set_color white
    printf '%s' (whoami)
    set_color blue
    printf '@%s' (hostname -s)
    set_color normal
    set_color yellow
    printf ' %s' (prompt_pwd)
    set_color normal
    printf ' '
end
