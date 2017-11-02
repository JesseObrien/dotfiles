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
export PATH=$PATH:~/.nexustools
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/usr/local/sbin:/sbin:/usr/local/bin
export PATH=$PATH:~/bin
export PATH=$PATH:~/.composer/vendor/bin
export EDITOR=nvim

# GOPATH exports
export GOBASE=$HOME/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# ## Aliases
alias v=nvim
alias del=rm -rf
alias ls=exa
alias f=fuzzy_find
alias y=yarn
alias battery=~/bin/battery.sh
alias brew up="brew update && brew upgrade"
alias fuckvehiklmaster="git co -b fuckmaster && git branch -D master && git fetch vehikl && git co -b master vehikl/master && git branch -D fuckmaster"
alias fuckoriginmaster="git co -b fuckmaster && git branch -D master && git fetch origin && git co -b master origin/master && git branch -D fuckmaster"
alias tmux="tmux -2"
alias vim=nvim
alias vi="nvim"
alias svim="sudo nvim"
alias gprune="git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d"
alias weather='curl -s wttr.in/Kitchener | sed -n "1,7p"'

# PHP aliases
alias art="php artisan"
alias grep="rg"
alias ag="rg"

# Go aliases
alias gb="go build"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias bindcb="kubectl port-forward couchbase-deployment-3819805086-6p1vt 8091:8091 8092:8092 11207:11207 11209:11209 11210:11210 11211:11211 11214:11214 11215:11215 18091:18091 18092:18092 4369:4369"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias node='unalias node ; unalias npm ; nvm use default ; node $@'
alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Load RVM
source /Users/jesse/.rvm/scripts/rvm

cassandra_port_foward () {
    kubectl port-forward `kubectl get pods | grep cassandra | cut -d' ' -f1` 7000:7000 7001:7001 7199:7199 9042:9042 9160:9160
}

rabbit_port_forward () {
    kubectl port-forward `kubectl get pods | grep rabbit | cut -d' ' -f1` 5672:5672 15672:15672 5671:5671 9093:9093
}

alias cassandraPortForward=cassandra_port_foward
alias rabbitPortForward=rabbit_port_forward
