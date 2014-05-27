# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

plugins=(git archlinux composer make)

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
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/jesse/.gem/ruby/2.1.0/bin

# Voice echo
say() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }

export TERM="screen-256color"
alias tmux="tmux -2"
# Make the editor vim
export EDITOR=vim

## Aliases

alias vi="vim"
alias svim="sudo vim"
alias upgrade="sudo packer -Syu"
alias packer="sudo packer --noconfirm --noedit"

# PHP aliases
alias composer="hhvm /usr/local/bin/composer.phar"
alias composer-install="curl -sS https://getcomposer.org/installer | php && composer install"
alias artisan="php artisan"


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
export PATH=$PATH:$GOPATH/bin

# Switch your GOPATH up
function go-switch {
	export GOPATH=$1
	export PATH=$GOPATH/bin:$PATH
}

# Set up a new go-workspace
function go-setup {
	mkdir -p $1/bin $1/src $1/pkg
}

# Create a whole workspace
function go-create {
	mkdir -p $GOBASE
	mkdir -p $GOBASE/$1
	go-setup $GOBASE/$1
	go-switch $GOBASE/$1
	echo "Created a go workspace in $GOBASE/$1"
	tree $GOBASE/$1
}

function go-clone {
	git clone $1 $GOBASE/
}

function breath {
	MIL=$(echo "$1*60" | bc)
	sleep $MIL && notify-send -i /usr/share/icons/default.kde4/256x256/apps/clock.png Breather "Time to take a rest" -t 5000
}

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


