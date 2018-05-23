# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# add custom PATHs
export PATH=$PATH:$HOME/.local/bin:$HOME/bin;

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# aliases
[[ -s "$HOME/.bash_aliases" ]] && . $HOME/.bash_aliases

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

# debian maintainer env
[[ -s "$HOME/.bash_dhmake" ]] && . $HOME/.bash_dhmake

# basecamp sub apps
[[ -s "$HOME/.gf/bin/gf" ]] && eval "$(~/.gf/bin/gf init -)"
[[ -s "$HOME/.cms/bin/cms" ]] && eval "$(~/.cms/bin/cms init -)"

# sdkman setup
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && . $HOME/.sdkman/bin/sdkman-init.sh
