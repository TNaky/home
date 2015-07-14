.vimrc
======
Vimの設定ファイルであるvimrcについて

# Vim環境
MacOS環境
ver 7.4 +lua環境で作成
ステータスバーにPowerline Fontを利用

## Vim install
### Mac
Homebrewを利用
```zsh
brew install lua
brew reinstall vim --with-lua
```

## PowerlineFont install
### Mac
Homebrewを利用
```zsh
brew tap sanemat/font
brew install --powerline --vim-powerline ricty
cp -f /usr/local/Cellar/ricty/*/share/fonts/Ricty*.ttf ~/Library/Fonts/
```

## syntastic利用のために
### zsh
.zshenvにrbenvの設定が必要
.zshenvを開いて
```zsh
vim .zshenv
```
下記の内容をコピペ
```vim
if [ -d ${HOME}/.rbenv  ] ; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
```
