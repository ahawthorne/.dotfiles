# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/AndroidSDK:$HOME/AndroidSDK/tools:$HOME/AndroidSDK/platform-tools

export PATH
export EDITOR=vim
