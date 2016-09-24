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

# Customize to your needs...
export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/usr/local/sbin:/sbin
export PATH=$PATH:~/bin
export PATH=$PATH:~/.gem/ruby/2.0.0/bin
export PATH=$PATH:~/.composer/vendor/bin
export PATH=$PATH:~/Library/Android/sdk/tools
export PATH=$PATH:~/Library/Android/sdk/platform-tools
export ANDROID_HOME=~/Library/Android/sdk

# Voice echo
# say() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }

alias tmux="tmux -2"
# Make the editor vim
export EDITOR=nvim

## Aliases
#alias vim=/usr/local/Cellar/macvim/8.0-110/MacVim.app/Contents/MacOS/Vim
alias vim=nvim
alias vi="vim"
alias svim="sudo vim"
alias vm='ssh vagrant@127.0.0.1 -p 2222'
# PHP aliases
alias art="php artisan"

alias gprune="git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d"


# Quick command to paste a file to paste.laravel.com
# Use: paste file.php
function laravel_paste {
	curl -sL -w "$1 Uploaded to paste.laravel.com\\n\\tStatus: %{http_code}\\n\\tURL: %{url_effective}\\n" --data-urlencode paste@$1 "http://paste.laravel.com" -o /dev/null
}
alias paste=laravel_paste

# Go aliases
alias gb="go build"

# GOPATH exports
export GOBASE=$HOME/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Switch your GOPATH up

# A quick fuzzy search function
function fuzzy_find {
	for file in `find . -name "*$1*"`; do
		echo -n "vim $file?"
		read yn
		case $yn in
			[Yy]* ) vim $file; break;;
			[Nn]* ) ;;
			* ) ;;
		esac
	done
}
alias f=fuzzy_find

alias battery=~/bin/battery.sh

export GEM_HOME=~/.gem/ruby/2.0.0/

export FONGO_ENV="development"
export AAFFD_ENV="development"
fpath=(/usr/local/share/zsh-completions $fpath)
alias brew up="brew update && brew upgrade"

ulimit -n 1024
source dnvm.sh
export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh
. `brew --prefix`/etc/profile.d/z.sh

# added by travis gem
[ -f /Users/jesse/.travis/travis.sh ] && source /Users/jesse/.travis/travis.sh

# The next line updates PATH for the Google Cloud SDK.
source '/Users/jesse/google/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/jesse/google/google-cloud-sdk/completion.zsh.inc'
export HOMEBREW_AUTO_UPDATE=1
