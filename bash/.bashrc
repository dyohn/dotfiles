# echo "Loading .bashrc"

##
## Homebrew setup
##
export  HOMEBREW_PREFIX=/opt/homebrew
eval $($HOMEBREW_PREFIX/bin/brew shellenv)

##
## Bash completions from Homebrew
##
if type brew &>/dev/null
then
  # HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

##
## Pyenv setup
##
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
