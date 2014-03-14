# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

plugins=(git archlinux composer)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/jesse/.gem/ruby/2.1.0/bin

# Voice echo
say() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }

# Make the editor vim
export EDITOR=vim

## Aliases

alias svim="sudo vim"
alias upgrade="sudo packer -Syu"

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
export GOROOT=$HOME/go
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
	mkdir -p $GOROOT
	mkdir -p $GOROOT/$1
	go-setup $GOROOT/$1
	go-switch $GOROOT/$1
	echo "Created a go workspace in $GOROOT/$1"
	tree $GOROOT/$1
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


