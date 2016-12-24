# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

plugins=(git osx brew npm composer make)

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

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
export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/usr/local/sbin:/sbin
export PATH=$PATH:~/bin
export PATH=$PATH:/usr/local/Cellar/node/7.0.0/bin
export PATH=$PATH:~/.gem/ruby/2.0.0/bin
export PATH=$PATH:~/.composer/vendor/bin
export ANDROID_HOME=~/Library/Android/sdk
export NVM_DIR=~/.nvm
export GEM_HOME=~/.gem/ruby/2.0.0/
export PATH=$PATH:${ANDROID_HOME}/tools
export PATH=$PATH:${ANDROID_HOME}/platform-tools
export EDITOR=nvim

# GOPATH exports
export GOBASE=$HOME/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# ## Aliases
alias f=fuzzy_find
alias battery=~/bin/battery.sh
alias brew up="brew update && brew upgrade"
alias tmux="tmux -2"
alias vim=/usr/local/Cellar/macvim/8.0-110/MacVim.app/Contents/MacOS/Vim
alias vim=nvim
alias vi="nvim"
alias svim="sudo nvim"
alias gprune="git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d"

# PHP aliases
alias art="php artisan"
alias ag="rg"

# Go aliases
alias gb="go build"

#
# fpath=(/usr/local/share/zsh-completions $fpath)
. `brew --prefix`/etc/profile.d/z.sh
