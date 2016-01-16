.vimrc
======
Vimの設定ファイルであるvimrcについて

# Vim環境

ver 7.4 +lua環境で作成

Vimがluaに対応しているか調べるには，

```zsh
vim --version | grep lua
```
を実行して，

+luaになっていれば対応しており，
-luaになっていれば未対応です

未対応の場合は，luaに対応したVimをインストールしてください．

また，ステータスバーの標示フォントにPowerline Fontを利用しています．

対応したフォントを利用してください．

## Vim install
luaが未対応の場合は，下記の手順で対応したVimをインストールできます．

### Mac
Homebrewを利用

```zsh
brew install lua
brew reinstall vim --with-lua
```

### Debian
Debian & Ubuntuのみ検証済み

```zsh
$ sudo aptitude install vim-nox
```

[Vim-nox](https://packages.debian.org/ja/jessie/vim-nox)

## PowerlineFont install
当Vimrcではステータス標示にPowerlineFontと呼ばれる，特別なフォントを利用します．

インストールされていない場合は，下記の手順でPowerline for rictyがインストールできます．

### Mac
Homebrewを利用

```zsh
brew tap sanemat/font
brew install --powerline --vim-powerline ricty
cp -f /usr/local/Cellar/ricty/*/share/fonts/Ricty*.ttf ~/Library/Fonts/
```

使っているTerminalなりiTermなりのフォントにインストールしたPowerlineFontを設定してください．
#### iTerm
iTerm > Preferences... > Profiles > Text

|Type|Font|Size|
|:---:|:---:|:---:|
|Regular Font|Ricty Regular for Powerline|20|
|Non-ASCII Font|Ricty Regular for Powerline|18|

## syntastic利用のために
syntasticは，プログラムソースのファイル保存時にシンタックスチェックを実施するプラグインです．

利用のためには.zshenvに下記の設定をしてください．(bash? 知りません)
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
