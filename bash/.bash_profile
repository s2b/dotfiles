#
# Adjust PATH
#

# Add primary SSH key to agent
ssh-add ~/.ssh/id_rsa 2> /dev/null

# Add local bin/sbin
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Add user bin
PATH="$HOME/bin:$PATH"

# Use current PHP version for CLI
# $ brew tap homebrew/php
# $ brew install php72
PATH="$(brew --prefix homebrew/php/php72)/bin:$PATH"

# Add composer path
export COMPOSER_HOME="~/.composer"
PATH="$PATH:$COMPOSER_HOME/vendor/bin"

export PATH

#
# Set constants
#

# Use SublimeText as editor
# $ ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sl
if [ $(which sl) ]; then
	export EDITOR='sl -w'
fi

# wiro-git default directory
export WIRO_GIT_DESTINATION="$(pwd ~)/WiRo/git/Extensions"

#
# Configure prompt
#
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\n\[$(tput bold)\]\[$(tput setaf 5)\]\u@\h:\[$(tput setaf 6)\]\w\[$(tput setaf 3)\]\$(parse_git_branch)\[\033[00m\]\n$ \[$(tput sgr0)\]"

# Enable colors in ls
export CLICOLOR=1

#
# Useful tools
#

# Show HTTP headers
# $ brew install httpie
alias headers='http -p Hh '

# Better directory listings
alias ll='ls -lah'

# Show size of a directory
alias size='du -sh'

# Simple development server
alias server='open http://localhost:8000 && python -m SimpleHTTPServer'

# Obtain local and online ip
alias ip="curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g'"
alias localip="ipconfig getifaddr en0"

# Remove all .DS_Store files in a directory
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Flush DNS cache on macOS
alias flushdns="sudo killall -HUP mDNSResponder"

# Android web debugging
# $ brew install android-sdk
alias androiddebug='open http://localhost:9222 && adb forward tcp:9222 localabstract:chrome_devtools_remote'

# Generate 8-digit simple password
alias password="openssl rand -base64 6"

# vagrant
alias v="vagrant"
alias vu="vagrant up"
alias vh="vagrant halt"
alias vd="vagrant destroy"
alias vgs="vagrant global-status | grep virtualbox"
alias vgsr="vagrant global-status | grep running"
alias vbu="vagrant box update"
alias vbl="vagrant box list"
alias vs="vagrant suspend"
alias vssh="vagrant ssh"
alias vre="vagrant destroy; vagrant up;"
alias vcd="cd `vagrant global-status | grep running | cut -f6- -d' '`"
alias vha="vagrant global-status | grep running | cut -f1 -d' ' | xargs vagrant halt"
alias vhu="vha && vu"

# docker-compose
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcdu="docker-compose down && docker-compose up"

# typo3
alias t3pu="[[ -e bin/phpunit ]] && bin/phpunit -c vendor/typo3/testing-framework/Resources/Core/Build/UnitTests.xml || vendor/bin/phpunit -c vendor/typo3/testing-framework/Resources/Core/Build/UnitTests.xml"
alias t3cs="phpcs --extensions=php"

# z
# brew install z
. /usr/local/etc/profile.d/z.sh

#
# More autocomplete for bash
# $ brew install bash-completion
#
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

#
# Autocomplete SSH hosts
#
_complete_ssh_hosts ()
{
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
			cut -f 1 -d ' ' | \
			sed -e s/,.*//g | \
			grep -v ^# | \
			uniq | \
			grep -v "\[" ;
		cat ~/.ssh/config | \
			grep -i "^Host " | \
			awk '{print $2}'
		`
	COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
	return 0
}
complete -F _complete_ssh_hosts ssh

#
# Autocomplete npm install
# https://medium.com/@jamischarles/adding-autocomplete-to-npm-install-5efd3c424067
#
_npm_install_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

	local si="$IFS"

	# if your npm command includes `install` or `i `
	if [[ ${words[@]} =~ 'install' ]] || [[ ${words[@]} =~ 'i ' ]]; then
		local cur=${COMP_WORDS[COMP_CWORD]}

		# supply autocomplete words from `~/.npm`, with $cur being value of current expansion like 'expre'
		COMPREPLY=( $( compgen -W "$(ls ~/.npm )" -- $cur ) )
	fi

	IFS="$si"
}
# bind the above function to `npm` autocompletion
complete -o default -F _npm_install_completion npm

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
