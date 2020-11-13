export PATH="/home/$USER/.local/bin:$PATH"

export EDITOR=nvim
alias vim=nvim
alias ls="ls --color=auto"
alias svim="sudo nvim"
alias webcam="mpv /dev/video0 --profile=low-latency --untimed"

RED="\033[0;31m"
NC="\033[0m"
GREY="\033[1;30m"
GREEN="\033[0;32m"
LBLUE="\033[0;34m"

export PS1="\n$NC\u $LBLUE\w\n$NC> "

cd() {
    command cd $1 && ls
}

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

git-dab() {
    git checkout master &&
    git branch -D `git branch | grep -E -v 'master|\*'` &&
    git pull
}

git-checkout() {
    git checkout `git branch -a | sed 's/remotes\/origin\///g' | sed 's/[\* ]//g' | grep -v 'HEAD->' | sort -u | fzf`
}

eval "$(pyenv init -)"
eval "$(rbenv init -)"
