# set umask to the most restrictive
umask 0077

# local paths
export PATH=$PATH:$HOME/.local/bin:$HOME/bin;

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# if set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories
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

## custom prompt

# custom git prompt
function get_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
function get_git_status {
  [ -n "`git status -s 2>/dev/null`" ] && echo '!'
}
PS1=" \W\$(get_git_branch)\$(get_git_status) \$ "

# terminal title
PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# defaults
EDITOR=vi               # only real editor
VISUAL=vi               #
PAGER='less -S'         # don't wrap long lines
BROWSER=google-chrome   # resistance is futile

# aliases
[[ -s "$HOME/.bash_aliases" ]] && . $HOME/.bash_aliases

# debian maintainer
[[ -s "$HOME/.bash_dhmake" ]] && . $HOME/.bash_dhmake

if [ -d "$HOME/.sdkman" ]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    source $HOME/.sdkman/bin/sdkman-init.sh
fi

# work apps
[[ -s "$HOME/.gf/bin/gf" ]] && eval "$(~/.gf/bin/gf init -)"
[[ -s "$HOME/.cms/bin/cms" ]] && eval "$(~/.cms/bin/cms init -)"

# start ssh-agent or connect to an existing one
#   we want to make sure the *real* ssh-agent is running and not
#   gnome-keyring
if ! [ -z "$(env | grep SSH | grep keyring)" ]; then
    SSH_AUTH_SOCK=""
fi
if [ "$SSH_AUTH_SOCK" == "" ]; then
    [ -f $HOME/.ssh/agent ] && . $HOME/.ssh/agent
    ssh-add -l &> /dev/null
    if [ $? -eq 2 ]; then
        ssh-agent > $HOME/.ssh/agent
        source $HOME/.ssh/agent > /dev/null
    fi
fi

# start tmux
[ -z "$TMUX" ] && exec tmux -2 -u

# vim: set ts=4 sts=4 sw=4 et :
