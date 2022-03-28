# zsh completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# z folder manager
. /opt/homebrew/etc/profile.d/z.sh

# Better directory listings
alias ll='ls -lah'

# Obtain local and online ip
alias ip="curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g'"
alias localip="ipconfig getifaddr en0"

# Generate 8-digit simple password
alias password="openssl rand -base64 6"

# docker-compose
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcdu="docker-compose down && docker-compose up"
alias dclw="docker-compose logs -f web"

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' (%b)'

# configure prompt
setopt PROMPT_SUBST
PROMPT=$'\n'"%F{magenta}%n@%m:%B%F{cyan}%~%F{yellow}\$vcs_info_msg_0_%f%b"$'\n'"$ "
