#
# Load brew environment
#
eval "$(/opt/homebrew/bin/brew shellenv)"

#
# Initialize z
#
. /opt/homebrew/etc/profile.d/z.sh

#
# Define aliases
#
alias ll='ls -lah'
alias ip="curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g'"
alias localip="ipconfig getifaddr en0"
alias password="openssl rand -base64 6"
alias code="codium"

#
# Configure prompt
#

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' (%b)'

# configure prompt
setopt PROMPT_SUBST
PROMPT=$'\n'"%F{magenta}%n@%m:%B%F{cyan}%~%F{yellow}\$vcs_info_msg_0_%f%b"$'\n'"$ "

#
# Setup completion
#
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit && compinit
