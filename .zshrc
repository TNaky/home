#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>

# alias
alias "airport=/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ビープ音を鳴らさない
setopt no_beep
# Vi mode
bindkey -v
function zle-line-init zle-keymap-select {
VIM_NORMAL="%K{148}%F%k%f%K{148}%F{022} %B NORMAL %b%k%f%K{black}%F{148}⮀%k%f"
VIM_INSERT="%K{255}%F%k%f%K{255}%F{024} %B INSERT %b%k%f%K{black}%F{255}⮀%k%f"
RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
RPS2=$RPS1
zle reset-prompt
}
# 履歴関連
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-pattern-search-backward
# Zsh特有の移動を設定
bindkey -a "^A" vi-beginning-of-line
bindkey -a "^E" vi-end-of-line
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
# Normal modeへの遷移時間
export KEYTIMEOUT=1
# Normal mode時にvでvimを起動
export VISUAL=vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# export Android development
export ANDROID_SDK=${HOME}/Library/android-sdk-macosx
export ANDROID_NDK=${HOME}/Library/android-ndk-r10e

## Customize to your needs...
export WWW_HOME="google.co.jp"

# 環境変数(PATH)
## tmux起動によって２重に読み込まれることが内容にするため
if [[ -z $TMUX ]]; then
  # export homeBin
  export PATH=${PATH}:${HOME}/.bin/sh
  # export Android development
  export PATH=${PATH}:${ANDROID_SDK}/platform-tools/
  export PATH=${PATH}:${ANDROID_SDK}/tools/
fi

# login時にtmuxを起動
if [[ -z "$TMUX" && -z "$WINDOW" && ! -z "$PS1" ]]; then
  if $(tmux has-session 2> /dev/null); then
    tmux attach -d
  else
    tmux
  fi
fi

exit() {
  if [[ -z $TMUX ]]; then
    builtin exit
  else 
    tmux detach
  fi
}
