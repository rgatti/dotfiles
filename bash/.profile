# set umask to the most restrictive
umask 0077

# start ssh-agent, connect if already exists
if [ "$SSH_AUTH_SOCK" == "" ]; then
    [ -f ~/.ssh/agent ] && . ~/.ssh/agent
    ssh-add -l &> /dev/null
    if [ $? -eq 2 ]; then
        ssh-agent > ~/.ssh/agent
        . ~/.ssh/agent > /dev/null
    fi
fi

# start tmux
[ -z "$TMUX" ] && exec tmux -2 -u

if [ -n "$BASH_VERSION" ] && [ -f $HOME/.bashrc ]; then
    . $HOME/.bashrc
fi
