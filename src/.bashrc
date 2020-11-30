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

# utility functions
[ -d ~/.bash ] && for f in ~/.bash/*; do . $f; done

# local-only settings
[ -f ~/.bashrc.sensitive ] && . ~/.bashrc.sensitive

# vim: ts=4:sw=4:et
