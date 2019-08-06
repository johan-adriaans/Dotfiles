#!/usr/bin/env bash
# If not running interactively, don't do anything (for sh compatability)
[ -z "$PS1" ] && return

# Set my umask
umask 0002

# Cache $DISPLAY value so we can use it later (X11 forwards)
if [ -z "$STY" ] && [ -z "$TMUX" ]; then
  echo "$DISPLAY" > ~/.display.txt
else
  export DISPLAY
  DISPLAY=$(cat ~/.display.txt)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  # shellcheck disable=SC2015
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
alias weather='curl http://wttr.in/utrecht'

# Force xterm-color on ssh sessions
alias ssh='LC_NO_TMUX=1 ssh'
alias vi='DISPLAY= vim' # Disable X11 mouse support
alias vim='DISPLAY= vim' # Disable X11 mouse support
alias irssi='irssi'
alias nagcon='sudo nagcon -f /var/cache/nagios3/status.dat'
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

# Define path for GO
if [ -d "$HOME/source/go" ] ; then
  export GOPATH="$HOME/source/go"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$HOME/bin/arm-toolchain/bin:$HOME/source/go/bin:$PATH"
fi

# Node path settings
if [ -d "$HOME/local/node" ]; then
  export PATH="$HOME/local/node/bin:/usr/local/share/npm/bin:$PATH"
  export NODE_PATH="$HOME/local/node:$HOME/local/node/lib/node_modules"
fi

# Android SDK settings
if [ -d "$HOME/share/adt-bundle" ]; then
  export ANDROID_HOME="$HOME/share/adt-bundle"
  export PATH="$PATH:$HOME/share/adt-bundle/tools:$HOME/share/adt-bundle/platform-tools"
fi
if [ -d "$HOME/android" ]; then
  export PATH="$HOME/android/sdk/tools:$HOME/android/sdk/platform-tools:$PATH"
fi

# Cargo path
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# !OSX
if [ ! -d "/Applications" ]; then
    # If set, the pattern "**" used in a pathname expansion context will
    # match all files and zero or more directories and subdirectories.
    shopt -s globstar
else # OSX
  # Some OSX Specific paths
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:/opt/local/bin:/opt/local/sbin:/Applications/Xcode.app/Contents/Developer/usr/bin:~/Library/Python/2.7/bin/:$PATH"

  # SSH hosts in ~/.ssh/config autocomplete
  # shellcheck disable=SC2016,SC2086
  complete -o default -o nospace -W "$(grep '^Host ' "$HOME/.ssh/config" | cut -d' ' -f2)" scp sftp ssh

  export HOMEBREW_GITHUB_API_TOKEN="d9a44a49a51967cca6468aecfb7bc9da7654a5fb"

  # Pretty ls (both coreutils and darwin version)
  # shellcheck disable=SC2015
  ls --color=auto &> /dev/null && alias ls='ls --color=auto' || alias ls='ls -G'
fi

# Trim working dir to 1/4 the screen width
function prompt_workingdir () {
  local pwdmaxlen=$((COLUMNS/4))
  local trunc_symbol="..."
  if [[ $PWD == $HOME* ]]; then
    newPWD="~${PWD#$HOME}"
  else
    newPWD=${PWD}
  fi
  if [ ${#newPWD} -gt $pwdmaxlen ]; then
    local pwdoffset=$(( ${#newPWD} - pwdmaxlen + 3 ))
    newPWD="${trunc_symbol}${newPWD:$pwdoffset:$pwdmaxlen}"
  fi
  echo "$newPWD"
}

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    *color) color_prompt=yes;;
esac

# My own __git_ps1, barebones but very fast
function __git_ps1 {
  cwd="$(pwd)"
  while true; do
    if [ -d "$cwd/.git" ]; then
      branch="$(basename "$(cat "$cwd/.git/HEAD")")"
      test ${#branch} -gt 25 && branch=${branch:0:22}...
      echo " ($branch)"
      return
    else
      cwd=$(dirname "$cwd")
      if [ "$cwd" = "/" ]; then
        return
      fi
    fi
  done
}

# Echo all supported colors
#( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )

if [ "$color_prompt" = yes ]; then
  PS1='\[$(tput setaf 2)\]\u@\h\[$(tput setaf 7)\]:\[$(tput bold)\]\[$(tput setaf 4)\]$(prompt_workingdir)\[$(tput sgr0)\]\[$(tput setaf 7)\]\[$(tput setaf 5)\]$(__git_ps1)\[$(tput setaf 7)\]\$ '
else
  PS1='\u@\h:$(prompt_workingdir)$(__git_ps1)\$ '
fi
unset color_prompt

# Fix the bash prompt to the first column - http://jonisalonen.com/2012/your-bash-prompt-needs-this/
PS1="\[\033[G\]$PS1"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
# shellcheck disable=SC1091
    . /etc/bash_completion
fi

# OSX bash completion
# shellcheck disable=SC1091
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Set gpg-agent as ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] || [[ "$SSH_AUTH_SOCK" = *com.apple.launchd* ]]; then
  gpg2 -K &> /dev/null
  SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  export SSH_AUTH_SOCK
  ssh-add
fi

# Fix SSH auth socket location so agent forwarding works with tmux
if test "$SSH_AUTH_SOCK" && [[ $SSH_AUTH_SOCK != "$HOME/.ssh/ssh_auth_sock" ]]; then
  ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
fi
if [ -e ~/.ssh/ssh_auth_sock ]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
fi

# Start tmux if not in dumb terminal
[[ $TERM != screen* ]] && [[ $TERM != dumb ]] && [[ $TERM != vt* ]] && exec tmux -2 attach

