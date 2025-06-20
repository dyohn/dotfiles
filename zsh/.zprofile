## This gets sourced before .zshrc, but only on login shells.
## Note that SSH connections are both login and interactive shells.
## For standard usage (Mac Terminal), the login happens the first
## time that the program is executed, and the settings here persist
## until the Terminal application is exited (<program> > Quit).

#echo "Loading .zprofile"
#echo $PATH
#echo

# PATH changes recommended by default .zshrc template
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

##
## Homebrew setup
##
export HOMEBREW_PREFIX=/opt/homebrew
##export HOMEBREW_CELLAR=/opt/homebrew/Cellar
##export HOMEBREW_REPOSITORY=/opt/homebrew
##export INFOPATH=/opt/homebrew/share/info:
##PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
eval $($HOMEBREW_PREFIX/bin/brew shellenv)

##
## Pyenv setup
##
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
