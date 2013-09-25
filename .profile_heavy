# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -e ~/profile ]; then
  . ~/profile
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
export PATH=$HOME/local/node/bin:$PATH
export NODE_PATH=$HOME/local/node:$HOME/local/node/lib/node_modules

# Force xterm-color on ssh sessions
alias ssh='TERM=xterm-color ssh' 
alias irssi='TERM=screen-256color irssi'
alias nagcon='TERM=screen-256color sudo nagcon -f /var/cache/nagios3/status.dat'
#alias tmux="TERM=screen-256color-bce tmux"

# TodoTxt tricks
export PATH=~/Dropbox/todo:~/bin:$PATH
export TODOTXT_DEFAULT_ACTION=pv
alias t='todo.sh -d ~/Dropbox/todo/todo.cfg'
source ~/Dropbox/todo/todo_completion
complete -F _todo t
export TODOTXT_FINAL_FILTER='~/Dropbox/todo/filters/futureTasks'

if [ ! -d "/Applications" ]; then
  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      #alias dir='dir --color=auto'
      #alias vdir='vdir --color=auto'

      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi

  # some more ls aliases
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
else
  alias ls='ls -G'
fi

# More alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Fix the bash prompt to the first column - http://jonisalonen.com/2012/your-bash-prompt-needs-this/
#PS1="\[\033[G\]$PS1" 

# Filename:      Custom promt
# Maintainer:    Dave Vehrs (modified by Johan Adriaans)
# Last Modified: 12 Jul 2005 13:29:40 by Dave Vehrs

# Current Format: USER@HOST [dynamic section] { CURRENT DIRECTORY }$ 
# USER:      (also sets the base color for the prompt)
#   Red       == Root(UID 0) Login shell (i.e. sudo bash)
#   Light Red == Root(UID 0) Login shell (i.e. su -l or direct login)
#   Yellow    == Root(UID 0) priviledges in non-login shell (i.e. su)
#   Brown     == SU to user other than root(UID 0)
#   Green     == Normal user
# @:
#   Light Red == http_proxy environmental variable undefined.
#   Green     == http_proxy environmental variable configured.
# HOST:
#   Red       == Insecure remote connection (unknown type)
#   Yellow    == Insecure remote connection (Telnet)
#   Brown     == Insecure remote connection (RSH)
#   Cyan      == Secure remote connection (i.e. SSH)
#   Green     == Local session
# DYNAMIC SECTION:  
#     (If count is zero for any of the following, it will not appear)
#   [tmux:#] ==== Number of detached tmux sessions
#     Yellow    == 1-2
#     Red       == 3+
#   [loadavg:#] ==== The current system load
#     Yellow    == 0.8-2
#     Red       == 2+
#   [bg:#]  ==== Number of backgrounded but still running jobs
#     Yellow    == 1-10
#     Red       == 11+
#   [stp:#] ==== Number of stopped (backgrounded) jobs
#     Yellow    == 1-2
#     Red       == 3+
# CURRENT DIRECTORY:     (truncated to 1/4 screen width)
#   Red       == Current user does not have write priviledges
#   Green     == Current user does have write priviledges
# NOTE:
#   1.  Displays message on day change at midnight on the line above the
#       prompt (Day changed to...). 
#   2.  Command is added to the history file each time you hit enter so its
#       available to all shells.

