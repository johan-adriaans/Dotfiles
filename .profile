# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set my umask
umask 0002

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
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
export PATH=$HOME/local/node/bin:$PATH
export NODE_PATH=$HOME/local/node:$HOME/local/node/lib/node_modules

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

# Colors:
#COLOR_WHITE='\033[1;37m'
#COLOR_LIGHTGRAY='033[0;37m'
#COLOR_GRAY='\033[1;30m'
#COLOR_BLACK='\033[0;30m'
#COLOR_RED='\033[0;31m'
#COLOR_LIGHTRED='\033[1;31m'
#COLOR_GREEN='\033[0;32m'
#COLOR_LIGHTGREEN='\033[1;32m'
#COLOR_BROWN='\033[0;33m'
#COLOR_YELLOW='\033[1;33m'
#COLOR_BLUE='\033[0;34m'
#COLOR_LIGHTBLUE='\033[1;34m'
#COLOR_PURPLE='\033[0;35m'
#COLOR_PINK='\033[1;35m'
#COLOR_CYAN='\033[0;36m'
#COLOR_LIGHTCYAN='\033[1;36m'
#COLOR_DEFAULT='\033[0m'

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

if [ "$color_prompt" = yes ]; then
  PS1='\[\033[0;32m\]\u@\h\[\033[0m\]:\[\033[01;34m\]$(prompt_workingdir)\[\033[0m\]\$ '
else
  PS1='\u@\h:$(prompt_workingdir)\$ '
fi
unset color_prompt force_color_prompt

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
