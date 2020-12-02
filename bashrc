export PATH="/home/$USER/.local/bin:$PATH"

export EDITOR=nvim
alias vim=nvim
alias ls="ls --color=auto"
alias svim="sudo nvim"
alias webcam="mpv --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg av://v4l2:/dev/video0"
# neat tools you will probably forget about.
# hyperfine - benchmark commands

RED="\033[0;31m"
NC="\033[0m"
GREY="\033[1;30m"
GREEN="\033[0;32m"
LBLUE="\033[0;34m"

setps1() {
    local BRANCH="$RED$(git branch 2>/dev/null | grep '\*' | sed 's/[\*\ ]//g') "
    PS1="\[$NC\]\u \[$BRANCH\]\[$LBLUE\]\w\n\[$NC\]> "
}

PROMPT_COMMAND="setps1"

alias aws-keys="cat ~/.aws/credentials"

cd() {
    command cd $1 && ls
}

h() {
    cmd="$(history | sed 's/^[\ ]\+[0-9\ ]\+//g' | fzf --tac)"
    [ -n "$cmd" ] && read -p "Run cmd: '$cmd'" confirmation && $cmd
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

git() {
    if [ $# -eq 0 ]; then
        `printf "git-checkout\ngit-dab\ngit fetch\ngit pull\ngit branch\ngit log" | fzf`
    else
        command git $@
    fi
}

git-dab() {
    git checkout master || git checkout main &&
    git branch -D `git branch | grep -E -v 'master|\*'`;
    git pull
}

git-checkout() {
    git checkout `git branch -a | sed 's/remotes\/origin\///g' | sed 's/[\* ]//g' | grep -v 'HEAD->' | sort -u | fzf`
}

pubkey-work() {
    cat ~/.ssh/id_rsa.pub | sed 's/smelly@/daniel.mcclintock@/'
}

pubkey-personal() {
    cat ~/.ssh/id_rsa.pub
}
