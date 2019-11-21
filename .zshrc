# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

plugins=(git osx brew npm composer make yarn)

source $ZSH/oh-my-zsh.sh

# Customize some options
setopt autocd
setopt nocheckjobs
setopt nohup
setopt listpacked
setopt extendedglob
setopt completeinword
setopt alwaystoend
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_verify
setopt append_history

export HOMEBREW_AUTO_UPDATE=1
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/usr/local/sbin:/sbin:/usr/local/bin
export PATH=$PATH:~/bin
export EDITOR=nvim

# GOPATH exports
export GOBASE=$HOME/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Aliases
alias v=nvim
alias del=rm -rf
alias ls=exa
alias f=fuzzy_find
alias y=yarn
alias battery=~/bin/battery.sh
alias brew up="brew update && brew upgrade"
alias tmux="tmux -2"
alias vim=nvim
alias vi="nvim"
alias svim="sudo nvim"
alias gprune="git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d"
alias weather='curl -s wttr.in/Kitchener | sed -n "1,7p"'
alias grep="rg"
alias ag="rg"

# Go aliases
alias gb="go build"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias node='unalias node ; unalias npm ; nvm use default ; node $@'
alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'
