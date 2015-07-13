homeDir
=======
homeディレクトリに置いてあるrcファイルとか...

# .vimrc
vimの設定関連
vimは+luaの必要が有ります

## vimのlua有効化方法
### Mac
Homebrewでおｋ
```zsh
$ brew install lua
$ brew reinstall vim --with-lua
```
### Linux & UNIX
自分でmake & make install頑張って！

## vimのカラースキームをプレビューする方法
```vim
:Unite colorscheme -auto-preview
```
気に入ったテーマを選んだら
```vim
colorscheme scheme_name
```
のscheme_nameをテーマ名に書き換えてテーマを設定

## syntasticを使う場合
zshenvにrbenvの設定が必要です

```zsh
$ vim .zshenv
```

```vim
if [ -d ${HOME}/.rbenv  ] ; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
```
