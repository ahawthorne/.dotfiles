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

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s /home/ahawthorne/.nvm/nvm.sh ]] && . /home/ahawthorne/.nvm/nvm.sh # This loads NVM

export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

export CHROME_DEVEL_SANDBOX=~/include/chrome-linux/chrome_sandbox

#alias rails="bundle exec rails"
#alias rake="bundle exec rake"
#alias knife="bundle exec knife"
export BUNGLER="rails rake rspec cucumber knife"
[[ -s "$HOME/.bungler/bungler" ]] && . $HOME/.bungler/bungler
