# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# enable color for GREP
export GREP_OPTIONS='--color=auto'

# Set color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls -hF --color=auto'
    alias dir='ls --color=auto --format=long'
fi

# if ~/scripts exists, add it to the path
if [ -d ~/scripts ] ; then
    PATH=~/scripts:"${PATH}"
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias du="du -kh"
alias df="df -hTh"
alias diff="colordiff -u"
alias ggrep="grep --recursive --line-number"
