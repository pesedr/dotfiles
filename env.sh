#!/bin/zsh

# dotfiles
alias dotedit='vim ~/Projects/env.sh'
alias dotsource='source ~/.zshrc'
alias vimedit='vim ~/.vimrc'
alias github='cd ~/Projects/go/src/github.com'
alias pesgit='cd ~/Projects/go/src/github.com/pesedr'

# Go
export GOPATH=$HOME/Projects/go
export PATH=$PATH:$(go env GOPATH)/bin

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Java
export PATH="/usr/local/bin:$PATH"
export JAVA_HOME="`/usr/libexec/java_home`"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fpath=(/usr/local/share/zsh-completions /Users/rodrigoalonso/.oh-my-zsh/plugins/osx /Users/rodrigoalonso/.oh-my-zsh/plugins/brew /Users/rodrigoalonso/.oh-my-zsh/plugins/python /Users/rodrigoalonso/.oh-my-zsh/plugins/pip /Users/rodrigoalonso/.oh-my-zsh/plugins/colorize /Users/rodrigoalonso/.oh-my-zsh/plugins/git /Users/rodrigoalonso/.oh-my-zsh/functions /Users/rodrigoalonso/.oh-my-zsh/completions /usr/local/share/zsh/site-functions /usr/share/zsh/site-functions /usr/share/zsh/5.3/functions)
eval "$(rbenv init -)"
