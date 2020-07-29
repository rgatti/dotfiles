alias vi=nvim
alias vim=nvim
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls -CG'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls'
alias s='cd ~/src'
alias ..='cd ../'
alias ...='cd ../..'

if which brew > /dev/null; then
    alias ctags=$(brew --prefix)/bin/ctags
fi

# python3 by default
alias python=python3
alias pylint=pylint3
alias pip=pip3

f() {
    local file=${1:-}
    if [ -z $file ]; then
        echo "usage: f file"
    else
        local files=$(find . -type f -not -path "*/build/*" -iname "*${file}*")

        if [ $(echo "$files" | wc -l) -eq 1 ]; then
            file=$files
        else
            file=$(echo "$files" | fzf)
        fi

        echo $file
    fi
}

cdf() {
    local file=${1:-}
    if [ -z $file ]; then
        echo "usage: cdf file"
    else
        local files=$(find . -type f -not -path "*/build/*" -iname "*${file}*")

        if [ $(echo "$files" | wc -l) -eq 1 ]; then
            file=$files
        else
            file=$(echo "$files" | fzf)
        fi

        if [ -z "$file" ]; then
            echo "No match found"
        else
            local dir=$(dirname "$file")
            echo "$dir"
            pushd $dir > /dev/null
        fi
    fi
}

# wrapper around gradlew that checks if Docker services are required and
# running
# NOTE: this should be replaced by the docker-compose plugin https://github.com/avast/gradle-docker-compose-plugin
g() {
    if ! [ -z "$(ls docker-compose.yml)" ]; then
        local prj=$(basename $(pwd))
        if [ -z "$(docker ps --format "{{.Names}}" | cut -d_ -f1 | sort -u | grep $prj)" ]; then
            docker-compose up -d
        fi
    fi
    ./gradlew "$@"
}

# interactive git-checkout with fzf (shift-tab for multi-select)
co() {
    local f="$(git status -s | awk '{ print $2 }' | fzf -m --height 10%)"
    if ! [ -z "$f" ]; then
        git checkout -- $f
    fi
}

# jump to project directory
p() {
    local dir=$(ls -1dt ~/src/*/* \
        | sed -e 's|^'"$HOME"'/src/||' \
        | fzf --no-sort)
    if ! [ -z "$dir" ]; then
        cd "$HOME/src/$dir"
        ls
    fi
}

# local-only settings
[ -f ~/.bashrc.sensitive ] && . ~/.bashrc.sensitive

# vim: ts=4:sw=4:et
