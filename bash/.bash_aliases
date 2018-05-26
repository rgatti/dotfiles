alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls -CF --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls'
alias v='vim'
alias ..='cd ..'
alias ...='cd ../..'

# mkdir/cd combo
_mkdir_cd_wrapper() {
	if [[ -z $1 ]]; then
	    echo <<- EOT
		Usage: md <directory>
		Create a new directory if it doesn't already exist and move into it.
EOT
	    exit 1
	fi
	mkdir -p $1
	cd $1
}
alias md=_mkdir_cd_wrapper

# add an "alert" alias for long running commands
#    sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# python3 by default
alias python=python3
alias pylint=pylint3
alias pip=pip3

# google cloud in containers
alias gcloud='docker run -it --rm -v google-sdk:/root google/cloud-sdk gcloud'
alias kubectl='docker run -it --rm -v google-sdk:/root google/cloud-sdk kubectl'
