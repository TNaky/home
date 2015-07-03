homeDir
=======
homeディレクトリに置いてあるrcファイルとか...

# .vimrc
vimの設定関連

## vimのカラースキームをプレビューする方法
```vim
:Unite colorscheme -auto-preview
```
気に入ったテーマを選んだら
```vim
colorscheme 'scheme name'
```

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
