umask 0077

export EDITOR=nvim
export VISUAL=nvim
export PAGER='less -S'

export SRC=$HOME/src

if [ "$(uname -s)" == "Darwin" ]; then
    export BROWSER="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
    export PATH="/usr/local/opt/ruby/bin:$PATH"
else
    export BROWSER="/usr/bin/firefox"
fi

# local paths
[ -d ~/bin ] && PATH=~/bin:$PATH
[ -d ~/.local/bin ] && PATH=~/.local/bin:$PATH
export PATH

# enable bash completions
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# check window size after each command and, if necessary, update the values of
# the LINES and COLUMNS
shopt -s checkwinsize

# if set, the pattern "**" used in a pathname expansion context will match all
# files and zero or more directories and subdirectories.
shopt -s globstar

## bash history

# enable history expansion with space
# e.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '

# keep history up to date, across sessions, in realtime
#  http://unix.stackexchange.com/a/48113
export HISTCONTROL="erasedups:ignoreboth"       # no duplicate entries
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history
shopt -s histappend                             # append to history, don't overwrite it

# don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Save multi-line commands as one command
shopt -s cmdhist

# Vi key binding
set -o vi

# Number of directories to keep when expanding the \w and \W prompt strings
export PROMPT_DIRTRIM=3

## custom prompt
TERM_RESET="$(tput sgr0)"        # turn off all attributes
TERM_BOLD="$(tput bold)"
TERM_FGCOLOR="$(tput setaf 0)"   # white
TERM_BGCOLOR="$(tput setab 7)"   # blue
_git_prompt_status() {
    # parse the working branch from git-branch
    local git_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    local git_status=""

    if ! [ -z "$(git status -s 2>/dev/null)" ]; then
        git_status=" !"
    fi

    if ! [ -z "$git_branch" ]; then
        echo " (${git_branch}${git_status})"
    fi
}
PS1="\[${TERM_BOLD}${TERM_FGCOLOR}\]\w $ \[${TERM_RESET}\] "
#PS1="\[${TERM_BOLD}${TERM_FGCOLOR}\]\w\$(_git_prompt_status) $ \[${TERM_RESET}\] "

# terminal title
#PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Change fzf search to include hidden files.
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# golang
if [ -d /usr/local/go ]; then
    PATH=$PATH:/usr/local/go/bin
    GOPATH=$HOME/Code
    export PATH
    export GOPATH
fi

# sdkman
if [ -d ~/.sdkman ]; then
    export SDKMAN_DIR=~/.sdkman
    source ~/.sdkman/bin/sdkman-init.sh
fi

[ -f ~/.bashrc ] && . ~/.bashrc

# vim: ts=4:sw=4:et
