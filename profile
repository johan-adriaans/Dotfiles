# Sublime is the default editor
export EDITOR='subl -w'

# TodoTxt tricks
export PATH=/Users/johan/Dropbox/todo:~/bin:$PATH
export TODOTXT_DEFAULT_ACTION=pv
alias t='todo.sh -d /Users/johan/Dropbox/todo/todo.cfg'
source /Users/johan/Dropbox/todo/todo_completion
complete -F _todo t

# SSH hosts in ~/.ssh/config autocomplete
complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh

# Pretty ls
alias ls='ls -G'

# PATH settings
export PATH=/opt/local/bin:/opt/local/sbin:/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

