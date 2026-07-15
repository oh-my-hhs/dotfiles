starship init fish | source

if test -d "$HOME/.local/bin"; and not contains -- "$HOME/.local/bin" $PATH
    set -gx PATH "$HOME/.local/bin" $PATH
end

alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias afind='ack -il'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gc1='git clone --recursive --depth=1'
alias globurl='noglob urlglobber '
alias grep='grep --color=auto'
alias md='mkdir -p'
alias rd=rmdir

alias c='clear'
########
if command -v exa >/dev/null
    set DISABLE_LS_COLORS true
    alias ls="exa --color=auto"
    # Exa is a modern version of ls. exa是一款优秀的ls替代品,拥有更好的文件展示体验,输出结果更快,使用rust编写。
    alias l='exa -lbah --icons'
    alias la='exa -labgh --icons'
    alias ll='exa -lbg --icons'
    alias lsa='exa -lbagR --icons'
    alias lst='exa -lTabgh --icons' # 输入lst,将展示类似于tree的树状列表。
else
    alias ls='ls --color=auto'
    # color should not be always.
    alias lst='tree -pCsh'
    alias l='ls -lah'
    alias la='ls -lAh'
    alias ll='ls -lh'
    alias lsa='ls -lah'
end

function fish_greeting
end

function yazi
    set -l cwd_file (mktemp -t yazi-cwd.XXXXXX)

    command yazi --cwd-file "$cwd_file" $argv

    set -l cwd (cat "$cwd_file")
    command rm -f -- "$cwd_file"

    if test -n "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end
end

function proxy_set
    if test (count $argv) -ge 1
        set -gx http_proxy "$argv[1]"
        set -gx https_proxy "$argv[1]"
        git config --global https_proxy "$argv[1]"
        git config --global https_proxy "$argv[1]"
    else
        set -gx http_proxy "127.0.0.1:7890"
        set -gx https_proxy "127.0.0.1:7890"
        git config --global http.proxy "127.0.0.1:7890"
        git config --global https.proxy "127.0.0.1:7890"
    end
end
function proxy_on
    set -gx http_proxy "127.0.0.1:7890"
    set -gx https_proxy "127.0.0.1:7890"
    git config --global http.proxy "127.0.0.1:7890"
    git config --global https.proxy "127.0.0.1:7890"
end
function proxy_off
    set -e http_proxy
    set -e https_proxy
    git config --global http.proxy ""
    git config --global https.proxy ""
end

if status is-interactive
    pokego --no-title -r 1,3,6
    # Commands to run in interactive sessions can go here
end
