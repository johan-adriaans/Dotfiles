# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set my umask
umask 0002

# Find Dotfiles folder
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1

# Load git prompt support
source $DIR/git-prompt.sh

# Cache $DISPLAY value so we can use it later (X11 forwards)
if [ -z "$STY" -a -z "$TMUX" ]; then
  echo $DISPLAY > ~/.display.txt
else
  export DISPLAY=`cat ~/.display.txt`
fi

# Shiny colors
[[ $TERM == screen* ]] && export TERM=screen-256color
[[ $TERM == xterm* ]] && export TERM=xterm-256color

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias vim-git-log='git log -p -40 | vim - -R -c "set foldmethod=syntax"'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Force xterm-color on ssh sessions
alias ssh='TERM=xterm-color ssh'
alias vi='DISPLAY= vim' # Disable X11 mouse support
alias vim='DISPLAY= vim' # Disable X11 mouse support
alias irssi='TERM=screen-256color irssi'
alias nagcon='TERM=screen-256color sudo nagcon -f /var/cache/nagios3/status.dat'
alias alpine='alpine -p "{kantoor.izi-services.nl:993/user=johan/ssl}remote_pinerc"'

# My locale settings
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Make c-w recognize words
stty werase undef
bind '\C-w:unix-filename-rubout'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Node path settings
export PATH=$HOME/local/node/bin:/usr/local/share/npm/bin:$PATH
export NODE_PATH=$HOME/local/node:$HOME/local/node/lib/node_modules

# Android SDK settings
export ANDROID_HOME="$HOME/share/adt-bundle"
export PATH=${PATH}:$HOME/share/adt-bundle/tools:$HOME/share/adt-bundle/platform-tools

# !OSX
if [ ! -d "/Applications" ]; then
    # If set, the pattern "**" used in a pathname expansion context will
    # match all files and zero or more directories and subdirectories.
    shopt -s globstar
else # OSX
  # Some OSX Specific paths
  export PATH=/opt/local/bin:/opt/local/sbin:/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH

  # SSH hosts in ~/.ssh/config autocomplete
  complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh

  # Pretty ls
  alias ls='ls -G'
fi

# Trim working dir to 1/4 the screen width
function prompt_workingdir () {
  local pwdmaxlen=$(($COLUMNS/4))
  local trunc_symbol="..."
  if [[ $PWD == $HOME* ]]; then
    newPWD="~${PWD#$HOME}" 
  else
    newPWD=${PWD}
  fi
  if [ ${#newPWD} -gt $pwdmaxlen ]; then
    local pwdoffset=$(( ${#newPWD} - $pwdmaxlen + 3 ))
    newPWD="${trunc_symbol}${newPWD:$pwdoffset:$pwdmaxlen}"
  fi
  echo $newPWD
}

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    *color) color_prompt=yes;;
esac

# Echo all supported colors
#( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )

if [ "$color_prompt" = yes ]; then
  PS1='\[$(tput setaf 2)\]\u@\h\[$(tput setaf 7)\]:\[$(tput bold)\]\[$(tput setaf 4)\]$(prompt_workingdir)\[$(tput sgr0)\]\[$(tput setaf 7)\]\[$(tput setaf 5)\]$(__git_ps1 " (%s)")\[$(tput setaf 7)\]\$ '
else
  PS1='\u@\h:$(prompt_workingdir)$(__git_ps1 " (%s)")\$ '
fi
unset color_prompt

# Fix the bash prompt to the first column - http://jonisalonen.com/2012/your-bash-prompt-needs-this/
PS1="\[\033[G\]$PS1" 

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Start tmux if not in dumb terminal and on frits
if [ "$(hostname)" == "frits" ]; then
  [[ $TERM != screen* ]] && [[ $TERM != dumb ]] && [[ $TERM != vt* ]] && exec tmux -2 attach
fi
