# echo "Loading .bash_profile"

# Setting PATH for Python 3.7 (system)
# export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"

# setup bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# setup fancy git prompt
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
  fi

# setup preexec and precmd like zsh
[ -f /usr/local/etc/profile.d/bash-preexec.sh ] && . /usr/local/etc/profile.d/bash-preexec.sh


##
## Homebrew setup
##
export  HOMEBREW_PREFIX=/opt/homebrew
eval $($HOMEBREW_PREFIX/bin/brew shellenv)

##
## Pyenv setup
##
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"


##
## Shell prompt default
##
export PS1="\u: \w $ "


##
## Delete -> backspace
##
stty erase ^H


##
## Terminal colors
##
export CLICOLOR=1
export TERM=xterm-256color # make sure colors work in tmux


##
## Basic shortcuts
##
alias la='ls -alh '
alias cl='clear '
alias e='emacs -nw '
alias py='python3 '

alias d='docker '
alias dl='docker logs '
alias dlf='docker logs -f '

alias dc='docker compose '
alias dce='docker compose exec '
alias dcl='docker compose logs '
alias dlcf='docker compose logs -f '
