# where the dotfiles at
export DOTFILES="$HOME/.dotfiles"

export BC_ENV_ARGS="-l $DOTFILES/extensions.bc $DOTFILES/scientific_constants.bc"

# save all the histories
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTFILE="$HOME/.history"

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# ... and ignore same successive entries.
export HISTCONTROL=ignoreboth

# Ctrl+D must be pressed twice to get out
export IGNOREEOF=1

# enable color for GREP
export GREP_OPTIONS='--color=auto'

# shell options
shopt -s histappend     # merge session histories
shopt -s cmdhist        # combine multiline commands in history
shopt -s cdspell        # cd tries to fix typos
shopt -s checkwinsize   # resize ouput to fit window

### COLORED MAN PAGES ###
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'        # end the info box            
export LESS_TERMCAP_so=$'\E[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# ignore case, long prompt, exit if it fits on one screen, allow colors for ls and grep
export LESS="-iXR"

# Set color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    # dircolors doesn't seem to exist on my mac (adds color to ls)
    command -v dircolors >/dev/null 2>&1 && eval "`dircolors -b`"
    
    # force ls to always use color and typ indicators
    alias ls='ls -hF --color=auto'

    # make the dir command work kinda like in windows (long format)
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

# make du and dh human readable
alias du="du -kh"
alias df="df -hTh"

# recursive grep alternative
alias ggrep="grep --recursive --line-number"

# digg checks against opendns server
alias digg="dig @208.67.222.222"

# use colordiff instead of diff if available
command -v colordiff >/dev/null 2>&1 && alias diff="colordiff -u"

# use htop instead of top if installed 
command -v htop >/dev/null 2>&1 && alias top=htop
