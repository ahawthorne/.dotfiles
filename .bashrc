# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# bash completion
if [ -d ~/bash_completion.d ]; then
  . ~/bash_completion.d/*
fi

export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox

[[ -s /home/ahawthorne/.nvm/nvm.sh ]] && . /home/ahawthorne/.nvm/nvm.sh # This loads NVM

export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

export BUNGLER="rails rake rspec cucumber knife pickler kitchen berks spring guard"
[[ -s "$HOME/.bungler/bungler" ]] && . $HOME/.bungler/bungler

# Set config variables first
GIT_PROMPT_ONLY_IN_REPO=1

GIT_PROMPT_THEME=Custom
# as last entry source the gitprompt script
source ~/bash-git-prompt/gitprompt.sh
source ~/bin/ssh-agent-setup