# Configure Colors:
COLOR_WHITE='\033[1;37m'
COLOR_LIGHTGRAY='033[0;37m'
COLOR_GRAY='\033[1;30m'
COLOR_BLACK='\033[0;30m'
COLOR_RED='\033[0;31m'
COLOR_LIGHTRED='\033[1;31m'
COLOR_GREEN='\033[0;32m'
COLOR_LIGHTGREEN='\033[1;32m'
COLOR_BROWN='\033[0;33m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
COLOR_LIGHTBLUE='\033[1;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_PINK='\033[1;35m'
COLOR_CYAN='\033[0;36m'
COLOR_LIGHTCYAN='\033[1;36m'
COLOR_DEFAULT='\033[0m'

# Function to set prompt_command to.
function promptcmd () {
    history -a 
    local SSH_FLAG=0
    local TTY=$(tty | awk -F/dev/ '{print $2}')
    if [[ ${TTY} ]]; then 
        local SESS_SRC=$(who | grep "$TTY "  | awk '{print $6 }')
    fi
    
    # Titlebar
    case ${TERM} in 
        xterm*  )  
            local TITLEBAR='\[\033]0;\u@\h:\w \007\]'
            ;;
        *       )  
            local TITLEBAR=''                               
            ;;
    esac
    PS1="${TITLEBAR}"
  
    # Test for day change.
    if [ -z $DAY ] ; then
        export DAY=$(date +%A)
    else
        local today=$(date +%A)
        if [ "${DAY}" != "${today}" ]; then
            PS1="${PS1}\n\[${COLOR_GREEN}\]Day changed to $(date '+%A, %d %B %Y').\n"
            export DAY=$today
       fi
    fi
   
    # User
    if [ ${UID} -eq 0 ] ; then
        if [ "${USER}" == "${LOGNAME}" ]; then
            if [[ ${SUDO_USER} ]]; then
                PS1="${PS1}\[${COLOR_RED}\]\u"
            else
                PS1="${PS1}\[${COLOR_LIGHTRED}\]\u"
            fi
        else                               
            PS1="${PS1}\[${COLOR_YELLOW}\]\u"
        fi
    else
        if [ ${USER} == ${LOGNAME} ]; then     
            PS1="${PS1}\[${COLOR_GREEN}\]\u"
        else                               
            PS1="${PS1}\[${COLOR_BROWN}\]\u"
        fi
    fi

    # HTTP Proxy var configured or not
    if [ -n "$http_proxy" ] ; then
        PS1="${PS1}\[${COLOR_LIGHTRED}\]@"
    else                               
        PS1="${PS1}\[${COLOR_GREEN}\]@"
    fi

    # Host

    if [[ ${SSH_CLIENT} ]] || [[ ${SSH2_CLIENT} ]]; then 
        SSH_FLAG=1
    fi
    if [ ${SSH_FLAG} -eq 1 ]; then 
       PS1="${PS1}\[${COLOR_CYAN}\]\h"
    elif [[ -n ${SESS_SRC} ]]; then 
        if [ "${SESS_SRC}" == "(:0.0)" ]; then 
        PS1="${PS1}\[${COLOR_GREEN}\]\h"
        else 
          if [ -f "/proc/${PPID}/cmdline" ]; then
            local parent_process=`cat /proc/${PPID}/cmdline`
            if [[ "$parent_process" == "in.rlogind*" ]]; then
                PS1="${PS1}\[${COLOR_BROWN}\]\h"
            elif [[ "$parent_process" == "in.telnetd*" ]]; then 
                PS1="${PS1}\[${COLOR_YELLOW}\]\h"
            else
                PS1="${PS1}\[${COLOR_LIGHTRED}\]\h"
            fi
          fi
        fi
    elif [[ "${SESS_SRC}" == "" ]]; then
        PS1="${PS1}\[${COLOR_GREEN}\]\h"
    else                                 
        PS1="${PS1}\[${COLOR_RED}\]\h" 
    fi

    # Detached tmux Sessions (Not in OSX)
    if [ ! -d "/Applications" ]; then
      local DTCHTMX=$(tmux list-sessions | grep -v '(attached)' | wc -l)
      if [ ${DTCHTMX} -gt 2 ]; then
          PS1="${PS1}\[${COLOR_RED}\][tmux:${DTCHTMX}]"
      elif [ ${DTCHTMX} -gt 0 ]; then
          PS1="${PS1}\[${COLOR_YELLOW}\][tmux:${DTCHTMX}]"
      fi
    fi

    # System load
    if [ -f "/proc/loadavg" ]; then
      local LOADAVG=$(cat /proc/loadavg | awk {'print $1 * 100'} | bc)
      local LOADAVGSTR=$(cat /proc/loadavg | awk {'print $1'})
      if [ ${LOADAVG} -gt 200 ]; then
          PS1="${PS1}\[${COLOR_RED}\][loadavg:${LOADAVGSTR}]"
      elif [ ${LOADAVG} -gt 80 ]; then
          PS1="${PS1}\[${COLOR_YELLOW}\][loadavg:${LOADAVGSTR}]"
      fi
    fi
   
    # Backgrounded running jobs
    local BKGJBS=$(jobs -r | wc -l )
    if [ ${BKGJBS} -gt 2 ]; then
        PS1="${PS1}\[${COLOR_RED}\][bg:${BKGJBS}]"
    elif [ ${BKGJBS} -gt 0 ]; then
        PS1="${PS1}\[${COLOR_YELLOW}\][bg:${BKGJBS}]"
    fi
    
    # Stopped Jobs
    local STPJBS=$(jobs -s | wc -l )
    if [ ${STPJBS} -gt 2 ]; then
        PS1="${PS1}\[${COLOR_RED}\][stp:${STPJBS}]"
    elif [ ${STPJBS} -gt 0 ]; then
        PS1="${PS1}\[${COLOR_YELLOW}\][stp:${STPJBS}]"
    fi
    
    # Bracket {
    if [ ${UID} -eq 0 ]; then              
        if [ "${USER}" == "${LOGNAME}" ]; then 
            if [[ ${SUDO_USER} ]]; then
                PS1="${PS1}\[${COLOR_RED}\]"
            else
                PS1="${PS1}\[${COLOR_LIGHTRED}\]"
            fi
        else                               
            PS1="${PS1}\[${COLOR_YELLOW}\]"
        fi
    else                                 
        if [ "${USER}" == "${LOGNAME}" ]; then 
            PS1="${PS1}\[${COLOR_GREEN}\]"
        else                               
            PS1="${PS1}\[${COLOR_BROWN}\]"
        fi
    fi
    PS1="${PS1}:"
    
    # Working directory
    if [ -w "${PWD}" ]; then 
        PS1="${PS1}\[${COLOR_LIGHTBLUE}\]$(prompt_workingdir)"
    else                                 
        PS1="${PS1}\[${COLOR_RED}\]$(prompt_workingdir)"
    fi
    
    # Closing bracket } and $\#
    if [ ${UID} -eq 0 ]; then              
        if [ "${USER}" == "${LOGNAME}" ]; then 
            if [[ ${SUDO_USER} ]]; then
                PS1="${PS1}\[${COLOR_RED}\]"
            else
                PS1="${PS1}\[${COLOR_LIGHTRED}\]"
            fi
        else                               
            PS1="${PS1}\[${COLOR_YELLOW}\]"
        fi
    else                                 
        if [ "${USER}" == "${LOGNAME}" ]; then 
            PS1="${PS1}\[${COLOR_GREEN}\]"
        else                               
            PS1="${PS1}\[${COLOR_BROWN}\]"
        fi
    fi
    PS1="${PS1}\[${COLOR_DEFAULT}\] # "
}     

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

# Determine what prompt to display:
# 1.  Display simple custom prompt for shell sessions started
#     by script.  
# 2.  Display "bland" prompt for shell sessions within emacs or 
#     xemacs.
# 3   Display promptcmd for all other cases.

function load_prompt () {
    # Get PIDs
    if [ -f "/proc/$PPID/cmdline" ]; then
      local parent_process=$(cat /proc/$PPID/cmdline | cut -d \. -f 1)
      local my_process=$(cat /proc/$$/cmdline | cut -d \. -f 1)
    fi

    if  [[ $parent_process == script* ]]; then
        PROMPT_COMMAND=""
        PS1="\t - \# - \u@\H { \w }\$ "
    elif [[ $parent_process == emacs* || $parent_process == xemacs* ]]; then
        PROMPT_COMMAND=""
        PS1="\u@\h { \w }\$ "
    else
        export DAY=$(date +%A)
        PROMPT_COMMAND=promptcmd
     fi 
    export PS1 PROMPT_COMMAND
}

# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ $TERM != screen* ]] && exec tmux -2 attach

load_prompt
