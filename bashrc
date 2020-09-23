export PATH="/home/$USER/.local/bin:$PATH"

export EDITOR=nvim
alias vim=nvim
alias ls="ls --color=auto"
alias svim="sudo nvim"
alias webcam="mpv /dev/video0 --profile=low-latency --untimed"

fd() {
    # NOTE: The `fd` name conflicts with the find replacement `fd`
    local dir
    dir=$(find ${1:-.} -path "*/\.*" -prune -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

pk() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

fpass() {
    pass "$(
        find /home/$(whoami)/.password-store/ -type f |
        grep '.gpg$' |
        sed "s/\/home\/$(whoami)\/.password-store\///g" |
        sed 's/.gpg$//g' |
        fzf
    )"
}

eval "$(pyenv init -)"
eval "$(rbenv init -)"
