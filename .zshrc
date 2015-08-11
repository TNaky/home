#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Vi mode
bindkey -v
function zle-line-init zle-keymap-select {
  VIM_NORMAL="%K{148}%F{black}⮀%k%f%K{148}%F{022} %B NORMAL %b%k%f%K{black}%F{148}⮀%k%f"
  VIM_INSERT="%K{255}%F{black}⮀%k%f%K{255}%F{024} %B INSERT %b%k%f%K{black}%F{255}⮀%k%f"
  RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
  RPS2=$RPS1
  zle reset-prompt
}
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey -a "^A" vi-beginning-of-line
bindkey -a "^E" vi-end-of-line
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
export EDITOR=vi
export KEYTIMEOUT=1

# export homeBin
export PATH=$PATH:$HOME/.bin/sh/

# Customize to your needs...
export WWW_HOME="google.co.jp"

