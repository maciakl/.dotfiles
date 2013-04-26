# where the dotfiles at
export DOTFILES="$HOME/.dotfiles"

# ensure terminal is 256 colors
export TERM="screen-256color"

# enable extensions for bc
BC_ENV_ARGS="-l $DOTFILES/extensions.bc $DOTFILES/scientific_constants.bc"

# save all the histories
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTFILE="$HOME/.history"

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth

# Ctrl+D must be pressed twice to get out
export IGNOREEOF=1

#enable color for GREP
export GREP_OPTIONS='--color=auto'

# shell options
shopt -s histappend     # merge session histories
shopt -s cmdhist        # combine multiline commands in history
shopt -s cdspell        # cd tries to fix typos
shopt -s dirspell 2>/dev/null
shopt -s autocd 2>/dev/null
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

###COLOR-CODES####
Color_Off="\033[0m"
###-Regular-###
Red="\033[0;31m"
Green="\033[0;32m"
Yellow="\033[0;33m"
Blue="\033[0;34m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
White="\033[0;37m"
####-Bold-####
BRed="\033[1;31m"
BGreen="\033[1;"
BYellow="\033[1;33m"
BBlue="\033[1;34m"
BPurple="\033[1;35m"
###-Intensive-###
IRed="\033[0;91m"
IGreen="\033[0;92m"
IYellow="\033[0;93m"
IBlue="\033[0;94m" 
IPurple="\033[0;95m"
ICyan="\033[0;96m" 
IWhite="\033[0;97m"
##################

# set up command prompt
function __prompt_command()
{
    # capture the exit status of the last command
    EXIT="$?"
    PS1=""

    if [ $EXIT -eq 0 ]; then PS1+="\[$Green\][\!]\[$Color_Off\] "; else  PS1+="\[$Red\][\!]\[$Color_Off\] "; fi

    # if logged in via ssh shows the ip of the client
    if [ -n "$SSH_CLIENT" ]; then PS1+="\[$Yellow\]("${SSH_CLIENT%% *}") \[$Color_Off\]"; fi
    
    # debian chroot stuff (take it or leave it)
    PS1+="${debian_chroot:+($debian_chroot)}"

    # basic information (user@host:path)
    PS1+="\[$BRed\]\u\[$Color_Off\]@\[$BRed\]\h\[$Color_Off\]:\[$BPurple\]\w\[$Color_Off\] "

    # Display the branch name of git repository
    #   Green   ->  clean
    #   purple  ->  untracked files
    #   red     ->  files to commit
    local git_status="`git status -unormal 2>&1`"

    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local Color_On=$Green
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local Color_On=$Purple
        else
            local Color_On=$Red
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi

        PS1+="\[$Color_On\][$branch]\[$Color_Off\] "
    fi

    # prompt $ or # for root
    PS1+="\$ "
}
PROMPT_COMMAND=__prompt_command

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

# make a directory and cd into it in a single command
md() { mkdir -p "$@" && cd "$_"; }

# recursive grep alternative
alias ggrep="grep --recursive --line-number"

# digg checks against opendns server
alias digg="dig @208.67.222.222"

# Open in existing vim
alias gv="gvim --remote-silent"

# Start named session
alias gd="gvim --servername DEV"

# Attach buffer to the named session
alias g="gvim --servername DEV --remote-silent"

# Create randomly named session for this buffer
alias gr="gvim --servername $$"

# force tmux to execute in 256 color mode
command -v tmux >/dev/null 2>&1 && alias tmux="tmux -2"

command -v phpunit >/dev/null 2>&1 && alias phpunit="phpunit --colors"

# use colordiff instead of diff if available
command -v colordiff >/dev/null 2>&1 && alias diff="colordiff -u"

# use htop instead of top if installed 
command -v htop >/dev/null 2>&1 && alias top=htop


[ -f ~/.bashrc_local ] && source ~/.bashrc_local
