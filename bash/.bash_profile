#
# Adjust PATH
#

# Add local bin/sbin
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Use current PHP version for CLI
# $ brew tap homebrew/php
# $ brew install php56
PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"

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
export PS1="\n\[$(tput bold)\]\[$(tput setaf 5)\]\u@\h:\[$(tput setaf 6)\]\w\[$(tput setaf 3)\] $ \[$(tput sgr0)\]"

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

# Android web debugging
# $ brew install android-sdk
alias androiddebug='open http://localhost:9222 && adb forward tcp:9222 localabstract:chrome_devtools_remote'

# Generate 8-digit simple password
alias password="openssl rand -base64 6"

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