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

#### COLOR CODES ####

Color_Off="\e[0m"

Red="\e[0;31m"
Green="\e[0;32m"
Yellow="\e[0;33m"
Blue="\e[0;34m"
Purple="\e[0;35m"
Cyan="\e[0;36m"
White="\e[0;37m"

BRed="\e[1;31m"
BGreen="\e[1;32m"
BYellow="\e[1;33m"
BBlue="\e[1;34m"
BPurple="\e[1;35m"

On_Red="\e[41m"
On_Green="\e[42m"
On_Yellow="\e[43m"
On_Blue="\e[44m"
On_Purple="\e[45m"
On_Cyan="\e[46m"
On_White="\e[47m"

IRed="\e[0;91m"
IGreen="\e[0;92m"
IYellow="\e[0;93m"
IBlue="\e[0;94m" 
IPurple="\e[0;95m"
ICyan="\e[0;96m" 
IWhite="\e[0;97m"

##################

# Status of last command (for prompt)
__stat() { if [ $? -eq 0 ]; then echo -ne "$Green✔"; else echo -en "$Red✘"; fi }

# Display the branch name of git repository
#   Green   ->  clean
#   purple  ->  untracked files
#   red     ->  files to commit
function __git_prompt() {

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
        echo -ne "$Color_On[$branch]$Color_Off "
    fi
}

#####################
#### BASH PROMPT ####
#####################

# Comment out any lines you don't like
# It's modular!

# command status (shows check-mark or red x if last command failed)
PS1=' $(__stat)'$Color_Off" " 

# debian chroot stuff (take it or leave it)
PS1+="${debian_chroot:+($debian_chroot)}"

# basic information (user@host:path)
PS1+="$BRed\u$Color_Off@$BRed\h$Color_Off:$BPurple\w$Color_Off "

# if git is installed add git display to prompt
command -v git >/dev/null 2>&1 && PS1+=$BGreen'$(__git_prompt)'$Color_Off

# prompt $ or # for root
PS1+="\$ "

export PS1

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

# force tmux to execute in 256 color mode
command -v tmux >/dev/null 2>&1 && alias tmux="tmux -2"

# use colordiff instead of diff if available
command -v colordiff >/dev/null 2>&1 && alias diff="colordiff -u"

# use htop instead of top if installed 
command -v htop >/dev/null 2>&1 && alias top=htop
