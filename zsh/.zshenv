## This gets sourced for every shell invocation, login or interactive
## so it's a great place to declare environment variables that should
## always exist. PATH can get mangled incorrectly if you fuss with
## it here, so save that for either .zprofile or .zshrc 

#echo "Loading .zshenv"
#echo $PATH
#echo

export HOMEBREW_PREFIX=/opt/homebrew
## export HOMEBREW_CELLAR=/opt/homebrew/Cellar
## export HOMEBREW_REPOSITORY=/opt/homebrew
## export INFOPATH=/opt/homebrew/share/info:

export PYENV_ROOT="$HOME/.pyenv"
